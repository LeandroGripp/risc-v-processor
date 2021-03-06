LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

-- Simple 32bit MUX with 1bit output selector and 2 possible outputs

ENTITY Mux32b_2x1 IS
    PORT (
        a0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s : IN STD_LOGIC;
        b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Mux32b_2x1;

ARCHITECTURE comportamental OF Mux32b_2x1 IS
BEGIN
    b <= a0 WHEN (s = '0') ELSE
        a1;
END comportamental;