------------------------------------------------------
-- Alarm Clock Testbench
-- File Name : tb_alarm_clock.vhd
-- Data Type : integer
-- Reset : Asynchronous
-- Active : Low
------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.all;
use work.types.all;
use work.all;

entity tb_alarm_clock is 
	GENERIC( MAX: INTEGER:=10;
				FREQ: INTEGER:=32;
				N: INTEGER:=5);
end tb_alarm_clock;

architecture arch_clk_divider of tb_alarm_clock is
	component alarm_clock
		generic( MAX: INTEGER:=10;
					FREQ: INTEGER:=32;
					N: INTEGER:=5
		);
		port( UP, CLK, RESET, EN : in std_logic;
				OUT1 : out std_logic;
				digits : out digits;
				OUT_EN1 : out std_logic_vector(N downto 0);
				SEGS : out SEGS
		);
	end component;
	
	SIGNAL UP, CLK, RESET, EN, OUT1: std_logic := '1';
	SIGNAL OUT_EN : std_logic_vector(N downto 0);
--	SIGNAL COUNTER: integer;
	SIGNAL dig : digits;
	SIGNAL SEG7 : SEGS;

BEGIN
	DUT: alarm_clock
		generic map( MAX => MAX,
			FREQ => FREQ,
			N => N
		)
		port map( 
			UP => UP, 
			CLK => CLK, 
			RESET => RESET, 
			EN => EN,
			OUT1 => OUT1,
			digits => dig,
			OUT_EN1 => OUT_EN,
			SEGS => SEG7
		);
	
	CLK <= not CLK after 10 ns;
	RESET <= '0', '1' after 50 ns;
	UP <= '1', '0' after 10 us;
	EN <= '1', '0' after 100 ns, '1' after 150 ns;
	
end; -- tb_alarm_clock