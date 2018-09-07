library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

ENTITY tb_addSub IS
	GENERIC(size: INTEGER:=8);
END tb_addSub;

ARCHITECTURE testAddSub OF tb_addSub IS
	COMPONENT addSub IS
		GENERIC(size: INTEGER:=4);
		PORT (
			a: IN std_logic_vector(size-1 downto 0);
			b: IN std_logic_vector(size-1 downto 0);
			cin:IN std_logic;
			sub: IN std_logic; -- sub = 0 => addition; sub = 1 => subtraktion
			q:OUT std_logic_vector(size-1 downto 0);
			cout:OUT std_logic
		);
	END COMPONENT;
	
	--inputs to DUT
	SIGNAL numA : integer;
	SIGNAL numB : integer;
	SIGNAL A_int     : std_logic_vector(size-1 downto 0);
	SIGNAL B_int     : std_logic_vector(size-1 downto 0);
	SIGNAL add_cin   : std_logic;
	SIGNAL sub : std_logic;
	
	--outputs from DUT
	SIGNAL answer    : std_logic_vector(size-1 downto 0);
	SIGNAL overflow: std_logic;

BEGIN
	DUT: addSub
		GENERIC MAP(
			size => size
		)
		PORT MAP(
			A   => A_int,
			B   => B_int,
			Cin   => add_cin,
			sub => sub,
			q   => answer,
			Cout  => overflow
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

END testAddSub;