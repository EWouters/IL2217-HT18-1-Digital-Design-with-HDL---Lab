library IEEE;
use ieee.std_logic_1164.all;
use work.all;

ENTITY tb_gate IS END tb_gate;

ARCHITECTURE tb_gate OF tb_gate IS
	COMPONENT gate
	PORT (
		a:IN std_logic;
		b:IN std_logic;
		q:OUT std_logic);
	END COMPONENT;
	
	SIGNAL a,b,q:std_logic;
	SIGNAL c:std_logic_vector(1 downto 0);
	
BEGIN
	C1:gate PORT MAP(a,b,q);
	a <= c(1);
	b <= c(0);
	c<= "00",
		 "01" AFTER 10 ns,
		 "11" AFTER 20 ns,
		 "10" AFTER 30 ns,
		 "00" AFTER 40 ns;
END tb_gate;