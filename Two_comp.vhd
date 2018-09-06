library IEEE;
use ieee.std_logic_1164.all;
use work.all;

ENTITY Two_comp IS
	GENERIC(N: INTEGER:=4);
	PORT (
			sub : IN  std_logic;
			B   : IN  std_logic_vector(N downto 0);
			Bout: OUT std_logic_vector(N downto 0)
		);
END Two_comp;

ARCHITECTURE Behaviour OF Two_comp IS
BEGIN

--	if (sub = '1') then
--	if ?? sub then
		Bout <= NOT B;
--	else
--		Bout <= B;
--	end if;
	
END Behaviour;
