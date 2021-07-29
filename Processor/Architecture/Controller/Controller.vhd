LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Controller IS
	PORT (
		opcode : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		funct7 : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		funct3 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);

		Branch : OUT STD_LOGIC
		Jump : OUT STD_LOGIC
		WDSrc : OUT STD_LOGIC
		WMemData : OUT STD_LOGIC
		WReg : OUT STD_LOGIC
		BaseAdd : OUT STD_LOGIC
		ALUSrc : OUT STD_LOGIC
    ImmSelect: OUR STD_LOGIC_VECTOR(1 DOWNTO 0)
    ALUCtr: OUR STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END ALU;

ARCHITECTURE arch OF ALU IS
BEGIN

	PROCESS (opcode, funct7, funct3) IS
		-- VARIABLE aux : STD_LOGIC_VECTOR(63 DOWNTO 0);
		-- VARIABLE result_temp : STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- VARIABLE zero_temp : STD_LOGIC;
	BEGIN
		CASE opcode IS
			WHEN "0110011" => -- Tipo R
				CASE funct7 IS
          WHEN "0000000" => -- add
            Branch <= 0;
            Jump <= 0;
            WDSrc <= 0;
            WMemData <= 0;
            WReg <= 1;
            AluSrc <= 0;
            AluCtr <= "000"
          
          WHEN "0000001" => -- mul, div ou rem
            CASE funct3 IS
              WHEN "000" => -- mul
                Branch <= 0;
                Jump <= 0;
                WDSrc <= 0;
                WMemData <= 0;
                WReg <= 1;
                AluSrc <= 0;
                AluCtr <= "001"

              WHEN "100" => -- div
                Branch <= 0;
                Jump <= 0;
                WDSrc <= 0;
                WMemData <= 0;
                WReg <= 1;
                AluSrc <= 0;
                AluCtr <= "010"

              WHEN "110" => -- rem
                Branch <= 0;
                Jump <= 0;
                WDSrc <= 0;
                WMemData <= 0;
                WReg <= 1;
                AluSrc <= 0;
                AluCtr <= "011"

              WHEN OTHERS => -- noOp
                Branch <= 0;
                Jump <= 0;
                WMemData <= 0;
                WReg <= 0;

          WHEN OTHERS => -- noOp
            Branch <= 0;
            Jump <= 0;
            WMemData <= 0;
            WReg <= 0;
      
			WHEN "1101111" => -- jal
        Branch <= 0;
        Jump <= 1;
        WMemData <= 0;
        WReg <= 1;
        ImmSelect <= "01";
        BaseAdd <= 1;
      
			WHEN "1100111" => -- jalr
        Branch <= 0;
        Jump <= 1;
        WMemData <= 0;
        WReg <= 1;
        ImmSelect <= "00";
        BaseAdd <= 0;
      
			WHEN "0100011" => -- sw
        Branch <= 0;
        Jump <= 0;
        WDSrc <= 0;
        WMemData <= 1;
        WReg <= 0;
        ImmSelect <= "10";
        AluSrc <= 1;
        AluCtr <= "000"
      
			WHEN "0000011" => -- lw
        Branch <= 0;
        Jump <= 0;
        WDSrc <= 1;
        WMemData <= 0;
        WReg <= 1;
        ImmSelect <= "00";
        AluSrc <= 1;
        AluCtr <= "000"
      
			WHEN "1100011" => -- Tipo B
        CASE funct3 IS
          WHEN "000" => -- beq
            Branch <= 1;
            Jump <= 0;
            WMemData <= 0;
            WReg <= 0;
            ImmSelect <= "11";
            BaseAdd <= 1;
            AluSrc <= 0;
            AluCtr <= "100"

          WHEN "001" => -- bne
            Branch <= 1;
            Jump <= 0;
            WMemData <= 0;
            WReg <= 0;
            ImmSelect <= "11";
            BaseAdd <= 1;
            AluSrc <= 0;
            AluCtr <= "101"

          WHEN "100" => -- blt
            Branch <= 1;
            Jump <= 0;
            WMemData <= 0;
            WReg <= 0;
            ImmSelect <= "11";
            BaseAdd <= 1;
            AluSrc <= 0;
            AluCtr <= "110"

          WHEN OTHERS => -- noOp
            Branch <= 0;
            Jump <= 0;
            WMemData <= 0;
            WReg <= 0;
      
			WHEN OTHERS => -- noOp
        Branch <= 0;
        Jump <= 0;
        WMemData <= 0;
        WReg <= 0;
      
		END CASE;
	END PROCESS;

END arch;