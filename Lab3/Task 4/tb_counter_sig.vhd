---------------------------------------------------------
---
-- Test Bench for Four Bit Up-Down Counter
-- File name : counter_sig_tb.vhd
---------------------------------------------------------
---
Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use work.all;

entity tb_counter_sig is end tb_counter_sig;

architecture arch_tb_counter_sig of tb_counter_sig is
	component counter_sig
	port( UP, CLK, RESET, EN: in std_logic;
		OUT1 : out std_logic;
		OUT2 : out std_logic_vector(3 downto 0)
	);
	end component;

	signal UP : std_logic := '1';
	signal RESET : std_logic := '0';
	signal EN : std_logic := '1';
	signal CLK : std_logic := '0';
	signal Out1 : std_logic := '0';
	signal Out2 : std_logic_vector(3 downto 0):=
		(others=>'0');

	for U1:counter_sig use entity
		work.counter_sig(Arch_counter_sig);

begin
	U1: counter_sig port map ( UP, CLK, RESET, EN, OUT1, OUT2);

	RESET <= '1' after 125 ns;
	CLK <= not(CLK) after 50 ns;
-----------------------------------------------------

	tb: process
	begin
		UP <= transport '0' after 945 ns;
		UP <= transport '1' after 1825 ns;
		UP <= transport '0' after 2025 ns;
		wait;
	end process; --tb
-----------------------------------------------------
end; -- tb_counter_sig



--configuration arch_counter_sig2 of test is
--	for tb_counter_sig
--		for U1: counter_sig use entity
--			work.counter_sig(Arch_counter_sig2);
--	end for;
--end arch_counter_sig2;
--
--configuration arch_counter_var of test is
--	for tb_counter_sig
--		for U1: counter_sig use entity
--			work.counter_sig(Arch_counter_var);
--	end for;
--end arch_counter_var;