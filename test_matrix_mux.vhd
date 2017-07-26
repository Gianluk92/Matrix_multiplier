library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity tmmux is	  
	
end tmmux;

architecture test_matrix_mux of tmmux is

	component matrix_mux
	generic (N : integer := 4;
			 P : integer := 12);
	port(
		row_A 		: in std_logic_vector(N-1 downto 0);
		column_B 	: in std_logic_vector(N-1 downto 0);
		clock		: in std_logic;	
		end_row		: in std_logic;
		res			: out std_logic_vector(P-1 downto 0)
	);
	end component;	
	
	-- C O S T A N T   D E C L A R A T I O N --
	
	CONSTANT N 		:  INTEGER 	:= 4;		-- Bus Width
	CONSTANT P 		:  INTEGER 	:= N*3;
	CONSTANT MckPer  :  TIME     := 200 ns;  -- Master Clk period
	CONSTANT TestLen :  INTEGER  := 300;      -- No. of Count (MckPer/2) for test
		
	-- I N P U T --
	
	signal clk 		: std_logic := '0';
	signal in_a		: std_logic_vector (N-1 downto 0) := "0000";
	signal in_b 	: std_logic_vector (N-1 downto 0) := "0000"; 
	signal fine		: std_logic := '0';
	
	-- O U T P U T --
	
	signal out_r 	: std_logic_vector (P-1 downto 0);  
	
	-- service signal --
	
	signal clk_cycle : INTEGER;
  	signal Testing: Boolean := True;
	
	-- start process --
	
	begin 
				
		I: matrix_mux generic map(N,P) port map (row_A => in_a, column_B => in_b , clock => clk, end_row => fine , res => out_r);
		
	-- generate clock
		
		clk <= not clk after MckPer/2 when Testing else '0';
		
	Test_Proc: PROCESS(clk)
	VARIABLE count: INTEGER:= 0;
	variable A: integer:=2;
	variable B: integer:=3;
	variable time_pass: integer:=5;
   		BEGIN
     		clk_cycle <= (count+1)/2;
		
		case count is
			when 0 => fine <='1';
			when 2 => fine <= '0';
			when 5 => in_a <= std_logic_vector(to_signed(3,4)); in_b <= std_logic_vector(to_signed(2,4));
			when 7 => in_a <= std_logic_vector(to_signed(5,4)); in_b <= std_logic_vector(to_signed(-7,4));
			when 9 => fine <='1';
			when 11 => fine <= '0';
				 in_a <= std_logic_vector(to_signed(3,4)); in_b <= std_logic_vector(to_signed(6,4));
			when 13 => in_a <= std_logic_vector(to_signed(5,4)); in_b <= std_logic_vector(to_signed(1,4));
			when 15 => fine <='1';
			when 17 => fine <= '0';
				in_a <= std_logic_vector(to_signed(-1,4)); in_b <= std_logic_vector(to_signed(2,4));
			when 19 => in_a <= std_logic_vector(to_signed(4,4)); in_b <= std_logic_vector(to_signed(-7,4));
			when 21 => fine <='1';
			when 23 => fine <= '0';
				in_a <= std_logic_vector(to_signed(-1,4)); in_b <= std_logic_vector(to_signed(6,4));
			when 25 => in_a <= std_logic_vector(to_signed(4,4)); in_b <= std_logic_vector(to_signed(1,4));
			when 27 => fine <='1';
			when 29 => fine <= '0';
			
			when others => null;
		
		end case;
		count:=count+1;
	end process Test_Proc;
end test_matrix_mux;
	
	
		