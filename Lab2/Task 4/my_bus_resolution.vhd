library ieee;
use ieee.std_logic_1164.all;
use work.all;

PACKAGE my_bus_resolution IS
	FUNCTION wired_and (drivers : std_logic_vector) RETURN std_logic;
END my_bus_resolution;

PACKAGE BODY my_bus_resolution IS
	FUNCTION wired_and (drivers : std_logic_vector) RETURN std_logic IS
		VARIABLE accumulate : std_logic := '1';
	BEGIN
		FOR i IN drivers'RANGE LOOP
			accumulate := accumulate AND drivers(i);
		END LOOP;
		RETURN accumulate;
	END wired_and;
END my_bus_resolution;