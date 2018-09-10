library ieee;
use ieee.std_logic_1164.all;
use work.all;

-- the S and R inputs are active low

entity d_register is
	GENERIC (N: INTEGER:=4);
	port (
		D		:	in std_logic_vector(N-1 downto 0);
		CLK		:	in std_logic;
		R		:	in std_logic;
		Q		:	out std_logic_vector(N-1 downto 0)
	);
end d_register;

architecture BEHAVIORAL of d_register is
begin
	process (CLK, D, R)
	begin
		if (R = '1') then
			Q <= (others => '0');
		elsif (CLK = '1') then
			Q <= D;
		end if;
	end process;
end BEHAVIORAL;
