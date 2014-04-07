-- Fonctionne global du chronometre
-- Les entrées des boutons pb1 et pb2 sont envoyé dans les "filtres" d'impulsion
-- Ensuite, elles sont envoyés au séquenceur de commande qui génère les commandes directement pour le chronomètre
-- La sortie du chronomètre est enfin transmise aux différents afficheurs à segments
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity resultat_final is
	port(
		clk_in, pb1, pb2 : in std_logic;
		HEX0, HEX1, HEX2 : out std_logic_vector(6 downto 0)
	);
end entity;

architecture a of resultat_final is
component commandeParImpulsion is
	port(
		clk, pb1, pb2 : in std_logic;
		nclear, EN, nload : out std_logic
	);
end component;
component chronometre is
	port(
		clk_in : in std_logic;
		nclear : in std_logic;
		nload : in std_logic;
		EN : in std_logic;
		HEX0, HEX1, HEX2 : out std_logic_vector(6 downto 0)
		);
end component;
component div is
	port(
		clk_in : in std_logic;
		clk : out std_logic
	);
end component;
signal EN, nclear, nload, clkDiv : std_logic;
begin
U0 : chronometre port map(clk_in, nclear, nload, EN, HEX0, HEX1, HEX2);
U1 : commandeParImpulsion port map(clkDiv, pb1, pb2, nclear, EN, nload);
U3 : div port map(clk_in, clkDiv);
end a;