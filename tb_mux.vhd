USE work.ALL;

ENTITY testMux IS END testMux;
ARCHITECTURE testMux OF testMux IS
COMPONENT mux
	PORT (
		a:IN BIT;
		b:IN BIT;
		adress:IN BIT;
		q:OUT BIT
	);
END COMPONENT;

SIGNAL testvector:BIT_VECTOR (2 downto 0); -- a, b, adress
SIGNAL gateResult,dfResult:BIT;

FOR c1:mux USE ENTITY work.mux(dataflow);
FOR c2:mux USE ENTITY work.mux(gates);
BEGIN
	C1:mux PORT MAP(testvector(2), testvector(1),testvector(0),dfResult);
	C2:mux PORT MAP(testvector(2), testvector(1),testvector(0),gateResult);
	testvector <=
		"000",
		"100" AFTER 10 ns,
		"110" AFTER 15 ns,
		"111" AFTER 20 ns,
		"110" AFTER 25 ns,
		"010" AFTER 27 ns,
		"101" AFTER 30 ns;
END testMux;