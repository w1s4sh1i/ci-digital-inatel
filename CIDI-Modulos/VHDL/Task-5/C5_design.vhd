LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;
    USE IEEE.numeric_std.ALL;

ENTITY tipos_vhdl IS
    PORT(
        clk                     : IN std_logic;
        rst                     : IN std_logic;
        signal_cnt              : OUT std_logic_vector(2 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY tipos_vhdl;

ARCHITECTURE behavioural OF tipos_vhdl IS
    -- SIGNAL signal_counter       : std_logic_vector(2 DOWNTO 0);
    -- SIGNAL signal_counter       : signed(2 DOWNTO 0);
    -- SIGNAL signal_counter       : unsigned(2 DOWNTO 0);
    SIGNAL signal_counter       : integer RANGE -4 TO 3;
    -- SIGNAL signal_counter       : natural RANGE 0 TO 7;
BEGIN

    PROCESS(clk, rst)
    BEGIN
        IF rst='1' THEN 
            -- signal_counter <= "000";
            signal_counter <= 0;
        ELSIF rising_edge(clk) THEN
            signal_counter <= signal_counter + 1;
        END IF;
    END PROCESS;

    -- atribuição para a saída
    -- signal_cnt <= signal_counter;
    -- signal_cnt <= std_logic_vector(signal_counter);
    signal_cnt <= std_logic_vector(to_signed(signal_counter, 3));
    -- signal_cnt <= std_logic_vector(to_unsigned(signal_counter, 3));
END ARCHITECTURE;