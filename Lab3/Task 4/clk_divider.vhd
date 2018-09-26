------------------------------------------------------
-- Clock Divider
-- File Name : clk_divider.vhd
-- Data Type : integer
-- Reset : Asynchronous
-- Active : Low
------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.all;
use work.all;

entity clk_divider is
	generic( MAX: INTEGER:=1);
	port( CLK, RESET : in std_logic;
			COUNTER : out integer;
			OUT1 : out std_logic
		);
	end;

architecture Arch_clk_divider of clk_divider is
	signal COUNT : integer:=0;
begin
-----------------------------------------------------
	process (CLK, RESET)
	begin
		if RESET = '0' then
			OUT1 <= '0';
			COUNT <= 0;
		elsif clk'event AND clk='1' then
--		if clk'event AND clk='1' then
			if COUNT >= MAX-1 then
				OUT1 <= '1';
				COUNT <= 0;
			else
				OUT1 <= '0';
				COUNT <= COUNT+1;
			end if;
		end if;
	end process;
	COUNTER <= COUNT;
-----------------------------------------------------
end; -- Arch_clk_divider