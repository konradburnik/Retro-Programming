'********************************************************************
'* Bezierove krivulje - implementacija by Konrad (c) 7/10/2002
'********************************************************************

' Bilo koju ravnu liniju mozemo pretvoriti u krivulju dodavanjem
' jos dviju tocaka u ravninu i racunajuci medjutocke sa Bezierovim
' jednadzbama za krivulju u 4 tocke.

' Bezijerove krivulje nastaju pomocu cetiri karakteristicne
' tocke: p0(x0,y0), p1(x1,y1), p2(x2,y2) i p3(x3,y3).
' Od ovih tocaka p0 i p3 su krajnje tocke linije od koje radimo
' krivulju a p1 i p2 su kontrolne tocke s kojima kontroliramo
' zakrivljenost krivulje.

' Za iscrtavanje potrebno je izracunati koordinate medjutocaka
' pomocu slijedecih jednadzbi:
'
' x(t) = ax * t^3 + bx * t^2 + cx * t
' y(t) = ay * t^3 + by * t^2 + cy * t
'
' gdje se vrijednost parametra "t" krece od 0 do 1 i treba
' ga odrediti za svaku medjutocku, dok se vrijednosti parametara
' ax,bx,cx i ay,by,cy definiraju sa slijedecim relacijama:
'
' cx = 3 * ( x1 - x0 )                  cy = 3 * ( y1 - y0 )
' bx = 3 * ( x2 - x1 ) - cx             by = 3 * ( y2 - y1 ) - cy
' ax = x3 - x0 - cx - bx                ay = y3 - y0 - cy - by
'
' Kako raste indeks medjutocke ciji "t" parametar racunamo potrebno
' je smanjivati interval izmedju prijasnjeg i trenutnog "t" parametra.
' Odnosno, ako je N trenutna medjutocka a M ukupan broj medjutocaka tada
' je t(N) = N / M.
'---------------------------------------------------------------------------
CONST MAX = 15     'Broj medutocaka

DIM t(1 TO MAX)    'vrijednosti "t" parametara
DIM tna2(1 TO MAX) 'isto na kvadrat
DIM tna3(1 TO MAX) 'isto na trecu
'-----------------------------------------
DIM x(0 TO 3)      'x koordinate karakteristicnih tocaka krivulje  
DIM y(0 TO 3)      'isto za y
'-----------------------------------------
DIM zx(1 TO MAX)   'U ove dvije tablice spremamo izacunate medjutocke   
DIM zy(1 TO MAX)   'zbog brzeg iscrtavanja
'-----------------------------------------


'Izracunaj vrijednosti "t" parametra za sve medjutocke unaprijed
'i pospremi sve u tablicu za kasnije

        FOR i = 1 TO MAX
                t(i) = (i / MAX)
                tna2(i) = t(i) ^ 2
                tna3(i) = tna2(i) * t(i)
        NEXT i

SCREEN 12
       
DO
'Krajnje tocke krivulje
        x(0) = 0: x(3) = 640
        y(0) = 0: y(3) = 480

'Polozaji dviju kontrolnih tocaka
        x(1) = RND * 100: x(2) = RND * 400
        y(1) = 100 * RND: y(2) = 100 * RND

'Parametri krivulje po zadanim relacijama
        cx = 3 * (x(1) - x(0))
        bx = 3 * (x(2) - x(1)) - cx
        ax = x(3) - x(0) - cx - bx

        cy = 3 * (y(1) - y(0))
        by = 3 * (y(2) - y(1)) - cy
        ay = y(3) - y(0) - cy - by


'Ovdje racunamo stvarne medjutocke i spremamo ih u tablicu
        FOR i = 1 TO MAX
                zx(i) = ax * tna3(i) + bx * tna2(i) + cx * t(i) + x(0)
                zy(i) = ay * tna3(i) + by * tna2(i) + cy * t(i) + y(0)
        NEXT i

'Prodji kroz tablicu medjutocaka i spoji ih linijama jednu za drugom   
'da dobijemo neprekinutu krivulju.

        FOR i = 1 TO MAX - 1
                LINE (zx(i), zy(i))-(zx(i + 1), zy(i + 1))
        NEXT i

tx = TIMER
tx = tx + .1
WHILE tx > TIMER: WEND
        FOR i = 1 TO MAX - 1
                LINE (zx(i), zy(i))-(zx(i + 1), zy(i + 1)), 0
        NEXT i



LOOP
END


