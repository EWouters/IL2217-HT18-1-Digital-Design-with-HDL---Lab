library IEEE;
use ieee.std_logic_1164.all;
use work.all;

ENTITY tb_Full_Adder is
	-- not needed here
END tb_Full_Adder;

ARCHITECTURE test OF tb_Full_Adder IS
	COMPONENT Full_Adder IS
		PORT (
			A   : IN  std_logic;
			B   : IN  std_logic;
			Cin : IN  std_logic;
			sub : IN  std_logic;
			Cout: OUT std_logic;
			S   : OUT std_logic
		);
	END COMPONENT;
	--input
	SIGNAL numA   : std_logic:='0';
	SIGNAL numB   : std_logic:='0';
	SIGNAL numCin : std_logic:='0';
	SIGNAL sub 	  : std_logic:='0';
	
	--output
	SIGNAL numCout: std_logic:='0';
	SIGNAL sum    : std_logic:='0';
	
BEGIN
	DUT: Full_Adder
		PORT MAP(
			A    => numA,
			B    => numB,
			Cin  => numCin,
			sub  => sub,
			Cout => numCout,
			S    => sum
		);
		
-- test stimulus
numCin <= not numCin after 10 ns;
numA   <= not numA   after 20 ns;
numB   <= not numB   after 40 ns;
sub    <= not sub    after 80 ns;

END test;