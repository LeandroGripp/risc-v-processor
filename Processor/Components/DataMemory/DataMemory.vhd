LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY DataMemory IS
  PORT (
    clk : IN STD_LOGIC;
    WE : IN STD_LOGIC;
    WD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END DataMemory;

ARCHITECTURE behavioral OF DataMemory IS

END behavioral;