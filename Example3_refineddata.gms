file file1;
put file1;

option solprint=on;

*option Lp=CPLEX;
*option Lp=CPLEX;

SETS
P PARCELS TO BE UNLOADED BY VLCCs or ULCCs /P1*P24/
*VCP(V,P) SHIP CARRYING PARCEL P /V1.(P1*P3),V2.(P4*P5),V3.(P6*P7)/
LP(P) /P4, P8, P12, P16, P20, P24/
K SLOTS /1*6/
S TANKS /S1*S4/
SK(S,K) /S1.(1*6), S2.(1*6), S3.(1*6),S4.(1*6)/
SKL(S,K)/S1.6, S2.6, S3.6, S4.6/
PS(P,S) /(P1,P2,P3,P4,P5,P6,P7,P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24).S1, (P1,P2,P3,P4,P5,P6,P7,P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24).S2, (P1,P2,P3,P4,P5,P6,P7,P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24).S3,(P1,P2,P3,P4,P5,P6,P7,P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24).S4/
O ORDERS /O1*O20/
OS(S,O) ORDERS FROM TANKS / S1.(O4,O5, O9, O13), S2.(O2, O8,O12, O14, O16, O17, O18), S3.(O3,O6, O10, O15), S4.(O1, O7, O11, O19, O20)/
M CRUDE PROPERTIES /M1*M3/
N /N1*N10/
W  Weight based properties /w1*w2/

;

SETS
X1(N,S,P,K) DYNAMIC SET WITH X VALUES AS 1

X2(N,S,P,K) DYNAMIC SET WITH X VALUES AS 0

A1(S,K)    DYNAMIC SET FOR +VE bilinear terms with inventory
A2(S,K)    DYNAMIC SET FOR -VE bilinear terms with inventory
B1(S,K)    DYNAMIC SET FOR +VE bilinear terms with order
B2(S,K)    DYNAMIC SET FOR -VE bilinear terms with order
E1(S,K)    DYNAMIC SET FOR +VE trilinear terms with inventory
E2(S,K)    DYNAMIC SET FOR -VE bilinear terms with inventory
F1(S,K)    DYNAMIC SET FOR +VE bilinear terms with order
F2(S,K)    DYNAMIC SET FOR -VE bilinear terms with order

;




ALIAS
(K,KK,KKK),(P,PP,PPP),(O,OO)  ;

Sets
PPS(PP,S) /(P1,P2,P3,P4,P5,P6,P7,P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24).S1, (P1,P2,P3,P4,P5,P6,P7,P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24).S2, (P1,P2,P3,P4,P5,P6,P7,P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24).S3,(P1,P2,P3,P4,P5,P6,P7,P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24).S4/
OOS(S,OO)/ S1.(O4,O5, O9, O13), S2.(O2, O8,O12, O14, O16, O17, O18), S3.(O3,O6, O10, O15), S4.(O1, O7, O11, O19, O20)/
SKk(S,kK)/S1.6, S2.6, S3.6, S4.4/
PARAMETERS
NX /1/

PARAMETERS

MN /0/
MP/0/


PARAMETERS

ETA(P) ESTIMATED TIME OF ARRIVAL OF VLCC OR ULCC/P1 5, P2 14.667, P3 21.524, P4 31.524, P5 43.10, P6 53.10, P7 64.702, P8 71.254, P9 80.81, P10 91.41, P11 107.73, P12 119.43, P13 125, P14 138.81, P15 150.85, P16 165.419, P17 176.83, P18 184.642, P19 190.017, P20 206.817, P21 222.766, P22 240.643, P23 258.643, P24 270.122/

STD(P) STIPULATED TIME OF DEPARTURE OF VLCC OR ULCC- UPPER LIMIT IN HOURS /P4 60, P8 100, P12 150, P16 200, P20 250, P24 320/

IPFU(P) INCOMING PUMPING RATE OF PARCELS IN KBBL PER HOUR/P1 30, P2 35, P3 25, P4 22, P5 19, P6 24, P7 25, P8 29, P9 27, P10 25, P11 19, P12 23.5, P13 21, P14 22, P15 19.5,P16 18.4, P17 32, P18 32, P19 25, P20 22, P21 24, P22 25, P23 29, P24 27/

Q(P) VOLUME OF EACH PARCEL /P1 290, P2 240, P3 250, P4 230, P5 220, P6 240, P7 290, P8 190, P9 258, P10 265, P11 310, P12 275, P13 390, P14 365, P15 384, P16 310, P17 250, P18 300, P19 320, P20 350, P21 470, P22 450, P23 350, P24 370/

DRU(S)  OUTGOING PUMPING RATE OF ORDERS IN KBBL PER HOUR /S1 20, S2 24, S3 27, S4 29/

CAPU(S) MAX CAPACITY OF TANK IN KBBL /S1 2000, S2 2000, S3 2000, S4 2000/

RQ(O) UPPER LIMIT REQUISITE VOLUME OF EACH ORDER /O1 550, O2 420, O3 420, O4 410, O5 490, O6 380, O7 390, O8 440, O9 325, O10 370, O11 390, O12 285,  O13 490, O14 420, O15 380, O16 450, O17 480, O18 390, O19 300, O20 430/

DDL(O) DELIVERY DEMAND DUE DATE OF ORDERS- LOWER LIMIT IN HOURS /O1 16, O2 40, O3 55, O4 80, O5 110, O6 140, O7 160, O8 180, O9 200, O10 225, O11 250, O12 270, O13 300, O14 340, O15 350, O16 360, O17 390, O18 420, O19 435, O20 450 /
*
DDU(O) DELIVERY DEMAND DUE DATE OF ORDERS-UPPER LIMIT IN HOURS /O1 32, O2 60, O3 70, O4 98, O5 122, O6 159, O7 170, O8 195, O9 220, O10 245,O11 260, O12 295, O13 320, O14 360, O15 370, O16 400, O17 410, O18 430, O19 450, O20 470/

I0(S) /S1 600, S2 500, S3 520, S4 550/

DC(P) DEMURRAGE COST ASSOCIATED WITH EACH SHIP IN $ PER HOUR/P4 120, P8 150, P12 100, P16 100, P20 130, P24 90/
*/P2 100/
*
DCO(O) DEMURRAGE COST ASSOCIATED WITH EACH ORDER IN $ PER HOUR /O1 20, O2 13, O3 19, O4 22, O5 14, O6 15, O7 15, O8 16, O9 20, O10 12, O11 21, O12 19, O13 22, O14 23, O15 24, O16 25, O17 24, O18 25, O19 26, O20 26/
ECO(O) DEMURRAGE COST ASSOCIATED WITH EACH ORDER IN $ PER HOUR /O1 11, O2 13, O3 11, O4 12, O5 14, O6 15, O7 15, O8 16, O9 10, O10 12, O11 11, O12 13, O13 12, O14 13, O15 14, O16 15, O17 14, O18 15, O19 16, O20 16/



IC(S) INVENTORY COST ASSOCIATED WITH EACH TANK IN $ PER HOUR/S1 0.2, S2 0.3, S3 0.4, S4 0.2/

*CP(P) CURRENT COST OF CRUDE PARCELS IN $ PER UNIT VOLUME /P1 25, P2 24, P3 27, P4 20, P5 24, P6 22, P7 17.5, P8 19, P9 20, P10 15, P11 22, P12 21, P13 19, P14 21, P15 22, P16 18.5 /
* P5 22, P6 18, P7 21/

*SP(O) COST OF SELLING ORDERS IN $ PER UNIT VOLUME /O1 60, O2 65, O3 62, O4 59, O5 57/

BST /8/

