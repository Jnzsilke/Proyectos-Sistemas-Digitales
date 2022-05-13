library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contadorN_32 is
    generic(N:natural:=31);
    port    (
        rst :       in  std_logic;
        clk :       in  std_logic;
        seg_stop:   out std_logic_vector(1 downto 0); -- la pos 0 es para la cuenta 3 seg pos 1 para 30 seg
        value:      in  std_logic_vector(N-1 downto 0);
        load:       in  std_logic;
        count:      out std_logic_vector(N-1 downto 0)
    );
end contadorN_32;

architecture    behavioral  of  contadorN_32    is
    constant seg_30:natural:=149; --1.5kM
    constant seg_3:natural:=14; --150M
    signal  aux_count   :   unsigned(N-1 downto 0);
begin
    process(clk,rst)
    begin
        if  rst='1' then
            aux_count <= (others => '0');
        elsif   clk='1' and clk'event then
            if load = '1' then
                aux_count <= unsigned(value);
            else
                aux_count <= aux_count + 1;
            end if;
        
        end if;
    end process;
    seg_stop <= "10"    when seg_30 = aux_count else --matcheo contra 30 seg o 3 seg. Esto entra a la fsm para verificar si debe pasar o no de estado
                "01"    when seg_3 = aux_count  else
                "00";    
    
    count <= std_logic_vector(aux_count);

end behavioral;
