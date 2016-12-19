.include "m16def.inc" ; 
.def X1m=r17 
.def X1exp=r18 
.def X2m=r19 
.def X2exp=r20 
.def X4m=r21 
.def X4exp=r22 
.def Mm=r23 
.def Mexp=r24 
.def Rm=r25 
.def Rexp=r26 
.def Km=r27 
.def Kexp=r28 
.def Vexp=r30 
.def Vm=r31 
.def Cm=r29 
rjmp reset ; 
.org 0x0030 ; 
reset: 
ldi temp,low(RAMEND) ; 
out SPL,TEMP ; 
ldi temp,high(RAMEND) 
out SPH,TEMP 
;-Ч назначение значений регистровЧ- 
ldi X1m,5 
ldi X1exp,8 
ldi X2m,4 
ldi X2exp,8 
ldi X4m,2 
ldi X4exp,8 
ldi Mm,7
ldi Mexp,8 
ldi Rm,5
ldi Rexp,8 
ldi Km,2
ldi Kexp,8 
;-Ч вызов подпрограммыЧ- 
rcall pprog 
;--------сравнение экспонент и мантис Ч--------Ч 
.def Cexp= r28 
.def Nm=r17 
.def Nexp=r18 
ldi Nm,-3 
ldi Nexp,3
cp Cexp,Nexp 
cp Cm,Nm 
brne m1 
.def Nm=r17 
.def Nexp=r18 
ldi Nm,0 
ldi Nexp,3 
cp Cexp,Nexp 
cp Cm,Nm 
brlo m2 
rjmp exit 
exit: 
nop 

;--------назначение usl 1 и usl 2----------Ч 
usl 1: 
rcall m1 
rjmp exit 
usl 2: 
rcall m2 
rjmp exit 
;-------pprog 1-------Ч 
pprog 1: 
.def X1m=r17 
.def X1exp=r18 
.def X2m=r19 
.def X2exp=r20 
.def Mm=r23 
.def Mexp=r24 
.def Cm= r29 
.def Cexp= r28 
ldi X1m,5 
ldi X1exp,8 
ldi X2m,4 
ldi X2exp,8 
ldi Mm,7
ldi Mexp,8 
;--------сравнение экспонент-----------Ч 
cp X1exp,x2exp 
brne exit 
cp x1exp, Mexp 
brne exit 
;-----------арефметич.действ-------------Ч 
sub x1m,x2m 
sub x1m,Mm 
mov Cm,x1m 
mov Cexp,x1exp 
ret
;-Ч вызов метки m1Ч- 
m1: 
.def X4m=r21 
.def X4exp=r22 
.def Rm=r25 
.def Rexp=r26 
.def Vexp=r30 
.def Vm=r31 
ldi X4m,2 
ldi X4exp,8 
ldi Rm,5
ldi Rexp,8 
ldi Cm,-3
ldi Cexp,3 
;--------сравнение экспонент--------------Ч 
cp Cexp,x4exp 
brne exit 
cp Cexp, Rexp 
brne exit 
;-----------арефметич.действ-------------Ч 
add Cm,X4 
sub Cm,Rm 
mov Vm,Cm 
mov Vexp,Cexp 
ret 
;-Чвызов m2Ч- 
m2: 
.def X4m=r21 
.def X4exp=r22 
.def Km=r27 
.def Kexp=r28 
.def Vexp=r30 
.def Vm=r31 
.def Cm=r17 
.def Cexp=r18 

ldi X4m,2 
ldi X4exp,8 
ldi Km,2
ldi Kexp,8 
ldi Cm,0
ldi Cexp,3 
;-----------арефметич.действ-------------Ч 
add Cm,X4m 
add Cm,Km 
mov Vm,Cm 
mov Vexp,Cexp 
ret
