LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.std_logic_unsigned.ALL;

ENTITY testbench_aula2 IS 
END ENTITY testbench_aula2;

ARCHITECTURE stimulus OF testbench_aula2 IS  
    SIGNAL binary_value     : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL grey_encoded     : std_logic_vector(3 DOWNTO 0);
    CONSTANT period         : time := 10 ns;
    SIGNAL clk              : std_logic := '1';
BEGIN
    -- Opção 1 para gerar os valores de entrada para a simulação
    -- PROCESS
    -- BEGIN
    --     WAIT FOR period;
    --     binary_value <= binary_value + 1;
    -- END PROCESS;

    -- Opção 2 para gerar os valores de entrada para a simulação
    gen_clk : PROCESS
    BEGIN
        WAIT FOR period/2;
        clk <= NOT clk;
    END PROCESS;

    count_proc : PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            binary_value <= binary_value + 1;
        END IF;
    END PROCESS;

    -- entidade sendo simulada
    instancia_em_teste : ENTITY work.binary2gray(usando_with_select)
        PORT MAP (
            binary => binary_value,
            gray => grey_encoded
        );
END ARCHITECTURE stimulus;
