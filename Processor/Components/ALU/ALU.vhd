LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU IS
	PORT (
		CONTROL : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		SRC1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		SRC2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RESULT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		ZERO : OUT STD_LOGIC
	);
END ALU;

ARCHITECTURE arch OF ALU IS
BEGIN

	PROCESS (CONTROL) IS
		VARIABLE aux : STD_LOGIC_VECTOR(63 DOWNTO 0);
		VARIABLE result_temp : STD_LOGIC_VECTOR(31 DOWNTO 0);
		VARIABLE zero_temp : STD_LOGIC;
	BEGIN
		CASE CONTROL IS
			WHEN "000" =>
				result_temp <= STD_LOGIC_VECTOR(signed(SRC1) + signed(SRC2));
				zero_temp := '0';
			WHEN "001" =>
				aux := STD_LOGIC_VECTOR(signed(SRC1) * signed(SRC2));
				result_temp := aux(63) & aux(30 DOWNTO 0);
				zero_temp := '0';
			WHEN "010" =>
				-- DIVISION;
			WHEN "011" =>
				-- REM;
			WHEN "100" =>
				result_temp <= "00000000000000000000000000000000";
				IF (SRC1 = SRC2) THEN
					zero_temp := '1';
				ELSE
					zero_temp := '0';
				END IF;
			WHEN "101" =>
				result_temp <= "00000000000000000000000000000000";
				IF (SRC1 = SRC2) THEN
					zero_temp := '0';
				ELSE
					zero_temp := '1';
				END IF;
			WHEN "110" =>
				result_temp <= "00000000000000000000000000000000";
				IF (signed(SRC1) < signed(SRC2)) THEN
					zero_temp := '1';
				ELSE
					zero_temp := '0';
				END IF;
			WHEN "111" =>
				result_temp <= "00000000000000000000000000000000";
				zero_temp := '0';
		END CASE;
		RESULT <= result_temp;
		ZERO <= zero_temp;
	END PROCESS;

END arch;