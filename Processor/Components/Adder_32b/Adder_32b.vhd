LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Adder_32b IS
    PORT (
        x, y : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Adder_32b;

ARCHITECTURE comportamental OF Adder_32b IS 
BEGIN 
    s <= x + y;
END comportamental;