REM ####################################################################
REM #
REM # Plot the region including the Mandelbrot Set just for fun
REM #
REM # The Mandelbrot set is defined as:
REM #  
REM # M = {c in C | z(0) = 0, z(n+1) = z(n)^2 + c, {z(n)} is bounded}
REM # 
REM # For the bound it is enough to test |z(n)| > 2.
REM # The points which "escape" to infinity we color according to 
REM # the number of iterations before they cross the bound.
REM # 
REM # Konrad Burnik, 2016. 
REM # (still playing around with BASIC after all these years)
REM # 
REM ##################################################################### 

SCREEN 13
FOR cy = -2 TO 2 STEP .01
        FOR cx = -2 TO 2 STEP .01
         x = 0: y = 0: iter = 0
         WHILE x ^ 2 + y ^ 2 <= 4 AND iter < 200
           oldx = x
           x = (x + y) * (x - y) + cx
           y = 2 * oldx * y + cy
           iter = iter + 1
         WEND
         PSET (200 + 100 * cx, 200 + 100 * cy), iter MOD 256
        NEXT cx
NEXT cy

REM ####################################################################
