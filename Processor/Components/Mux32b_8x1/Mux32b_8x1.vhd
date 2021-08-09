LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

-- Simple 32bit MUX with 3bit output selector and 8 possible outputs

ENTITY Mux32b_8x1 IS
    PORT (
        a0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a5 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a6 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a7 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Mux32b_8x1;

ARCHITECTURE comportamental OF Mux32b_8x1 IS
BEGIN
    b <= a0 WHEN (s = "000") ELSE
        a1 WHEN (s = "001") ELSE
        a2 WHEN (s = "010") ELSE
        a3 WHEN (s = "011") ELSE
        a4 WHEN (s = "100") ELSE
        a5 WHEN (s = "101") ELSE
        a6 WHEN (s = "110") ELSE
        a7;
END comportamental;