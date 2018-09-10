library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity TB_D_STD_LOGIC is end TB_D_STD_LOGIC;

architecture TEST of TB_D_STD_LOGIC is
	component D_LATCH
		port (
			D		:	in std_logic;
			CLK		:	in std_logic;
			Q		:	out std_logic
		);
	end component;
	component D_FLIPFLOP
		port (
			D		:	in std_logic;
			CLK		:	in std_logic;
			Q		:	out std_logic
		);
	end component;

	signal TEST, CLK, Q_LATCH, Q_FLIPFLOP : std_logic := '0';

begin
	test <=
		'0',
		'1' after 15 ns,
		'0' after 65 ns,
		'1' after 70 ns,
		'0' after 75 ns,
		'1' after 125 ns;

	U1	:	D_LATCH port map (TEST, CLK, Q_LATCH);
	U2	:	D_FLIPFLOP port map (TEST, CLK, Q_FLIPFLOP);

	CLK <=
		'0',
		'1' after 20 ns,
		'0' after 40 ns,
		'H' after 60 ns,
		'L' after 80 ns,
		'H' after 100 ns,
		'L' after 120 ns;

end TEST;