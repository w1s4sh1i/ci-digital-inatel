-- TASK E-105 (VHDL)
LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;

ENTITY testbench_vhdl_types IS
END ENTITY testbench_vhdl_types;

ARCHITECTURE stimulus OF testbench_vhdl_types IS
    COMPONENT vhdl_types IS
        PORT(
            clk                     : IN std_logic;
            rst                     : IN std_logic;
            signal_cnt              : OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, rst                 : std_logic := '1'; -- Default 
    SIGNAL sig_cnt                  : std_logic_vector(2 DOWNTO 0);
    CONSTANT PERIOD                 : time := 10 ns;
BEGIN

    -- clock generation
    PROCESS
    BEGIN
        WAIT FOR PERIOD/2;
        clk <= NOT clk;
    END PROCESS;

    PROCESS BEGIN
        WAIT FOR PERIOD/2;
        rst <= '0';
        WAIT;
    END PROCESS;

    sigvsvar : vhdl_types
        PORT MAP (
            clk                 => clk,
            rst                 => rst,
            signal_cnt          => sig_cnt
        );

END ARCHITECTURE;
