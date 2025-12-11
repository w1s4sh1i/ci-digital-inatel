LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.numeric_std.ALL;
  
ENTITY testbench IS
END ENTITY testbench;
  
ARCHITECTURE stimulus OF testbench IS
    -- componentes da testbench
    COMPONENT read_stimulus IS
        GENERIC(
            CONSTANT filename           : string
        );
        PORT(
            value_from_file             : OUT integer
        );
    END COMPONENT;

    COMPONENT write_result IS
        GENERIC(
            CONSTANT filename           : string;
            CONSTANT radix              : string;
            CONSTANT print_identifier   : boolean
        );
        PORT(
            identifier                  : IN std_logic_vector;
            clock                       : IN std_logic;
            valid                       : IN std_logic;
            data                        : IN std_logic_vector
        );
    END COMPONENT;

    -- sinais da testbench
    SIGNAL tb_clk                       : std_logic := '1';
    SIGNAL tb_valid                     : std_logic := '1';
    SIGNAL tb_result                    : std_logic_vector(31 DOWNTO 0);
    SIGNAL tb_estimulo                  : integer;
  
    -- configurações de simulação
    CONSTANT clock_period               : time := 10 ns;
    
BEGIN
    
    -- gerar o clock da simulação
    PROCESS 
    BEGIN
        WAIT FOR clock_period/2;
        tb_clk <= NOT tb_clk;
    END PROCESS;

    -- instancia - DUT
    reader_inst : read_stimulus
    GENERIC MAP(
        filename                        => "estimulo.txt"
    )
    PORT MAP(
        value_from_file                 => tb_estimulo
    );

    -- instancia - DUT
    writer_inst : write_result
    GENERIC MAP (
        filename                        => "resultado.txt",
        radix                           => "u10",
        print_identifier                => false
    )
    PORT MAP (
        identifier                      => "0",
        clock                           => tb_clk,
        valid                           => tb_valid,
        data                            => tb_result
    );

    -- gerar o reset e o set será feito após 300 pulsos
    PROCESS(tb_clk)
        VARIABLE count_clock_pulse      : integer RANGE 0 TO 25000 := 0;
        VARIABLE sum                    : integer;
    BEGIN
        IF rising_edge(tb_clk) THEN
            count_clock_pulse := count_clock_pulse + 1;
            sum := count_clock_pulse + tb_estimulo;
            tb_result <= std_logic_vector(to_unsigned(sum, 32));
            
            IF (count_clock_pulse - 1 = 30) THEN
                tb_valid <= '0';
            ELSIF (count_clock_pulse - 1 = 40) THEN
                tb_valid <= '1';
            END IF;

        END IF;
    END PROCESS;
END ARCHITECTURE;
