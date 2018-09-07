library IEEE;
use ieee.std_logic_1164.all;
use work.all;

--ENTITY addsub IS
--	GENERIC (size: INTEGER);
--	PORT(
--		a: IN bit_vector(size-1 downto 0);
--		b: IN bit_vector(size-1 downto 0);
--		cin:IN bit;
--		sub: IN bit; -- sub = 0 => addition; sub = 1 => subtraktion
--		q:OUT bit_vector(size-1 downto 0);
--		cout:OUT bit
--	);
--END addsub;


ENTITY Ripple_Adder IS
	GENERIC(N: INTEGER:=4);
	PORT(
			A   : IN  std_logic_vector(N downto 0);
			B   : IN  std_logic_vector(N downto 0);
			Cin : IN  std_logic;
			sub : IN  std_logic;
			Cout: OUT std_logic;
			S   : OUT std_logic_vector(N downto 0)
		);
END Ripple_Adder;

ARCHITECTURE Behaviour OF Ripple_Adder IS
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

	SIGNAL carryline: std_logic_vector(N downto 0);

BEGIN
	FA0: Full_Adder
		PORT MAP(
			A => A(0),
			B => B(0),
			Cin => Cin,
			sub => sub,
			Cout => carryline(0),
			S => S(0)
		);
		
		
	FAN: Full_Adder
		PORT MAP(
			A => A(N),
			B => B(N),
			Cin => carryline(N-1),
			sub => sub,
			Cout => Cout,
			S => S(N)
		);
		
	gen_adder:
		FOR i IN 1 TO N-1 GENERATE
			FAx: Full_Adder
			PORT MAP(
				A => A(i),
				B => B(i),
				Cin => carryline(i-1),
				sub => sub,
				Cout => carryline(i),
				S => S(i)
			);
		END GENERATE;
			
			
END Behaviour;