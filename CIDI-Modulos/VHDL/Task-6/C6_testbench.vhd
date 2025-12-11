LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.std_logic_unsigned.ALL;
    USE IEEE.numeric_std.ALL;

ENTITY testbench IS
END ENTITY;

ARCHITECTURE stimulus OF testbench IS
    COMPONENT single_port_memory IS
        PORT (
            clk                     : IN std_logic;
            data                    : IN std_logic_vector(7 DOWNTO 0);
            we                      : IN std_logic;
            addr                    : IN std_logic_vector(3 DOWNTO 0);
            q                       : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    CONSTANT period                 : time := 10 ns;
    SIGNAL clk, rst                 : std_logic := '1';

    SIGNAL flag_start               : std_logic := '1'; 
    SIGNAL write_en                 : std_logic := '0';

    SIGNAL counter, address         : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL mem_D, mem_Q             : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
BEGIN

    -- clock generation
    PROCESS
    BEGIN
        WAIT FOR period/2;
        clk <= NOT clk;
    END PROCESS;

    -- reset liberado apos 20 ns
    PROCESS
    BEGIN
        WAIT FOR 20 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    -- processo baseado em clock para gerar o contador e 
    PROCESS(clk, rst)
    BEGIN
        IF rising_edge(clk) THEN
            -- contador com flip flop dentro de reset sincrono
            IF (rst='1') THEN
                counter <= (OTHERS => '0');
            ELSE
                counter <= counter + 1;
            END IF;

            -- processo de geracao de valor pra memoria e desabilitar o write enable
            IF (rst='1') THEN
                write_en <= '0';
                mem_D <= (OTHERS => '0');
            ELSIF (flag_start='1') THEN
                write_en <= '1';
                mem_D <= std_logic_vector(shift_left(unsigned("0000" & counter), 2));
                IF (counter="1111") THEN 
                    flag_start <= '0';
                END IF;
            ELSE
                write_en <= '0';
                mem_D <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS;

    address <= counter - 1;

    -- Instancia do modulo sobre teste
    EUT : single_port_memory 
    PORT MAP (
        clk                     => clk,
        data                    => mem_D,
        we                      => write_en,
        addr                    => address,
        q                       => mem_Q
    );
END ARCHITECTURE;