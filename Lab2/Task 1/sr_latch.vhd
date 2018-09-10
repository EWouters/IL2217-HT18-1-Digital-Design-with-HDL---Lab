library ieee;
use ieee.std_logic_1164.all;
use work.all;

-- the S and R inputs are active low

entity SR_LATCH is
	port (
		S		:	in std_logic;
		R		:	in std_logic;
		QPRIM	:	out std_logic;
		Q		:	out std_logic
	);
end SR_LATCH;

architecture DATAFLOW of SR_LATCH is
	signal QPRIM_INT	:	std_logic := '0';
	signal Q_INT		:	std_logic := '0';
begin
	Q_INT		<=	S AND QPRIM_INT;
	QPRIM_INT	<=	R AND Q_INT;
	Q			<=	Q_INT;
	QPRIM		<=	QPRIM_INT;
end DATAFLOW;
