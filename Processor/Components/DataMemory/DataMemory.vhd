LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY DataMemory IS
  PORT (
    clk : IN STD_LOGIC;
    WE : IN STD_LOGIC;
    WD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    systemInput: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    systemOutput: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END DataMemory;

ARCHITECTURE behavioral OF DataMemory IS
  TYPE ramType IS ARRAY(0 TO 63) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ram : ramType := (62 => systemInput, others => x"00000000");

  CONSTANT baseAddress : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"10010000";
  
BEGIN
  PROCESS (clk) IS
    VARIABLE memIndex : INTEGER RANGE 0 TO 63;
  BEGIN
  ram(62) <= systemInput;
  IF rising_edge(clk) THEN
      memIndex := to_integer((unsigned(A) - unsigned(baseAddress)) / 4);
      IF (WE = '1') THEN -- When we want to write to the DataMemory
        ram(memIndex) <= WD;

        IF (memIndex = 63) THEN -- Exposing the output to the outside world
          systemOutput <= ram(memIndex);
        ELSE
          systemOutput <= x"00000000";
        END IF; 
      ELSE -- When we want to read from the DataMemory
        RD <= ram(memIndex);
      END IF;

    END IF;
  END PROCESS;
END behavioral;