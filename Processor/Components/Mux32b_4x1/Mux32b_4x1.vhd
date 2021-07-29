LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Mux32b IS
    PORT (
        a0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a2: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a3: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s0 : IN STD_LOGIC;
        s1 : IN STD_LOGIC;
        b: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Mux32b;

ARCHITECTURE comportamental OF Mux32b IS 
BEGIN 
    b <= a0 when (s0='0' and s1='0') else 
         a1 when (s0='0' and s1='1') else
         a2 when (s0='1' and s1='0') else 
         a3 when (s0='1' and s1='1');
END comportamental;