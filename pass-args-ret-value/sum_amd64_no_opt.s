go tool compile -S -N sum.go
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
	0x01fc 00508 (sum.go:8)	NOP
	0x01fc 00508 (sum.go:3)	PCDATA	$1, $-1
	0x01fc 00508 (sum.go:3)	PCDATA	$0, $-2
	0x01fc 00508 (sum.go:3)	MOVQ	AX, 32(SP)
	0x0201 00513 (sum.go:3)	MOVQ	BX, 40(SP)
	0x0206 00518 (sum.go:3)	MOVQ	CX, 48(SP)
	0x020b 00523 (sum.go:3)	CALL	runtime.morestack_noctxt(SB)
	0x0210 00528 (sum.go:3)	MOVQ	32(SP), AX
	0x0215 00533 (sum.go:3)	MOVQ	40(SP), BX
	0x021a 00538 (sum.go:3)	MOVQ	48(SP), CX
	0x021f 00543 (sum.go:3)	PCDATA	$0, $-1
	0x021f 00543 (sum.go:3)	NOP
	0x0220 00544 (sum.go:3)	JMP	0
	0x0000 4c 8d 64 24 f0 4d 3b 66 10 0f 86 ed 01 00 00 48  L.d$.M;f.......H
	0x0010 81 ec 90 00 00 00 48 89 ac 24 88 00 00 00 48 8d  ......H..$....H.
	0x0020 ac 24 88 00 00 00 48 89 84 24 b0 00 00 00 48 89  .$....H..$....H.
	0x0030 9c 24 b8 00 00 00 48 89 8c 24 c0 00 00 00 48 c7  .$....H..$....H.
	0x0040 44 24 40 00 00 00 00 48 c7 44 24 38 00 00 00 00  D$@....H.D$8....
	0x0050 48 c7 44 24 30 00 00 00 00 48 c7 44 24 28 00 00  H.D$0....H.D$(..
	0x0060 00 00 48 c7 44 24 20 00 00 00 00 48 c7 44 24 18  ..H.D$ ....H.D$.
	0x0070 00 00 00 00 48 c7 44 24 10 00 00 00 00 48 c7 44  ....H.D$.....H.D
	0x0080 24 08 00 00 00 00 48 c7 04 24 00 00 00 00 48 c7  $.....H..$....H.
	0x0090 84 24 98 00 00 00 00 00 00 00 48 c7 84 24 a0 00  .$........H..$..
	0x00a0 00 00 00 00 00 00 48 c7 84 24 a8 00 00 00 00 00  ......H..$......
	0x00b0 00 00 48 c7 44 24 50 00 00 00 00 48 8b 94 24 b0  ..H.D$P....H..$.
	0x00c0 00 00 00 4c 8b a4 24 b8 00 00 00 4c 8b ac 24 c0  ...L..$....L..$.
	0x00d0 00 00 00 48 89 54 24 70 4c 89 64 24 78 4c 89 ac  ...H.T$pL.d$xL..
	0x00e0 24 80 00 00 00 48 c7 44 24 60 00 00 00 00 48 8b  $....H.D$`....H.
	0x00f0 54 24 78 48 89 54 24 58 eb 00 48 8b 54 24 60 90  T$xH.T$X..H.T$`.
	0x0100 48 39 54 24 58 7f 02 eb 34 48 8b 54 24 60 48 c1  H9T$X...4H.T$`H.
	0x0110 e2 03 48 03 54 24 70 48 8b 12 48 89 54 24 48 4c  ..H.T$pH..H.T$HL
	0x0120 8b 64 24 50 4c 01 e2 48 89 54 24 50 eb 00 48 8b  .d$PL..H.T$P..H.
	0x0130 54 24 60 48 ff c2 48 89 54 24 60 eb bd 48 8b 94  T$`H..H.T$`..H..
	0x0140 24 c0 00 00 00 48 89 54 24 68 48 8b 54 24 50 48  $....H.T$hH.T$PH
	0x0150 89 54 24 40 48 8b 54 24 68 48 89 54 24 38 48 c7  .T$@H.T$hH.T$8H.
	0x0160 44 24 30 01 00 00 00 48 c7 44 24 28 02 00 00 00  D$0....H.D$(....
	0x0170 48 c7 44 24 20 03 00 00 00 48 c7 44 24 18 04 00  H.D$ ....H.D$...
	0x0180 00 00 48 c7 44 24 10 05 00 00 00 48 c7 44 24 08  ..H.D$.....H.D$.
	0x0190 06 00 00 00 48 c7 04 24 07 00 00 00 48 c7 84 24  ....H..$....H..$
	0x01a0 98 00 00 00 08 00 00 00 48 c7 84 24 a0 00 00 00  ........H..$....
	0x01b0 09 00 00 00 48 c7 84 24 a8 00 00 00 0a 00 00 00  ....H..$........
	0x01c0 48 8b 44 24 40 48 8b 5c 24 38 48 8b 4c 24 30 48  H.D$@H.\$8H.L$0H
	0x01d0 8b 7c 24 28 48 8b 74 24 20 4c 8b 44 24 18 4c 8b  .|$(H.t$ L.D$.L.
	0x01e0 4c 24 10 4c 8b 54 24 08 4c 8b 1c 24 48 8b ac 24  L$.L.T$.L..$H..$
	0x01f0 88 00 00 00 48 81 c4 90 00 00 00 c3 48 89 44 24  ....H.......H.D$
	0x0200 20 48 89 5c 24 28 48 89 4c 24 30 e8 00 00 00 00   H.\$(H.L$0.....
	0x0210 48 8b 44 24 20 48 8b 5c 24 28 48 8b 4c 24 30 90  H.D$ H.\$(H.L$0.
	0x0220 e9 db fd ff ff                                   .....
	rel 524+4 t=7 runtime.morestack_noctxt+0
main.main STEXT nosplit size=1 args=0x0 locals=0x0 funcid=0x0 align=0x0
	0x0000 00000 (sum.go:11)	TEXT	main.main(SB), NOSPLIT|ABIInternal, $0-0
	0x0000 00000 (sum.go:11)	FUNCDATA	$0, gclocals·g2BeySu+wFnoycgXfElmcg==(SB)
	0x0000 00000 (sum.go:11)	FUNCDATA	$1, gclocals·g2BeySu+wFnoycgXfElmcg==(SB)
	0x0000 00000 (sum.go:12)	RET
	0x0000 c3                                               .
go.cuinfo.producer.<unlinkable> SDWARFCUINFO dupok size=0
	0x0000 2d 4e 20 72 65 67 61 62 69                       -N regabi
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
gclocals·odYzRIjT7IX9pYG9TnNVzw== SRODATA dupok size=10
	0x0000 02 00 00 00 03 00 00 00 00 00                    ..........
main.SumAndCap.arginfo1 SRODATA static dupok size=9
	0x0000 fe 18 08 20 08 28 08 fd ff                       ... .(...
gclocals·g2BeySu+wFnoycgXfElmcg== SRODATA dupok size=8
	0x0000 01 00 00 00 00 00 00 00                          ........
