library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity mux is
	generic (N : integer:=4;
			 P : integer:=12);
	port( 
		in_A	:in std_logic_vector (N-1 downto 0); -- 4 bit in ingresso
		in_B 	:in std_logic_vector (N-1 downto 0);
		result 	:out std_logic_vector(P-1 downto 0) -- sono P bit
	);
end mux;

-- COMPONENT DECLARATION

architecture STRUCTURAL of mux is

begin
	SUM:process(in_A,in_B)
	
	variable tmp:integer;
	
	begin									 		 
		
		tmp:=to_integer(signed(in_A))* to_integer(signed(in_B));	
		result <=std_logic_vector(to_signed(tmp,P));
	
	end process SUM;
	
end architecture STRUCTURAL;
