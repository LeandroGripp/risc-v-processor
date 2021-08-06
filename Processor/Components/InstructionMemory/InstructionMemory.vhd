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
  TYPE ramType IS ARRAY(0 TO 1) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ram : ramType :=(
    x"00000000",
    x"00000000"
  );

  CONSTANT baseAddress : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00400000";

begin
  process(A) is
    variable memIndex : INTEGER range 0 to 63;
  begin
    memIndex := to_integer((unsigned(A) - unsigned(baseAddress)) / 4);
    RD <= ram(memIndex);
END behavioral;