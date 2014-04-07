-- Chronomètre : implémente le compteur par 1000, les 3 afficheurs à segments ainsi que la mémoire
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity chronometre is
	port(
		clk_in : in std_logic; -- Horloge
		nclear : in std_logic;	-- Réinitialisation du chronomètre (et donc du compteur)
		nload : in std_logic;	-- Permet (à l'état bas) d'enregistrer en mémoire la valeure du compteur
		EN : in std_logic;	-- Active/désactive le compteur
		HEX0, HEX1, HEX2 : out std_logic_vector(6 downto 0)	-- Afficheurs à segments fonctionnant chacun sur 7 bits
		);
end chronometre;

architecture a of chronometre is
signal S : std_logic_vector(11 downto 0);
signal mem : std_logic_vector(11 downto 0);
component compteur is
	port(
		clk_in : in std_logic;
		nclear : in std_logic;
		EN : in std_logic;
		cpt : out std_logic_vector(11 downto 0)
	);
end component;
component afficheur is
	port(
		E : in std_logic_vector(3 downto 0);
		HEX : out std_logic_vector(6 downto 0)
		);
end component;
component memoire is 
	port(
		clk : in std_logic;
		nload : in std_logic;
		cpt : in std_logic_vector(11 downto 0);
		mem : out std_logic_vector(11 downto 0)
		);
end component;
begin
U0 : compteur port map(clk_in, nclear, EN, S);
U1 : afficheur port map(mem(3 downto 0), HEX0);		-- Les afficheurs sont reliés à la sortie du module de mémoire, ainsi, le compteur peut continuer à fonctionner sans modifier l'affichage.
U2 : afficheur port map(mem(7 downto 4), HEX1);
U3 : afficheur port map(mem(11 downto 8), HEX2);
U4 : memoire port map(clk_in, nload, S, mem);
end a;