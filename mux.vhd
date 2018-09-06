library IEEE;
use ieee.std_logic_1164.all;
use work.all;

ENTITY mux IS
	PORT (
		a:IN BIT;
		b:IN BIT;
		adress:IN BIT;
		q:OUT BIT
	);
END mux;

ARCHITECTURE behavioural OF mux IS
BEGIN
	q <= a WHEN adress = '0' ELSE b;
END behavioural;

ARCHITECTURE dataflow OF mux IS
	SIGNAL int1,int2,int_adress: BIT;
BEGIN
	q <= int1 OR int2;
	int1 <= b and adress;
	int_adress <= NOT adress;
	int2 <= int_adress AND a;
END dataflow;