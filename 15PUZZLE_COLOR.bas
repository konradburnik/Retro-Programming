DECLARE SUB PRINT.STATUS ()
DECLARE SUB SOLVED.PUZZLE ()
DECLARE SUB PRINT.TIME ()
DECLARE FUNCTION GET.SECONDS! (T$)
DECLARE FUNCTION INSIDE! (X, Y)
DECLARE SUB MOVE (DIRECTION$)
DECLARE SUB UPDATE.POSITION ()
DECLARE SUB SET.DIRECTION (DIRECTION$)
DECLARE FUNCTION MOVEABLE! (DIRECTION$)
DECLARE SUB CHANGE.STATE ()
DECLARE FUNCTION GET.DIRECTION$ ()
DECLARE SUB SCRAMBLE.PUZZLE ()
DECLARE SUB DRAW.PUZZLE ()
DECLARE SUB DRAW.SQUARE (X!, Y!)
DECLARE FUNCTION SOLVED! ()

' The puzzle is represented by a 4x4 grid of numbers.
DIM SHARED PUZZLE(1 TO 4, 1 TO 4)

' The whole puzzle is nothing but a permutation that we need to bring back to identity,
' so we keep track of our progress through this array.
DIM SHARED PERMUTATION(0 TO 15)

' A list of possible moves in solving the puzzle.
DIM SHARED POSSIBLE.MOVE$(1 TO 4)

' Some helper variables
COMMON SHARED GAME.OVER           ' A flag indicating game over.
COMMON SHARED START.TIME          ' The time (in seconds) we started solving the puzzle.
COMMON SHARED NUMBER.OF.MOVES     ' Keep track of how many moves we made so far.
COMMON SHARED MOVES.INCREMENT     ' By how many we increment the number of moves ?

COMMON SHARED CURRENT.X, CURRENT.Y      ' Keeps track of our current possition.
COMMON SHARED DIRECTION.X, DIRECTION.Y  ' Keeps track in what direction to slide '+0' square.

REM ***********************************************
REM *
REM * 15 Slide Puzzle Extreme (color version)
REM *
REM * by Konrad Burnik,
REM * on 20th of January 2011.
REM *
REM ***********************************************

SCREEN 13

REM --+- Main procedure. -+------------------------


REM ---+- Print welcome message and instructions -+----
CLS

PRINT "Welcome to the 15 SLIDE PUZZLE EXTREME!"
PRINT
PRINT "The solved puzzle looks like this."
LOCATE 23, 1
PRINT "Press any key"
PRINT "to start scrambling the puzzle ...";

REM ---+- Show the user how a solved puzzle looks like. -+-----
SOLVED.PUZZLE
DRAW.PUZZLE

REM ---+- Wait for a key to be pressed -+----
WHILE INKEY$ = "": WEND

CLS

REM ----+- Scramble the puzzle -+------
SCRAMBLE.PUZZLE

CLS

PRINT "FINISHED SCRAMBLING !!!"
PRINT
PRINT "Take a big breath and hit the <ENTER>"
PRINT "key when ever you're ready ..."
PRINT
PRINT "GOOD LUCK!"
LOCATE 21, 1
PRINT "Ready ?"
LOCATE 23, 1
COLOR 31
PRINT "!!! PRESS <ENTER> TO START !!!";
COLOR 7
LOCATE 23, 1
PRINT "Hint: When you get tierd you can always hit <ESC> and quit. ;)";

REM ---+- Show user how scrambled te puzzle is. -+---
DRAW.PUZZLE

REM ---+- Wait for <ENTER> key to be pressed -+----
WHILE INKEY$ <> CHR$(13): WEND
PRINT "GO !!!"

CLS

REM ----+- Initialize game parameters -+-----
NUMBER.OF.MOVES = 0
MOVES.INCREMENT = 1
GAME.OVER = 0

REM ----+- Get start time -+-----
START.TIME = GET.SECONDS(TIME$)

REM **** Main Game loop ****
WHILE NOT GAME.OVER = 1
 CHANGE.STATE
 IF (SOLVED = 1) THEN
  GAME.OVER = 1
 END IF
