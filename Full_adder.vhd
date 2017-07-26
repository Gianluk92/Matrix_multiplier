LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY adder is

   generic (N : INTEGER:=11);
   port( a          : in  std_logic_VECTOR (N-1 downto 0);
         b          : in  std_logic_VECTOR (N-1 downto 0);
         carry_in   : in  std_logic;
         s          : out std_logic_VECTOR (N-1 downto 0);
         carry_out  : out std_logic);
END adder;

architecture BEHAVIOURAL of adder is

BEGIN
    SUM:process(a,b,carry_in)
      variable C:std_logic;
     begin
      C:=carry_in;
        FOR i IN 0 TO N-1 LOOP
         -- Calculate bit sum using carry from previous step, then carry out
         s(i)<= a(i) XOR b(i) XOR C;
         C:= (a(i) AND b(i)) OR (a(i) AND C) OR (b(i) AND C);
      END LOOP;
       carry_out <= C;
      END  process SUM;

END BEHAVIOURAL;
