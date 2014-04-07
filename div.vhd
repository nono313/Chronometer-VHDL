-- Diviseur d'horloge : permet de convertir l'horloge système de 50MHz en une horloge de période 1/10 s
-- Fréquence de 50 MHz => période de 0,02 µs
-- Pour avoir une période de sortie de 0,1 s = 100 000 µs = 0,02 * 5 000 000
-- On divise 5 000 000 par deux, avec en première moitié une sortie à 1 et en deuxième moitié une sortie à 0
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity div is
	port(
		clk_in : in std_logic;
		clk : out std_logic
	);
end div;

architecture arch of div is
signal compt : integer range 0 to 5000000 := 0;	-- Compteur du nombre de coup d'horloge
begin
process(clk_in)
begin
	if(clk_in'event and clk_in = '1') then
		if (compt < 2500000) then 
			clk <= '0';
		else
			clk <= '1';
		end if;
		if(compt = 5000000) then -- On repasse à 0 quand le compteur atteint 5 000 000
			compt <= 0;
		else
			compt <= compt + 1;
		end if;
	end if;
end process;
end arch;
	