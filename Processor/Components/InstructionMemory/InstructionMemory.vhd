LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InstructionMemory IS
  PORT (
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END InstructionMemory;

ARCHITECTURE behavioral OF InstructionMemory IS

END behavioral;