*CO /10/


 CL0(M,S) VOLUME BASED PROPERTY IN TANK INITIALLY

/        M1.S1 0.76,     M1.S2 0.82,     M1.S3 0.88,     M1.S4 0.87

         M2.S1 4.5,      M2.S2 6,        M2.S3 9,        M2.S4 13

         M3.S1 16.3,     M3.S2 17,       M3. S3 18.5,    M3.S4 15.2
/

CLL(M,S)

/        M1.S1 0.70,      M1.S2 0.78,    M1.S3 0.82,     M1.S4 0.85

         M2.S1 2.5,       M2.S2 5.0,     M2.S3 7,        M2.S4 10

         M3.S1 12.3,      M3.S2 12.35,   M3.S3 12.24,    M3.S4 12.5

/

CLU(M,S)

/        M1.S1 0.80,     M1.S2 0.85,     M1.S3 0.92,     M1.S4 0.95

         M2.S1 6,        M2.S2 9.2,      M2.S3 12,      M2.S4 15

         M3.S1 20.5,     M3.S2 21.10,    M3.S3 30,      M3.S4 20.5


/


CK(P,M)   VOLUME BASED PROPERTIES OF PARCELS

/        P1.M1  0.91,    P1.M2 12,        P1.M3 17.44
         P2.M1  0.89,    P2.M2 10.6,      P2.M3 12.5
         P3.M1  0.78,    P3.M2 5.22,      P3.M3 17.5
         P4.M1  0.90,    P4.M2 8.5  ,     P4.M3 18.25
         P5.M1  0.73,    P5.M2 5.6,       P5.M3 13.33
         P6.M1  0.90,    P6.M2 10.2,      P6.M3 12.93
         P7.M1  0.72,    P7.M2 6.00 ,     P7.M3 17.33
         P8.M1  0.81,    P8.M2 8.46  ,    P8.M3 14.33
         P9.M1  0.87,    P9.M2 7.7  ,     P9.M3 12.44
         P10.M1 0.79,    P10.M2 6.4  ,    P10.M3 15.33
         P11.M1 0.81,    P11.M2 6.9  ,    P11.M3 16.15
         P12.M1 0.86,    P12.M2 8.4  ,    P12.M3 20.13
         P13.M1 0.75,    P13.M2 4.8  ,    P13.M3 18.43
         P14.M1 0.89,    P14.M2 8.94  ,   P14.M3 19.13
         P15.M1 0.85,    P15.M2 8.34  ,   P15.M3 12.39
         P16.M1 0.91,    P16.M2 12.4  ,   P16.M3 15.47
         P17.M1 0.78,    P17.M2 5.5,      P17.M3 14.42
         P18.M1 0.83,    P18.M2 8.4,      P18.M3 15.32
         P19.M1 0.89,    P19.M2 11.5,     P19.M3 15.79
         P20.M1 0.94,    P20.M2 12.3,     P20.M3 16.78
         P21.M1 0.89,    P21.M2 12.9,     P21.M3 19.33
         P22.M1 0.87,    P22.M2 13.5,     P22.M3 15.93
         P23.M1 0.83,    P23.M2 6.8,      P23.M3 20.33
         P24.M1 0.75,    P24.M2 4.4,      P24.M3 18.25
/



WP0(W,S) WEIGHT BASED PROPERTY IN TANK INITIALLY

/        w1.s1 0.023,    w1.s2 0.005,     w1.s3 0.035,     w1.s4 0.04
         w2.s1 0.085,    w2.s2 0.100,    w2.s3 0.122,     w2.s4 0.116

/


WPL(W,S) WEIGHT BASED PROPERTY LOWER LIMIT

/        w1.s1 0.011,     w1.s2 0.002,     w1.s3 0.025,      w1.s4 0.035
         w2.s1 0.05,      w2.s2 0.065,     w2.s3 0.067,      w2.s4 0.072

/

WPU(W,S) WEIGHT BASED PROPERTY UPPER LIMIT

/        w1.s1 0.03,     w1.s2 0.015,      w1.s3 0.040,      w1.s4 0.06
         w2.s1 0.222,    w2.s2 0.175,      w2.s3 0.178,      w2.s4 0.192

/




CKW(P,W) WEIGHT BASED PROPERTIES OF PARCELS
/        P1.w1 0.036 ,    P1.W2 0.085
         P2.w1 0.04   ,  P2.W2 0.079
         P3.w1 0.016 ,    P3.W2 0.067
         P4.w1 0.026 ,    P4.W2 0.1
         P5.w1 0.019 ,   P5.W2 0.129
         P6.w1 0.039 ,   P6.W2 0.145
         P7.w1 0.025 ,   P7.W2 0.099
         P8.w1 0.028 ,    P8.W2 0.087
         P9.w1 0.036 ,    P9.W2 0.087
         P10.w1 0.008 ,  P10.W2 0.097
         P11.w1 0.006 ,  P11.W2 0.137
         P12.w1 0.004 ,  P12.W2 0.156
         P13.w1 0.017,    P13.w2 0.082
         P14.w1 0.003,    P14.w2 0.082
         P15.w1 0.028,   P15.w2 0.091
         P16.w1 0.037,    P16.w2 0.089
         P17.w1 0.016,    P17.w2 0.087
         P18.w1 0.008,    P18.w2 0.095
         P19.w1 0.026,    P19.w2 0.125
         P20.w1 0.036,    P20.w2 0.155
         P21.w1 0.043,    P21.w2 0.079
         P22.w1 0.039,    P22.w2 0.085
         P23.w1 0.009,    P23.w2 0.099
         P24.w1 0.027,    P24.w2 0.128
/




QL(S) /  S1 0,            S2 0,           S3 0,           S4 0/

QU(S) /  S1 1225,         S2 1185,        S3 1220,        S4 1330/

PI(S,K)

/        S1.1 0,         S1.2 0,         S1.3 0,         S1.4 0
         S2.1  0,        S2.2 0,         S2.3 0,         S2.4 0
         S3.1 0,         S3.2 0,         S3.3  0,        S3.4 0
         S4.1 0,         S4.2 0,         S4.3  0,        S4.4 0/

PO(S,O,K)

/        S1.O1.1 0,      S1.O1.2 0,      S1.O1.3 0,      S1.O1.4 0
         S2.O2.1 0 ,     S2.O2.2 0,      S2.O2.3 0,      S2.O2.4 0
         S3.O3.1 0,      S3.O3.2 0,      S3.O3.3 0,      S3.O3.4 0
         S4.O3.1 0,      S4.O3.2 0,      S4.O3.3 0,      S4.O3.4 0
/


CLK(M,S,K)

/        M1.S1.1 1,      M1.S1.2 1,      M1.S1.3 1,      M1.S1.4 1
         M1.S2.1 1,      M1.S2.2 1,      M1.S2.3 1,      M1.S2.4 1
         M1.S3.1 1,      M1.S3.2 1,      M1.S3.3 1,      M1.S3.4 1
         M1.S4.1 1,      M1.S4.2 1,      M1.S4.3 1,      M1.S4.4 1
/

CLKI(M,S,K)

/        M1.S1.1 1,      M1.S1.2 1,      M1.S1.3 1,      M1.S1.4 1
         M1.S2.1 1,      M1.S2.2 1,      M1.S2.3 1,      M1.S2.4 1
         M1.S3.1 1,      M1.S3.2 1,      M1.S3.3 1,      M1.S3.4 1
         M1.S4.1 1,      M1.S4.2 1,      M1.S4.3 1,      M1.S4.4 1
/


WPK(W,S,K)

/W1.S1.1 0/;


