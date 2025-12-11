LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.numeric_std.ALL;
  
ENTITY testbench IS
END ENTITY testbench;
  
ARCHITECTURE stimulus OF testbench IS
    -- component a ser instanciado
    COMPONENT real_time_clock IS
        GENERIC(
            clock_frequency_Hz          : integer
        );
        PORT(
            clk                         : IN std_logic;
            rst                         : IN std_logic;
            set                         : IN std_logic;
            init_hour                   : IN integer;
            init_minute                 : IN integer;
            init_second                 : IN integer; 
            hour                        : OUT integer;
            minute                      : OUT integer;
            second                      : OUT integer
        );
    END COMPONENT real_time_clock;

    -- sinais da testbench
    SIGNAL tb_clk, tb_rst               : std_logic := '1';
    SIGNAL tb_set                       : std_logic := '0';
    SIGNAL tb_hour                      : integer;
    SIGNAL tb_minute                    : integer;
    SIGNAL tb_second                    : integer;
  
    -- configurações de simulação
    CONSTANT clock_frequency            : integer := 20;
    CONSTANT clock_period               : time := 5 ns;
    
BEGIN
  
    -- instancia do timer - DUT
    timer_instance : real_time_clock
    GENERIC MAP (
        clock_frequency_Hz          => clock_frequency
    )
    PORT MAP (
        clk                         => tb_clk,
        rst                         => tb_rst,
        set                         => tb_set,
        init_hour                   => 21,
        init_minute                 => 30,
        init_second                 => 23,
        hour                        => tb_hour,
        minute                      => tb_minute,
        second                      => tb_second 
    );

    -- gerar o clock da simulação
    PROCESS 
    BEGIN
        WAIT FOR clock_period/2;
        tb_clk <= NOT tb_clk;
    END PROCESS;

    -- gerar o reset e o set será feito após 300 pulsos
    PROCESS(tb_clk)
        VARIABLE count_clock_pulse      : integer RANGE 0 TO 600 := 0;
    BEGIN
        IF rising_edge(tb_clk) THEN
            count_clock_pulse := count_clock_pulse + 1;
            IF (count_clock_pulse - 1 = 2) THEN -- tira o reset no 2° pulso de clock
                tb_rst <= '0';
            ELSIF (count_clock_pulse - 1 = 300) THEN -- manda o set no 300° pulso de clock
                tb_set <= '1';
            ELSIF (count_clock_pulse - 1 = 301) THEN -- zera o set no 301° pulso de clock
                tb_set <= '0';
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
