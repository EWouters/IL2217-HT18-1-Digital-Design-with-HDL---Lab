library IEEE;
use ieee.std_logic_1164.all;
USE work.ALL; -- all components are in the work library

ENTITY alu IS
	GENERIC (size: INTEGER:=8);
	PORT(
		a:IN std_logic_vector (size-1 downto 0);
		b:IN std_logic_vector (size-1 downto 0);
		ctrl:IN std_logic_vector (1 downto 0);
		q:OUT std_logic_vector (size-1 downto 0);
		cout:OUT std_logic
	);
END alu;

ARCHITECTURE Behaviour OF alu IS
	COMPONENT mux
		PORT (
			a:IN std_logic;
			b:IN std_logic;
			adress:IN std_logic;
			q:OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT gate
		PORT (
			a:IN std_logic;
			b:IN std_logic;
			q:OUT std_logic
		);
	END COMPONENT;

	COMPONENT addSub IS
		GENERIC (size: INTEGER);
		PORT(
			a: IN std_logic_vector(size-1 downto 0);
			b: IN std_logic_vector(size-1 downto 0);
			cin:IN std_logic;
			sub: IN std_logic; -- sub = 0 => addition; sub = 1 => subtraktion
			q:OUT std_logic_vector(size-1 downto 0);
			cout:OUT std_logic
		);
	END COMPONENT;

	SIGNAL q_gate: std_logic_vector(size-1 downto 0);
	SIGNAL q_nor: std_logic_vector(size-1 downto 0);
	SIGNAL q_addSub: std_logic_vector(size-1 downto 0);
	SIGNAL add_cin   : std_logic;
	SIGNAL sub : std_logic;
	
--SIGNAL testvector:std_logic_VECTOR (2 downto 0); -- a, b, adress
--SIGNAL gateResult,dfResult:std_logic;
	
--	FOR c1:mux USE ENTITY work.mux(dataflow);

BEGIN
	gen_gate: 
	FOR i IN 1 TO size-1 GENERATE gate_x: gate
		PORT MAP(
			A => A(i),
			B => B(i),
			Q => q_gate(i)
		);
	END GENERATE;
	
--	gen_nor: 
--	FOR i IN 1 TO size-1 GENERATE nor_x: nand
--		PORT MAP(
--			A => A(i),
--			B => B(i),
--			Q => q_nor(i)
--		);
--	END GENERATE;

	DUTaddSub: addSub
		GENERIC MAP(
			size => size
		)
		PORT MAP(
			A   => A,
			B   => B,
			Cin   => add_cin,
			sub => sub,
			q   => q_addsub,
			Cout  => cout
		);

--	gen_muxA:
--	FOR i IN 1 TO size-1 GENERATE muxA_x: mux 
--		PORT MAP(
--			a, 
--			b,
--			ctrl(0),
--			q
--		);

	add_cin <= '0';

	process(ctrl, a, b) is
	begin
		case ctrl is
			when "00" =>
				sub <= '0';
				q <= q_addSub;
			when "01" =>
				sub <= '1';
				q <= q_addSub;
			when "10" =>
				q <= q_gate;
			when "11" =>
				q <= q_gate;
			when others =>
				assert false;
		end case;
	end process;


			
END Behaviour;