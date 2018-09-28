USE WORK.ALL;
USE WORK.package_MicroAssemblyCode.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all; -- contains some conversion functions
USE IEEE.std_logic_arith.all;

ENTITY VideoComposer IS
	GENERIC (
		Size  : INTEGER; -- # bits in word
		ASize : INTEGER  -- # bits in address
	);
	PORT (
		Clk          : IN STD_LOGIC;
		Reset        : IN STD_LOGIC;
		DataIn       : IN STD_LOGIC_VECTOR(Size*3-1 DOWNTO 0);
		DataInReady  : IN STD_LOGIC;
		DataInRead   : OUT STD_LOGIC;
		DataOut      : OUT STD_LOGIC_VECTOR(Size*3-1 DOWNTO 0);
		DataOutReady : OUT STD_LOGIC;
		DataOutRead  : IN STD_LOGIC
	);
END VideoComposer;

ARCHITECTURE behaviour OF VideoComposer IS
BEGIN
END behaviour;