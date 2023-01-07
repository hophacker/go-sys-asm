本文将借助Plan 9汇编探究：
* Golang调用函数是如何传参及返回结果的
* Golang是如何实现多结果返回的
* Golang汇编器如何进行优化
* Golang Slice的底层表达及其作为参数的传递方式

我们的实验环境为: 
```bash
~/ go version
go version go1.19 darwin/amd64
```
本文不涉及Plan 9汇编的基础知识及Plan 9一些高深莫测的助记符解析，前者网上能找到大量资料，后者会让本文偏离主题。

要想深度了解Plan 9汇编，除了阅读大量文档外，还需多看从Golang源代码生成的汇编代码。这里我们以下面的函数SumAndCap举例:

```golang
package main

func SumAndCap(xs []int) (int, int, int, int, int, int, int, int, int, int, int, int) {
	var n int
	for _, v := range xs {
		n += v
	}
	return n, cap(xs), 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
}

func main() {
}
```

顾名思义，SumAndCap计算一个int Slice所有元素的和，并返回和以及该Slice的容量。故意返回更多值是为了方便接下来探究Golang底层如何实现返回多个值。

将这片代码保存为sum.go并运行以下命令：`go tool compile -S sum.go`
便能得到sum.go的汇编代码(这里截取主要部分)：
```as
main.SumAndCap STEXT nosplit size=99 args=0x30 locals=0x0 funcid=0x0 align=0x0
        0x0000 00000 (sum.go:3) TEXT    main.SumAndCap(SB), NOSPLIT|ABIInternal, $0-48
        0x0000 00000 (sum.go:3) MOVQ    AX, main.xs+32(FP)
        0x0005 00005 (sum.go:3) FUNCDATA        $0, gclocals·dfs/88MXouNqNY2126ZUeg==(SB)
        0x0005 00005 (sum.go:3) FUNCDATA        $1, gclocals·J5F+7Qw7O7ve2QcWC7DpeQ==(SB)
        0x0005 00005 (sum.go:3) FUNCDATA        $5, main.SumAndCap.arginfo1(SB)
        0x0005 00005 (sum.go:3) FUNCDATA        $6, main.SumAndCap.argliveinfo(SB)
        0x0005 00005 (sum.go:3) PCDATA  $3, $1
        0x0005 00005 (sum.go:8) XORL    DX, DX
        0x0007 00007 (sum.go:8) XORL    SI, SI
        0x0009 00009 (sum.go:5) JMP     21
        0x000b 00011 (sum.go:5) MOVQ    (AX)(DX*8), R12
        0x000f 00015 (sum.go:5) INCQ    DX
        0x0012 00018 (sum.go:6) ADDQ    R12, SI
        0x0015 00021 (sum.go:5) CMPQ    BX, DX
        0x0018 00024 (sum.go:5) JGT     11
        0x001a 00026 (sum.go:8) MOVQ    $8, main.~r9+8(SP)
        0x0023 00035 (sum.go:8) MOVQ    $9, main.~r10+16(SP)
        0x002c 00044 (sum.go:8) MOVQ    $10, main.~r11+24(SP)
        0x0035 00053 (sum.go:8) MOVQ    SI, AX
        0x0038 00056 (sum.go:8) MOVQ    CX, BX
        0x003b 00059 (sum.go:8) MOVL    $1, CX
        0x0040 00064 (sum.go:8) MOVL    $2, DI
        0x0045 00069 (sum.go:8) MOVL    $3, SI
        0x004a 00074 (sum.go:8) MOVL    $4, R8
        0x0050 00080 (sum.go:8) MOVL    $5, R9
        0x0056 00086 (sum.go:8) MOVL    $6, R10
        0x005c 00092 (sum.go:8) MOVL    $7, R11
        0x0062 00098 (sum.go:8) RET                                          ..
```
对于这段汇编代码，我们不准备逐行解析或陷入细节(例如GC相关的助记符)，我们只需对照Go源码并了解我们想要的即可。

**初始化代码**(5~7)：
```as
	0x0005 00005 (sum.go:8)	XORL	DX, DX
	0x0007 00007 (sum.go:8)	XORL	SI, SI
```
在汇编里，XORL是给寄存器清零最快的方式，一般来说，编译器都会将清零任务转成XOR操作，这里也不例外。进一步可以根据函数内容推断出，上面这两步是将访问数组的下标及要计算的和分别置0。

