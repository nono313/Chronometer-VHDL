-- Circuit de commande : interface entre l'utilisateur et le fonctionnement interne du chronomètre
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity commande is
	port(
		clk_in, a,b : in std_logic; -- Horloge et boutons d'entrée du chronomètre
		EN, nload, nclear : out std_logic	-- Signaux utilisable directement sur le chronomètre
	);
end entity;

architecture a of commande is
type Etat is (clear, stop1, run1, run2, stop2);
signal courant : Etat := clear;
signal suivant : Etat;
begin
-- Définition de l'état suivant en fonction de l'état actuel et des variables d'entrées
process(courant, a, b)
begin
	case courant is
		when clear => suivant <= stop1;
		when stop1 => if a = '1' then
								suivant <= run1;
							elsif b = '1' then
								suivant <= clear;
							else	
								suivant <= stop1;
							end if;
		when run1 => if a = '1' then
								suivant <= stop1;
							elsif b = '1' then
								suivant <= run2;
							else
								suivant <= run1;
							end if;
		when run2 => if a = '1' then
								suivant <= stop2;
							elsif b = '1' then
								suivant <= run1;
							else
								suivant <= run2;
							end if;
		when stop2 => if a = '1' then	
								suivant <= run2;
							elsif b = '1' then
								suivant <= stop1;
							else
								suivant <= stop2;
							end if;
	end case;
end process;
-- Passage à l'état suivant à chaque coup d'horloge
process(clk_in)
begin
	if clk_in'event and clk_in = '1' then
		courant <= suivant;
	end if;
end process;
-- Pour chaque état correspond des états pour les sorties
process(courant)
begin
	case courant is
		when clear => EN <= '0';
							nload <= '0';
							nclear <= '0';
		when stop1 => EN <= '0';
							nload <= '0';
							nclear <= '1';
		when run1 => EN <= '1';
							nload <= '0';
							nclear <= '1';
		when run2 => EN <= '1';
							nload <= '1';
							nclear <= '1';	
		when stop2 => EN <= '0';
							nload <= '1';
							nclear <= '1';	
	end case;
end process;
end a;