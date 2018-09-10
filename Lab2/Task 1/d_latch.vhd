library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity D_LATCH is
	port (
		D		:	in std_logic;
		CLK		:	in std_logic;
		Q		:	out std_logic
	);
end D_LATCH;

architecture BEHAVIORAL of D_LATCH is
begin
	process (CLK, D)
	begin
		if (CLK = '1') then
			Q <= D;
		end if;
	end process;
end BEHAVIORAL;
