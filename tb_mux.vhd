library IEEE;
use ieee.std_logic_1164.all;
USE work.ALL;

ENTITY tb_mux IS END tb_mux;

ARCHITECTURE testMux OF tb_mux IS
COMPONENT mux
	PORT (
		a:IN std_logic;
		b:IN std_logic;
		adress:IN std_logic;
		q:OUT std_logic
	);
END COMPONENT;

SIGNAL testvector:std_logic_VECTOR (2 downto 0); -- a, b, adress
SIGNAL gateResult,dfResult:std_logic;

FOR c1:mux USE ENTITY work.mux(dataflow);
FOR c2:mux USE ENTITY work.mux(behavioural);
BEGIN
	C1:mux PORT MAP(testvector(2), testvector(1),testvector(0),dfResult);
	C2:mux PORT MAP(testvector(2), testvector(1),testvector(0),gateResult);
	testvector <=
		"000",
		"100" AFTER 10 ns,
		"110" AFTER 15 ns,
		"111" AFTER 20 ns,
		"110" AFTER 25 ns,
		"010" AFTER 27 ns,
		"101" AFTER 30 ns;
END testMux;