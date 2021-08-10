LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- The main entity in the project, which connects the Controller to the DataPath

-- Wires systemInput and systemOutput represent interaction with the outside (system) 
-- They were used to provide input and to display output to our program
-- More information about them can be found in DataMemory component

ENTITY riscV IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;

    systemInput : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    systemOutput : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END riscV;

ARCHITECTURE behavioral OF riscV IS

  COMPONENT Datapath IS
    PORT (

      clk : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      Branch : IN STD_LOGIC;
      Jump : IN STD_LOGIC;
      WDSrc : IN STD_LOGIC;
      WMemData : IN STD_LOGIC;
      WReg : IN STD_LOGIC;
      BaseAdd : IN STD_LOGIC;
      ALUSrc : IN STD_LOGIC;
      ImmSelect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      ALUCtr : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

      opcode : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      funct7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      funct3 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);

      datapathInput : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      datapathOutput : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT Controller IS
    PORT (
      opcode : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      funct7 : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      funct3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

      Branch : OUT STD_LOGIC;
      Jump : OUT STD_LOGIC;
      WDSrc : OUT STD_LOGIC;
      WMemData : OUT STD_LOGIC;
      WReg : OUT STD_LOGIC;
      BaseAdd : OUT STD_LOGIC;
      ALUSrc : OUT STD_LOGIC;
      ImmSelect : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      ALUCtr : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
  END COMPONENT;

  SIGNAL sig_opcode : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL sig_funct7 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL sig_funct3 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL sig_Branch : STD_LOGIC;
  SIGNAL sig_Jump : STD_LOGIC;
  SIGNAL sig_WDSrc : STD_LOGIC;
  SIGNAL sig_WMemData : STD_LOGIC;
  SIGNAL sig_WReg : STD_LOGIC;
  SIGNAL sig_BaseAdd : STD_LOGIC;
  SIGNAL sig_ALUSrc : STD_LOGIC;
  SIGNAL sig_ImmSelect : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL sig_ALUCtr : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
  DatapathInstance :
  Datapath PORT MAP(
    clk => clk,
    reset => reset,
    Branch => sig_Branch,
    Jump => sig_Jump,
    WDSrc => sig_WDSrc,
    WMemData => sig_WMemData,
    WReg => sig_WReg,
    BaseAdd => sig_BaseAdd,
    ALUSrc => sig_ALUSrc,
    ImmSelect => sig_ImmSelect,
    ALUCtr => sig_ALUCtr,
    opcode => sig_opcode,
    funct7 => sig_funct7,
    funct3 => sig_funct3,
    datapathInput => systemInput,
    datapathOutput => systemOutput
  );

  ControllerInstance :
  Controller PORT MAP(
    opcode => sig_opcode,
    funct7 => sig_funct7,
    funct3 => sig_funct3,
    Branch => sig_Branch,
    Jump => sig_Jump,
    WDSrc => sig_WDSrc,
    WMemData => sig_WMemData,
    WReg => sig_WReg,
    BaseAdd => sig_BaseAdd,
    ALUSrc => sig_ALUSrc,
    ImmSelect => sig_ImmSelect,
    ALUCtr => sig_ALUCtr
  );
END behavioral;