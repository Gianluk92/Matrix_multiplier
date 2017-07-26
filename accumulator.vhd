LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY accu is
	generic(N : integer:=12);
   	port( f	          : in  std_logic_VECTOR (N-1 downto 0);
         clock        : in  std_logic;
         rst	      : in  std_logic;
		 controll	  : in  std_logic;
         u       	  : out std_logic_VECTOR (N-1 downto 0));
END accu;

architecture STRUCTURAL of accu is
component adder is	
   generic (N : INTEGER:=12);
   port( a          	: in  std_logic_VECTOR (N-1 downto 0);
         b          	: in  std_logic_VECTOR (N-1 downto 0);
         carry_in   	: in  std_logic;
         s          	: out std_logic_VECTOR (N-1 downto 0);
         carry_out  	: out std_logic);
end component adder; 
component dff is
   generic (N : INTEGER:=12);
   port( d          	: in  std_logic_VECTOR (N-1 downto 0);
         clk        	: in  std_logic;
         reset      	: in  std_logic;
         q          	: out std_logic_VECTOR (N-1 downto 0));	
end component dff; 
component multi is
	generic (N :integer:=4);
	
	port(
	in1 		:in std_logic_vector(N-1 downto 0);
	in2 		:in std_logic_vector(N-1 downto 0);
	controll	:in std_logic;
	out_mux		:out std_logic_vector(N-1 downto 0)
	);
end component multi;

signal Us, Qs,a: std_logic_vector(N-1 downto 0);
signal zero: std_logic_vector(N-1 downto 0):=(others => '0'); 
begin  
	IA: adder generic map(N) port map (a => a, b => Qs, carry_in => '0', s => Us, carry_out => open); 
	IM: multi generic map(N) port map (in1=>f, in2=>zero,controll=>controll,out_mux => a);
	ID: dff	generic map(N) port map (d => Us, clk => clock, reset => rst, q => Qs);
	u <= Qs;
end architecture structural;