LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Datapath IS
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
    ImmSelect : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    ALUCtr : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

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
      a0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      a1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s : IN STD_LOGIC;
      b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT Mux32b_4x1 IS
    PORT (
      a0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      a1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      a2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      a3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      b : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
      A1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      A2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      A3 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      WD3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      RD1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      RD2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;

  COMPONENT SigExt IS
    GENERIC (
      inputLength : INTEGER := 12
    );
    PORT (
      input : IN STD_LOGIC_VECTOR(inputLength - 1 DOWNTO 0);
      output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
  END COMPONENT;

  -- DECLARAÇÃO DE SINAIS AUXILIARES
  SIGNAL NextPC : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL PC : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL PCPlus4 : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL Instruction : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL JumpAddress : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL NextPCSource : STD_LOGIC;

  SIGNAL RS1 : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL RS2 : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL RD : STD_LOGIC_VECTOR (4 DOWNTO 0);

  SIGNAL ImmI : STD_LOGIC_VECTOR(11 DOWNTO 0);
  SIGNAL ImmJ : STD_LOGIC_VECTOR(20 DOWNTO 0);
  SIGNAL ImmS : STD_LOGIC_VECTOR(11 DOWNTO 0);
  SIGNAL ImmB : STD_LOGIC_VECTOR(12 DOWNTO 0);

  SIGNAL ImmI32b : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ImmJ32b : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ImmS32b : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ImmB32b : STD_LOGIC_VECTOR(31 DOWNTO 0);

  SIGNAL ExtendedImmediate : STD_LOGIC_VECTOR(31 DOWNTO 0);

  SIGNAL WD3Data1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL WD3Data2 : STD_LOGIC_VECTOR(31 DOWNTO 0);

  SIGNAL Reg1 : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL Reg2 : STD_LOGIC_VECTOR (31 DOWNTO 0);

  SIGNAL ALUSourceSignal : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ALURes : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ShouldBranch : STD_LOGIC;

  SIGNAL DataFromMemory : STD_LOGIC_VECTOR(31 DOWNTO 0);

  SIGNAL BaseAddress : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
  -- ELEMENTOS CENTRAIS
  ProgramCounter :
  Register32b PORT MAP(clock => clk, ld => '1', reset => reset, D => NextPC, Q => PC);

  InstructionMemoryInstance :
  InstructionMemory PORT MAP(A => PC, RD => Instruction);

  RegisterFile :
  register_file PORT MAP(clk => clk, A1 => RS1, A2 => RS2, A3 => RD, WD3 => WD3Data2, writeEnable => WReg, RD1 => Reg1, RD2 => Reg2);

  DataMemoryInstance :
  DataMemory PORT MAP(clk => clk, WE => WMemData, WD => Reg2, A => ALURes, RD => DataFromMemory);

  ALUInstance :
  ALU PORT MAP(SRC1 => Reg1, SRC2 => ALUSourceSignal, CONTROL => AluCtr, RESULT => ALURes, ZERO => shouldBranch);

  -- EXTENSORES DE SINAL
  SigExtI :
  SigExt GENERIC MAP(inputLength => 12)
  PORT MAP(input => ImmI, output => ImmI32b);

  SigExtJ :
  SigExt GENERIC MAP(inputLength => 21)
  PORT MAP(input => ImmJ, output => ImmJ32b);

  SigExtS :
  SigExt GENERIC MAP(inputLength => 12)
  PORT MAP(input => ImmS, output => ImmS32b);

  SigExtB :
  SigExt GENERIC MAP(inputLength => 13)
  PORT MAP(input => ImmB, output => ImmB32b);

  -- ADDERS
  PCIncrementer :
  Adder_32b PORT MAP(x => PC, y => x"00000004", s => PCPlus4);

  AddressGenerator :
  Adder_32b PORT MAP(x => ExtendedImmediate, y => BaseAddress, s => JumpAddress);

  -- MULTIPLEXADORES
  PCPicker :
  Mux32b_2x1 PORT MAP(a0 => PCPlus4, a1 => JumpAddress, s => NextPCSource, b => NextPC);

  BaseAddressSelector :
  Mux32b_2x1 PORT MAP(a0 => Reg1, a1 => PC, s => BaseAdd, b => BaseAddress);

  ALUSourceSelector :
  Mux32b_2x1 PORT MAP(a0 => Reg2, a1 => ExtendedImmediate, s => ALUSrc, b => ALUSourceSignal);

  WriteToRegSrc1Picker :
  Mux32b_2x1 PORT MAP(a0 => ALURes, a1 => DataFromMemory, s => WDSrc, b => WD3Data1);

  WriteToRegSrc2Picker :
  Mux32b_2x1 PORT MAP(a0 => WD3Data1, a1 => PCPlus4, s => Jump, b => WD3Data2);

  ImmediateSelector :
  Mux32b_4x1 PORT MAP(a0 => ImmI32b, a1 => ImmJ32b, a2 => ImmS32b, a3 => ImmB32b, s => ImmSelect, b => ExtendedImmediate);

  -- UPDATE DE SINAIS DEPENDENTES

  RS1 <= Instruction(19 DOWNTO 15);
  RS2 <= Instruction(24 DOWNTO 20);
  RD <= Instruction(11 DOWNTO 7);

  ImmI <= Instruction(31 DOWNTO 20);
  ImmJ <= Instruction(31) & Instruction(19 DOWNTO 12) & Instruction(20) & Instruction(30 DOWNTO 21) & "0";
  ImmS <= Instruction(31 DOWNTO 25) & Instruction(11 DOWNTO 7);
  ImmB <= Instruction(31) & Instruction(7) & Instruction(30 DOWNTO 25) & Instruction(11 DOWNTO 8) & "0";

  NextPCSource <= ((Branch AND shouldBranch) OR Jump);

  opcode <= Instruction(6 DOWNTO 0);
  funct7 <= Instruction(31 DOWNTO 25);
  funct3 <= Instruction(14 DOWNTO 12);

END Behaviour;