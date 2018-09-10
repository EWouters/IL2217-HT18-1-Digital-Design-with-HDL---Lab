library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity D_FLIPFLOP is
	port (
		D		:	in std_logic;
		CLK		:	in std_logic;
		Q		:	out std_logic
	);
end D_FLIPFLOP;

architecture BEHAVIORAL of D_FLIPFLOP is
begin
	process (CLK, D)
	begin
--		if (CLK = '1' and rising_edge(CLK)) then	-- rising_edge is compatible with std_logic
		if (rising_edge(CLK)) then	-- rising_edge is compatible with std_logic
			Q	<=	D;
		end if;
	end process;
end BEHAVIORAL;
