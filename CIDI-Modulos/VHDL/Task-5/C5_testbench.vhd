LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;

ENTITY testbench IS
END ENTITY;

ARCHITECTURE stimulus OF testbench IS
    COMPONENT tipos_vhdl IS
        PORT(
            clk                     : IN std_logic;
            rst                     : IN std_logic;
            signal_cnt              : OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk, rst                 : std_logic := '1';
    SIGNAL sig_cnt                  : std_logic_vector(2 DOWNTO 0);
    CONSTANT period                 : time := 10 ns;
BEGIN

    -- clock generation
    PROCESS
    BEGIN
        WAIT FOR period/2;
        clk <= NOT clk;
    END PROCESS;

    PROCESS
    BEGIN
        WAIT FOR 20 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    sigvsvar : tipos_vhdl
        PORT MAP (
            clk                 => clk,
            rst                 => rst,
            signal_cnt          => sig_cnt
        );
END ARCHITECTURE;