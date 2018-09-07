library IEEE;
use ieee.std_logic_1164.all;
use work.all;

ENTITY mux IS
	PORT (
		a:IN std_logic;
		b:IN std_logic;
		adress:IN std_logic;
		q:OUT std_logic
	);
END mux;

ARCHITECTURE behavioural OF mux IS
BEGIN
	q <= a WHEN adress = '0' ELSE b;
END behavioural;

ARCHITECTURE dataflow OF mux IS
	SIGNAL int1,int2,int_adress: std_logic;
BEGIN
	q <= int1 OR int2;
	int1 <= b and adress;
	int_adress <= NOT adress;
	int2 <= int_adress AND a;
END dataflow;