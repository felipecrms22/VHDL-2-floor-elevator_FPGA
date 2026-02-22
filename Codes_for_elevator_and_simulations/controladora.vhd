library IEEE;
use IEEE.std_logic_1164.all;

entity controladora is
port (
	BC1, BC2 : in std_logic;
    SPA : in std_logic;
    BE : in std_logic := '0';
    cmp_eq : in std_logic;
    IA : in std_logic := '0';
    CLOCK : in std_logic;
    ME : out std_logic;
    LE : out std_logic;
    PA : out std_logic;
    cont_load, cont_clear : out std_logic;
    IA_load : out std_logic;
    IAF : out std_logic
);
end entity controladora;

architecture arch_controladora of controladora is

signal estado_atual, estado_futuro : std_logic_vector (2 downto 0) := "000";

constant INI : std_logic_vector (2 downto 0) := "000"; --INI = estado inicial
constant PAR : std_logic_vector (2 downto 0) := "001"; --PAR = parado
constant MOV : std_logic_vector (2 downto 0) := "010"; --MOV = em movimento
constant CHE : std_logic_vector (2 downto 0) := "011"; --CHE = chegou
constant EME : std_logic_vector (2 downto 0) := "100"; --EME = emergência
constant RES : std_logic_vector (2 downto 0) := "101"; --RES = reset

begin
  P1 : process(CLOCK)
  begin
  	if (rising_edge(CLOCK)) then
    	estado_atual <= estado_futuro;
    end if;
  end process P1;

  P2 : process(estado_atual,BE, BC1, BC2, SPA, cmp_eq, IA)
  begin
  	if ((BE = '1') AND ((estado_atual = CHE) OR (estado_atual = PAR) OR (estado_atual = MOV))) then
    	cont_clear <= '1'; --talvez fazer 1 ciclo de clock extra ou eliminar o registrador no resultado da comparação
        IAF <= '0';
        LE <= '1';
        estado_futuro <= EME;
    elsif ((SPA = '1') AND (estado_atual = MOV)) then
    	cont_clear <= '1';
        IAF <= '0';
        LE <= '1';
        estado_futuro <= EME;
    else
    	case estado_atual is
        		when INI =>
            		estado_futuro <= "001";
                PA <= '1';
                cont_load <= '0';
                cont_clear <= '1'; 
                IA_load <= '0';
                LE <= '0';
                ME <= '0';


            when PAR =>

            	PA <= '1';
                cont_load <= '0';
                cont_clear <= '1'; 
                --talvez adicionar um clear no reg do comparador
                IA_load <= '0';
                LE <= '0';
                ME <= '0';

            	if (BC1 = '1' AND IA = '1') then
                  estado_futuro <= MOV;
                  IAF <= '0';
                elsif (BC2 = '1' AND IA = '0') then
                  estado_futuro <= MOV;
                  IAF <= '1';
                end if;

            when MOV =>

            	ME <= '1';
                PA <= '0';
                cont_clear <= '0';
                cont_load <= '1';
                IA_load <= '0';
                --IAF mantém
                LE <= '0';
                if (cmp_eq = '1') then
                	estado_futuro <= CHE;
                end if;

            when CHE =>
            	IA_load <= '1'; --como eu faço IA = 1??
                cont_load <= '0';
                cont_clear <= '1';
                --IAF mantém
                LE <= '0';
                ME <= '0';
                PA <= '0';
                estado_futuro <= PAR;

            when EME => --fazer os outputs do EME e RES
            	cont_load <= '0';
                LE <= '1';
                ME <= '0';
                PA <= '0';
                IA_load <= '0';
                IAF <= '0';
                cont_clear <= '1';
                estado_futuro <= RES;

            when RES =>
            	cont_clear <= '0';
                --IAF mantém
                ME <= '1';
                PA <= '0';
            	IA_load <= '0';
                cont_load <= '1';
                LE <= '1';
                if (cmp_eq = '1') then
                	estado_futuro <= CHE;
                end if;

            when others =>
              cont_load <= '0';
              cont_clear <= '0';
              IA_load <= '0';
              IAF <= '0';
              LE <= '0';
              ME <= '0';
              PA <= '0';
        end case;
    end if;
   end process P2;
end arch_controladora;
