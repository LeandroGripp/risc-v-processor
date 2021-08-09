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
  PROCESS (clk) IS
    VARIABLE memIndex : INTEGER;
  BEGIN
    IF rising_edge(clk) THEN
      ram(62) <= dataInput;
      memIndex := to_integer((unsigned(A) - unsigned(baseAddress)) / 4);
      IF (WE = '1') THEN -- When we want to write to the DataMemory
        ram(memIndex) <= WD;

        IF (memIndex = 63) THEN -- Exposing the output to the outside world
          dataOutput <= ram(memIndex);
        ELSE
          dataOutput <= x"00000000";
        END IF; 
      ELSE -- When we want to read from the DataMemory
        if (memIndex > 63) then  -- when memIndex is out of range. Happens when A is garbage
          memIndex := 0;
        end if;
        RD <= ram(memIndex);
      END IF;
    END IF;
  END PROCESS;
END behavioral;