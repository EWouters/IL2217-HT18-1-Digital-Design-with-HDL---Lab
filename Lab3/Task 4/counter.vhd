------------------------------------------------------
-- Counter
-- File Name : counter.vhd
-- Data Type : integer
-- Reset : Asynchronous
-- Active : Low
------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.all;
use work.all;

entity counter is
	generic( MAX: INTEGER:=1);
	port( UP, CLK, RESET, EN: in std_logic;
			OUT1 : out std_logic;
			OUT2 : out integer range 0 to MAX-1
		);
	end;

architecture Arch_counter of counter is
	signal COUNT: integer range 0 to MAX-1;
begin
-----------------------------------------------------
	process (CLK, RESET, EN)
	begin
		if RESET = '0' then
			OUT1 <= '0';
			COUNT <= 0;
		elsif clk'event AND clk='1' then
			if UP='1' and EN='1' then
				if COUNT >= MAX-1 then
					OUT1 <= '1';
					COUNT <= 0;
				else
					OUT1 <= '0';
					COUNT <= COUNT+1;
				end if;
			elsif EN='1' then
				if COUNT <= 0 then
					OUT1 <= '1';
					COUNT <= MAX-1;
				else
					OUT1 <= '0';
					COUNT <= COUNT-1;
				end if;
			else
				OUT1 <= '0';
				COUNT <= COUNT;
			end if;
		end if;
	end process;
	OUT2 <= COUNT;
-----------------------------------------------------
end; -- Arch_counter