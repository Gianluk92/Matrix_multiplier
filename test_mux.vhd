library ieee;
use ieee.std_logic_1164.all;

entity tmux is	  
	
end tmux;

architecture test_mux of tmux is

	component mux
	generic (N : integer:=4;
			 P : integer:=12);
	port( 
		in_A	:in std_logic_vector (N-1 downto 0); -- 4 bit in ingresso
		in_B 	:in std_logic_vector (N-1 downto 0);
		result 	:out std_logic_vector(P-1 downto 0) -- sono P bit
	);
	end component;	
	
	-- C O S T A N T   D E C L A R A T I O N --
	
	CONSTANT N 			:  INTEGER 	:= 4;		-- Bus Width
	CONSTANT P			:  INTEGER 	:= 12;
	CONSTANT MckPer  	:  TIME     := 200 ns;  -- Master Clk period
	CONSTANT TestLen 	:  INTEGER  := 300;      -- No. of Count (MckPer/2) for test
		
	-- I N P U T --
	
	signal clk 		: std_logic := '0';
	signal in_a		: std_logic_vector (N-1 downto 0) := "0000";
	signal in_b 	: std_logic_vector (N-1 downto 0) := "0000";
	
	-- O U T P U T --
	
	signal out_r 	: std_logic_vector (P-1 downto 0);  
	
	-- service signal --
	
	signal clk_cycle : INTEGER;
  	signal Testing: Boolean := True;
	
	-- start process --
	
	begin
		I: mux generic map(N,P) port map (in_A => in_a, in_B => in_b , result => out_r);
		
	-- generate clock
		
		clk <= not clk after MckPer/2 when Testing else '0';
		
	Test_Proc: PROCESS(clk)
      		VARIABLE count: INTEGER:= 0;
   		BEGIN
     		clk_cycle <= (count+1)/2;
		
	
		case count is
			when 10 => in_a <= "1000"; in_b <= "1000";
			when others => null;
		end case;
		
		count:=count+1;
	end process Test_Proc;
end test_mux;
	
	
		