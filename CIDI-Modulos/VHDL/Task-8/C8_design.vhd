LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.numeric_std.ALL;
  
ENTITY real_time_clock IS
    GENERIC(
        clock_frequency_Hz              : integer
    );
    PORT(
        clk                             : IN std_logic;
        rst                             : IN std_logic;
        set                             : IN std_logic;
        init_hour                       : IN integer;
        init_minute                     : IN integer;
        init_second                     : IN integer; 
        hour                            : OUT integer;
        minute                          : OUT integer;
        second                          : OUT integer
    );
END ENTITY real_time_clock;
  
ARCHITECTURE rtl OF real_time_clock IS
    -- conta os pulsos de clock para calcular a base de tempo
    SIGNAL reg_ticks                    : integer;
    SIGNAL reg_hour                     : integer;
    SIGNAL reg_minute                   : integer;
    SIGNAL reg_second                   : integer;
  
    -- procedimento que faz o wrapping da contagem de tempo
    PROCEDURE timer_wrapper(
        SIGNAL timer_counter            : INOUT integer;
        CONSTANT timer_limit            : IN integer;
        CONSTANT enable                 : IN boolean;
        VARIABLE wrapped_flag           : OUT boolean
    ) IS
    BEGIN
        wrapped_flag := false;
        IF (enable = true) THEN
            IF timer_counter = timer_limit - 1 THEN
                wrapped_flag := true;
                timer_counter <= 0;
            ELSE
                timer_counter <= timer_counter + 1;
            END IF;
        END IF;
    END PROCEDURE timer_wrapper;
  
BEGIN
  
    -- processo principal sensitivo a clock
    PROCESS(clk) IS
        VARIABLE wrap                   : boolean;
    BEGIN
        IF rising_edge(clk) THEN
            -- reset zera a contagem do relogio
            IF (rst = '1') THEN
                reg_ticks   <= 0;
                reg_hour    <= 0;
                reg_minute  <= 0;
                reg_second  <= 0;
            -- flag set permite configurar a hora do relogio
            ELSIF (set = '1') THEN
                reg_ticks   <= 0;
                reg_hour    <= init_hour;
                reg_minute  <= init_minute;
                reg_second  <= init_second;
            -- sem reset nem aplicação do set, faz a contagem do tempo
            ELSE
                -- sempre que a contagem de ticks é igual à frequência em Hz, temos 1s
                timer_wrapper(reg_ticks,    clock_frequency_Hz, true, wrap);
                -- cada contagem de 60 segundos habilita a contagem do próximo minuto
                timer_wrapper(reg_second,                   60, wrap, wrap);
                -- cada contagem de 60 minutos habilita a contagem da próxima hora
                timer_wrapper(reg_minute,                   60, wrap, wrap);
                -- após a contagem de 23h, reseta a contagem de horas para zero.
                timer_wrapper(reg_hour,                     24, wrap, wrap);
            END IF;
        END IF;
    END PROCESS;

    -- conecta os registradores para as saídas 
    hour    <= reg_hour;
    minute  <= reg_minute;
    second  <= reg_second;
  
END ARCHITECTURE;