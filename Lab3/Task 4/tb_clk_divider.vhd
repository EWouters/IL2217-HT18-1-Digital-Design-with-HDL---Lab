------------------------------------------------------
-- Clock Divider Testbench
-- File Name : clk_divider.vhd
-- Data Type : integer
-- Reset : Asynchronous
-- Active : Low
------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.all;
use work.all;

entity tb_clk_divider is 
	GENERIC(MAX : INTEGER := 32);
end tb_clk_divider;

architecture arch_clk_divider of tb_clk_divider is
	component clk_divider
		generic( MAX: INTEGER:=1);
		port( CLK, RESET : in std_logic;
				COUNTER : out integer;
				OUT1 : out std_logic
		);
	end component;
	
	SIGNAL CLK, RESET, OUT1: std_logic := '1';
	SIGNAL COUNTER: integer;

BEGIN
	DUT: clk_divider
	generic map(MAX => MAX)
	port map(
		CLK => CLK,
		RESET => RESET,
		COUNTER => COUNTER,
		OUT1 => OUT1
	);
	
	CLK <= not CLK after 10 ns;
	RESET <= '0', '1' after 25 ns;
	
end; -- tb_clk_divider