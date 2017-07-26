library IEEE;
use IEEE.std_logic_1164.all;

entity matrix_mux is
	generic (N : integer := 4;
			 P : integer :=12);
	port(
		row_A 		: in std_logic_vector(N-1 downto 0);
		column_B 	: in std_logic_vector(N-1 downto 0);
		clock		: in std_logic;	
		end_row		: in std_logic;	 
		res			: out std_logic_vector(P-1 downto 0)
	);
end matrix_mux;

architecture STRUCTURAL of matrix_mux is
	component mux is
		generic (N : integer:=4;
				 P : integer:=12);
		port( 
			in_A	:in std_logic_vector (N-1 downto 0); -- questi sono 4 bit che devo usare col complemento a due
			in_B 	:in std_logic_vector (N-1 downto 0);
			result 	:out std_logic_vector(P-1 downto 0) -- 
		);
	end component mux;
	
	component accu is
		generic(N : integer:=12);
	   	port( f	          : in  std_logic_VECTOR (N-1 downto 0);
	         clock        : in  std_logic;
	         rst	      : in  std_logic;
			 controll	  : in  std_logic;
	         u       	  : out std_logic_VECTOR (N-1 downto 0));	
	end component accu;
	
	
	
	signal partial: std_logic_vector(P-1 downto 0);	
	signal mask_input: std_logic_vector(P-1 downto 0);
	signal mask_res :std_logic_vector(P-1 downto 0); 
	signal controll :std_logic;
	
	begin 
		
		
		
		IM: mux generic map(N,P) port map (in_A => row_A, in_B => column_B, result=>partial);
		mask_in:process(partial,end_row)
		begin
			for i in 0 to P-1 loop
				mask_input(i) <= partial(i) and not end_row;
			end loop;
		end process mask_in;
		
		controll <= not(end_row);
		IA: accu generic map(P) port map (controll => controll,f => mask_input, rst => end_row,clock=>clock, u => mask_res);
		
		mask_out:process(mask_res,end_row)
		begin
			FOR i in 0 to P-1 loop
           	         res(i) <= mask_res(i) and end_row;
           	     END LOOP;
		end process mask_out;
		
		
		
end architecture STRUCTURAL;
	