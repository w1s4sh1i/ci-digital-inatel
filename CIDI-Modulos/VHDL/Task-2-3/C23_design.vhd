LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;

ENTITY binary2gray IS 
    PORT (
        binary          : IN std_logic_vector(3 DOWNTO 0);
        gray            : OUT std_logic_vector(3 DOWNTO 0)
    );
END ENTITY binary2gray;

ARCHITECTURE usando_with_select OF binary2gray IS
BEGIN
    WITH binary SELECT
        gray <= "0000" WHEN "0000",
                "0001" WHEN "0001",
                "0011" WHEN "0010",
                "0010" WHEN "0011",
                "0110" WHEN "0100",
                "0111" WHEN "0101",
                "0101" WHEN "0110",
                "0100" WHEN "0111",
                "1100" WHEN "1000",
                "1101" WHEN "1001",
                "1111" WHEN "1010",
                "1110" WHEN "1011",
                "1010" WHEN "1100",
                "1011" WHEN "1101",
                "1001" WHEN "1110",
                "1000" WHEN "1111",
                "----" WHEN OTHERS;
END ARCHITECTURE usando_with_select;

ARCHITECTURE usando_case OF binary2gray IS
BEGIN
    PROCESS(binary)
    BEGIN
        CASE (binary) IS
            WHEN "0000" => 
                gray <= "0000"; 
            WHEN "0001" => 
                gray <= "0001"; 
            WHEN "0010" => 
                gray <= "0011"; 
            WHEN "0011" => 
                gray <= "0010"; 
            WHEN "0100" => 
                gray <= "0110"; 
            WHEN "0101" => 
                gray <= "0111"; 
            WHEN "0110" => 
                gray <= "0101"; 
            WHEN "0111" => 
                gray <= "0100"; 
            WHEN "1000" => 
                gray <= "1100"; 
            WHEN "1001" => 
                gray <= "1101"; 
            WHEN "1010" => 
                gray <= "1111"; 
            WHEN "1011" => 
                gray <= "1110"; 
            WHEN "1100" => 
                gray <= "1010"; 
            WHEN "1101" => 
                gray <= "1011"; 
            WHEN "1110" => 
                gray <= "1001"; 
            WHEN "1111" => 
                gray <= "1000"; 
            WHEN OTHERS =>
                gray <= "----";
        END CASE;
    END PROCESS;
END ARCHITECTURE usando_case;