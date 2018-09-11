library ieee;
use ieee.std_logic_1164.all;
use work.my_bus_resolution.all;
use work.all;

-- the S and R inputs are active low

entity data_bus is
	GENERIC (N: INTEGER:=4);
	port (
		D		:	in std_logic_vector(2*N-1 downto 0);
		CLK	:	in std_logic;
		R		:	in std_logic;
		Q		:	out std_logic_vector(N-1 downto 0);
		En		:	in std_logic_vector(1 downto 0)
	);
end data_bus;

architecture STRUCTURAL of data_bus is
	component d_register
		GENERIC (N: INTEGER:=4);
		port (
			D		:	in std_logic_vector(N-1 downto 0);
			CLK		:	in std_logic;
			R		:	in std_logic;
			Q		:	out std_logic_vector(N-1 downto 0)
		);
	end component;
	
--	signal CLK,R : std_logic;
--	signal D : std_logic_vector(2*N-1 downto 0);
--	signal Q_int0 : wired_and std_logic;
--	signal Q_int1 : wired_and std_logic;
--	signal Q_int2 : wired_and std_logic;
--	signal Q_int3 : wired_and std_logic;
	signal Q_int0 : std_logic_vector(N-1 downto 0);
	signal Q_int1 : std_logic_vector(N-1 downto 0);
begin
--	Q <= Q_int;
--	
--	gen_d_register:
--		FOR i IN 1 TO 2 GENERATE
--			DRx: d_register
--			PORT MAP(
--				D => D(i*N-1 downto (i-1)*N),
--				CLK => CLK,
--				R => R,
--				Q => Q_int
--			);
--		END GENERATE;

		DR0: d_register
		PORT MAP(
			D => D(3 downto 0),
			CLK => CLK,
			R => R,
			Q => Q_int0
		);

		DR1: d_register
		PORT MAP(
			D => D(7 downto 4),
			CLK => CLK,
			R => R,
			Q => Q_int1
		);

		Q <= Q_int0 when en(0) = '1' else (others => 'Z');
		Q <= Q_int1 when en(1) = '1' else (others => 'Z');
		
end STRUCTURAL;
