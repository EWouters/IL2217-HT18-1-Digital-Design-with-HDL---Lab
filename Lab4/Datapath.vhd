USE WORK.ALL;
USE WORK.package_MicroAssemblyCode.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;
USE IEEE.std_logic_arith.all;

ENTITY Datapath IS
	GENERIC (
		Size  : INTEGER := 8; -- # bits in word
		ASize : INTEGER := 3 -- # bits in address
	);
	PORT (
		InPort  : IN STD_LOGIC_VECTOR(Size-1 DOWNTO 0);
		OutPort : OUT STD_LOGIC_VECTOR(Size-1 DOWNTO 0);
		Clk     : IN STD_LOGIC;
		Instr   : Instruction_Type
	);
END Datapath;
