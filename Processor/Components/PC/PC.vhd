LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;

ENTITY PC IS
    PORT (
        clock : IN STD_LOGIC;
        ld : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END PC;

ARCHITECTURE RTL OF PC IS
BEGIN
    PROCESS (clock)
    BEGIN
        IF (rising_edge(clock)) THEN
            IF (reset = '1') THEN
                Q <= x"00400000";
            ELSE
                IF (ld = '1') THEN
                    Q <= D;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END RTL;