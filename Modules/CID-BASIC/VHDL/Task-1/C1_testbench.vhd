-- TASK E-101 (VHDL)
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
            port_A          : IN STD_LOGIC;
            port_B          : IN STD_LOGIC;
            selector        : IN STD_LOGIC;
            mux_out         : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL sig_A : STD_LOGIC; -- := '0';
    SIGNAL sig_B : STD_LOGIC; -- := '0';
    SIGNAL sig_sel : STD_LOGIC; -- := '0'; 
    SIGNAL sig_out : STD_LOGIC;

BEGIN
    -- Instância da entidade em test (Entity Under Test)
    EUT : mux_2x1 PORT MAP(
            port_A => sig_A,
            port_B => sig_B,
            selector => sig_sel,
            mux_out => sig_out
        );
    
    -- Gera os valores para a simulação
    stimuli : PROCESS BEGIN
        
	sig_A <= '0'; 
	sig_B <= '1'; 

	sig_sel <= '0';
    WAIT FOR 10 ns;
        
	sig_sel <= '1';
    WAIT FOR 10 ns;

	sig_sel <= '0';
    WAIT FOR 10 ns;
 
	sig_sel <= '1';
    WAIT FOR 10 ns;
	
	sig_sel <= '0';
    WAIT FOR 10 ns;
        
	wait; -- Analisar 'finish' ou usar 'wait': aguardar todo processo.
    END PROCESS;

END ARCHITECTURE stimulus;
