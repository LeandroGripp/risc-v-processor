LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

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
  PROCESS (clk) IS
  BEGIN
    IF rising_edge(clk) THEN
      report 
        "a0=" & integer'image(to_integer(unsigned(registers(10)))) & " " &
        "s0=" & integer'image(to_integer(unsigned(registers(8)))) & " " &
        "t0=" & integer'image(to_integer(unsigned(registers(5))))
      severity note;

      -- Read A and B before bypass
      RD1 <= registers(to_integer(unsigned(A1)));
      RD2 <= registers(to_integer(unsigned(A2)));

      -- When required register is $0
      IF to_integer(unsigned(A1)) = 0 THEN 
        RD1 <= x"00000000";
      END IF;
      IF to_integer(unsigned(A2)) = 0 THEN 
        RD2 <= x"00000000";
      END IF;

      -- Write and bypass
      IF writeEnable = '1' AND to_integer(unsigned(A3)) /= 0 THEN
        registers(to_integer(unsigned(A3))) <= WD3; -- Write
      END IF;
    END IF;
  END PROCESS;
END behavioral;