Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_signed.ALL;
use IEEE.numeric_std.all;
use work.types.all;
use work.all;

entity seven_seg is
	port (
		clk : in std_logic;
		num : in integer;  --num input
		segment7 : out std_logic_vector(6 downto 0)  -- 7 bit decoded output.
	);
end seven_seg;
--'a' corresponds to MSB of segment7 and g corresponds to LSB of segment7.

architecture Behavioral of seven_seg is
begin
	process (clk,num)
	BEGIN
		if (clk'event and clk='1') then
				case  num is
					when 0 => segment7 <="1000000";  -- '0'
					when 1 => segment7 <="1111001";  -- '1'
					when 2 => segment7 <="0100100";  -- '2'
					when 3 => segment7 <="0110000";  -- '3'
					when 4 => segment7 <="0011001";  -- '4' 
					when 5 => segment7 <="0010010";  -- '5'
					when 6 => segment7 <="0000010";  -- '6'
					when 7 => segment7 <="1111000";  -- '7'
					when 8 => segment7 <="0000000";  -- '8'
					when 9 => segment7 <="0010000";  -- '9'
					--nothing is displayed when a number more than 9 is given as input. 
					when others=> segment7 <="1111111"; 
				end case;
			end if;
end process;

end Behavioral;