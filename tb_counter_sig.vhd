library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity TEST is end TEST;

architecture TB_COUNTER_SIG of TEST is
	component COUNTER_SIG
	port (UP, CLK, RESET	:	in std_logic;
		OUT1	:	out	std_logic;
		OUT2	:	out std_logic_vector(3 downto 0)
	);
	end component;

	signal UP		:	std_logic := '1';
	signal RESET	:	std_logic := '0';
	signal CLK		:	std_logic := '0';
	signal OUT1		:	std_logic := '0';
	signal OUT2		:	std_logic_vector(3 downto 0) := (others => '0');

	for U1 : COUNTER_SIG use entity work.COUNTER_SIG(ARCH_COUNTER_SIG);

	begin
		U1 : COUNTER_SIG port map (UP, CLK, RESET, OUT1, OUT2);
		RESET <= '1' after 125 ns;
		CLK <= not (CLK) after 50 ns;

		tb: process
		begin
			UP <= transport '0' after 945 ns;
			UP <= transport '1' after 1825 ns;
			UP <= transport '0' after 2025 ns;
		wait;
		end process;
end;

