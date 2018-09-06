library IEEE;
use ieee.std_logic_1164.all;
use work.all;

ENTITY Full_Adder IS
	PORT (
			A   : IN  std_logic;
			B   : IN  std_logic;
			Cin : IN  std_logic;
			sub : IN  std_logic;
			Cout: OUT std_logic;
			S   : OUT std_logic
		);
END Full_Adder;

ARCHITECTURE Behaviour OF Full_Adder IS
BEGIN
	
	S <= A XOR B XOR Cin;
	
	--Cout <= (sub AND (  ((NOT Cin) AND (NOT A) AND B) OR (Cin AND (NOT A) AND (NOT B)) OR (Cin AND (NOT A) AND B) OR (Cin AND A AND B)  )) OR ((NOT sub) AND ((A AND B) OR (B AND Cin) OR (B AND Cin)));
	
	Cout <= (A AND B AND NOT sub) OR ( NOT A AND B AND sub) OR ( NOT A AND Cin AND sub) OR (B AND Cin);
	
END Behaviour;
