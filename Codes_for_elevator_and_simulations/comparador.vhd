library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Comparador_16 is

  Port (
    A : in std_logic_vector (15 downto 0) := (others => '0');
    B : in std_logic_vector (15 downto 0) := (others => '0');
    CLOCK : in std_logic;
    igual_ou_maior : out std_logic
  );
  
end Comparador_16;

architecture arq_comparador of Comparador_16 is
begin

  process(CLOCK)
  begin
  
    if rising_edge(CLOCK) then
      if (unsigned(A) < unsigned(B)) then
        igual_ou_maior <= '0';
      else
        igual_ou_maior <= '1';
      end if;
    end if;
  end process;
end arq_comparador;
