library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Eleva_dor is
    port(
		  SW : in std_logic_vector (9 downto 0);    -- SW0 = BC1; SW1 = BC2; SW2 = SPA; SW3 = BE; 
		  KEY : in std_logic_vector (1 downto 0);
		  LEDR : out std_logic_vector (9 downto 0); --LEDR0 = PA; LEDR1 = ME; LEDR2 = IA_saida; LEDR_3 = IAF_saida; LEDR9 = LE;
		  CLOCK_50 : in std_logic
    );
end entity Eleva_dor;

architecture arch_sistema of Eleva_dor is

    signal cont_load, cont_clear, IA_load, IAF_carregado : std_logic := '0';
    signal IA, IAF : std_logic := '0';
    signal cmp_eq : std_logic := '0';
    signal CLOCK : std_logic;

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
            Ciclos_comparador : std_logic_vector (15 downto 0) := "0000000000010000";
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
	 
component DivisorClock is
	port (
		CLOCK_50MHz : in std_logic;
		reset	      : in std_logic;
		CLOCK_4Hz   : out std_logic
	);

end component;


begin
	 clock_inst: DivisorClock port map (
		      CLOCK_50MHz => CLOCK_50,
				reset => '0',
				CLOCK_4Hz => CLOCK--mudar para 4 Hz
		  );
    datapath_inst: datapath port map(
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

    controladora_inst: controladora port map(
            BC1 => SW(0),
            BC2 => SW(1),
            SPA => SW(2),
            BE => SW(3),
            cmp_eq => cmp_eq,
            IA => IA,
            CLOCK => CLOCK,
            ME => LEDR(1),
            LE => LEDR(9),
            PA => LEDR(0),
            cont_load => cont_load,
            cont_clear => cont_clear,
            IA_load => IA_load,
            IAF => IAF
        );
		  
    --LEDR0 = PA; LEDR1 = ME; LEDR2 = IA_saida; LEDR_3 = IAF_saida; LEDR9 = LE;
	 LEDR(2) <= IA;
	 LEDR(3) <= IAF;

end architecture;