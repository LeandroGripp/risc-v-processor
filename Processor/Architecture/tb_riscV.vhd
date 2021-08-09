library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity tb_riscV is
end tb_riscV;

architecture teste of tb_riscV is
component riscV is
port (	
    clk: IN STD_LOGIC;
    reset: IN STD_LOGIC;

    systemInput : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    systemOutput : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end component;

signal sig_clk: STD_LOGIC:= '0';
signal sig_reset: STD_LOGIC;
signal sig_systemInput: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal sig_systemOutput: STD_LOGIC_VECTOR(31 DOWNTO 0);

begin
instancia_counter: riscV port map(
    clk => sig_clk,
    reset => sig_reset,
    systemInput => sig_systemInput,
    systemOutput => sig_systemOutput
);

    sig_reset <= '1','0' after 21 ns;
    sig_systemInput <= x"00000276"; --630
    sig_clk <= not sig_clk after 10 ns;
end teste;

--Expected output: 2 3 3 5 7