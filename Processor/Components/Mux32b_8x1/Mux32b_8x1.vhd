LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Mux32b_8x1 IS
    PORT (
        a0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a2: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a3: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a4: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a5: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a6: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a7: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        b: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Mux32b_8x1;

ARCHITECTURE comportamental OF Mux32b_8x1 IS 
BEGIN 
    b <= a0 when (s="000") else 
         a1 when (s="001") else
         a2 when (s="010") else 
         a3 when (s="011") else
         a4 when (s="100") else
         a5 when (s="101") else
         a6 when (s="110") else
         a7 when (s="111");
END comportamental;