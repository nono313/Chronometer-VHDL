-- Compteur par 1000 : implémente 3 compteurs par 10 avec deux comparEN pour les relier ensemble
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity compteur is
	port(
		clk_in : in std_logic;	-- Signal d'horloge direct (à 50 MHz)
		nclear : in std_logic;	-- Signal de réinitialisation du compteur
		EN : in std_logic;	-- Permet d'activer le compteur
		cpt : out std_logic_vector(11 downto 0)	-- Sortie du compteur sur 12 bits, chaque digit étant codé sur 4 bits
	);
end compteur;

architecture arch of compteur is
signal clock : std_logic; -- Sortie du diviseur d'horloge
signal S : std_logic_vector(11 downto 0);	-- Signal S utilisé pour renvoyer la sortie des compteurs par 10 en entrée des modules comparEN
component compt10 is
	port(
		Q : out std_logic_vector(3 downto 0);
		nclear : in std_logic;
		EN : in std_logic;
		clk : in std_logic
		);
end component;

component div is
	port(
		clk_in : in std_logic;
		clk : out std_logic
	);
end component;

component comparEN is
	port(
		ENin : in std_logic;
		Q : in std_logic_vector(3 downto 0);
		ENout : out std_logic
	);
end component;

signal EN1, EN2 : std_logic;
begin
cpt <= S;
U0 : div port map(clk_in, clock);
U1 : compt10 port map(S(3 downto 0), nclear, EN, clock);
U2 : comparEN port map(EN, S(3 downto 0), EN1);
U3 : compt10 port map(S(7 downto 4), nclear, EN1, clock);
U4 : comparEN port map(EN1, S(7 downto 4), EN2);
U5 : compt10 port map(S(11 downto 8), nclear, EN2, clock);
end arch;