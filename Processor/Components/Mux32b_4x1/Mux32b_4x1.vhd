LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Mux32b_4x1 IS
    PORT (
        a0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a2: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a3: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        b: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Mux32b_4x1;

ARCHITECTURE comportamental OF Mux32b_4x1 IS 
BEGIN 
    b <= a0 when (s="00") else 
         a1 when (s="01") else
         a2 when (s="10") else 
         a3 when (s="11");
END comportamental;