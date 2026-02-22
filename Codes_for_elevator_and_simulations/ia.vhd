library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_ia is
  port (  entrada_ia : in std_logic := '0';
          carregar_bit_ia : in std_logic := '0';
          CLOCK_ia : in std_logic := '0';
          saida_ia : out std_logic := '0'
  );

end reg_ia;

architecture arch_registrador_2 of reg_ia is
begin
  process (CLOCK_ia)
  begin
  
  if rising_edge(CLOCK_ia) then
    if carregar_bit_ia = '1' then
		saida_ia <= entrada_ia;
    else
    end if;
  else
  end if;
  end process;
end arch_registrador_2;


