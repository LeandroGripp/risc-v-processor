LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_riscV IS
END tb_riscV;

ARCHITECTURE teste OF tb_riscV IS
    COMPONENT riscV IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            systemInput : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            systemOutput : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INSTRUCTION : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            A_DataPath_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL sig_clk : STD_LOGIC := '0';
    SIGNAL sig_reset : STD_LOGIC;
    SIGNAL sig_systemInput : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL sig_systemOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL sig_PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL sig_INSTRUCTION : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL sig_A_DataPath_Out : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    instancia_counter : riscV PORT MAP(
        clk => sig_clk,
        reset => sig_reset,
        systemInput => sig_systemInput,
        systemOutput => sig_systemOutput,
        PC => sig_PC,
        INSTRUCTION => sig_INSTRUCTION,
        A_DataPath_Out => sig_A_DataPath_Out
    );

    sig_reset <= '1', '0' AFTER 210 ns;
    sig_systemInput <= x"00000276"; --630
    sig_clk <= NOT sig_clk AFTER 100 ns;

END teste;

--Expected output: 2 3 3 5 7 (remember output display's 0 when there is notthing to be displayed)