WEND
REM **** Main Game loop ****

REM ---+- Handle victory or defeat -+-----

IF SOLVED = 1 THEN
 COLOR 10
 LOCATE 4, 1
 PRINT "CONGRATULATIONS! YOU SOLVED IT !!!"
 COLOR 7
 DRAW.PUZZLE
 PRINT.STATUS
 LOCATE 21, 1
 PRINT "*** GAME OVER ***"
 SLEEP 15
ELSE
 CLS
 PRINT "Had enough ? :D"
 PRINT
 COLOR 4
 PRINT "LOSER !!!"
 COLOR 7
 PRINT
 PRINT "Don't worry you'll solve it some day. ;) ";
 PRINT "Maybe :P"
 PRINT
 PRINT "Bye!"
 PRINT
 PRINT "*** GAME OVER ***"
 SLEEP 3
END IF


REM ***********************************************

SUB CHANGE.STATE
 DIRECTION$ = GET.DIRECTION
 MOVE DIRECTION$
 DRAW.PUZZLE
 PRINT.STATUS
END SUB

SUB DRAW.PUZZLE
 FOR Y = 1 TO 4
  FOR X = 1 TO 4
   DRAW.SQUARE X, Y
  NEXT X
 NEXT Y
END SUB

SUB DRAW.SQUARE (X, Y)
 LINE (60 + 30 * X, 7 + 30 * Y)-(60 + 10 + 30 * X + 10, 7 + 10 + 30 * Y + 10), PUZZLE(X, Y), BF
 LINE (60 + 30 * X - 2, 7 + 30 * Y - 2)-(60 + 10 + 30 * X + 10 + 2, 7 + 10 + 30 * Y + 10 + 2), 4 * (Y - 1) + (X - 1), B
END SUB

FUNCTION GET.DIRECTION$

 K$ = INKEY$

 SELECT CASE K$
  CASE CHR$(0) + "M"
   GET.DIRECTION$ = "RIGHT"
  CASE CHR$(0) + "K"
   GET.DIRECTION$ = "LEFT"
  CASE CHR$(0) + "H"
   GET.DIRECTION$ = "UP"
  CASE CHR$(0) + "P"
   GET.DIRECTION$ = "DOWN"
   CASE CHR$(27) 'ESC
   GET.DIRECTION$ = "EXIT"
   CASE "1"
   GET.DIRECTION$ = "CHEAT" ' This game even has cheats ;)
 END SELECT
END FUNCTION

FUNCTION GET.SECONDS (T$)
 HH = VAL(MID$(T$, 1, 2))
 MM = VAL(MID$(T$, 4, 2))
 SS = VAL(MID$(T$, 7, 2))
 GET.SECONDS = HH * 3600 + MM * 60 + SS
END FUNCTION

FUNCTION INSIDE (X, Y)
 IF (X >= 1) AND (X <= 4) AND (Y >= 1) AND (Y <= 4) THEN
  INSIDE = 1
 ELSE
  INSIDE = 0
 END IF
END FUNCTION

SUB MOVE (DIRECTION$)
 SET.DIRECTION DIRECTION$

 IF MOVEABLE(DIRECTION$) = 1 THEN
 
  REM Save old position.

  OLD.X = CURRENT.X
  OLD.Y = CURRENT.Y

  UPDATE.POSITION

  REM Update position matrix.

   P = PERMUTATION(PUZZLE(OLD.X, OLD.Y))
   PERMUTATION(PUZZLE(OLD.X, OLD.Y)) = PERMUTATION(PUZZLE(CURRENT.X, CURRENT.Y))
   PERMUTATION(PUZZLE(CURRENT.X, CURRENT.Y)) = P
 
  REM Take care of squares on the PUZZLE.

   B = PUZZLE(OLD.X, OLD.Y)
   PUZZLE(OLD.X, OLD.Y) = PUZZLE(CURRENT.X, CURRENT.Y)
   PUZZLE(CURRENT.X, CURRENT.Y) = B


 END IF
