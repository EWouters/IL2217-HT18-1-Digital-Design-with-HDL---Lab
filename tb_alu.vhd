USE WORK.ALL; -- Search for components in work library
LIBRARY IEEE; -- These lines informs the the compiler that the library IEEE
				  -- is used
USE IEEE.std_logic_1164.all; -- contains some conversion functions
USE IEEE.numeric_std.all; -- contains more conversion functions

ENTITY tb_ALU IS END tb_ALU;

ARCHITECTURE ALUTest OF tb_ALU IS
	constant width : INTEGER := 8;
	SIGNAL a,b,q:std_logic_vector(width-1 downto 0);
	SIGNAL ctrl:std_logic_vector (1 DOWNTO 0);
	SIGNAL cout,cin:std_logic:='0';
	COMPONENT alu
		GENERIC (size: INTEGER:=4);
		PORT (
			a:IN std_logic_vector (size-1 downto 0);
			b:IN std_logic_vector (size-1 downto 0);
			ctrl:IN std_logic_vector (1 downto 0);
			q:OUT std_logic_vector (size-1 downto 0);
			cout:OUT std_logic
		);
	END COMPONENT;

	FUNCTION to_bitvector(a:INTEGER;length:NATURAL) RETURN std_logic_vector IS
	-- This function converts an integer to a bitvector of length.
	-- To do this conversion are conversion functions from
	-- the IEEE package used.
	BEGIN
		RETURN std_logic_vector(to_signed(a,length));
	END;
	
	-- The statements inside a Procedure and a function is executed in sequence.
	PROCEDURE behave_alu(a:INTEGER; b:INTEGER;ctrl:INTEGER;
		q:OUT std_logic_vector(width-1 downto 0);
		cout: OUT std_logic) IS
		-- This is a behavioral model of the ALU.
		VARIABLE ret: std_logic_vector(width downto 0);
	BEGIN
		CASE ctrl IS
			-- width+1 for compensating for cout
			WHEN 0 => ret := to_bitvector(a+b, width+1);
			WHEN 1 => ret := to_bitvector(a-b,width+1);
						 ret(width):= not ret(width);
			-- & means concatenation
			WHEN 2 => ret := '0' &
				(to_bitvector(a,width) nand to_bitvector(b,width));
			WHEN 3 => ret := '0'&
				(to_bitvector(a,width) nor to_bitvector(b,width));
			WHEN OTHERS =>
				ASSERT false
				REPORT "CTRL out of range, testbench error"
				SEVERITY error;
		END CASE;
		q := ret(width-1 downto 0);
		cout := ret(width);
	END;
BEGIN
-- The key world process means that the code inside the process
-- is executed serially.
	PROCESS
	-- These variables are only valid inside a processes.
	-- The biggest difference from a signal in that they
	-- are uppdated immediately. Not at the nearest break.
		VARIABLE res:std_logic_vector ( width-1 downto 0);
		VARIABLE int_CTRL: std_logic_vector ( 2 downto 0);
		VARIABLE c:std_logic;
	BEGIN
		FOR i IN 0 TO width-1 LOOP
			a<= to_bitvector(i,width);
			FOR j IN 0 TO width LOOP
				b<= to_bitvector(j,width);
				FOR k IN 0 TO 3 LOOP
					ctrl<= to_bitvector(k,3)(1 downto 0);
					wait for 10 ns;
					behave_alu(i,j,k,res,c);
					-- Assert that q = res, otherwise is
					-- the messaege "wrong result from ALU"
					-- displayed in ModelSim EE window.
					ASSERT q = res
					REPORT "wrong result from ALU"
					SEVERITY warning;
					ASSERT cout = c
					REPORT "wrong carry from ALU"
					SEVERITY warning;
				END LOOP;
			END LOOP;
		END LOOP;
		wait;
	END PROCESS;
	T1:alu GENERIC MAP(width)
--	PORT MAP (a,b,cin,ctrl,cout,q);
	PORT MAP (a,b,ctrl,q,cout);
END ALUTest;