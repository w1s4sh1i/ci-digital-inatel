
LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;

LIBRARY std;
    USE std.env.ALL;

ENTITY testbench_mux_2x1 IS
END ENTITY testbench_mux_2x1;

ARCHITECTURE stimulus OF testbench_mux_2x1 IS
  
    -- componente que iremos testar
    
    COMPONENT mux_2x1 IS 
        PORT (
            port_A          : IN std_logic;
            port_B          : IN std_logic;
            selector        : IN std_logic;
            mux_out         : OUT std_logic
        );
    END COMPONENT;

    SIGNAL sig_A, sig_B, sig_sel, sig_out : std_logic := '0';

BEGIN
    
    -- gera os valores para a simulação
    stimuli : PROCESS
    BEGIN
        sig_A <= '0'; sig_B <= '0'; sig_sel <= '0';
        WAIT FOR 10 ns;
        sig_A <= '0'; sig_B <= '1'; sig_sel <= '0';
        WAIT FOR 10 ns;
        sig_A <= '0'; sig_B <= '1'; sig_sel <= '1';
        WAIT FOR 10 ns;
        sig_A <= '0'; sig_B <= '1'; sig_sel <= '0';
        WAIT FOR 10 ns;
        stop; -- Analisar 'finish'
    END PROCESS;

    -- instância da entidade em test (entity under test)
    EUT : mux_2x1
        PORT MAP(
            port_A => sig_A,
            port_B => sig_B,
            selector => sig_sel,
            mux_out => sig_out
        );

END ARCHITECTURE stimulus;
