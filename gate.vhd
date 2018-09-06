library IEEE;
use ieee.std_logic_1164.all;
use work.all;

ENTITY gate IS
	PORT (
		a:IN std_logic;
		b:IN std_logic;
		q:OUT std_logic
	);
END gate;

ARCHITECTURE dataflow OF gate IS
	SIGNAL q_prim : std_logic;
BEGIN
	q_prim <= a AND b AFTER 5 ns;
	q <= NOT q_prim;
END dataflow;