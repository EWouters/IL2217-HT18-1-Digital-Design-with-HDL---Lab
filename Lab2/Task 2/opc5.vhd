
library IEEE;
--use ieee.std_logic_1164.all;
use work.all;
use work.opc5_logic.all;

ENTITY opc5 IS
	PORT (
		a:IN work.opc5_logic.opc_logic;
		b:IN work.opc5_logic.opc_logic;
		q:OUT work.opc5_logic.opc_logic
	);
END opc5;

ARCHITECTURE dataflow OF opc5 IS
	SIGNAL q_prim : work.opc5_logic.opc_logic;
BEGIN
	q_prim <= a XOR b AFTER 5 ns;
	q <= NOT q_prim;
END dataflow;