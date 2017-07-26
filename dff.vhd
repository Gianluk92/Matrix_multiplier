LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY dff is
   
   generic (N : INTEGER:=12);
   port( d          : in  std_logic_VECTOR (N-1 downto 0);
         clk        : in  std_logic;
         reset      : in  std_logic;
         q          : out std_logic_VECTOR (N-1 downto 0));
END dff;

architecture BEHAVIOURAL of dff is

BEGIN
    DFF:process(clk)
     begin
       IF (clk'EVENT AND clk='1') THEN
            IF (reset = '1') THEN
                FOR i in 0 to N-1 loop
                    q(i) <= '0';
                END LOOP;
             else
                q <= d;
            END IF;
       end if;
     END process DFF;

END BEHAVIOURAL;