*CLKI('M1',S,K)=(1/CLK('M1',S,K));


SCALARS

H SCHEDULING HORIZON /900/

NK
NP
;

NK=CARD(K);
NP=CARD(P);
VARIABLES
nlpobj
nlpobj1
cost1

slack
;
POSITIVE VARIABLES

T,TS,TE,QI,QO,I,D,CL,A,B,QS,COST2,WP,E,F,yc ;

POSITIVE VARIABLES

APSL,ANSL,BPSL, BNSL,EPSW,ENSW,FPSW,FNSW,PX,PY,WI,bs,v;



BINARY VARIABLES
X,Y;
EQUATIONS
** VLCC TANK CONNECTION
CONST3(P)

CONST5(P)

CONST6(P)
CONST7(S,P)
CONST8(P)
CONST9(S,P,K)
CONST10(S,K)
CONST10b(S,K)
const10c(s,k)
CONST18(O)
cONST18a(S,o,K)
CONST18b(S,K)
const18c(s,k)
CONST13(S,P,K)
CONST14(P)
CONST15(P)
CONST16(S,P,K)
CONST17(S,P,K)
CONST19(S,O,K)
CONST20(O)
CONST22(S,O,K)
CONST22A(S,O,K)
CONST22B(S,O,K)
const22c(s,o,k)
*CONST24(S,O,K)
CONST24(O)

CONST26(S,K)

 OBJ1

**VOLUME BASED PROPERTIES

CONST27v(M,S,K)
CONST28v(M,S,K)
CONST29v(M,S,K)
CONST30v(M,S,K)
CONST31v(M,S,K)
CONST32v(M,S,K)
CONST33v(M,S,K)
CONST34v(M,S,K)
CONST35v(M,S,K)
CONST36v(S,K)

**WEIGHT BASED PROPERTIES
CONST27w
*CONVEX ENVELOPES
CONST28w
CONST29w
CONST30w
CONST31w
CONST31_1w
CONST31_2w
CONST32w
CONST33w
CONST34w
CONST35w
CONST35_1w
CONST35_2w

**WEIGHT BASED PROPERTIES+CONCAVE ENVELOPES

CONST28cw
CONST29cw
CONST30cw
CONST31cw
CONST31_1cw
CONST31_2cw

CONST32cw
CONST33cw
CONST34cw
CONST35cw
CONST35_1cw
CONST35_2cw

**MILP1
*VOLUME BASED PROPERTY BALANCE
CONST41_m1v
CONST42_m1v
*WEIGHT BASED PROPERTY BALANCE
CONST41_m1w
CONST42_m1w

****INTEGER CUTS for MILP0CUT AND milp2

CONST43_m1(N)


**NLP EQUATIONS

CONST3_n(P)
CONST5_n(P)
CONST6_n(P)
CONST7_n(S,P)
CONST8_n(P)
CONST9_n(S,P,K)
CONST10_n(S,K)

CONST10b_n(S,K)
const10c_n(s,k)

CONST13_n(S,P,K)
CONST14_n(P)
CONST15_n(P)
CONST16_n(S,P,K)
CONST17_n(S,P,K)
CONST18_n(O)


CONST18a_n(S,o,K)

CONST18b_n(S,K)

const18c_n(s,k)



CONST19_n(S,O,K)
CONST20_n(O)
CONST22_n(S,O,K)
const22c_n(s,o,k)
CONST22A_n(S,O,K)
CONST22B_n(S,O,K)
*CONST24_n(S,O,K)
CONST24_n(O)
*INVENTORY BALANCE
CONST26_n1(S,K)
CONST26_n2(S,K)
*VOLUME BASED PROPERTY BALANCE
CONST27A_nv1(M,S,K)
CONST27B_nv1(M,S,K)
CONST27C_nv1(M,S,K)
CONST27A_nv2(M,S,K)
CONST27B_nv2(M,S,K)
CONST27C_nv2(M,S,K)

CONST27D_nv(M,S,K)

**WEIGHT BASED PROPERTY BALANCE
CONST27A_nw(W,S,K)
CONST27B_nw1(W,S,K)
CONST27B_nw2(W,S,K)
CONST27C_nw1(W,S,K)
CONST27C_nw2(W,S,K)
CONST27D_nw1(W,S,K)
CONST27D_nw2(W,S,K)
**SLACK VARIABLE SUMMATION
CONST47_n

obj2

*NLP1
CONST27_nv(M,S,K)

CONST27_nw(W,S,K)

const48_n
*
obj3

;


CONST3(P).. TS(P)=G=ETA(P);

CONST5(P)..   TE(P)=G=TS(P)+(Q(P)/IPFU(P));

CONST6(P)$(ord(p) gt 1) ..   TS(P)=G=TE(P-1);

CONST7(S,P)$PS(P,S)..    SUM(K$(SK(S,K) AND (ORD(K) GT 1)),X(S,P,K))=L=1;

CONST8(P)..          SUM((K,S)$((ORD(K) GT 1) AND SK(S,K) AND PS(P,S)and (ord(k) gt 1)),X(S,P,K))=G=1;

CONST9(S,P,K)$(SK(S,K) AND PS(P,S)and (ord(k) gt 1))..      BS(S,K)=G=X(S,P,K);

CONST10(S,K)$(SK(S,K)and (ord(k) gt 1))..               BS(S,K)=L=SUM(P$PS(P,S),X(S,P,K));

CONST10b(S,K)$(sk(s,k)and (ord(k) gt 1))..              BS(S,K)+ v(s,k)+wi(s,k)=e=1;
*CONST10b(S,o,K)$(os(s,o) and sk(s,k)and (ord(k) gt 1))..              BS(S,K)+ y(s,o,k)+wi(s,k)=e=1;

const10c(s,k)$(sk(s,k) and (ord(k) gt 1))..            bs(s,k)+bs(s,k+1)=l=1;

CONST18(O)..                               SUM((S,K)$(SK(S,K) AND OS(S,O) and (ord(k) gt 1)),Y(S,O,K))=L=1;


CONST18a(S,o,K)$(SK(S,K) and os(s,o) and (ord(k) gt 1))..      v(S,K)=g=y(S,o,K);

CONST18b(S,K)$(SK(S,K)and (ord(k) gt 1))..               v(S,K)=L=SUM(o$os(s,o),y(S,o,K));

const18c(s,k)$(SK(S,K)and (ord(k) gt 1))..                  T(S,k)=g=T(s,k-1);

**BINARY BINARY MULTIPLICATION


CONST13(S,P,K)$(SK(S,K) AND PS(P,S)and (ord(k) gt 1)) ..       QI(S,P,K)=L=Q(P)*X(S,P,K);

CONST14(P)..                  SUM((S,K)$(SK(S,K) AND PS(P,S) AND (ORD(K) GT 1)),QI(S,P,K))=E=Q(P);

CONST15(P)$LP(P)..                        D(P)=G=TE(P)-STD(P);
*
CONST16(S,P,K)$(SK(S,K) AND PS(P,S)and (ord(k) gt 1)) ..     T(S,K)=G=TE(P)+sum(pp$(pps(pp,s) and (ord(pp) gt ord(p))),(qi(s,pp,k)/IPFU(pp)))+BST*BS(S,K)-H*(1-X(S,P,K));                                 ;
*
CONST17(S,P,K)$(SK(S,K) AND PS(P,S) and (ord(k) gt 1)) ..     T(S,K-1)=L=TS(P)-sum(pp$(pps(pp,s) and (ord(pp) lt ord(p))),(qi(s,pp,k)/IPFU(pp)))+H*(1-X(S,P,K));


