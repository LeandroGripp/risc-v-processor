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
    
    dataInput: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dataOutput: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END DataMemory;

ARCHITECTURE behavioral OF DataMemory IS
  TYPE ramType IS ARRAY(0 TO 63) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ram : ramType := (62 => dataInput, others => x"00000000");

  CONSTANT baseAddress : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"10010000";
  
BEGIN 
  PROCESS(A) IS -- Process for reading from DataMemory
    VARIABLE memIndex : INTEGER;
  BEGIN
    memIndex := to_integer((unsigned(A) - unsigned(baseAddress)) / 4);
    if (memIndex > 63) then  -- when memIndex is out of range. Happens when A is garbage
      memIndex := 0;
    end if;
    RD <= ram(memIndex);
  END PROCESS;

  PROCESS (clk) IS -- Process for writing to DataMemory
    VARIABLE memIndex : INTEGER;
  BEGIN
    IF falling_edge(clk) THEN
      ram(62) <= dataInput;
      memIndex := to_integer((unsigned(A) - unsigned(baseAddress)) / 4);
      -- report 
      --   "memIndex=" & integer'image(memIndex) &
      --   " WE=" & std_logic'image(WE) &
      --   " WD=" & integer'image(to_integer(unsigned(WD)))
      -- severity note;
      IF (WE = '1') THEN -- When we want to write to the DataMemory
        ram(memIndex) <= WD; 
      END IF;
      IF (memIndex = 63 and WE = '1') THEN -- Exposing the output to the outside world
        dataOutput <= WD;
      ELSE
        dataOutput <= x"00000000";
      END IF;
    END IF;
  END PROCESS;
END behavioral;