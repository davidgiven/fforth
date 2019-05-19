: prime? ( n -- ? ) HERE + C@ 0= ;
: composite! ( n -- ) HERE + 1 SWAP C! ;

CREATE start-time 2 CELLS ALLOT

: start-benchmark
  ." Starting" CR
  UTIME start-time 2!
;

: end-benchmark
  ." Ending: "
  UTIME start-time 2@ D- D>S 
  . ." us" CR
;

( Mostly stolen from Rosetta Code: https://rosettacode.org/wiki/Sieve_of_Eratosthenes#Forth )
: sieve ( n -- )
  start-benchmark
  HERE OVER ERASE
  2
  BEGIN
    2DUP DUP * >
  WHILE
    DUP prime? IF
      2DUP DUP * DO
        I composite!
      DUP +LOOP
    THEN
    1+
  REPEAT
  DROP
  end-benchmark
  ." Primes: " 2 DO I prime? IF I . THEN LOOP
;

1000 sieve