CONST19(S,O,K)$(SK(S,K) AND OS(S,O)and (ord(k) gt 1))..              QO(S,O,K)=L=RQ(O)*Y(S,O,K);
*
CONST20(O)..                            SUM((S,K)$(SK(S,K) AND OS(S,O)and (ord(k) gt 1)),QO(S,O,K))=E=RQ(O);


CONST22(S,O,K)$((ORD(K) GT 1)AND SK(S,K) AND OS(S,O))..      TE(O)=G=TS(O)+RQ(O)/DRU(S);

const22c(s,o,k)$((ORD(K) GT 1)AND SK(S,K) AND OS(S,O))..      TS(O)=G=DDL(O);

CONST22A(S,O,K)$(SK(S,K) AND OS(S,O)and (ord(k) gt 1)) ..     T(S,K)=G=TE(O)+sum(oo$(oos(s,oo) and (ord(oo) gt ord(o))),(qo(s,oo,k)/DRU(s)))-H*(1-Y(S,O,K));
*
CONST22B(S,O,K)$(SK(S,K) AND OS(S,O) and (ord(k) gt 1)) ..    T(S,K-1)=L=TS(O)-sum(oo$(oos(s,oo) and (ord(oo) lt ord(o))),(qo(s,oo,k)/DRU(s)))+H*(1-Y(S,O,K));

*CONST24(S,O,K)$(SK(S,K) AND OS(S,O)and (ord(k) gt 1))..            D(O)=G=T(S,K)-DDU(O)-H*(1-Y(S,O,K)) ;
CONST24(O)..            D(O)=G=TE(o)-DDU(O) ;

*INVENTORY BALANCE

CONST26(S,K)$(SK(S,K) and (ord(k) gt 1))..     I(S,K)=E=I(S,K-1)+SUM(P$PS(P,S),QI(S,P,K))-SUM((O)$OS(S,O),QO(S,O,K));

OBJ1..            cost1=E=  SUM(P,(D(P)*DC(P)))+SUM(P,(D(P)*DC(P)))+SUM(O,(D(O)*DCO(O)))+sum(o,ECO(O)*(TS(o)-DDL(O)));

*VOLUME BASED PROPERTY BALANCE

CONST27v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=E=A(M,S,K-1)+ SUM(P$PS(P,S),QI(S,P,K)*CK(P,M))-B(M,S,K);

**MCCORMICK'S CONVEX CONCAVE  FOR VOLUME BASED PROPERTIES

CONST28v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=G=0*CL(M,S,K)+CLL(M,S)*I(S,K)-0*CLL(M,S);

CONST29v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=G=CAPU(S)*CL(M,S,K)+CLU(M,S)*I(S,K)-CAPU(S)*CLU(M,S);

CONST30v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=L=CAPU(S)*CL(M,S,K)+CLL(M,S)*I(S,K)-CAPU(S)*CLL(M,S);

CONST31v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=L=0*CL(M,S,K)+CLU(M,S)*I(S,K)-0*CLL(M,S);

CONST32v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1))..B(M,S,K)=G=QL(S)*CL(M,S,K-1)+CLL(M,S)*QS(S,K)-QL(S)*CLL(M,S);

CONST33v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1))..B(M,S,K)=G=QU(S)*CL(M,S,K-1)+CLU(M,S)*QS(S,K)-QU(S)*CLU(M,S);

CONST34v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1))..B(M,S,K)=L=QU(S)*CL(M,S,K-1)+CLL(M,S)*QS(S,K)-QU(S)*CLL(M,S);

CONST35v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1))..B(M,S,K)=L=QL(S)*CL(M,S,K-1)+CLU(M,S)*QS(S,K)-QL(S)*CLU(M,S);

CONST36v(S,K)$(SK(S,K) AND (ORD(K) GT 1))..  SUM(O$OS(S,O),QO(S,O,K))=E=QS(S,K);

**WEIGHT BASED PROPERTIES +CONVEX ENVELOPES

CONST27w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=E=E(W,S,K-1)+ SUM(P$PS(P,S),(QI(S,P,K)*CKW(P,W)*CK(P,'M1')))-F(W,S,K);

CONST28w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=g=CLL('M1',S)*WPL(W,S)*I(S,K)+0*WPL(W,S)*CL('M1',S,K)+0*CLL('M1',S)*WP(W,S,K)-2*0*CLL('M1',S)*WPL(W,S);

CONST29w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1))..E(W,S,K)=g=CLU('M1',S)*WPU(W,S)*I(S,K)+CAPU(S)*WPU(W,S)*CL('M1',S,K)+CAPU(S)*CLU('M1',S)*WP(W,S,K)-2*CAPU(S)*CLU('M1',S)*WPU(W,S);

CONST30w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=g=CLL('M1',S)*WPU(W,S)*I(S,K)+0*WPU(W,S)*CL('M1',S,K)+CAPU(S)*CLL('M1',S)*WP(W,S,K)-0*CLL('M1',S)*WPU(W,S)-CAPU(S)*CLL('M1',S)*WPU(W,S);

CONST31w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=g=CLU('M1',S)*WPL(W,S)*I(S,K)+CAPU(S)*WPL(W,S)*CL('M1',S,K)+0*CLU('M1',S)*WP(W,S,K)-CAPU(S)*CLU('M1',S)*WPL(W,S)-0*CLU('M1',S)*WPL(W,S);

CONST31_1w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=g=((CAPU(S)*CLU('M1',S)*WPL(W,S)-0*CLU('M1',S)*WPU(W,S)-CAPU(S)*CLL('M1',S)*WPL(W,S)+ CAPU(S)*CLL('M1',S)*WPU(W,S))/(CAPU(S)-0))*I(S,K)+CAPU(S)*WPL(W,S)*CL('M1',S,K)+CAPU(S)*CLL('M1',S)*WP(W,S,K)
                                        -((CAPU(S)*CLU('M1',S)*WPL(W,S)-0*CLU('M1',S)*WPU(W,S)-CAPU(S)*CLL('M1',S)*WPL(W,S)+ CAPU(S)*CLL('M1',S)*WPU(W,S))/(CAPU(S)-0))*0-CAPU(S)*CLU('M1',S)*WPL(W,S)-CAPU(S)*CLL('M1',S)*WPU(W,S)+0*CLU('M1',S)*WPU(W,S);

CONST31_2w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=g=((0*CLL('M1',S)*WPU(W,S)-CAPU(S)*CLL('M1',S)*WPL(W,S)-0*CLU('M1',S)*WPU(W,S)+ 0*CLU('M1',S)*WPL(W,S))/(0-CAPU(S)))*I(S,K)+0*WPU(W,S)*CL('M1',S,K)+0*CLU('M1',S)*WP(W,S,K)
                                        -((0*CLL('M1',S)*WPU(W,S)-CAPU(S)*CLL('M1',S)*WPL(W,S)-0*CLU('M1',S)*WPU(W,S)+ 0*CLU('M1',S)*WPL(W,S))/(0-CAPU(S)))*CAPU(S)-0*CLL('M1',S)*WPU(W,S)-0*CLU('M1',S)*WPL(W,S)+CAPU(S)*CLL('M1',S)*WPL(W,S);

***WEIGHT BASED PROPERTIES AND CONCAVE ENVELOPE

CONST28cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=l=CLL('M1',S)*WPL(W,S)*I(S,K)+CAPU(S)*WPL(W,S)*CL('M1',S,K)+CAPU(S)*CLU('M1',S)*WP(W,S,K)-CAPU(S)*CLU('M1',S)*WPL(W,S)-CAPU(S)*CLL('M1',S)*WPL(W,S);

