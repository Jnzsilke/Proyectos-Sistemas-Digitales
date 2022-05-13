library IEEE;
use IEEE.std_logic_1164.all;

entity semaforo is
    port(
        clk:in           std_logic;
        rst:in           std_logic;
        osem1_v: out      std_logic;
        osem1_a: out      std_logic;
        osem1_r: out      std_logic;
        osem2_v: out      std_logic;
        osem2_a: out      std_logic;
        osem2_r: out      std_logic
    );
end semaforo;

architecture behavioral of semaforo is
    constant    Ncount:integer:=31;
    signal      count:      std_logic_vector(Ncount-1 downto 0);
    signal      init_value: std_logic_vector(Ncount-1 downto 0);
    signal      load:       std_logic;
    signal      seg_stop:   std_logic_vector(1 downto 0);
    signal      sem1_v:     std_logic;
    signal      sem1_a:     std_logic;
    signal      sem1_r:     std_logic;
    signal      sem2_v:     std_logic;
    signal      sem2_a:     std_logic;
    signal      sem2_r:     std_logic;
    signal      sel_mux:    std_logic;
begin

fsm_sem:        entity work.fsm_semaforo
                port map(
                clk => clk,rst => rst,seg_30 => seg_stop(1), seg_3 => seg_stop(0),
                sem1_v => sem1_v,sem1_a => sem1_a,sem1_r => sem1_r,
                sem2_v => sem2_v,sem2_a => sem2_a,sem2_r => sem2_r,sel_mux => sel_mux);

contadorN_32:   entity work.contadorN_32
                port map(clk => clk,rst => rst,seg_stop => seg_stop,value => init_value,load=>load,count => count);


init_value <= (others=>'0');

load <= '1' when  ((seg_stop(1) = '1') OR ((seg_stop(0) = '1') AND (sel_mux ='1'))) else
       '0';
osem1_v <= sem1_v;
osem1_a <= sem1_a;
osem1_r <= sem1_r;
osem2_v <= sem2_v;
osem2_a <= sem2_a;
osem2_r <= sem2_r;

end;
