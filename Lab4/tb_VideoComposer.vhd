USE WORK.ALL;
USE WORK.package_MicroAssemblyCode.ALL;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all; -- contains some conversion functions
USE IEEE.std_logic_arith.all;

USE Std.TextIO.ALL;

ENTITY tb_VideoComposer IS
END tb_VideoComposer;

ARCHITECTURE tb_behaviour OF tb_VideoComposer IS
	COMPONENT VideoComposer
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
	END COMPONENT;
	
	TYPE HashTable_Type IS ARRAY(CHARACTER) OF INTEGER;
	
	PROCEDURE CreateHashTable(
		VARIABLE hash_table : OUT HashTable_Type
	) IS
		VARIABLE tmp : INTEGER := 0; -- Temp. var. for creation of hash table
	BEGIN
		FOR i IN CHARACTER LOOP
			hash_table(i) := tmp;
			tmp := tmp+1;
		END LOOP;
	END CreateHashTable;
	
	PROCEDURE ReadHeader(
		FILE FileIn : Std.TextIO.Text;
		FILE FileOut : Std.TextIO.Text;
		VARIABLE HashTable : HashTable_Type
	) IS
		VARIABLE buf : STRING(1 DOWNTO 1);
			-- The read character, i.e., one char of the string.
		VARIABLE len : INTEGER;
			-- A "dummy" var. for getting the READ syntax right
		VARIABLE char : CHARACTER; -- A temporary character
		VARIABLE int : INTEGER RANGE 0 TO 255;
			-- The integer value of the read ASCII character
		VARIABLE lf_count : INTEGER := 0;
		VARIABLE state : INTEGER := 0;
	BEGIN
		LOOP
			READ(FileIn, buf, len); -- Read 1 character from the input file
			WRITE(FileOut, buf); 	-- Write the character char to the output file
			char := buf(1);			-- Extraction of curr. read character
			int := HashTable(char); -- Make the char integer val. survive
			CASE state IS
				WHEN 0 =>
					IF int = 50 THEN
						state := 1;
					ELSE
						state := 0;
					END IF;
				WHEN 1 =>
					IF int = 53 THEN
						state := 2;
					ELSIF int = 2 THEN
						state := 1;
					ELSE
						state := 0;
					END IF;
				WHEN 2 =>
					IF int = 53 THEN
						state := 3;
					ELSIF int = 2 THEN
						state := 1;
					ELSE
						state := 0;
					END IF;
				WHEN 3 =>
					IF int = 10 THEN
						EXIT;
					ELSIF int = 2 THEN
						state := 1;
					ELSE
						state := 0;
					END IF;
				WHEN OTHERS =>
					null;
			END CASE;
		END LOOP;
	END ReadHeader;
		
	PROCEDURE ReadData(
		SIGNAL data_in : OUT STD_LOGIC_VECTOR(Size*3-1 DOWNTO 0);
		SIGNAL count : IN INTEGER
	) IS
	BEGIN
		data_in <= RGBDataIn(count);
	END ReadData;
	PROCEDURE ReadData(
	SIGNAL data_in : OUT STD_LOGIC_VECTOR(Size*3-1 DOWNTO 0);
		FILE FileIn : Std.TextIO.Text;
		VARIABLE HashTable : HashTable_Type
	) IS
		VARIABLE buf : STRING(1 DOWNTO 1); -- The read character i.e. one char of the string.
		VARIABLE len : INTEGER; -- A "dummy" var. for getting the READ syntax right
		VARIABLE char : CHARACTER; -- A temporary character
		VARIABLE int : INTEGER RANGE 0 TO 255; -- The integer value of a the read ASCII character
	BEGIN
		FOR i IN 3 DOWNTO 1 LOOP
		READ(FileIn, buf, len); -- Read 1 character from the input file
		char := buf(1); -- Extraction of curr. read character
		int := HashTable(char); -- Make the char integer val. survive
		data_in(Size*i-1 DOWNTO Size*(i-1)) <= CONV_STD_LOGIC_VECTOR(int,8);
		END LOOP;
	END ReadData;
	
	PROCEDURE WriteData(
		SIGNAL data_out : IN STD_LOGIC_VECTOR(Size*3-1 DOWNTO 0);
		SIGNAL RGBDataOut : OUT RGBData_Type(RGBDataIn'RANGE);
		SIGNAL count : INOUT INTEGER
	) IS
	BEGIN
		RGBDataOut(count) <= data_out;
		count <= count +1;
	END WriteData;
	
	PROCEDURE WriteData(
		SIGNAL data_out : IN STD_LOGIC_VECTOR(Size*3-1 DOWNTO 0);
		FILE FileOut : Std.TextIO.Text
	) IS
		VARIABLE buf : STRING(1 DOWNTO 1); 		-- The read character i.e. one char of the string.
		VARIABLE char : CHARACTER; 				-- A temporary character
		VARIABLE int : INTEGER RANGE 0 TO 255; -- The integer value of a the read ASCII character
		USE IEEE.std_logic_signed.all;
	BEGIN
		FOR i IN 3 DOWNTO 1 LOOP
			int := CONV_INTEGER(UNSIGNED(data_out(Size*i-1 DOWNTO Size*(i-1))));
			char := character'val(int);
			buf(1) := char;
			WRITE(FileOut, buf); -- Write the character char to the output file
		END LOOP;
	END WriteData;
	
	FILE FileIn  : Text OPEN Read_Mode  IS "datain.txt";
	FILE FileOut : Text OPEN Write_Mode IS "dataout.txt";
	
	SIGNAL clk : STD_LOGIC := '0';
	SIGNAL reset : STD_LOGIC;
	
	SIGNAL data_in : STD_LOGIC_VECTOR(Size*3-1 DOWNTO 0);
	SIGNAL data_in_ready : STD_LOGIC := '0';
	SIGNAL data_in_read : STD_LOGIC;
	
	SIGNAL data_out : STD_LOGIC_VECTOR(Size*3-1 DOWNTO 0);
	SIGNAL data_out_ready : STD_LOGIC;
	SIGNAL data_out_read : STD_LOGIC := '0';
	
	SIGNAL rgb_data_out : RGBData_Type(RGBDataIn'RANGE);
	SIGNAL count : INTEGER := 0;
	
	CONSTANT read_from_file : BOOLEAN := TRUE;
BEGIN
	
	clk<=NOT(clk) AFTER 10 ns;
	
	PROCESS
		VARIABLE hash_table : HashTable_Type;
	BEGIN
		IF read_from_file THEN
			CreateHashTable(hash_table);
			ReadHeader(FileIn, FileOut, hash_table);
			WHILE NOT Endfile(FileIn) LOOP
				ReadData(data_in, FileIn, hash_table);
				data_in_ready <= '1';
				WAIT UNTIL data_in_read = '1';
				data_out_read <= '0';
				data_in_ready <= '0';
				WAIT UNTIL data_out_ready = '1';
				WriteData(data_out,FileOut);
				data_out_read <= '1';
			END LOOP;
		ELSE
			FOR i IN RGBDataIn'RANGE LOOP
				ReadData(data_in,count);
				data_in_ready <= '1';
				WAIT UNTIL data_in_read = '1';
				data_out_read <= '0';
				data_in_ready <= '0';
				WAIT UNTIL data_out_ready = '1';
				WriteData(data_out,rgb_data_out,count);
				WAIT ON count;
				data_out_read <= '1';
			END LOOP;
		END IF;
		ASSERT false report "End of file. Aborting simulation"severity error;
		WAIT;
	END PROCESS;
	
	U_VideoComposer: VideoComposer GENERIC MAP(Size => Size, ASize => ASize)
	
	PORT MAP(
		Clk => clk,
		Reset => reset,
		DataIn => data_in,
		DataInReady => data_in_ready,
		DataInRead => data_in_read,
		DataOut => data_out,
		DataOutReady => data_out_ready,
		DataOutRead => data_out_read
	);
END tb_behaviour;
