LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.numeric_std.ALL;

ENTITY Datapath IS
    PORT (
      
      clk : IN STD_LOGIC;
      Branch : IN STD_LOGIC;
      Jump : IN STD_LOGIC;
      WDSrc : IN STD_LOGIC;
      WMemData : IN STD_LOGIC;
      WReg : IN STD_LOGIC;
      BaseAdd : IN STD_LOGIC;
      ALUSrc : IN STD_LOGIC;
      ImmSelect: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      ALUCtr: IN STD_LOGIC_VECTOR(2 DOWNTO 0);

      opcode : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      funct7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      funct3 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END Datapath;

ARCHITECTURE Behaviour OF Datapath IS
-- DEFINIÇÃO DE COMPONENTES AUXILIARES
COMPONENT Adder_32b IS
    PORT (
        x, y : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END COMPONENT;

COMPONENT ALU IS
  PORT (
    SRC1, SRC2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- 2 inputs 32-bit
    CONTROL : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 1 input 3-bit for selecting function
    RESULT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- 1 output 32-bit 
    ZERO : OUT STD_LOGIC -- ZERO flag
  );
END COMPONENT;

COMPONENT DataMemory IS
  PORT (
    clk : IN STD_LOGIC;
    WE : IN STD_LOGIC;
    WD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT InstructionMemory IS
  PORT (
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT Mux32b_2x1 IS
    PORT (
        a0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s : IN STD_LOGIC;
        b: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END COMPONENT;

COMPONENT Mux32b_4x1 IS
    PORT (
        a0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a2: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        a3: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        b: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END COMPONENT;

COMPONENT Register32b IS
    PORT (
        clock : IN STD_LOGIC;
        ld : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END COMPONENT;

COMPONENT register_file IS
  PORT (
    clk : IN STD_LOGIC;
    writeEnable : IN STD_LOGIC;
    A1 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    A2 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    A3 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    WD3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    RD2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

COMPONENT SigExt IS
  GENERIC (
    inputLength: INTEGER := 12
  );
  PORT (
    input : IN STD_LOGIC_VECTOR(inputLength-1 DOWNTO 0);
    output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- DECLARAÇÃO DE SINAIS AUXILIARES




END Behaviour;