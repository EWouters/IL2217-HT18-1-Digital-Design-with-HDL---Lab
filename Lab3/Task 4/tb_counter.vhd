------------------------------------------------------
-- Counter Testbench
-- File Name : tb_counter.vhd
-- Data Type : integer
-- Reset : Asynchronous
-- Active : Low
------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.all;
use work.all;

entity tb_counter is 
	GENERIC(MAX : INTEGER := 10);
end tb_counter;

architecture arch_counter of tb_counter is
	component counter
		generic( MAX: INTEGER:=1);
		port( UP, CLK, RESET, EN : in std_logic;
				OUT1 : out std_logic;
				OUT2 : out integer
		);
	end component;
	
	SIGNAL UP, CLK, RESET, EN, OUT1: std_logic := '1';
	SIGNAL OUT2: integer;

BEGIN
	DUT: counter
	generic map(MAX => MAX)
	port map(
		UP => UP,
		CLK => CLK,
		RESET => RESET,
		EN => EN,
		OUT1 => OUT1,
		OUT2 => OUT2
	);
	
	CLK <= not CLK after 10 ns;
	RESET <= '0', '1' after 25 ns;
	EN <= '1', '0' after 111 ns, '1' after 141 ns;
	UP <= '1', '0' after 1000 ns;
	
end; -- tb_counter