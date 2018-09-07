library IEEE;
use ieee.std_logic_1164.all;
use work.all;


ENTITY addsub IS
	GENERIC (size: INTEGER:=4);
	PORT(
		a: IN std_logic_vector(size-1 downto 0);
		b: IN std_logic_vector(size-1 downto 0);
		cin:IN std_logic;
		sub: IN std_logic; -- sub = 0 => addition; sub = 1 => subtraktion
		q:OUT std_logic_vector(size-1 downto 0);
		cout:OUT std_logic
	);
END addsub;

ARCHITECTURE Behaviour OF addSub IS
	COMPONENT Full_Adder IS
		PORT(
			A   : IN  std_logic;
			B   : IN  std_logic;
			Cin : IN  std_logic;
			sub : IN  std_logic;
			Cout: OUT std_logic;
			S   : OUT std_logic
		);
	END COMPONENT;

	SIGNAL carryline: std_logic_vector(size-1 downto 0);

BEGIN
	FA0: Full_Adder
		PORT MAP(
			A => A(0),
			B => B(0),
			Cin => Cin,
			sub => sub,
			Cout => carryline(0),
			S => q(0)
		);
		
		
	FAN: Full_Adder
		PORT MAP(
			A => A(size-1),
			B => B(size-1),
			Cin => carryline(size-2),
			sub => sub,
			Cout => Cout,
			S => q(size-1)
		);
		
	gen_adder:
		FOR i IN 1 TO size-2 GENERATE
			FAx: Full_Adder
			PORT MAP(
				A => A(i),
				B => B(i),
				Cin => carryline(i-1),
				sub => sub,
				Cout => carryline(i),
				S => q(i)
			);
		END GENERATE;
			
			
END Behaviour;