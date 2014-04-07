-- Compteur synchrone par 10 (0 à 9)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity compt10 is
	port(
		Q : out std_logic_vector(3 downto 0); -- Vecteur de sortie sur 4 bits contenant le digit
		nclear : in std_logic;	-- Entrée synchrone de remise à 0
		EN : in std_logic;	-- Le compteur ne s'incrémente que si EN = 1
		clk : in std_logic	-- Signal d'horloge
		);
end compt10;

architecture arch of compt10 is
signal compt : integer range 0 to 10;
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if(nclear = '0') then
				compt <= 0;
			elsif(EN = '1') then
				if(compt = 9) then
					compt <= 0;
				else
					compt <= compt + 1;
				end if;
			end if;
		end if;
	end process;
	-- Converti la valeur de la variable integer compt en std_logic_vector de 4 bits
	with compt select
		Q <= "0000" when 0,
			"0001" when 1,
			"0010" when 2,
			"0011" when 3,
			"0100" when 4,
			"0101" when 5,
			"0110" when 6,
			"0111" when 7,
			"1000" when 8,
			"1001" when 9,
			"0000" when others;	-- Si au dessus de 9, on renvoie en sortie 0
end arch;