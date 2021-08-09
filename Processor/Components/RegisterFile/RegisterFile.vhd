LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Register File, which contains 32 registers of 32bits
-- Inputs initiated with A specify the adress (2 read, 1 write)
-- Does not depend of the clock while reading a register and can read 2 registers simultaneously
-- Writes in the falling edge (writeEnable needs to be TRUE as well)
-- Has a ZERO refference register, which can not ve overwritten

ENTITY register_file IS
  PORT (
    clk : IN STD_LOGIC;
    writeEnable : IN STD_LOGIC;
    A1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    A2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    A3 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    WD3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END register_file;
ARCHITECTURE behavioral OF register_file IS
  TYPE registerFile IS ARRAY(0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL registers : registerFile;
BEGIN
  PROCESS (A1, A2) IS
  BEGIN
    -- Read A and B
    RD1 <= registers(to_integer(unsigned(A1)));
    RD2 <= registers(to_integer(unsigned(A2)));

    -- Zero Refference
    IF to_integer(unsigned(A1)) = 0 THEN
      RD1 <= x"00000000";
    END IF;
    IF to_integer(unsigned(A2)) = 0 THEN
      RD2 <= x"00000000";
    END IF;

  END PROCESS;
  PROCESS (clk) IS
  BEGIN
    IF falling_edge(clk) THEN
      IF writeEnable = '1' AND to_integer(unsigned(A3)) /= 0 THEN --can not write in ZERO register
        registers(to_integer(unsigned(A3))) <= WD3; -- Write
      END IF;
    END IF;
  END PROCESS;
END behavioral;