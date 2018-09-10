library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity TB_SR_LATCH is end TB_SR_LATCH;

architecture TEST of TB_SR_LATCH is
	component SR_LATCH
		port (
			S		:	in std_logic;
			R		:	in std_logic;
			QPRIM	:	out std_logic;
			Q		:	out std_logic
		);
	end component;

	signal Q, QPRIM : std_logic := '0';
	signal TEST_VECTOR : std_logic_vector(1 downto 0);
	
begin
	TEST_VECTOR <=
		-- a, b
		"10",
		"11" after 5 ns,
		"01" after 10 ns,
		"11" after 15 ns,
		"10" after 20 ns,
		"11" after 25 ns,
		"00" after 30 ns;
	T1	:	SR_LATCH port map(TEST_VECTOR(1), TEST_VECTOR(0), QPRIM, Q);
end TEST;
