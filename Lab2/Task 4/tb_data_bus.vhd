library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_bus_resolution.all;
use work.all;

entity TB_data_bus is
	GENERIC (N: INTEGER:=4);
end TB_data_bus;

architecture TEST of TB_data_bus is
	component data_bus
		GENERIC (N: INTEGER:=4);
		port (
			D		:	in std_logic_vector(2*N-1 downto 0);
			CLK		:	in std_logic;
			R		:	in std_logic;
			Q		:	out std_logic_vector(N-1 downto 0)
		);
	end component;

	signal CLK, R : std_logic := '0';
	signal D: std_logic_vector(2*N-1 downto 0);
	signal Q : std_logic_vector(N-1 downto 0);
--	signal count : integer range 0 to 2**N-1;
	
begin
	process is
	begin
	for count in 0 to 2 ** N - 1 loop 
		D <= std_logic_vector(to_unsigned(count, D'length));
		wait for 10 ns;
		CLK <= not CLK;
		wait for 10 ns;
		CLK <= not CLK;
	end loop;
	end process;
	
	
	process is
	begin
	for count in 0 to 2 ** N - 1 loop
		wait for 5 ns;
		R <= '1', '0' AFTER 1 ns;
		wait for 10 ns;
		R <= '1', '0' AFTER 1 ns;
		wait for 5 ns;
	end loop;
	end process;
	
	
	T1	:	data_bus port map(
		D, CLK, R, Q);
end TEST;