END SUB

FUNCTION MOVEABLE (DIRECTION$)

 SET.DIRECTION DIRECTION$

 NEW.X = CURRENT.X + DIRECTION.X
 NEW.Y = CURRENT.Y + DIRECTION.Y

 IF INSIDE(NEW.X, NEW.Y) = 1 THEN
  MOVEABLE = 1
 ELSE
  MOVEABLE = 0
 END IF

END FUNCTION

SUB PRINT.STATUS
 YOUR.TIME = GET.SECONDS(TIME$) - START.TIME
 LOCATE 1, 1
 PRINT "THE 15 SLIDE PUZZLE EXTREME"
 LOCATE 2, 1
 PRINT "Your time:" + STR$(YOUR.TIME);
 LOCATE 3, 1
 PRINT "Number of moves:" + STR$(NUMBER.OF.MOVES)
 LOCATE 22, 1
 PRINT "Use the arrow keys to move the '+0' and <ESC> to quit.";
END SUB

SUB SCRAMBLE.PUZZLE

 REM --+ Set possible moves. +--

 POSSIBLE.MOVE$(1) = "LEFT"
 POSSIBLE.MOVE$(2) = "RIGHT"
 POSSIBLE.MOVE$(3) = "UP"
 POSSIBLE.MOVE$(4) = "DOWN"

 CURRENT.X = 1
 CURRENT.Y = 1

 SOLVED.PUZZLE

 REM --+ Scramble the puzzle for a few seconds. +--

 LOCATE 2, 1
 PRINT "Scrambling ..."
 LOCATE 22, 1
 PRINT "(press any key to stop scrambling)"

 RANDOMIZE TIMER

 FOR K = 1 TO 5000
  RANDOM.MOVE = 1 + INT(RND * 4)
  MOVE POSSIBLE.MOVE$(RANDOM.MOVE)
  IF K MOD 100 = 0 THEN
   DRAW.PUZZLE
   SLEEP 1
  END IF
 IF INKEY$ <> "" THEN EXIT FOR
 NEXT K

END SUB

SUB SET.DIRECTION (DIRECTION$)

 SELECT CASE DIRECTION$
  CASE "LEFT"
   DIRECTION.X = -1
   DIRECTION.Y = 0
   MOVES.INCREMENT = 1
  CASE "RIGHT"
   DIRECTION.X = 1
   DIRECTION.Y = 0
   MOVES.INCREMENT = 1
  CASE "UP"
   DIRECTION.X = 0
   DIRECTION.Y = -1
   MOVES.INCREMENT = 1
  CASE "DOWN"
   DIRECTION.X = 0
   DIRECTION.Y = 1
   MOVES.INCREMENT = 1
  CASE "CHEAT"
   SOLVED.PUZZLE
   GAME.OVER = 1
  CASE "EXIT"
  GAME.OVER = 1
 END SELECT

END SUB

FUNCTION SOLVED

 REM --+- Check if we got the identity permutation -+---

 FOR K = 0 TO 15
  IF PERMUTATION(K) <> K THEN
   SOLVED = 0
   EXIT FUNCTION
  END IF
 NEXT K
 SOLVED = 1
END FUNCTION

SUB SOLVED.PUZZLE

 CURRENT.X = 1
 CURRENT.Y = 1

 REM --+ Initialize PUZZLE +--

 FOR Y = 1 TO 4
  FOR X = 1 TO 4
   PUZZLE(X, Y) = (4 * (Y - 1) + (X - 1))
  NEXT X
 NEXT Y

 REM --+ Initialize permutation. +----------

 FOR K = 0 TO 15
  PERMUTATION(K) = K
 NEXT K


END SUB

SUB UPDATE.POSITION
 CURRENT.X = CURRENT.X + DIRECTION.X
 CURRENT.Y = CURRENT.Y + DIRECTION.Y

 NUMBER.OF.MOVES = NUMBER.OF.MOVES + MOVES.INCREMENT

 DIRECTION.X = 0
 DIRECTION.Y = 0

 MOVES.INCREMENT = 0
END SUB

