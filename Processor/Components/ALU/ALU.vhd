USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.NUMERIC_STD.ALL;
-----------------------------------------------
---------- ALU 32-bit VHDL ---------------------
-----------------------------------------------
ENTITY ALU IS
  PORT (
    SRC1, SRC2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- 2 inputs 32-bit
    CONTROL : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 1 input 3-bit for selecting function
    RESULT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- 1 output 32-bit 
    ZERO : OUT STD_LOGIC -- ZERO flag
  );
END ALU;
ARCHITECTURE Behavioral OF ALU IS

  SIGNAL ALU_Result : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL ZERO_Result : STD_LOGIC;

BEGIN
  PROCESS (SRC1, SRC2, CONTROL)
  BEGIN
    CASE(CONTROL) IS
      WHEN "000" => -- Addition
      ALU_Result <= SRC1 + SRC2;
      ZERO_result <= '0';
      WHEN "001" => -- Multiplication
      ALU_Result <= STD_LOGIC_VECTOR(to_unsigned((to_integer(unsigned(SRC1)) * to_integer(unsigned(SRC2))), 32));
      ZERO_result <= '0';
      WHEN "010" => -- Division
      ALU_Result <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(SRC1)) / to_integer(unsigned(SRC2)), 32));
      ZERO_result <= '0';
      WHEN "011" => -- REM
      ALU_Result <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(SRC1)) REM to_integer(unsigned(SRC2)), 32));
      ZERO_result <= '0';
      WHEN "100" => -- Equal
      IF (SRC1 = SRC2) THEN
        ZERO_result <= '1';
      ELSE
        ZERO_result <= '0';
      END IF;
      ALU_Result <= "00000000000000000000000000000000";
      WHEN "101" => -- Not Equal
      IF (SRC1 = SRC2) THEN
        ZERO_result <= '0';
      ELSE
        ZERO_result <= '1';
      END IF;
      ALU_Result <= "00000000000000000000000000000000";
      WHEN "110" => --  Less than
      IF (SRC1 < SRC2) THEN
        ZERO_result <= '1';
      ELSE
        ZERO_result <= '0';
      END IF;
      ALU_Result <= "00000000000000000000000000000000";
      WHEN "111" => -- devolve SRC2
      ALU_Result <= SRC2;
      ZERO_result <= '0';
    END CASE;
  END PROCESS;
  RESULT <= ALU_Result;
  ZERO <= ZERO_result;
END Behavioral;