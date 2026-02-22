library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg_iaf is
  port (  entrada_iaf : in std_logic := '0';
          carregar_bit_iaf : in std_logic := '1';
          CLOCK_iaf : in std_logic := '0';
          saida_iaf : out std_logic := '0'
  );

end reg_iaf;

architecture arch_registrador_1 of reg_iaf is
begin
  process (CLOCK_iaf)
  begin
  
  if rising_edge(CLOCK_iaf) then
    if carregar_bit_iaf = '1' then
		saida_iaf <= entrada_iaf;
    else
    end if;
  else
  end if;
  end process;
end arch_registrador_1;


