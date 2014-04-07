-- Utilise le "limiteur" sur les entrée des boutons utilisateurs (afin de limiter à un coup d'horloge leurs effets)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity commandeParImpulsion is
	port(
		clk, pb1, pb2 : in std_logic;
		nclear, EN, nload : out std_logic
	);
end entity;

architecture a of commandeParImpulsion is
signal a,b : std_logic;
component commande is
	port(
		clk_in, a,b : in std_logic;
		EN, nload, nclear : out std_logic
	);
end component;
component impulsionUnique is
	port(
		clk_in : in std_logic;
		E : in std_logic;
		S : out std_logic
	);
end component;
begin
U0 : commande port map(clk, a, b, EN, nload, nclear);
U1 : impulsionUnique port map(clk, pb1, a);
U2 : impulsionUnique port map(clk, pb2, b);
end a;