library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador is
    generic (
        W : natural := 16
    );
    port(
        CLOCK : in std_logic;
        RESET : in std_logic;
        CONT_LOAD : in std_logic;
        FINAL_VALUE : out std_logic_vector (W-1 downto 0)
    );
end entity Contador;

architecture Main of Contador is
    signal COUNT : unsigned(W-1 downto 0) := (others => '0');
begin
    process (CLOCK, RESET)
    begin
        if RESET = '1' then
            COUNT <= (others => '0');
        elsif rising_edge(CLOCK) then
            if (CONT_LOAD = '1') then
                COUNT <= COUNT + 1;
            end if;
        end if;
    end process;

    FINAL_VALUE <= std_logic_vector(COUNT);
end architecture Main;
