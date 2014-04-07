-- Mémoire sur 12 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity memoire is
	port(
		clk : in std_logic;
		nload : in std_logic;	-- Chargement en mémoire de l'entrée cpt (nload actif bas)
		cpt : in std_logic_vector(11 downto 0);
		mem : out std_logic_vector(11 downto 0)
		);
end memoire;

architecture arch of memoire is
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			if nload = '0' then
				mem <= cpt;
			end if;
		end if;
	end process;
end arch;
	