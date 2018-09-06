library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

ENTITY tb_Ripple_Adder IS
	GENERIC(N: INTEGER:=8);
END tb_Ripple_Adder;

ARCHITECTURE test OF tb_Ripple_Adder IS
	COMPONENT Ripple_Adder IS
		GENERIC(N: INTEGER:=4);
		PORT (
			A   : IN std_logic_vector(N downto 0);
			B   : IN std_logic_vector(N downto 0);
			Cin : IN std_logic;
			sub : IN std_logic;
			Cout: OUT std_logic;
			S   : OUT std_logic_vector(N downto 0)
		);
	END COMPONENT;
	
	--inputs to DUT
	SIGNAL numA : integer;
	SIGNAL numB : integer;
	SIGNAL A_int     : std_logic_vector(N downto 0);
	SIGNAL B_int     : std_logic_vector(N downto 0);
	SIGNAL add_cin   : std_logic;
	SIGNAL sub : std_logic;
	
	--outputs from DUT
	SIGNAL answer    : std_logic_vector(N downto 0);
	SIGNAL overflow: std_logic;

BEGIN
	DUT: ripple_adder
		GENERIC MAP(
			N => N
		)
		PORT MAP(
			A   => A_int,
			B   => B_int,
			Cin   => add_cin,
			sub => sub,
			Cout  => overflow,
			S   => answer
		);


	-- to_unsigned from numeric_std library
	A_int <= std_logic_vector(to_unsigned(numA,A_int'length));
	B_int <= std_logic_vector(to_unsigned(numB,B_int'length));
	add_cin <= '0'; -- not needed in this example so we set it to '0'
	--sub <= '0';
	
	PROCESS
	BEGIN
		sub <= '0';
		numA <= 3;
		numB <= 3;
		WAIT FOR 10 ns;
		numA <= 8;
		numB <= 1;
		WAIT FOR 10 ns;
		numA <= 4;
		numB <= 4;
		WAIT FOR 10 ns;
		numA <= 0;
		numB <= 1;
		WAIT FOR 10 ns;
		
		sub <= '1';
		numA <= 3;
		numB <= 3;
		WAIT FOR 10 ns;
		numA <= 8;
		numB <= 1;
		WAIT FOR 10 ns;
		numA <= 4;
		numB <= 4;
		WAIT FOR 10 ns;
		numA <= 0;
		numB <= 1;
		WAIT FOR 10 ns;
	END PROCESS;

END test;