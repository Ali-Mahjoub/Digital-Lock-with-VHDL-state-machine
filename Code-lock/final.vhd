----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:39:07 12/13/2020 
-- Design Name: 
-- Module Name:    final - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity final is
Port ( clk : in  STD_LOGIC;
           clear : in  STD_LOGIC;                                       --reset
			  m: in string(1 downTO 1) ;                                   --caractere entré
			  b:in string(4 DOWNTO 1);                                     --le code de la serrure numérique
			  ncode: in string(4 DOWNTO 1);                                --nouveau code proposé de la serrure
			  sortie:in std_logic;                                         --sortie du systeme
			  validation:in std_logic;                                     --validation du code saisi
			  vncode:in std_logic;                                         --validation du nouveau code entré
			  conf:in std_logic;                                           -- bouton de configuration
			  code: inout  std_logic_vector(31 DOWNTO 0):= (others => '0');--code ascii du code de la serrure
			  btn: inout  std_logic_vector(7 DOWNTO 0):= (others => '0');  --code ascii du caractere entré
			  q: out std_logic_vector(3 downto 0);                         --l'etat present du systeme
			  alarm : out  STD_LOGIC;                                      --si 3 tentatives fausses de suite une alarme se déclenche
           right : out  STD_LOGIC;                                      -- =1 si le code entré est valide
           wrong : out  STD_LOGIC);                                     -- =1 si le code entré est invalide
			  

end final;

architecture Behavioral of final is
function to_slv(str : string) return std_logic_vector is                 --fonction de conversion du caractere en son code ascii
  alias str_norm : string(str'length downto 1) is str;
  variable res_v : std_logic_vector(8 * str'length - 1 downto 0);
begin
  for idx in str_norm'range loop
    res_v(8 * idx - 1 downto 8 * idx - 8) := 
      std_logic_vector(to_unsigned(character'pos(str_norm(idx)), 8));
  end loop;
  return res_v;
end function;

subtype state_type is integer range 0 to 12;                             --les différents etats du systeme
signal present_state, next_state : state_type ;
signal c: integer := 0;
 
begin

reg:process (m,clk,clear)                                                --process de registre d'état
begin
btn <= to_slv(m);
if vncode = '0'
then 
code <= to_slv(b);
else 
code <= to_slv(ncode);
end if;
if clear ='1'  then present_state <= 0;
elsif rising_edge(clk) then 
present_state <=next_state;
 
end if;
 
end process ;
C1: process (sortie,validation,btn)                                    -- décodeur d'état
begin
case present_state is 
when 0 =>  
if btn = code(31 DOWNTO 24) 
then next_state <= 1;
else next_state <= 6;
end if;
when 1 =>  if  btn = code (23 DOWNTO 16)
then next_state <= 2;
else next_state <= 7;
end if; 
when 2 => if btn = code (15 DOWNTO 8)
then next_state <= 3;
else next_state <= 8;
end if;
when 3 => if btn = code (7 DOWNTO 0)
then next_state <= 4;
else next_state <= 9;
end if;
when 4 => if ( validation = '1')
then next_state <= 5;
else next_state <= 0;
end if;
when 5 => if  sortie = '1'
then next_state <= 0;
else if ( (sortie = '0') and (conf = '1') )
then next_state <= 11 ;
else next_state <= 0;
end if;
end if;
when 6 => next_state <= 7;
when 7 => next_state <= 8;
when 8 => next_state <= 9;
when 9 => if validation= '1'
then next_state <= 10;
else next_state <= 0;
end if;
when 10 => if sortie= '1'
then next_state <= 0;
else next_state <= 10;
end if;
when 11 => if  not( ncode ="")
then
next_state <= 12;
ELSE next_state <= 0;
END if;
when 12 => if vncode = '1' 
then 
 next_state <= 0;
 else next_state <= 12;
 end if;
when others =>null;
end case;
end process;
debug_output:                             -- afficher l'etat
q <= conv_std_logic_vector(present_state,4);
C2: process (present_state)               --decodeur des sorties
begin
if present_state = 5 then right <= '1';   --code valide
else right <='0';
end if;
if present_state = 10 then wrong <= '1';
c <= c+1 ;                                --code invalide
else wrong <='0';
end if;
if c = 3 then alarm <= '1';               --alarm
else alarm <='0';
end if ;
end process;
end Behavioral;

