LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Memory where raw data is stored and acessed

-- In a real processor, DataMemory and InstructionMemory are all together, so we implemented a base adress
-- to simulate a real memory

-- Built as a modified RAM memory

-- Writes on falling edge

-- Reads realtime. Sometimes adress may be garbage, so if it is out of range, output is first element 
-- of memory

-- We defined address 62 for system input, and there is a direct wire connected to it as input

-- We defined address 63 for system output, and there is a direct wire connected to it as output
-- Anytime there is data beeing writen on it from the processor, this data is exported as system output
-- When there is nothing beeing writen on it during any given clock cicle, the output is 0

ENTITY DataMemory IS
  PORT (
    clk : IN STD_LOGIC;
    WE : IN STD_LOGIC; -- Enables Write mode
    WD : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data to be written in speccified adress
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Adress to be accessed
    RD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- output

    dataInput : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- system input, as explaned previously
    dataOutput : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- system output, as explaned previously
  );
END DataMemory;

ARCHITECTURE behavioral OF DataMemory IS
  TYPE ramType IS ARRAY(0 TO 63) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ram : ramType := (62 => dataInput, OTHERS => x"00000000");

  CONSTANT baseAddress : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"10010000"; --base memory adress

BEGIN
  PROCESS (A) IS -- Process for reading from DataMemory
    VARIABLE memIndex : INTEGER;
  BEGIN
    memIndex := to_integer((unsigned(A) - unsigned(baseAddress)) / 4);
    IF (memIndex > 63) THEN -- when memIndex is out of range. Happens when A is garbage
      memIndex := 0;
    END IF;
    RD <= ram(memIndex);
  END PROCESS;

  PROCESS (clk) IS -- Process for writing to DataMemory
    VARIABLE memIndex : INTEGER;
  BEGIN
    IF falling_edge(clk) THEN
      ram(62) <= dataInput; -- stores system input
      memIndex := to_integer((unsigned(A) - unsigned(baseAddress)) / 4);
      IF (WE = '1') THEN -- When we want to write to the DataMemory
        ram(memIndex) <= WD;
      END IF;
      IF (memIndex = 63 AND WE = '1') THEN -- Exposing the output to the outside world
        dataOutput <= WD;
      ELSE
        dataOutput <= x"00000000"; -- when nothing is beeing writen in system output
      END IF;
    END IF;
  END PROCESS;
END behavioral;