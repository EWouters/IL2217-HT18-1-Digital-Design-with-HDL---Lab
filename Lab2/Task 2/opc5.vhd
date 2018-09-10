-- This package shall be compiled into a design library
-- symbolically named IEEE.

package opc5 is

-----------------------------------------------------------------------------------

-- logic State System (unresolved)

-----------------------------------------------------------------------------------

type opc_LOGIC is (
	'U',      -- Uninitialized
	'X',      -- Forcing Unknown
	'0',       -- Forcing   0
	'1',       -- Forcing   1
	'Z',       -- High Impedance
	'W',     -- Weak     Unknown
	'L',      -- Weak     0
	'H',      -- Weak     1
	'-'        -- don't care
);
-----------------------------------------------------------------------------------
-- Unconstrained array of std_logic for use in declaring
-- signal arrays
-----------------------------------------------------------------------------------
type opc_logic_vector is array ( NATURAL range <> )
      of opc_logic;
-----------------------------------------------------------------------------------
-- common subtypes
-----------------------------------------------------------------------------------
subtype X01 is RESOLVED opc_logic range 'X' to '1';
      -- ('X', '0', '1')
subtype X01Z is RESOLVED opc_logic range 'X' to 'Z';
      -- ('X', '0', '1', 'Z;)
subtype UX01 is RESOLVED opc_logic range 'U' to '1';
      -- ('U', 'X', '0', '1')
subtype UX01Z is RESOLVED opc_logic range 'U' to 'Z';
      -- ('U', 'X', '0', '1', 'Z')
-----------------------------------------------------------------------------------
-- overloaded logical operators
-----------------------------------------------------------------------------------
function "and" ( L : opc_logic; R : opc_logic ) return UX01;
function "nand" (L : opc_logic; R : opc_logic ) return UX01;
function "or" (L : opc_logic; R : opc_logic ) return UX01;
function "xor" (L : opc_logic; R : opc_logic ) return UX01;
function "xnor" (L : opc_logic; R : opc_logic ) return UX01;
function "not" (L : opc_logic ) return UX01;
-----------------------------------------------------------------------------------
-- vectorized overloaded logical operators
-----------------------------------------------------------------------------------
function "and" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "and" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "nand" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "nand" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "or" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "or" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "nor" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "nor" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "xor" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "xor" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "xnor" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "xnor" ( L, R : opc_logic_vector )
	return opc_logic_vector;
function "not" ( L  : opc_logic_vector )
	return opc_logic_vector;
function "not" ( L   : opc_logic_vector )
	return opc_logic_vector;
-----------------------------------------------------------------------------------
-- conversion functions
-----------------------------------------------------------------------------------

function TO_BIT ( S : opc_logic; XMAP : BIT :='0')
	return BIT;
function TO_BITVECTOR     (S : opc_logic_vector;
	XMAP : BIT :='0') return BIT_VECTOR;
function TO_BITVECTOR     (S : opc_logic_vector;
	XMAP : BIT :='0') return BIT_VECTOR;
function TO_STDULOGIC     ( B : BIT ) return opc_logic;
function TO_STDLOGICVECTOR       ( B : BIT_VECTOR        )
	return opc_logic_vector;
function TO_STDLOGICVECTOR       ( S : opc_logic_vector )
	return opc_logic_vector;
function TO_STDULOGICVECTOR    ( B : BIT_VECTOR     )
	return opc_logic_vector;
function TO_STDULOGICVECTOR    ( S : opc_logic_vector  )
	return opc_logic_vector;
-----------------------------------------------------------------------------------
-- strength strippers and type converters
-----------------------------------------------------------------------------------

function TO_X01  ( S : opc_logic_vector )
	return opc_logic_vector;
function TO_X01  ( S : opc_logic_vector)
	return opc_logic_vector;
function TO_X01  ( S : opc_logic     ) return X01;
function TO_X01  ( B : BIT_VECTOR     )
	return opc_logic_vector;
function TO_X01  ( B : BIT_VECTOR     )
	return opc_logic_vector;
function TO_X01  ( B : BIT             ) return X01;
function TO_X01Z  ( S : opc_logic_vector )
	return opc_logic_vector;
function TO_X01Z  ( S : opc_logic_vector)
	return opc_logic_vector;
function TO_X01Z  ( S : opc_logic     ) return X01Z;
function TO_X01Z  ( B : BIT_VECTOR     )
	return opc_logic_vector;
function TO_X01Z  ( B : BIT_VECTOR     )
	return opc_logic_vector;
function TO_X01Z  (B : BIT            ) return X01Z;
function TO_UX01  ( S : opc_logic_vector )
	return opc_logic_vector;
function TO_UX01  ( S : opc_logic_vector)
	return opc_logic_vector;
function TO_UX01  ( S : opc_logic     ) return UX01;
function TO_UX01  ( B : BIT_VECTOR     )
	return opc_logic_vector;
function TO_UX01  ( B : BIT_VECTOR     )
	return opc_logic_vector;
function TO_UX01  ( B : BIT              ) return UX01;     
-----------------------------------------------------------------------------------
-- edge detection
-----------------------------------------------------------------------------------
function RISING_EDGE (signal S : opc_logic)
	return BOOLEAN;
function FALLING_EDGE (signal S : opc_logic)
	return BOOLEAN;
-----------------------------------------------------------------------------------
-- object contains an unknown
-----------------------------------------------------------------------------------
function IS_X ( S : opc_logic_vector ) return BOOLEAN;
function IS_X ( S : opc_logic_vector ) return BOOLEAN;
function IS_X ( S : opc_logic      ) return BOOLEAN;

end opc5;