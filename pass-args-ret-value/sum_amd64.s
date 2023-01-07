go tool compile -S sum.go
main.SumAndCap STEXT nosplit size=99 args=0x30 locals=0x0 funcid=0x0 align=0x0
	0x0000 00000 (sum.go:3)	TEXT	main.SumAndCap(SB), NOSPLIT|ABIInternal, $0-48
	0x0000 00000 (sum.go:3)	MOVQ	AX, main.xs+32(FP)
	0x0005 00005 (sum.go:3)	FUNCDATA	$0, gclocals·dfs/88MXouNqNY2126ZUeg==(SB)
	0x0005 00005 (sum.go:3)	FUNCDATA	$1, gclocals·J5F+7Qw7O7ve2QcWC7DpeQ==(SB)
	0x0005 00005 (sum.go:3)	FUNCDATA	$5, main.SumAndCap.arginfo1(SB)
	0x0005 00005 (sum.go:3)	FUNCDATA	$6, main.SumAndCap.argliveinfo(SB)
	0x0005 00005 (sum.go:3)	PCDATA	$3, $1
	0x0005 00005 (sum.go:8)	XORL	DX, DX
	0x0007 00007 (sum.go:8)	XORL	SI, SI
	0x0009 00009 (sum.go:5)	JMP	21
	0x000b 00011 (sum.go:5)	MOVQ	(AX)(DX*8), R12
	0x000f 00015 (sum.go:5)	INCQ	DX
	0x0012 00018 (sum.go:6)	ADDQ	R12, SI
	0x0015 00021 (sum.go:5)	CMPQ	BX, DX
	0x0018 00024 (sum.go:5)	JGT	11
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
	0x0000 48 89 44 24 20 31 d2 31 f6 eb 0a 4c 8b 24 d0 48  H.D$ 1.1...L.$.H
	0x0010 ff c2 4c 01 e6 48 39 d3 7f f1 48 c7 44 24 08 08  ..L..H9...H.D$..
	0x0020 00 00 00 48 c7 44 24 10 09 00 00 00 48 c7 44 24  ...H.D$.....H.D$
	0x0030 18 0a 00 00 00 48 89 f0 48 89 cb b9 01 00 00 00  .....H..H.......
	0x0040 bf 02 00 00 00 be 03 00 00 00 41 b8 04 00 00 00  ..........A.....
	0x0050 41 b9 05 00 00 00 41 ba 06 00 00 00 41 bb 07 00  A.....A.....A...
	0x0060 00 00 c3                                         ...
main.main STEXT nosplit size=1 args=0x0 locals=0x0 funcid=0x0 align=0x0
	0x0000 00000 (sum.go:11)	TEXT	main.main(SB), NOSPLIT|ABIInternal, $0-0
	0x0000 00000 (sum.go:11)	FUNCDATA	$0, gclocals·g2BeySu+wFnoycgXfElmcg==(SB)
	0x0000 00000 (sum.go:11)	FUNCDATA	$1, gclocals·g2BeySu+wFnoycgXfElmcg==(SB)
	0x0000 00000 (sum.go:12)	RET
	0x0000 c3                                               .
go.cuinfo.producer.<unlinkable> SDWARFCUINFO dupok size=0
	0x0000 72 65 67 61 62 69                                regabi
go.cuinfo.packagename.main SDWARFCUINFO dupok size=0
	0x0000 6d 61 69 6e                                      main
main..inittask SNOPTRDATA size=24
	0x0000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0010 00 00 00 00 00 00 00 00                          ........
runtime.memequal64·f SRODATA dupok size=8
	0x0000 00 00 00 00 00 00 00 00                          ........
	rel 0+8 t=1 runtime.memequal64+0
runtime.gcbits.01 SRODATA dupok size=1
	0x0000 01                                               .
type..namedata.*[]int- SRODATA dupok size=8
	0x0000 00 06 2a 5b 5d 69 6e 74                          ..*[]int
type.*[]int SRODATA dupok size=56
	0x0000 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 60 88 d2 70 08 08 08 36 00 00 00 00 00 00 00 00  `..p...6........
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 24+8 t=1 runtime.memequal64·f+0
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[]int-+0
	rel 48+8 t=1 type.[]int+0
type.[]int SRODATA dupok size=56
	0x0000 18 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
	0x0010 83 73 77 99 02 08 08 17 00 00 00 00 00 00 00 00  .sw.............
	0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	0x0030 00 00 00 00 00 00 00 00                          ........
	rel 32+8 t=1 runtime.gcbits.01+0
	rel 40+4 t=5 type..namedata.*[]int-+0
	rel 44+4 t=-32763 type.*[]int+0
	rel 48+8 t=1 type.int+0
gclocals·dfs/88MXouNqNY2126ZUeg== SRODATA dupok size=10
	0x0000 02 00 00 00 04 00 00 00 08 00                    ..........
gclocals·J5F+7Qw7O7ve2QcWC7DpeQ== SRODATA dupok size=8
	0x0000 02 00 00 00 00 00 00 00                          ........
main.SumAndCap.arginfo1 SRODATA static dupok size=9
	0x0000 fe 18 08 20 08 28 08 fd ff                       ... .(...
main.SumAndCap.argliveinfo SRODATA static dupok size=2
	0x0000 18 00                                            ..
gclocals·g2BeySu+wFnoycgXfElmcg== SRODATA dupok size=8
	0x0000 01 00 00 00 00 00 00 00                          ........
