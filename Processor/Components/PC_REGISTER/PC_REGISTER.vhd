LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

-- Modified 32b register used as Program Counter
-- Adress of first program intruction is 0x00400000, as specified in riscV memory organization
-- Resets to 0x003FFFFC and will be incremmented right away

ENTITY PC_REGISTER IS
    PORT (
        clock : IN STD_LOGIC;
        ld : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END PC_REGISTER;

ARCHITECTURE RTL OF PC_REGISTER IS
BEGIN
    PROCESS (clock)
    BEGIN
        IF (rising_edge(clock)) THEN
            IF (reset = '1') THEN
                Q <= x"003FFFFC"; --Adress of first program intruction is 0x00400000
            ELSE
                IF (ld = '1') THEN
                    Q <= D;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END RTL;