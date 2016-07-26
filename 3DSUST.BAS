DECLARE SUB tocka (x1!, y1!, z1!, d!, cx!, cy!, boja!)
DECLARE FUNCTION angle! (x1!, y1!, x2!, y2!)
DECLARE SUB linija (x1!, y1!, z1!, d!, cx!, cy!, boja, uvjet)
SCREEN 12
CONST MAX = 100
SKALA = 100

dist = .001
p = .05
C = (4 * ATN(1)) / 180
DIM x1(MAX), y1(MAX), z1(MAX), x2(MAX), y2(MAX), z2(MAX)
DIM spoj(MAX, MAX)
sredx = 320
sredy = 240

DATA 20
DATA 0.525731, 0.381966, 0.850651
DATA -0.200811, 0.618034, 0.850651
DATA -0.649839,0., 0.850651
DATA -0.200811, -0.618034, 0.850651
DATA 0.525731, -0.381966,0.850651
DATA 0.850651, 0.618034, 0.200811
DATA -0.32492, 1.,0.200811
DATA -1.05146, 0., 0.200811
DATA -0.32492, -1.,0.200811
DATA 0.850651, -0.618034, 0.200811
DATA 0.32492, 1., -0.200811
DATA -0.850651,0.618034, -0.200811
DATA -0.850651, -0.618034, -0.200811
DATA 0.32492, -1.,-0.200811
DATA 1.05146, 0., -0.200811
DATA 0.200811, 0.618034, -0.850651
DATA -0.525731,0.381966, -0.850651
DATA -0.525731, -0.381966, -0.850651
DATA 0.200811, -0.618034, -0.850651
DATA 0.649839, 0., -0.850651

DATA 12,5
DATA 1, 2, 3, 4, 5
DATA 1, 5, 10, 15, 6
DATA 1, 6, 11, 7, 2
DATA 2, 7, 12, 8, 3
DATA 3, 8, 13, 9, 4
DATA 4, 5, 10, 14, 9
DATA 6, 15, 20, 16, 11
DATA 7, 11, 16, 17, 12
DATA 8, 12, 17, 18, 13
DATA 9, 13, 18, 19, 14
DATA 10, 14, 19, 20, 15
DATA 16, 20, 19, 18, 17





DATA 12, 5
DATA 0., 0., 1.17557
DATA 1.05146, 0., 0.525731
DATA 0.32492, 1., 0.525731
DATA -0.850651, 0.618034, 0.525731
DATA -0.850651, -0.618034, 0.525731
DATA 0.32492,-1., 0.525731
DATA 0.850651, 0.618034, -0.525731
DATA -0.32492, 1., -0.525731
DATA -1.05146, 0., -0.525731
DATA -0.32492, -1., -0.525731
DATA 0.850651, -0.618034,-0.525731
DATA 0., 0., -1.17557

DATA 20
DATA 1, 3, 2
DATA 1, 4, 3
DATA 1, 5, 4
DATA 1, 6, 5
DATA 1, 2, 6
DATA 2, 3, 7
DATA 3, 4, 8
DATA 4, 5, 9
DATA 5, 6, 10
DATA 6, 2, 11
DATA 7, 3, 8
DATA 8, 4, 9
DATA 9, 5, 10
DATA 10, 6, 11
DATA 11, 2, 7
DATA 7, 8, 12
DATA 8, 9, 12
DATA 9, 10, 12
DATA 10, 11, 12
DATA 11, 7, 12


READ nx
FOR i = 1 TO nx
    READ x1(i), y1(i), z1(i)
NEXT i

READ n, f
FOR i = 1 TO n
    FOR j = 1 TO f
    READ spoj(i, j)
    NEXT j
NEXT i


kut = 0
FOR i = 1 TO nx
   x2(i) = SKALA * x1(i)
   y2(i) = SKALA * y1(i)
   z2(i) = SKALA * z1(i)
NEXT i



DO

FOR i = 1 TO nx
  
  
    x1(i) = x2(i)
    z1(i) = (y2(i) * SIN(kut * C) + (z2(i)) * COS(kut * C))
    y1(i) = (y2(i) * COS(kut * C) - (z2(i)) * SIN(kut * C))

NEXT i


    linija x1(spoj(1, 1)), y1(spoj(1, 1)), z1(spoj(1, 1)), dist, sredx, sredy, 15, 1
   
    FOR i = 1 TO n
        'linija x1(spoj(i, j)), y1(spoj(i, j)), z1(spoj(i, j)), dist, sredx, sredy, 15, 1
        FOR j = 1 TO f
        
        linija x1(spoj(i, j)), y1(spoj(i, j)), z1(spoj(i, j)), dist, sredx, sredy, 15, 0
        'aaaaaaaaaa$ = INPUT$(1)
        NEXT j
    linija x1(spoj(i, 1)), y1(spoj(i, 1)), z1(spoj(i, 1)), dist, sredx, sredy, 15, 0
    NEXT i
   
'aaaaaaaaaa$ = INPUT$(1)

    tx = TIMER
    tx = tx + p
    WHILE tx > TIMER: WEND

    linija x1(spoj(1, 1)), y1(spoj(1, 1)), z1(spoj(1, 1)), dist, sredx, sredy, 0, 1
   
    FOR i = 1 TO n
        FOR j = 1 TO f
        linija x1(spoj(i, j)), y1(spoj(i, j)), z1(spoj(i, j)), dist, sredx, sredy, 0, 0
        NEXT j
    linija x1(spoj(i, 1)), y1(spoj(i, 1)), z1(spoj(i, 1)), dist, sredx, sredy, 0, 1
    NEXT i
kut = (kut + 10) MOD 360

    

IF INKEY$ = CHR$(13) THEN dist = dist + .0001
IF INKEY$ = CHR$(32) THEN dist = dist - .0001
LOOP

REM *z-os
'    zz1 = z1(i)
'    xx1 = (x1(i) * COS(kut * C) - y1(i) * SIN(kut * C))
'    yy1 = (x1(i) * SIN(kut * C) + y1(i) * COS(kut * C))
'
'    zz2 = z2(i)
'    xx2 = (x2(i) * COS(kut * C) - y2(i) * SIN(kut * C))
'    yy2 = (x2(i) * SIN(kut * C) + y2(i) * COS(kut * C))

REM *y-os
'    yy1 = y1(i)
'    xx1 = (x1(i) * COS(kut * C) - y1(i) * SIN(kut * C))
'    zz1 = (x1(i) * SIN(kut * C) + z1(i) * COS(kut * C))
'
'    yy2 = y2(i)
'    xx2 = (x2(i) * COS(kut * C) - y2(i) * SIN(kut * C))
'    zz2 = (x2(i) * SIN(kut * C) + z2(i) * COS(kut * C))
REM *x-os
'    xx1 = x1(i)
'    yy1 = (y1(i) * COS(kut * C) - z1(i) * SIN(kut * C))
'    zz1 = (y1(i) * SIN(kut * C) + z1(i) * COS(kut * C))
'
'    xx2 = x2(i)
'    yy2 = (y2(i) * COS(kut * C) - z2(i) * SIN(kut * C))
'    zz2 = (y2(i) * SIN(kut * C) + z2(i) * COS(kut * C))

SUB linija (x1, y1, z1, d, cx, cy, boja, uvjet)
    xs1 = cx + (x1 / ((z1 - 500) * d))
    ys1 = cy + (y1 / ((z1 - 500) * d))

    IF uvjet = 1 THEN
        LINE (xs1, ys1)-(xs1, ys1), boja
    ELSE
        LINE -(xs1, ys1), boja
    END IF
END SUB