CONST29cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1))..E(W,S,K)=l=CLU('M1',S)*WPL(W,S)*I(S,K)+0*WPL(W,S)*CL('M1',S,K)+CAPU(S)*CLU('M1',S)*WP(W,S,K)-CAPU(S)*CLU('M1',S)*WPL(W,S)-0*CLU('M1',S)*WPL(W,S);      ;

CONST30cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=l=CLL('M1',S)*WPL(W,S)*I(S,K)+CAPU(S)*WPU(W,S)*CL('M1',S,K)+CAPU(S)*CLL('M1',S)*WP(W,S,K)-CAPU(S)*CLL('M1',S)*WPU(W,S)-CAPU(S)*CLL('M1',S)*WPL(W,S);

CONST31cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=l=CLU('M1',S)*WPU(W,S)*I(S,K)+0*WPL(W,S)*CL('M1',S,K)+0*CLU('M1',S)*WP(W,S,K)-0*CLU('M1',S)*WPU(W,S)-0*CLU('M1',S)*WPL(W,S);

CONST31_1cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=l=CLL('M1',S)*WPU(W,S)*I(S,K)+CAPU(S)*WPU(W,S)*CL('M1',S,K)+0*CLL('M1',S)*WP(W,S,K)-CAPU(S)*CLL('M1',S)*WPU(W,S)-0*CLL('M1',S)*WPU(W,S);

CONST31_2cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=l=CLU('M1',S)*WPU(W,S)*I(S,K)+0*WPU(W,S)*CL('M1',S,K)+0*CLU('M1',S)*WP(W,S,K)-0*CLU('M1',S)*WPU(W,S)-0*CLL('M1',S)*WPU(W,S);


CONST32w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=g=CLL('M1',S)*WPL(W,S)*QS(S,K)+QL(S)*WPL(W,S)*CL('M1',S,K-1)+QL(S)*CLL('M1',S)*WP(W,S,K-1)-2*QL(S)*CLL('M1',S)*WPL(W,S);

CONST33w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=g=CLU('M1',S)*WPU(W,S)*QS(S,K)+QU(S)*WPU(W,S)*CL('M1',S,K-1)+QU(S)*CLU('M1',S)*WP(W,S,K-1)-2*QU(S)*CLU('M1',S)*WPU(W,S);

CONST34w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1))..  F(W,S,K)=g=CLL('M1',S)*WPU(W,S)*QS(S,K)+QL(S)*WPU(W,S)*CL('M1',S,K-1)+QU(S)*CLL('M1',S)*WP(W,S,K-1)-QL(S)*CLL('M1',S)*WPU(W,S)-QU(S)*CLL('M1',S)*WPU(W,S);

CONST35w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=g=CLU('M1',S)*WPL(W,S)*QS(S,K)+QU(S)*WPL(W,S)*CL('M1',S,K-1)+QL(S)*CLU('M1',S)*WP(W,S,K-1)-QU(S)*CLU('M1',S)*WPL(W,S)-QL(S)*CLU('M1',S)*WPL(W,S);

CONST35_1w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1))..  F(W,S,K)=g=((QU(S)*CLU('M1',S)*WPL(W,S)-QL(S)*CLU('M1',S)*WPU(W,S)-QU(S)*CLL('M1',S)*WPL(W,S)+ QU(S)*CLL('M1',S)*WPU(W,S))/(QU(S)-QL(S)))*QS(S,K)+QU(S)*WPL(W,S)*CL('M1',S,K-1)+QU(S)*CLL('M1',S)*WP(W,S,K-1)
                                        -((QU(S)*CLU('M1',S)*WPL(W,S)-QL(S)*CLU('M1',S)*WPU(W,S)-QU(S)*CLL('M1',S)*WPL(W,S)+ QU(S)*CLL('M1',S)*WPU(W,S))/(QU(S)-QL(S)))*QL(S)-QU(S)*CLU('M1',S)*WPL(W,S)-QU(S)*CLL('M1',S)*WPU(W,S)+QL(S)*CLU('M1',S)*WPU(W,S);

CONST35_2w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1))..  F(W,S,K)=g=((QL(S)*CLL('M1',S)*WPU(W,S)-QU(S)*CLL('M1',S)*WPL(W,S)-QL(S)*CLU('M1',S)*WPU(W,S)+ QL(S)*CLU('M1',S)*WPL(W,S))/(QL(S)-QU(S)))*QS(S,K)+QL(S)*WPU(W,S)*CL('M1',S,K-1)+QL(S)*CLU('M1',S)*WP(W,S,K-1)
                                        -((QL(S)*CLL('M1',S)*WPU(W,S)-QU(S)*CLL('M1',S)*WPL(W,S)-QL(S)*CLU('M1',S)*WPU(W,S)+ QL(S)*CLU('M1',S)*WPL(W,S))/(QL(S)-QU(S)))*QU(S)-QL(S)*CLL('M1',S)*WPU(W,S)-QL(S)*CLU('M1',S)*WPL(W,S)+QU(S)*CLL('M1',S)*WPL(W,S);


CONST32cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=l=CLL('M1',S)*WPL(W,S)*QS(S,K)+QU(S)*WPL(W,S)*CL('M1',S,K-1)+QU(S)*CLU('M1',S)*WP(W,S,K-1)-QU(S)*CLU('M1',S)*WPL(W,S)-QU(S)*CLL('M1',S)*WPL(W,S);

CONST33cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=l=CLU('M1',S)*WPL(W,S)*QS(S,K)+QL(S)*WPL(W,S)*CL('M1',S,K-1)+QU(S)*CLU('M1',S)*WP(W,S,K-1)-QU(S)*CLU('M1',S)*WPL(W,S)-QL(S)*CLU('M1',S)*WPL(W,S);

CONST34cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1))..  F(W,S,K)=l=CLL('M1',S)*WPL(W,S)*QS(S,K)+QU(S)*WPU(W,S)*CL('M1',S,K-1)+QU(S)*CLL('M1',S)*WP(W,S,K-1)-QU(S)*CLL('M1',S)*WPU(W,S)-QU(S)*CLL('M1',S)*WPL(W,S);

CONST35cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=l=CLU('M1',S)*WPU(W,S)*QS(S,K)+QL(S)*WPL(W,S)*CL('M1',S,K-1)+QL(S)*CLU('M1',S)*WP(W,S,K-1)-QL(S)*CLU('M1',S)*WPU(W,S)-QL(S)*CLU('M1',S)*WPL(W,S);

CONST35_1cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=l=CLL('M1',S)*WPU(W,S)*QS(S,K)+QU(S)*WPU(W,S)*CL('M1',S,K-1)+QL(S)*CLL('M1',S)*WP(W,S,K-1)-QU(S)*CLL('M1',S)*WPU(W,S)-QL(S)*CLL('M1',S)*WPU(W,S);

CONST35_2cw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=l=CLU('M1',S)*WPU(W,S)*QS(S,K)+QL(S)*WPU(W,S)*CL('M1',S,K-1)+QL(S)*CLU('M1',S)*WP(W,S,K-1)-QL(S)*CLU('M1',S)*WPU(W,S)-QL(S)*CLL('M1',S)*WPU(W,S);



**MILP1
*VOLUME BASED PROPERTY BALANCE

CONST41_m1v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=E=I(S,K)*CLK(M,S,K);

