-- Impulsion unique : permet de limiter l'appui sur un bouton à un seul coup d'horloge
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity impulsionUnique is
	port(
		clk_in : in std_logic;
		E : in std_logic;	-- Actif à l'état bas
		S : out std_logic	-- Actif à l'état haut
	);
end entity;

architecture a of impulsionUnique is
type etat is (X0,X1,X2);
signal courant, suivant : etat := X0;
begin
process(E, courant)
begin
	-- Système combinatoire : obligation de définir la sortie à chaque fois (d'où les else qui renvoient sur le même état).
	case courant is
		when X0 => if E = '0' then	-- Si entrée active (bas)
							S <= '1';
							suivant <= X1;
						else
							S <= '0';
							suivant <= X0;
						end if;
		when X1 =>  S <= '0';	-- Dès qu'on arrive à l'état X1, on met la sortie à 0
						if E = '1' then
							suivant <= X0;
						else
							suivant <= X2;	-- Si l'entrée est toujours active, on passe à l'état X2
						end if;
		when X2 => S <= '0';
						-- On reste dans cet état tant que l'entrée reste active
						if E = '1' then
							suivant <= X0;
						else
							suivant <= X2;
						end if;
	end case;
	
end process;
process(clk_in)
begin
	-- A chaque coup d'horloge, on passe à l'état suivant
	if clk_in'event and clk_in = '1' then
		courant <= suivant;
	end if;	
end process;

end a;