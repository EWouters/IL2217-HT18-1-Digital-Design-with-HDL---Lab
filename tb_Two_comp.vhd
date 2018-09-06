library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

ENTITY tb_Two_comp IS
	GENERIC(N: INTEGER:=8);
END tb_Two_comp;

ARCHITECTURE test OF tb_Two_comp IS
	COMPONENT Two_comp IS
		GENERIC(N: INTEGER:=4);
		PORT (
			sub : IN  std_logic;
			B   : IN  std_logic_vector(N downto 0);
			Bout: OUT std_logic_vector(N downto 0)
		);
	END COMPONENT;
	
	--inputs to DUT
	SIGNAL numB		 	: integer;
	SIGNAL sub 			: std_logic;
	SIGNAL B     		: std_logic_vector(N downto 0);
	
	--outputs from DUT
	SIGNAL Bout    	: std_logic_vector(N downto 0);
BEGIN
	DUT: two_comp
		GENERIC MAP(
			N => N
		)
		PORT MAP(
			sub => sub,
			B   => B,
			Bout  => Bout
		);


	-- to_unsigned from numeric_std library
	sub <= '0';
	B <= std_logic_vector(to_unsigned(numB,B'length));
	
	PROCESS
	BEGIN
		numB <= 3;
		WAIT FOR 10 ns;
		for i in 0 to 2**N-1 loop
			numB <= i;
			wait for 1 ns;
			--assert to_integer(Y) = -i severity error;
		end loop;
	END PROCESS;

END test;