------------------------------------------------------
-- Alarm Clock
-- File Name : alarm_clock.vhd
-- Data Type : integer
-- Reset : Asynchronous
-- Active : Low
------------------------------------------------------


Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.all;

package Types is
	constant N : integer := 5;
	constant MAX : integer := 10;
	constant FREQ : integer := 32;
	type digits is array (N-1 downto 0) of integer range 0 to MAX-1;
	type SEGS is array (N-1 downto 0) of std_logic_vector(6 downto 0);
end package;


Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.all;

use work.types.all;
use work.all;

entity alarm_clock is
	generic( MAX: INTEGER:=10;
				FREQ: INTEGER:=32;
				N: INTEGER:=5
		);
	port( UP, CLK, RESET, EN: in std_logic;
			OUT1 : out std_logic;
			digits : out digits;
			OUT_EN1 : out std_logic_vector(N downto 0);
			SEGS : out SEGS
		);
	end;

architecture Arch_alarm_clock of alarm_clock is
	
	component clk_divider is
		generic( MAX: INTEGER:=1);
		port( CLK, RESET : in std_logic;
			COUNTER : out integer;
			OUT1 : out std_logic
		);
	end component;
	
	component counter is
		generic( MAX: INTEGER:=10);
		port( UP, CLK, RESET, EN: in std_logic;
			OUT1 : out std_logic;
			OUT2 : out integer range 0 to MAX-1
		);
	end component;
	
	component seven_seg is
		port( CLK: in std_logic;
			NUM : in integer;
			SEGMENT7 : out std_logic_vector(6 downto 0)
		);
	end component;
	
--	signal EN : std_logic;
	signal COUNTER1 : integer;
	signal OUT_EN, EN_MASK : std_logic_vector(N downto 0);
	signal digits1 : types.digits;
begin
-----------------------------------------------------
	DIV: clk_divider
		generic map( MAX => FREQ)
		port map(
			CLK => CLK,
			RESET => RESET,
			COUNTER => COUNTER1,
			OUT1 => OUT_EN(0)
		);

--	CO0: counter
--		generic map (MAX => MAX)
--		PORT MAP(
--			UP => UP,
--			CLK => CLK,
--			RESET => RESET, 
--			EN => OUT_EN(0),
--			OUT1 => OUT_EN(1),
--			OUT2 => digits(0)
--		);
		
	gen_counter:
		FOR i IN N-1 DOWNTO 0 GENERATE
			COx: counter
			generic map (MAX => MAX)
			PORT MAP(
				UP => UP,
				CLK => CLK, 
				RESET => RESET, 
				EN => OUT_EN(i),
				OUT1 => OUT_EN(i+1),
				OUT2 => digits1(i)
			);
		END GENERATE;
	
--	COn: counter
--		generic map (MAX => MAX)
--		PORT MAP(
--			UP => UP,
--			CLK => CLK,
--			RESET => RESET, 
--			EN => OUT_EN(N-1),
--			OUT1 => OUT1,
--			OUT2 => digits(N-1)
--		);

	gen_segs:
		FOR i IN N-1 DOWNTO 0 GENERATE
			SEx: seven_seg
			PORT MAP(
				CLK => CLK, 
				NUM => digits1(i),
				SEGMENT7 => SEGS(i)
			);
		END GENERATE;
	
	EN_MASK <= (others => EN);
	OUT_EN1 <= OUT_EN and EN_MASK;
	OUT1 <= OUT_EN(N-1);
	digits <= digits1;
-----------------------------------------------------
end; -- Arch_alarm_clock