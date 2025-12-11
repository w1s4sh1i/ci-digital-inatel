-- Entidade de leitura
LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.numeric_std.ALL;
    USE IEEE.std_logic_textio.ALL;
    USE STD.textio.ALL;

ENTITY read_stimulus IS
    GENERIC(
        CONSTANT filename               : string
    );
    PORT(
        value_from_file                 : OUT integer
    );
END ENTITY read_stimulus;
  
ARCHITECTURE reader OF read_stimulus IS
BEGIN
  
    PROCESS
        FILE file_descriptor            : text;
        VARIABLE text_line              : line;
        VARIABLE read_ok                : boolean;

        VARIABLE wait_delay             : integer;
        VARIABLE file_value             : integer;

    BEGIN
        -- abre o arquivo
        file_open(file_descriptor, filename, read_mode);
        
        -- lê o arquivo enquanto não atingir o fim
        WHILE NOT endfile(file_descriptor) LOOP
            -- lê uma linha do arquivo e transfere para o buffer text_line
            readline(file_descriptor, text_line);
            IF text_line.ALL'LENGTH = 0 THEN        -- testa se a linha está vazia
                NEXT;                               -- pula linhas vazias
            END IF;

            -- lê o primeiro valor do buffer text_line
            read(text_line, wait_delay, read_ok);
            ASSERT read_ok
                REPORT "Falha ao ler valor da linha: " & text_line.ALL SEVERITY warning;
            WAIT FOR wait_delay*1 ns;

            -- lê o segundo valor do buffer text_line
            read(text_line, file_value, read_ok);
            ASSERT read_ok
                REPORT "Falha ao ler valor da linha: " & text_line.ALL SEVERITY warning;
            value_from_file <= file_value;

            -- mostra no display do console a linha que foi lida
            REPORT "Linha lida: " & text_line.ALL; 
        END LOOP;
        
        -- fecha o arquivo
        file_close(file_descriptor);
        
        -- WAIT obrigatório ao fim de um processo de simulação quando ele não pode ser cíclico 
        WAIT; 
    END PROCESS;

END ARCHITECTURE;







-- Entidade de escrita
LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.numeric_std.ALL;
    USE IEEE.std_logic_textio.ALL;
    USE STD.textio.ALL;

ENTITY write_result IS
    GENERIC(
        CONSTANT filename               : string;
        CONSTANT radix                  : string;
        CONSTANT print_identifier       : boolean
    );
    PORT(
        identifier                      : IN std_logic_vector;
        clock                           : IN std_logic;
        valid                           : IN std_logic;
        data                            : IN std_logic_vector
    );
END ENTITY write_result;
  
ARCHITECTURE writer OF write_result IS
    ALIAS identifier_vector             : std_logic_vector(identifier'length-1 DOWNTO 0) IS identifier;
    ALIAS data_vector                   : std_logic_vector(data'length-1 DOWNTO 0) IS data;
BEGIN
    PROCESS(clock)
        FILE file_descriptor            : text;
        VARIABLE text_line              : line;
        CONSTANT separation             : string := " : ";
    BEGIN
        IF rising_edge(clock) THEN
            IF valid='1' THEN
                file_open(file_descriptor, filename, append_mode);
                
                -- escreve um identificador na frente do valor a ser salvo no buffer
                IF print_identifier THEN
                    write(text_line, to_integer(unsigned(identifier_vector)));
                    write(text_line, separation);
                END IF;
                
                -- define o radix que será usado para salvar os dados e escreve o buffer
                CASE radix IS
                    WHEN "bin" => -- binário
                        write(text_line, string'("0b"));
                        write(text_line, data_vector);
                    WHEN "u10" => -- decimal unsigned
                        write(text_line, to_integer(unsigned(data_vector)));
                    WHEN "s10" => -- decimal signed
                        write(text_line, to_integer(signed(data_vector)));
                    WHEN "hex" => -- hexadecimal
                        write(text_line, string'("0x"));
                        write(text_line, to_hstring(data_vector)); -- requer VHDL-2008
                    WHEN OTHERS => -- fallback para binário
                        write(text_line, string'("0b"));
                        write(text_line, data_vector); 
                END CASE;
                -- ponto e vírgula no final do buffer
                write(text_line, string'(";"));
                
                -- escreve a linha do buffer para o arquivo
                writeline(file_descriptor, text_line);
                file_close(file_descriptor);
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;