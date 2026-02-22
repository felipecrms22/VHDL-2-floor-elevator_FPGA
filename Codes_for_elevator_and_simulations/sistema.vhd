library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity sistema is
    port(
        BC1, BC2, SPA, BE : in std_logic := '0'-- associar SPA a uma alavanca e PA a SPA
        CLOCK : in std_logic;
        PA, LE, ME, IA_saida, IAF_saida : out std_logic := '0'
    );
end entity sistema;

architecture arch_sistema of sistema is

    signal cont_load, cont_clear, IA_load, IAF_carregado : std_logic := '0';
    signal IA, IAF : std_logic := '0';
    signal cmp_eq : std_logic := '0';

    component datapath is
        generic (
            W : natural := 16
        );
        port(
            cont_load, cont_clear : in std_logic;
            IAF : in std_logic;
            CLOCK : in std_logic;
            IA_load : in std_logic;
            IA : out std_logic;
            cmp_eq : out std_logic;
            Ciclos_comparador : std_logic_vector (15 downto 0);
            IAF_carregado : out std_logic
        );
    end component;

    component controladora is
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
    end component;

begin

    datapath_inst : datapath
        port map(
            cont_load => cont_load, 
            cont_clear => cont_clear,
            IAF => IAF,
            CLOCK => CLOCK,
            IA_load => IA_load,
            IA => IA,
            cmp_eq => cmp_eq,
            Ciclos_comparador => std_logic_vector(to_unsigned(150, 16)),
            IAF_carregado => IAF_carregado
        );

    controladora_inst : controladora
        port map(
            BC1 => BC1,
            BC2 => BC2,
            SPA => SPA,
            BE => BE,
            cmp_eq => cmp_eq,
            IA => IA,
            CLOCK => CLOCK,
            ME => ME,
            LE => LE,
            PA => PA,
            cont_load => cont_load,
            cont_clear => cont_clear,
            IA_load => IA_load,
            IAF => IAF
        );

end architecture;
