library ieee;
use ieee.std_logic_1164.all;

entity tb_semaforo is
end tb_semaforo;

architecture behavioral of tb_semaforo is
    signal tb_rst: std_logic;
    signal tb_clk: std_logic:='0';
    signal      sem1_v:     std_logic;
    signal      sem1_a:     std_logic;
    signal      sem1_r:     std_logic;
    signal      sem2_v:     std_logic;
    signal      sem2_a:     std_logic;
    signal      sem2_r:     std_logic;

    

begin
    tb_rst <= '1','0' after 10 ns;
    tb_clk <= not tb_clk after 10 ns; 

    semaforo_inst: entity work.semaforo
      port map (
        clk     => tb_clk,
        rst     => tb_rst,
        osem1_v => sem1_v,
        osem1_a => sem1_a,
        osem1_r => sem1_r,
        osem2_v => sem2_v,
        osem2_a => sem2_a,
        osem2_r => sem2_r
      );
end behavioral;