**For循环代码**(9~24):
```as
	0x0009 00009 (sum.go:5)	JMP	21
	0x000b 00011 (sum.go:5)	MOVQ	(AX)(DX*8), R12
	0x000f 00015 (sum.go:5)	INCQ	DX
	0x0012 00018 (sum.go:6)	ADDQ	R12, SI
	0x0015 00021 (sum.go:5)	CMPQ	BX, DX
	0x0018 00024 (sum.go:5)	JGT	11
```
清0后，程序跳转的地址21，将BX和DX比较，如果BX > DX，则跳到地址11。再联系地址15的INCQ DX可以推断出DX中存放的是访问数组的下标，而地址11到24实现的就是访问xs Slice所有元素的for循环。

因64位机中每个int为8个字节，故地址11语句"MOVQ	(AX)(DX*8), R12"就是要将第DX个元素移到寄存器R12中，并在地址18相加到寄存器SI中。从而，SI中最终存放的也就是xs Slice中元素的总和。

在这里，"(AX)(DX*8)"所代表的就是基址AX与偏移量相加后的地址。从而AX中存放的就是指向xs Slice的的指针，因为AX之前没有修改过，可以推断出，AX是按照调用规约存放的是调用入参的第一个参数。

因为Go语言中表达一个Slice需要需要三个值: 1) 指向Slice的指针 2) Slice的长度 3) 存储Slice的容量。在go1.19 darwin/amd64环境中，这三个值都是8个字节。其中，AX中存放指向Slice的指针，另外两个值暂且不知道在哪存放。
在地址21处的判断中，若BX == QX，程序进入到地址26处。

**函数返回代码**(26~98):
```as
	0x001a 00026 (sum.go:8)	MOVQ	$8, main.~r9+8(SP)
	0x0023 00035 (sum.go:8)	MOVQ	$9, main.~r10+16(SP)
	0x002c 00044 (sum.go:8)	MOVQ	$10, main.~r11+24(SP)
	0x0035 00053 (sum.go:8)	MOVQ	SI, AX
	0x0038 00056 (sum.go:8)	MOVQ	CX, BX
	0x003b 00059 (sum.go:8)	MOVL	$1, CX
	0x0040 00064 (sum.go:8)	MOVL	$2, DI
	0x0045 00069 (sum.go:8)	MOVL	$3, SI
	0x004a 00074 (sum.go:8)	MOVL	$4, R8
	0x0050 00080 (sum.go:8)	MOVL	$5, R9
	0x0056 00086 (sum.go:8)	MOVL	$6, R10
	0x005c 00092 (sum.go:8)	MOVL	$7, R11
	0x0062 00098 (sum.go:8)	RET
```
因`SI`中存的是Slice总和，`MOVQ	SI, AX`就是将总和转到AX中作为第一个返回值；数字1~10的返回及顺序也已确定，分别为: `CX、DI、SI、R8、R9、R10、R11、main.~r9+8(SP)、main.~r10+16(SP)、main.~r11+24(SP) `。
现在只剩`BX`，对应的便是`cap(xs)`的返回值。而`BX`中的值从`CX`中来，`CX`在函数调用过程中并未被修改，那么`CX`中传进来时就已经存放好了`cap(xs)`。

