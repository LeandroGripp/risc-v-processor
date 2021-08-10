LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.NUMERIC_STD.ALL;

-- Generic Sign Extender, which extends any input to a 32bit output, by reproducing the most significant bit.

ENTITY SigExt IS
  GENERIC (
    inputLength : INTEGER := 12
  );
  PORT (
    input : IN STD_LOGIC_VECTOR(inputLength - 1 DOWNTO 0);
    output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END SigExt;

ARCHITECTURE Behavioral OF SigExt IS
  SIGNAL extension : STD_LOGIC_VECTOR(31 - inputLength DOWNTO 0); -- extension that has a size of 32 - inputLength

BEGIN
  extension <= (OTHERS => input(inputLength - 1)); -- all the bits of the extension correspond to the MSB of the input
  output <= extension & input; -- extended signal
END Behavioral;