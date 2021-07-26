LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Shifter IS
    PORT (
        X: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Shifter;

ARCHITECTURE comportamental OF Shifter IS 
BEGIN 
    S <= "00" & X(31 downto 2);
END comportamental;