综合以上各类信息，我们可以推断出：
* 在进入函数"SumAndCap"时，Slice的地址指针、长度、容量分别通过寄存器AX、BX、CX传入。
* 调用完后一个函数，返回值先分别存于AX、BX、CX、DI、SI、R8、R9、R10、R11寄存器，寄存器不够用后，会使用堆栈继续按顺序依次存储返回值。
* 函数传参也会先使用寄存器，且使用的顺序与返回值一致。
```

                                       caller                                                                                 
                                 +------------------+                                                                         
                                 |                  |                                                                         
       +---------------------->  --------------------                                                                         
       |                         |                  |                                                                         
       |                         | caller parent BP |                                                                         
       |           BP(pseudo SP) --------------------                                                                         
       |                         |                  |                                                                         
       |                         |   Local Var0     |                                                                         
       |                         --------------------                                                                         
       |                         |                  |                                                                         
       |                         |   .......        |                                                                         
       |                         --------------------                                                                         
       |                         |                  |                                                                         
       |                         |   Local VarN     |                                                                         
                                 --------------------                                                                         
 caller stack frame              |                  |                                                                         
                                 |   callee arg2    |                                                                         
       |                         |------------------|                                                                         
       |                         |                  |                                                                         
       |                         |   callee arg1    |                                                                         
       |                         |------------------|                                                                         
       |                         |                  |                                                                         
       |                         |   callee arg0    |                                                                         
       |                         ----------------------------------------------+   FP(virtual register)                       
       |                         |                  |                          |                                              
       |                         |   return addr    |  parent return address   |                                              
       +---------------------->  +------------------+---------------------------    <-------------------------------+         
                                                    |  caller BP               |                                    |         
                                                    |  (caller frame pointer)  |                                    |         
                                     BP(pseudo SP)  ----------------------------                                    |         
                                                    |                          |                                    |         
                                                    |     Local Var0           |                                    |         
                                                    ----------------------------                                    |         
                                                    |                          |                                              
                                                    |     Local Var1           |                                              
                                                    ----------------------------                            callee stack frame
                                                    |                          |                                              
                                                    |       .....              |                                              
                                                    ----------------------------                                    |         
                                                    |                          |                                    |         
                                                    |     Local VarN           |                                    |         
                                  SP(Real Register) ----------------------------                                    |         
                                                    |                          |                                    |         
                                                    |                          |                                    |         
                                                    |                          |                                    |         
                                                    |                          |                                    |         
                                                    |                          |                                    |         
                                                    +--------------------------+    <-------------------------------+         
                                                                                                                              
                                                              callee
```
上面这张图是流传很广的**Golang函数调用规约**图。如果不去作编译器优化，也就是加入`-N`参数来汇编Go代码得到的是:
```as
# go tool compile -S -N sum.go
main.SumAndCap STEXT size=549 args=0x30 locals=0x90 funcid=0x0 align=0x0
	0x0000 00000 (sum.go:3)	TEXT	main.SumAndCap(SB), ABIInternal, $144-48
	0x0000 00000 (sum.go:3)	LEAQ	-16(SP), R12
	0x0005 00005 (sum.go:3)	CMPQ	R12, 16(R14)
	0x0009 00009 (sum.go:3)	PCDATA	$0, $-2
	0x0009 00009 (sum.go:3)	JLS	508
	0x000f 00015 (sum.go:3)	PCDATA	$0, $-1
	0x000f 00015 (sum.go:3)	SUBQ	$144, SP
	0x0016 00022 (sum.go:3)	MOVQ	BP, 136(SP)
	0x001e 00030 (sum.go:3)	LEAQ	136(SP), BP
	0x0026 00038 (sum.go:3)	FUNCDATA	$0, gclocals·dfs/88MXouNqNY2126ZUeg==(SB)
	0x0026 00038 (sum.go:3)	FUNCDATA	$1, gclocals·odYzRIjT7IX9pYG9TnNVzw==(SB)
	0x0026 00038 (sum.go:3)	FUNCDATA	$5, main.SumAndCap.arginfo1(SB)
	0x0026 00038 (sum.go:3)	MOVQ	AX, main.xs+176(SP)
	0x002e 00046 (sum.go:3)	MOVQ	BX, main.xs+184(SP)
	0x0036 00054 (sum.go:3)	MOVQ	CX, main.xs+192(SP)
	0x003e 00062 (sum.go:3)	MOVQ	$0, main.~r0+64(SP)
	0x0047 00071 (sum.go:3)	MOVQ	$0, main.~r1+56(SP)
	0x0050 00080 (sum.go:3)	MOVQ	$0, main.~r2+48(SP)
	0x0059 00089 (sum.go:3)	MOVQ	$0, main.~r3+40(SP)
	0x0062 00098 (sum.go:3)	MOVQ	$0, main.~r4+32(SP)
	0x006b 00107 (sum.go:3)	MOVQ	$0, main.~r5+24(SP)
	0x0074 00116 (sum.go:3)	MOVQ	$0, main.~r6+16(SP)
	0x007d 00125 (sum.go:3)	MOVQ	$0, main.~r7+8(SP)
	0x0086 00134 (sum.go:3)	MOVQ	$0, main.~r8(SP)
	0x008e 00142 (sum.go:3)	MOVQ	$0, main.~r9+152(SP)
	0x009a 00154 (sum.go:3)	MOVQ	$0, main.~r10+160(SP)
	0x00a6 00166 (sum.go:3)	MOVQ	$0, main.~r11+168(SP)
	0x00b2 00178 (sum.go:4)	MOVQ	$0, main.n+80(SP)
	0x00bb 00187 (sum.go:5)	MOVQ	main.xs+176(SP), DX
	0x00c3 00195 (sum.go:5)	MOVQ	main.xs+184(SP), R12
	0x00cb 00203 (sum.go:5)	MOVQ	main.xs+192(SP), R13
	0x00d3 00211 (sum.go:5)	MOVQ	DX, main..autotmp_15+112(SP)
	0x00d8 00216 (sum.go:5)	MOVQ	R12, main..autotmp_15+120(SP)
	0x00dd 00221 (sum.go:5)	MOVQ	R13, main..autotmp_15+128(SP)
	0x00e5 00229 (sum.go:5)	MOVQ	$0, main..autotmp_17+96(SP)
	0x00ee 00238 (sum.go:5)	MOVQ	main..autotmp_15+120(SP), DX
	0x00f3 00243 (sum.go:5)	MOVQ	DX, main..autotmp_18+88(SP)
	0x00f8 00248 (sum.go:5)	JMP	250
	0x00fa 00250 (sum.go:5)	MOVQ	main..autotmp_17+96(SP), DX
	0x00ff 00255 (sum.go:5)	NOP
	0x0100 00256 (sum.go:5)	CMPQ	main..autotmp_18+88(SP), DX
	0x0105 00261 (sum.go:5)	JGT	265
	0x0107 00263 (sum.go:5)	JMP	317
	0x0109 00265 (sum.go:5)	MOVQ	main..autotmp_17+96(SP), DX
	0x010e 00270 (sum.go:5)	SHLQ	$3, DX
	0x0112 00274 (sum.go:5)	ADDQ	main..autotmp_15+112(SP), DX
	0x0117 00279 (sum.go:5)	MOVQ	(DX), DX
	0x011a 00282 (sum.go:5)	MOVQ	DX, main.v+72(SP)
	0x011f 00287 (sum.go:6)	MOVQ	main.n+80(SP), R12
	0x0124 00292 (sum.go:6)	ADDQ	R12, DX
	0x0127 00295 (sum.go:6)	MOVQ	DX, main.n+80(SP)
	0x012c 00300 (sum.go:6)	JMP	302
	0x012e 00302 (sum.go:5)	MOVQ	main..autotmp_17+96(SP), DX
	0x0133 00307 (sum.go:5)	INCQ	DX
	0x0136 00310 (sum.go:5)	MOVQ	DX, main..autotmp_17+96(SP)
	0x013b 00315 (sum.go:5)	JMP	250
	0x013d 00317 (sum.go:8)	MOVQ	main.xs+192(SP), DX
	0x0145 00325 (sum.go:8)	MOVQ	DX, main..autotmp_16+104(SP)
	0x014a 00330 (sum.go:8)	MOVQ	main.n+80(SP), DX
	0x014f 00335 (sum.go:8)	MOVQ	DX, main.~r0+64(SP)
	0x0154 00340 (sum.go:8)	MOVQ	main..autotmp_16+104(SP), DX
	0x0159 00345 (sum.go:8)	MOVQ	DX, main.~r1+56(SP)
	0x015e 00350 (sum.go:8)	MOVQ	$1, main.~r2+48(SP)
	0x0167 00359 (sum.go:8)	MOVQ	$2, main.~r3+40(SP)
	0x0170 00368 (sum.go:8)	MOVQ	$3, main.~r4+32(SP)
	0x0179 00377 (sum.go:8)	MOVQ	$4, main.~r5+24(SP)
	0x0182 00386 (sum.go:8)	MOVQ	$5, main.~r6+16(SP)
	0x018b 00395 (sum.go:8)	MOVQ	$6, main.~r7+8(SP)
	0x0194 00404 (sum.go:8)	MOVQ	$7, main.~r8(SP)
	0x019c 00412 (sum.go:8)	MOVQ	$8, main.~r9+152(SP)
	0x01a8 00424 (sum.go:8)	MOVQ	$9, main.~r10+160(SP)
	0x01b4 00436 (sum.go:8)	MOVQ	$10, main.~r11+168(SP)
	0x01c0 00448 (sum.go:8)	MOVQ	main.~r0+64(SP), AX
	0x01c5 00453 (sum.go:8)	MOVQ	main.~r1+56(SP), BX
	0x01ca 00458 (sum.go:8)	MOVQ	main.~r2+48(SP), CX
	0x01cf 00463 (sum.go:8)	MOVQ	main.~r3+40(SP), DI
	0x01d4 00468 (sum.go:8)	MOVQ	main.~r4+32(SP), SI
	0x01d9 00473 (sum.go:8)	MOVQ	main.~r5+24(SP), R8
	0x01de 00478 (sum.go:8)	MOVQ	main.~r6+16(SP), R9
	0x01e3 00483 (sum.go:8)	MOVQ	main.~r7+8(SP), R10
	0x01e8 00488 (sum.go:8)	MOVQ	main.~r8(SP), R11
	0x01ec 00492 (sum.go:8)	MOVQ	136(SP), BP
	0x01f4 00500 (sum.go:8)	ADDQ	$144, SP
	0x01fb 00507 (sum.go:8)	RET
...
```
此时产生的汇编代码中对参数的传递和函数值返回的处理基本与该图吻合，但默认情况下没有`-N`时，程序会作大量优化，其中一个重要优化就是直接用寄存器进行传参及存储返回值，从而减少内存和寄存器之间的copy次数。

至此，我们几个探究目标皆已实现。当然本文中诸多内容都是基于个人推断(推断有时比查资料容易)，难免失误，欢迎读者指正。
