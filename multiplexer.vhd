library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity multi is
	generic (N :integer:=4);
	
	port(
	in1 		:in std_logic_vector(N-1 downto 0);
	in2 		:in std_logic_vector(N-1 downto 0);
	controll	:in std_logic;
	out_mux		:out std_logic_vector(N-1 downto 0)
	);
end multi;

architecture STRUCTURAL of multi is

begin
	switch:process(controll,in1)
	begin
		if(controll='1') then 
			out_mux <= in1;
		else
			out_mux <= in2;
		end if;
	end process switch;
end architecture STRUCTURAL;
	