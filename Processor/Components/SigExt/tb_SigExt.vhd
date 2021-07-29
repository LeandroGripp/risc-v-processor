-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_SigExt is
end tb_SigExt;

architecture teste of tb_SigExt is

COMPONENT SigExt IS
  GENERIC (
    inputLength: INTEGER := 12
  );
  PORT (
    input : IN STD_LOGIC_VECTOR(inputLength-1 DOWNTO 0);
    output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

signal INPUT: STD_LOGIC_VECTOR(5 downto 0);
signal OUTPUT: STD_LOGIC_VECTOR(31 downto 0);

begin
intancia : SigExt
	generic map (
    	inputLength => 6
    )
    port map (
    	input => INPUT,
      output => OUTPUT
    );
    
    INPUT <= "101111",
    		     "001111" after 10 ns;

end teste;