CONST42_m1v(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. B(M,S,K)=E=SUM(O$OS(S,O),QO(S,O,K))*CLK(M,S,K-1);


*WEIGHT BASED PROPERTY BALANCE

CONST41_m1w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=E=I(S,K)*CLK('M1',S,K)*WPK(W,S,K);

CONST42_m1w(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=E=SUM(O$OS(S,O),QO(S,O,K))*CLK('M1',S,K-1)*WPK(W,S,K-1);

****INTEGER CUTS for MILP0CUT AND milp2

CONST43_m1(N)$(MN EQ 1).. SUM((S,P,K)$(X1(N,S,P,K) AND (ORD(K) GT 1) AND PS(P,S) AND SK(S,K)),X(S,P,K))-SUM((S,P,K)$(X2(N,S,P,K) AND (ORD(K) GT 1)AND PS(P,S) AND SK(S,K)),X(S,P,K))=L=NX-1;

**NLP EQUATIONS
**EQUATIONS FOR NLP

CONST3_n(P).. TS(P)=G=ETA(P);

CONST5_n(P)..   TE(P)=G=TS(P)+(Q(P)/IPFU(P));
CONST6_n(P)$(ord(p) gt 1) ..   TS(P)=G=TE(P-1);


CONST7_n(S,P)$PS(P,S)..    SUM(K$(SK(S,K) AND (ORD(K) GT 1)),PX(S,P,K))=L=1;

CONST8_n(P)..          SUM((K,S)$((ORD(K) GT 1) AND SK(S,K) AND PS(P,S)and (ord(k) gt 1)),PX(S,P,K))=G=1;

CONST9_n(S,P,K)$(SK(S,K) AND PS(P,S)and (ord(k) gt 1))..      BS(S,K)=G=PX(S,P,K);

CONST10_n(S,K)$(SK(S,K)and (ord(k) gt 1))..               BS(S,K)=L=SUM(P$PS(P,S),PX(S,P,K));

CONST10b_n(S,K)$(SK(S,K) and (ord(k) gt 1))..              BS(S,K)+v(s,k)+wi(s,k)=e=1;
*CONST10b_n(S,o,K)$(SK(S,K) and os(s,o) and (ord(k) gt 1))..              BS(S,K)+py(s,o,k)+wi(s,k)=e=1;

CONST10c_n(S,K)$(SK(S,K) and (ord(k) gt 1))..              BS(S,K)+bs(s,k+1)=l=1;

*
CONST13_n(S,P,K)$(SK(S,K) AND PS(P,S)and (ord(k) gt 1)) ..       QI(S,P,K)=L=Q(P)*PX(S,P,K);

CONST14_n(P)..                  SUM((S,K)$(SK(S,K) AND PS(P,S) AND (ORD(K) GT 1)),QI(S,P,K))=E=Q(P);

CONST15_n(P)$LP(P)..                        D(P)=G=TE(P)-STD(P);
*
CONST16_n(S,P,K)$(SK(S,K) AND PS(P,S)and (ord(k) gt 1)) ..     T(S,K)=G=TE(P)+sum(pp$(pps(pp,s) and (ord(pp) gt ord(p))),(qi(s,pp,k)/IPFU(pp)))+BST*BS(S,K)-H*(1-pX(S,P,K));                                 ;
*
*
CONST17_n(S,P,K)$(SK(S,K) AND PS(P,S) and (ord(k) gt 1)) ..     T(S,K-1)=L=TS(P)-sum(pp$(pps(pp,s) and (ord(pp) lt ord(p))),(qi(s,pp,k)/IPFU(pp)))+H*(1-PX(S,P,K));

CONST18_n(O)..                               SUM((S,K)$(SK(S,K) AND OS(S,O)),PY(S,O,K))=L=1;


CONST18a_n(S,o,K)$(SK(S,K) and os(s,o) and (ord(k) gt 1))..      v(S,K)=g=py(S,o,K);

CONST18b_n(S,K)$(SK(S,K)and (ord(k) gt 1))..               v(S,K)=L=SUM(o$os(s,o),py(S,o,K));

const18c_n(s,k)$(SK(S,K)and (ord(k) gt 1))..                  T(S,k)=g=T(s,k-1);



CONST19_n(S,O,K)$(SK(S,K) AND OS(S,O)and (ord(k) gt 1))..              QO(S,O,K)=L=RQ(O)*PY(S,O,K);
*
CONST20_n(O)..                            SUM((S,K)$(SK(S,K) AND OS(S,O)and (ord(k) gt 1)),QO(S,O,K))=E=RQ(O);


CONST22_n(S,O,K)$((ORD(K) GT 1)AND SK(S,K) AND OS(S,O))..      TE(O)=G=DDL(O)+RQ(O)/DRU(S);

const22c_n(s,o,k)$((ORD(K) GT 1)AND SK(S,K) AND OS(S,O))..      TS(O)=G=DDL(O);

CONST22A_n(S,O,K)$(SK(S,K) AND OS(S,O)and (ord(k) gt 1)) ..    T(S,K)=G=TE(O)+sum(oo$(oos(s,oo) and (ord(oo) gt ord(o))),(qo(s,oo,k)/DRU(s)))-H*(1-PY(S,O,K));      ;
*
CONST22B_n(S,O,K)$(SK(S,K) AND OS(S,O) and (ord(k) gt 1)) ..    T(S,K-1)=L=TS(O)-sum(oo$(oos(s,oo) and (ord(oo) lt ord(o))),(qo(s,oo,k)/DRU(s)))+H*(1-PY(S,O,K));

CONST24_n(O)..            D(O)=G=TE(o)-DDU(O) ;

*INVENTORY BALANCE


CONST26_n1(S,K)$(SK(S,K) and (ord(k) gt 1))..     I(S,K)=E=I(S,K-1)+SUM(P$PS(P,S),QI(S,P,K))-SUM((O)$OS(S,O),QO(S,O,K));
CONST26_n2(S,K)$(SK(S,K) and (ord(k) gt 1))..     QS(S,K)=E=SUM((O)$OS(S,O),QO(S,O,K));

*VOLUME BASED PROPERTY BALANCE

CONST27A_nv1(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=L=I(S,K)*CL(M,S,K)+APSL(M,S,K)  ;

CONST27A_nv2(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=G=I(S,K)*CL(M,S,K)-ANSL(M,S,K);


CONST27B_nv1(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K-1)=L=I(S,K-1)*CL(M,S,K-1)+APSL(M,S,K-1);
*
CONST27B_nv2(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K-1)=G=I(S,K-1)*CL(M,S,K-1)-ANSL(M,S,K-1);

CONST27C_nv1(M,S,K)$(SK(S,K) AND (ORD(K) GT 1))..B(M,S,K) =L= QS(S,K)*CL(M,S,K-1)+BPSL(M,S,K);

CONST27C_nv2(M,S,K)$(SK(S,K) AND (ORD(K) GT 1))..B(M,S,K) =G= QS(S,K)*CL(M,S,K-1)-BNSL(M,S,K);


CONST27D_nv(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. A(M,S,K)=E=A(M,S,K-1)+ SUM(P$PS(P,S),QI(S,P,K)*CK(P,M))-B(M,S,K) ;


**WEIGHT BASED PROPERTY BALANCE

CONST27A_nw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K)=E=E(W,S,K-1)+ SUM(P$PS(P,S),(QI(S,P,K)*CKW(P,W)*CK(P,'M1')))-F(W,S,K);

CONST27B_nw1(W,S,K)$(SK(S,K) AND (ORD(K) GT 1))..  E(W,S,K)=L=I(S,K)*CL('M1',S,K)*WP(W,S,K)+EPSW(W,S,K) ;

CONST27B_nw2(W,S,K)$(SK(S,K) AND (ORD(K) GT 1))..  E(W,S,K)=G=I(S,K)*CL('M1',S,K)*WP(W,S,K)-ENSW(W,S,K) ;

CONST27C_nw1(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K-1)=L=I(S,K-1)*CL('M1',S,K-1)*WP(W,S,K-1)+EPSW(W,S,K) ;

CONST27C_nw2(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. E(W,S,K-1)=G=I(S,K-1)*CL('M1',S,K-1)*WP(W,S,K-1)-ENSW(W,S,K) ;


CONST27D_nw1(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=L=QS(S,K)*CL('M1',S,K-1)*WP(W,S,K-1)+FPSW(W,S,K);

CONST27D_nw2(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. F(W,S,K)=G=QS(S,K)*CL('M1',S,K-1)*WP(W,S,K-1)-FNSW(W,S,K);

**SLACK VARIABLE SUMMATION

CONST47_n..      slack =e=SUM((M,S,K),APSL(M,S,K))+SUM((M,S,K),ANSL(M,S,K))+SUM((M,S,K),BPSL(M,S,K))+SUM((M,S,K),BNSL(M,S,K))+SUM((w,S,K),EPSW(w,S,K))+SUM((w,S,K),ENSW(w,S,K))+SUM((w,S,K),FPSW(w,S,K))+SUM((w,S,K),FNSW(w,S,K));
obj2..           nlpobj =e= slack;

**NLP1

CONST27_nv(M,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. I(S,K)*CL(M,S,K)=E=I(S,K-1)*CL(M,S,K-1)+ SUM(P$PS(P,S),QI(S,P,K)*CK(P,M))-SUM(O$OS(S,O),QO(S,O,K))*CL(M,S,K-1);

CONST27_nw(W,S,K)$(SK(S,K) AND (ORD(K) GT 1)).. I(S,K)*CL('M1',S,K)*WP(W,S,K)=E=I(S,K-1)*CL('M1',S,K-1)*WP(W,S,K-1)+ SUM(P$PS(P,S),(QI(S,P,K)*CKW(P,W)*CK(P,'M1')))-SUM(O$OS(S,O),QO(S,O,K))*CL('M1',S,K-1)*WP(W,S,K-1);

const48_n..     cost2=E= SUM(P,(D(P)*DC(P)))+SUM(O,(D(O)*DCO(O)))+sum(o,ECO(O)*(TS(o)-DDL(O)));
*
obj3..           nlpobj1=e=cost2;




TE.UP(P)=H;
TE.UP(O)=H;
T.fx(S,'1')=0;
T.UP(S,K)=H;

I.UP(S,K)=CAPU(S);
I.FX(S,'1')=I0(S);
CL.FX(M,S,'1')=CL0(M,S);
A.fx(M,S,'1')=CL0(M,S)*I0(S);

E.FX(W,S,'1')=I0(S)*CL0('M1',S)*WP0(W,S);
WP.FX(W,S,'1')=WP0(W,S);
CL.FX('M1',S,'1')=CL0('M1',S);
CL.LO(M,S,K)=CLL(M,S);
CL.UP(M,S,K)=CLU(M,S);
WP.LO(W,S,K)=WPL(W,S);
WP.UP(W,S,K)=WPU(W,S);

model milp0/
CONST3
CONST5
CONST6

CONST7
CONST8
CONST9
CONST10
CONST10b
const10c
CONST18
CONST18a
CONST18b
const18c
CONST13
CONST14
CONST15
CONST16
CONST17

CONST19
CONST20
CONST22
CONST22A
CONST22B
const22c
CONST24
CONST26
OBJ1
**VOLUME BASED PROPERTIES
CONST27v
CONST28v
CONST29v
CONST30v
CONST31v
CONST32v
CONST33v
CONST34v
CONST35v
CONST36v

**WEIGHT BASED PROPERTIES
CONST27w
*CONVEX ENVELOPES (first term)
CONST28w
CONST29w
CONST30w
CONST31w
CONST31_1w
CONST31_2w

**CONCAVE ENVELOPES(first term)

CONST28cw
CONST29cw
CONST30cw
CONST31cw
CONST31_1cw
CONST31_2cw

**convex(second term)
CONST32w
CONST33w
CONST34w
CONST35w
CONST35_1w
CONST35_2w

**concave(second term)
CONST32cw
CONST33cw
CONST34cw
CONST35cw
CONST35_1cw
CONST35_2cw

/



model milp0cut/
CONST3
CONST5
CONST6

CONST7
CONST8
CONST9
CONST10
CONST10b
const10c
CONST13
CONST14
CONST15
CONST16
CONST17
CONST18
CONST18a
CONST18b
const18c

CONST19
CONST20
CONST22
CONST22A
CONST22B
const22c
CONST24
CONST26

**VOLUME BASED PROPERTIES

CONST27v

CONST28v
CONST29v
CONST30v
CONST31v
CONST32v
CONST33v
CONST34v
CONST35v
CONST36v
**WEIGHT BASED PROPERTIES
CONST27w
*CONVEX ENVELOPES
CONST28w
CONST29w
CONST30w
CONST31w
CONST31_1w
CONST31_2w
CONST32w
CONST33w
CONST34w
CONST35w
CONST35_1w
CONST35_2w

**WEIGHT BASED PROPERTIES+CONCAVE ENVELOPES

CONST28cw
CONST29cw
CONST30cw
CONST31cw
CONST31_1cw
CONST31_2cw

CONST32cw
CONST33cw
CONST34cw
CONST35cw
CONST35_1cw
CONST35_2cw
*INTEGER CUT EQN
CONST43_m1
OBJ1/
;

model milp1/
CONST3
CONST5
CONST6

CONST7
CONST8
CONST9
CONST10

CONST10b
const10c
CONST13
CONST14
CONST15
CONST16
CONST17
CONST18
CONST18a
CONST18b
const18c

CONST19
CONST20
CONST22
CONST22A
CONST22B
const22c
CONST24
CONST26
*volume based
CONST27v
CONST41_m1v
CONST42_m1v



*weight based
CONST27w
CONST41_m1w
CONST42_m1w
OBJ1/

model milp2/
CONST3
CONST5
CONST6

CONST7
CONST8
CONST9
CONST10

CONST10b
const10c
CONST13
CONST14
CONST15
CONST16
CONST17
CONST18
CONST18a
CONST18b
const18c


CONST19
CONST20
CONST22
CONST22A
CONST22B
const22c
CONST24
CONST26
*volume based
CONST27v
CONST41_m1v
CONST42_m1v
*weight based
CONST27w
CONST41_m1w
CONST42_m1w
**integer cuts
CONST43_m1
OBJ1/
;

model nlp0/
CONST3_n
CONST5_n
CONST7_n
CONST8_n
CONST9_n
CONST10_n

CONST10b_n
const10c_n
CONST13_n
CONST14_n
CONST15_n
CONST16_n
CONST17_n
CONST18_n
CONST18a_n
CONST18b_n
CONST18c_n
CONST19_n
CONST20_n
CONST22_n
const22c_n
CONST22A_n
CONST22B_n
CONST24_n
*INVENTORY BALANCE
CONST26_n1
CONST26_n2
*VOLUME BASED PROPERTY BALANCE
CONST27A_nv1
CONST27B_nv1
CONST27C_nv1
CONST27A_nv2
CONST27B_nv2
CONST27C_nv2
CONST27D_nv

**WEIGHT BASED PROPERTY BALANCE
CONST27A_nw
CONST27B_nw1
CONST27B_nw2
CONST27C_nw1
CONST27C_nw2
CONST27D_nw1
CONST27D_nw2
CONST47_n
obj2
/
;
model nlp1/
CONST3_n
CONST5_n
CONST6_n
CONST7_n
CONST8_n
CONST9_n
CONST10_n

CONST10b_n
const10c_n
CONST13_n
CONST14_n
CONST15_n
CONST16_n
CONST17_n
CONST18_n
CONST18a_n
CONST18b_n
CONST18c_n
CONST19_n
CONST20_n
CONST22_n
const22c_n
CONST22A_n
CONST22B_n
CONST24_n
*INVENTORY BALANCE
CONST26_n1

*VOLUME BASED PROPERTY BALANCE
*NLP1
CONST27_nv

CONST27_nw

const48_n
*
obj3
/

;
OPTION MIP=CPLEX;
OPTION LP=CPLEX;
option nlp=baron;
milp0.optcr=0.0;
milp0cut.optcr=0;
milp2.optcr=0;

milp0.reslim=100000;
milp0cut.reslim=100000;
milp2.reslim=100000;

parameter flag1,flag2,tag,tag1, flag3,tol1,tol2,count;
tol1=0.001;
tol2=0;
flag1=0;
count=0;

SOLVE milp0 using mip minimizing COST1;
DISPLAY X.L,Y.L,T.L,QI.L,QO.L,TE.L,D.L,I.L,COST1.L,CL.L,bs.l,wi.l;
while(flag1=0,

         PX.FX(S,P,K)=X.L(S,P,K);
         PY.FX(S,O,K)=Y.L(S,O,K);

         SOLVE NLP0 USING NLP MINIMIZING nlpobj;
         DISPLAY  nlpobj.L, slack.l,PX.L,PY.L,T.L,QI.L,QO.L,TE.L,D.L,I.L,CL.L,WP.L,CL.L,A.L,B.L,slack.l,Apsl.l,Ansl.l,BPSL.L,BNSL.L,EPSW.L,ENSW.L,FNSW.L,FPSW.L,E.L,F.L,WP.L;
                                 tag=0;
              if(slack.l gt tol2,
                 tag=1;
                 display tag;
                 );

                 if(slack.l gt tol2,
                                 tag1=1;
                                 );

                if(tag=0,
                   SOLVE NLP1 USING NLP MINIMIZING nlpobj1;
        DISPLAY  nlpobj1.L, PX.L,PY.L,T.L,QI.L,QO.L,TE.L,D.L,I.L,COST2.L,CL.L,WP.L,CL.L,A.L,B.L,Apsl.l,Ansl.l,BPSL.L,BNSL.L,EPSW.L,ENSW.L,FNSW.L,FPSW.L,E.L,F.L,WP.L;
                 if((cost2.l-cost1.l)/(Cost1.l) le tol1,
                 flag1=1;
                 abort$(flag1=1) "best solution found"
                 );
              );

               flag3=0;
                 If(tag=0,
                         if ((cost2.l-cost1.l) gt tol1,
                         flag3=1;
                         );
                 );
                         while(flag3=1,
                                 CLK(M,S,K)=CL.L(M,S,K);
                                 WPK(W,S,K)=WP.L(W,S,K);
                        solve milp1  using mip minimizing cost1;
                        DISPLAY X.L,Y.L,T.L,QI.L,QO.L,TE.L,D.L,I.L,COST1.L,CLK,WPK,A.L,B.L,E.L,F.L;

                        PX.FX(S,P,K)=X.L(S,P,K);
                        PY.FX(S,O,K)=Y.L(S,O,K);
                        solve nlp0 using nlp minimizing nlpobj;
                        DISPLAY PX.L,PY.L,T.L,QI.L,QO.L,TE.L,D.L,I.L,CL.L,WP.L,CL.L,A.L,B.L,slack.l,Apsl.l,Ansl.l,BPSL.L,BNSL.L,EPSW.L,ENSW.L,FNSW.L,FPSW.L,E.L,F.L,WP.L;
                          tag1=0;
                                  if(tag1 =1,
                                       NX=0;
                                          MN=1;
                                          MP=MP+1;
                 LOOP((m,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(Apsl.l(m,s,k) gt 0,
                         A1(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                         );

                                 );
                                 );
 LOOP((m,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(ANsl.l(m,s,k) gt 0,
                         A2(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                         );

                                 );
                                 );

 LOOP(( m,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(Bpsl.l(m,s,k) gt 0,
                         B1(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                           );

                                 );
                                 );
 LOOP((m,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1) ) ,
                         if(BNsl.l(m,s,k) gt 0,
                         B2(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                             );

                                 );
                                 );
 LOOP((w,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1) ) ,
                         if(epsw.l(w,s,k) gt 0,
                         e1(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                           );

                                 );
                                 );
 LOOP((w,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1) ) ,
                         if(ensw.l(w,s,k) gt 0,
                         e2(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                       );

                                 );
                                 );
 LOOP((w,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(fpsw.l(w,s,k) gt 0,
                         f1(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                 IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                      );

                                 );
                                 );
 LOOP((w,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(fnsw.l(w,s,k) gt 0,
                         f2(s,k) = yes;
                                 );
                 LOOP((N,KK)$(PS(P,S) AND SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                 IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                     );

                                 );
                                  );
                                  solve milp2 using mip minimizing COST1;
                                   DISPLAY X.L,Y.L,T.L,QI.L,QO.L,TE.L,D.L,I.L,COST1.L,CLK,WPK,A.L,B.L,E.L,F.L;
                                 else
                                 if(cost1.l gt cost2.l,
                                         flag1=1 ;
                                         flag3=0;
                                 else
                                         flag3=0;

                                          );
                                 );


                        );


                if(tag1 =1,
                                       NX=0;
                                          MN=1;
                                          MP=MP+1;
                 LOOP((m,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(Apsl.l(m,s,k) gt 0,
                         A1(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                         );

                                 );
                                 );
 LOOP((m,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(ANsl.l(m,s,k) gt 0,
                         A2(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                         );

                                 );
                                 );

 LOOP(( m,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(Bpsl.l(m,s,k) gt 0,
                         B1(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,K) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                           );

                                 );
                                 );
 LOOP((m,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1) ) ,
                         if(BNsl.l(m,s,k) gt 0,
                         B2(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                             );

                                 );
                                 );
 LOOP((w,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1) ) ,
                         if(epsw.l(w,s,k) gt 0,
                         e1(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,Kk)=YES;
                                           );

                                 );
                                 );
 LOOP((w,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1) ) ,
                         if(ensw.l(w,s,k) gt 0,
                         e2(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                       IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                       );

                                 );
                                 );
 LOOP((w,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(fpsw.l(w,s,k) gt 0,
                         f1(s,k) = yes;
                                 );
                 LOOP((N,KK)$(SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                 IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                      );

                                 );
                                 );
 LOOP((w,P,S,K)$(PS(P,S) AND SK(S,K) AND (ORD(K) GT 1)) ,
                         if(fnsw.l(w,s,k) gt 0,
                         f2(s,k) = yes;
                                 );
                 LOOP((N,KK)$(PS(P,S) AND SKK(S,KK) AND (ORD(KK) LT ORD(K)) AND (ORD(N) EQ MP)) ,
                                 IF(X.L(S,P,KK) EQ 1,
                                 X1(N,S,P,KK)=YES;
                                 NX=NX+1;
                                 ELSE
                                 X2(N,S,P,KK)=YES;
                                     );

                                 );
                                  );

                 solve milp0cut using mip minimizing cost1;
                    DISPLAY  X.L,Y.L,T.L,QI.L,QO.L,TE.L,D.L,I.L,COST1.L,CL.L,A.L,B.L,E.L,F.L,CL.L,QS.L;
                    );
       count=count+1;
       display count;

      abort$(milp0cut.modelstat=10) "problem is integer infeasible"

);


