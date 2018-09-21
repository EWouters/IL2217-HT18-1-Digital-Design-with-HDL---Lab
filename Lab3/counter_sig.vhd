library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity COUNTER_SIG is
	port (UP, CLK, RESET	:	in std_logic;
		OUT1	:	out	std_logic;
		OUT2	:	out std_logic_vector(3 downto 0)
	);
end;

architecture ARCH_COUNTER_SIG of COUNTER_SIG is
	signal COUNT : std_logic_vector(3 downto 0);
begin
	process (CLK, RESET)
	begin
		if RESET = '0' then
			COUNT <= (others => '0');
		elsif CLK'event and CLK = '1' then
			case UP is
				when '1'	=> COUNT <= COUNT + 1;
				when '0'	=> COUNT <= COUNT - 1;
				when others => COUNT <= COUNT;  --to prevent a simulation error, where only 2/9 cases are covered
			end case;
		end if;
	end process;

	OUT1 <= '1' when (UP='1' and COUNT=15) or (UP='0' and COUNT=0) else '0';

	OUT2 <= COUNT;

end ARCH_COUNTER_SIG;