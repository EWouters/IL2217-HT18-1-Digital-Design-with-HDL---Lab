library IEEE;
--use ieee.std_logic_1164.all;
use work.opc5_logic.all;
use work.all;

ENTITY tb_opc5 IS END tb_opc5;

ARCHITECTURE tb_opc5 OF tb_opc5 IS
	
	SIGNAL a,b,clk1,clk2,bus_wire: work.opc5_logic.opc_logic :='0';
	
BEGIN
	PROCESS
	BEGIN
		FOR i IN work.opc5_logic.opc_logic LOOP
			a<=i;
			bus_wire<=i;
			WAIT ON clk1 UNTIL clk1='1';
		END LOOP;
	END PROCESS;
	PROCESS
	BEGIN
		FOR j IN work.opc5_logic.opc_logic LOOP
			b<=j;
			bus_wire<=j;
			WAIT ON clk2 UNTIL clk2='1';
		END LOOP;
	END PROCESS;
	clk1<=NOT(clk1) AFTER 10 ns;
	clk2<=NOT(clk2) AFTER 50 ns;
END tb_opc5;