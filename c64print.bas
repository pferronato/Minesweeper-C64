000 ;*** TO DO ***1 ;* BUGS2 ;3 ;4 ;* FEATURES5 ;ADD SOUND6 ;SPEED UP ARRAY INDEXING7 ;ADD TIME AS INTERRUPT8 ;ADD MOUSE CONTROL9 ;SPEED UP ADDRSS * CALCULATION10 REM ================================20 REM           MINESC6430 REM ================================40 DEBUG42 CLS:CLR:TBOMBS=1643 TAG RESTART45 RANDOM:TAG BLK=0,WHT=1,RED=2,LTGN=13,GRY=12,DGRY=11,BLU=6,LTGY=1550 TAG MAXSIDE=20:SUB ISIDE=MAXSIDE-1:TAG CUR=102:DECIMAL TI,F0%,DD60 DIM FIELD(399):DIM ZLX(399):DIM ZLY(399):DIM VIS(399)61 TAG VISIBLE=1:TAG MARK=88:LET CL0=LTGR:LET LFT=40070 TAG BOMB=214:TAG HIDDEN=230:TAG EMPTY=255:TAG SPACE=32:MARKED=079 ;80 SHOWMAP85 INITFLD87 GENBOMBS:SCORES90 MCALC93 ;SHALL:KEYPRESS95 INITCRS110 MENU120 RETURN150 ;160 PROC INITFLD165 TAG SVIS=VIS():TAG SF=FIELD():FSIZ=400*2:EF=FSIZ+SF-1:EVIS=FSIZ+SVIS-1174 FILL SF,EF,HIDDEN177 FILL SVIS,EVIS,0179 POKE 53280,0;SIDCLR:VOL 15:VOICE 1270 RETURN299 ;300 PROC MOD:PASS N,D320 DD=N/D330 F0%=FRAC(DD)340 RETURN399 ;400 PROC CLICK420 POKE 54296,15430 POKE 54296,0460 RETURN580 ;590 PROC COORD:PASS AX,BX600 ;I=MAXSIDE*BX:ADD I=I+AX605 ADD I=BX+BX:DUBL I:ADD I=I+BX:DUBL I:DUBL I:ADD I=I+AX610 RETURN710 ;720 PROC CKCELL:PASS AA,BB:LET OOB=0722 COMP ISIDE,AA:[BCC 738]724 COMP ISIDE,BB:[BCC 738]730 COMP AA,0:[BCC 738]731 COMP BB,0:[BCC 738]732 GOTO 740738 LET<OOB=1740 RETURN770 ;780 PROC DISP:LOCAL:PASS X,Y,P782 ADD TY=Y+Y:DUBLTY:ADDTY=TY+Y:DUBLTY:DUBLTY:DUBLTY;Y0=40*Y+80784 ADD Y0=TY+80790 ADD XY=Y0+X:ADD XY=XY+1028;XY=Y0+X+1028805 POKE XY,P810 GLOBAL:RETURN820 ;830 PROC ZEROS:PASS A,B850 ZLX(0)=A:ZLY(0)=B:LET ZLS=1:LET C=O:Y=0;X=0860 TAG ZLOOP870 A=ZLX(C):B=ZLY(C)880 ADD X=A+1:ADD Y=B+1:ZEROED890 ADD X=A+1:SUB Y=B-1:ZEROED900 SUB X=A-1:ADD Y=B+1:ZEROED910 SUB X=A-1:SUB Y=B-1:ZEROED930 ADD X=A+1:LET<Y=B:ZEROED940 LET<X=A:ADD Y=B+1:ZEROED950 SUB X=A-1:LET<Y=B:ZEROED960 LET<X=A:SUB Y=B-1:ZEROED970 INC C:COMP C,ZLS:[BCC ZLOOP]977 RETURN979 ;980 PROC ZEROED990 CKCELL.X,Y:COORD.X,Y995 COMP OOB,1:[BEQ 1040]:VI=VIS(I)998 COMP VI,VISIBLE:[BEQ 1040]1010 IF FIELD(I)=0 THEN ZLX(ZLS)=X:ZLY(ZLS)=Y:INC ZLS1025 THEN DISP.X,Y,SPACE1026 ELSE P=FIELD(I)+48:DISP.X,Y,P1027 DEC LFT:VIS(I)=VISIBLE1030 ADD YT=Y+2:ADD XT=X+4:COMP VI,MARK:[BNE 1040]1032 DEC MARKED:P=40*YT+XT+55296:POKEP,LTGN1040 RETURN1060 ;1070 PROC EXIT1080 POKE 646,LTGY:CLS:LOC 0,0;"MINES 64 - BYE BYE":POKE 646,LTGN:END1090 ;1100 PROC PROG:PASS C,M1105 LET 646=WHT1110 LOC 6,23;MSG$;" ";C;" /";M;"  "1120 COMP C,M:[BNE 1130]1125 LOC 6,23 "                   "1130 LET 646=LTGN:RETURN1139 ;1200 PROC MENU1203 SCORES1205 LET SX=25:P0=40*20+10+10241210 CHR$(151):POKE 646,WHT1220 LOC SX,06;"[RET] OPEN"1230 LOC SX,08;"[SPC] MARK"1235 LOC SX,12;"[Q]   QUIT"1240 LOC SX,14;"[R]   RESTART"1245 LOC SX,10;"[B]   #BOMBS"1250 LOC SX,16;"[A]   ABOUT"1255 LOC SX,18;"USE ARROWS KEYS";CHR$(153)1260 GETK$:IF K$="" THEN 12601270 IF K$="S" THEN MSHALL1290 IF K$="R" THEN MREST1291 IF K$="B" THEN MCONF1292 IF K$="A" THEN MABOUT1293 IF K$="Q" THEN MEXIT1294 CURS:SCORES:CKEND1295 GOTO 12601299 ;1800 TAG FAILED1805 SCORES:SVSCR1810 MSG$="BOOOM!":WIND1830 KEYPRESS1835 RSTSCR1838 POKE 646,LTGN:RESTART1908 ;1910 PROC SCORES1915 POKE 646,BLK1930 LOC 4,0;"MARKED:    LEFT:     BOMBS:   "1940 POKE 646,LTGY: LOC11,0;MARKED:LOC20,0;LFT;LOC31,0;TBOMBS1950 POKE646,LTGN:RETURN1999 ;2000 PROC SHOWMAP2001 LET L=19:LET X=2:LET Y=4:POKE 646,BLU2002 LOC3,1;"�";DUP$("�",20);"�"2003 LOC3,22;"�";DUP$("�",20);"�"2004 FORI=2TO21:LOC3,I;"�":NEXT2005 FORI=2TO21:LOC24,I;"�":NEXT:POKE 646,LTGR2010 FORI=0TOISIDE2020 ADD X1=X+I2030 ADD S=X1+X1:DUBL S:ADD S=S+X12040 DUBL S:DUBL S:DUBL S:SS=S+1024+Y2045 COLS=S+55296+Y2060 ADD EE=SS+L:ADD CLE=COLS+L2062 FILLCOLS,CLE,LTGN2070 FILL SS,EE,HIDDEN2080 NEXT2090 RETURN2099 ;2100 PROC MREST2110 CONFIRM2130 IFM$="Y" THEN RESTART2150 RETURN2155 ;2160 PROC CONFIRM2170 SVSCR2172 MSG$= "SURE? (Y/N)":WIND2175 GETM$:IFM$=""THEN21752177 RSTSCR2185 POKE 646,LTGN2187 RETURN2199 ;2200 PROC MEXIT2210 CONFIRM2230 IFM$="Y" THEN EXIT2250 RETURN2259 ;2300 PROC CKEND2310 IF MARKED=TBOMBS AND LFT=MARKED THEN WIN2315 ELSE RETURN2320 TAG WIN2330 SVSCR:MSG$=" *WIN* ":WIND2340 KEYPRESS2345 RSTSCR:RESTART2350 RETURN2499 ;2500 PROC CURS2505 LET MV=0:CLICK2510 IF K$="�" THEN DEC R%:INC MV2520 IF K$="" THEN INC R%:INC MV2530 IF K$="" THEN INC C%:INC MV2540 IF K$="�" THEN DEC C%:INC MV2543 R$=CHR$(13):IF K$=R$ THEN OCELL2545 S$=CHR$(32):IF K$=S$ THEN MCELL2546 COMP MV,0:[BEQ 2620]2550 IF R%=65535 THEN LET R%=192560 IF C%=65535 THEN LET C%=192570 IF R%>19 THEN LET R%=02580 IF C%>19 THEN LET C%=02585 ADD R1=R%+2:ADD C1=C%+42590 L=40*R1+C1+1024:PC=40*R1+C1+552962600 POKE P0,ST:ST=PEEK(L):POKE PC0,CL02610 POKE L,CUR:LET P0=L:CL0=PEEK(PC):POKE PC,0:LET PC0=PC2620 RETURN2699 ;2700 PROC INITCRS:C%=0:R%=02710 C1=4:R1=2:PC=40*R1+C1+55296:L=40*R1+C1+10242715 POKE L,HIDDEN:POKE PC,BLK:CL0=LTGN:ST=HIDDEN:P0=L:PC0=PC2720 RETURN2799 ;2800 PROC OCELL2805 COORD.C%,R%2807 IF VIS(I)=VISIBLE THEN RETURN2808 IF VIS(I)=MARK THEN RETURN2810 IF FIELD(I)=0 THEN ZEROS.C%,R%:LET P0=SPACE:GOTO 28402820 IF FIELD(I)=BOMB THEN FAILED2825 IF VIS(I)=MARK THEN RETURN2830 PX=FIELD(I)+48:DISP.C%,R%,PX:LET ST=PX:DEC LFT:VIS(I)=VISIBLE2840 RETURN2999 ;3000 PROC MCELL3010 COORD.C%,R%:IF VIS(I)=VISIBLE THEN RETURN3015 IF VIS(I)=MARK THEN DEC MARKED:LET ST=HIDDEN:VIS(I)=0:LET CL0=LTGN:RETURN3020 DISP.C%,R%,MARK:INC MARKED:LET ST=MARK:VIS(I)=MARK:LET CL0=RED3998 RETURN3999 ;4000 PROC GENBOMBS4010 DECIMAL V:MSG$="BOMBS":LET P=3994020 FORI=0TO399:VIS(I)=I:NEXT4025 FORI=1TOTBOMBS4030 V=RND*P:R=INT(V):W=VIS(R)4035 FIELD(W)=BOMB:VIS(R)=VIS(P):VIS(P)=W:DEC P4060 NEXT4065 FILL SVIS,EVIS,04070 RETURN4499 ;4500 PROC SHALL4510 FOR R=0TO194520 FOR C=0TO194530 COORD.C,R:IF FIELD(I)=BOMB THEN DISP.C,R,BOMB:GOTO 45404538 P=FIELD(I)+48:DISP.C,R,P4540 NEXT4543 PROG.R,194545 NEXT4550 RETURN4999 ;5000 PROC MCALC5010 LET<NB=0:MSG$="INIT"5020 FORI=0TO3995025 FI=FIELD(I)5030 COMP FI,BOMB:[BEQ 5130]5040 ADD S=I+01:COMPS,400:[BCS 5050]5045 IF FIELD(S)=BOMB THEN INC NB5050 SUB S=I-01:COMPS,0:[BCC 5060]5055 IF FIELD(S)=BOMB THEN INC NB5060 ADD S=I+20:COMPS,400:[BCS 5070]5065 IF FIELD(S)=BOMB THEN INC NB5070 SUB S=I-20:COMPS,0:[BCC 0]5075 IF FIELD(S)=BOMB THEN  INC NB5080 ADD S=I+21:COMPS,400:[BCS 5090]5085 IF FIELD(S)=BOMB THEN INC NB5090 ADD S=I+19:COMPS,400:[BCS 5100]5095 IF FIELD(S)=BOMB THEN INC NB5100 SUB S=I-19:COMPS,0:[BCC 5105]5105 IF FIELD(S)=BOMB THEN INC NB5110 SUB S=I-21:COMPS,0:[BCC 5120]5115 IF FIELD(S)=BOMB THEN INC NB5120 FIELD(I)=NB:LET NB=0:PROG.I,3995130 NEXT5140 RETURN5999 ;6000 PROC WIND6005 LN=LEN(MSG$):SUB LN=17-LN:HALF LN6020 POKE646,WHT:LOC11,11;"�����������������"6030 LOC11,12;"�";DUP$(" ",15);"�"6040 POKE646,WHT:LOC11,13;"�����������������"6045 POKE646,RED:LOC11,12;SPC(LN);MSG$6050 RETURN6199 ;6200 PROC SVSCR6210 COPY 1024,2024,409606215 COPY 55296,56295,419616220 RETURN6249 ;6250 PROC RSTSCR6260 COPY 40960,41960,10246265 COPY 41961,42961,552966270 RETURN6399 ;6400 PROC MCONF6410 SVSCR:POKE646,WHT:POKE19,65:RT$=CHR$(13):C=06415 LOC 12,11;"������������������"6420 LOC 12,13;"������������������"6430 LOC 12,12;"�                �"6435 LOC 17,12;"BOMBS="6437 LOC 23,12;6440 GETK$:IF K$="" THEN 64406443 V=VAL(K$)6445 IFC=0THEN IFV>0ANDV<5THEN D1=V:INCC:LOC 23,12;:PRINTK$:GOTO64406450 IFC=1THEN IFV>=0ANDV<=9THEN D2=V:INCC:LOC 24,12;:PRINTK$:GOTO64406452 IF K$=RT$ THEN 64556453 GOTO 64406455 IF C=1 THEN TBOMBS=D16457 IF C=2 THEN TBOMBS=D1*10+D26460 RSTSCR:SCORES:POKE646,LTGN6470 RESTART6480 RETURN6599 ;6600 PROC MABOUT6610 MSG$="�IRONBORN 65�"6620 SVSCR6630 WIND6640 GETK$:IFK$=""THEN 66406650 RSTSCR6660 RETURN6699 ]6700 PROC MSHALL6710 SVSCR6720 SHALL6730 KEYPRESS6740 RSTSCR6750 RETURN