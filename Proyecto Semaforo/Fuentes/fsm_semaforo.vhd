library IEEE;
use ieee.std_logic_1164.all;


entity fsm_semaforo is
    port(
    clk:in      std_logic;
    rst:in      std_logic;
    seg_30:in   std_logic;
    seg_3:in    std_logic;
    sem1_v:out  std_logic;
    sem1_a:out  std_logic;
    sem1_r:out  std_logic;
    sem2_v:out  std_logic;
    sem2_a:out  std_logic;
    sem2_r:out  std_logic;
    sel_mux:out std_logic  ---carga para el mux que luego resetea el contador   
    );

end fsm_semaforo;

architecture behavioral of fsm_semaforo is

type t_estado is (R1_V2,R1_A2,A1_R2,V1_R2,A1_R2_p,R1_A2_p);
signal estado   :   t_estado;

begin

    process(clk,rst)
    begin
        if rst='1'then
            estado<=R1_V2;
        elsif clk='1'and clk'event then
            case estado is
                when R1_V2 =>
                    if seg_30='1'then
                        estado<=R1_A2;
                    end if;
                when R1_A2 =>
                    if seg_3='1'then
                        estado<=A1_R2;
                    end if;
                when A1_R2 =>
                    if seg_3='1'then
                        estado<=V1_R2;
                    end if;
                when V1_R2 =>
                    if seg_30='1'then
                        estado <= A1_R2_p;
                    end if;
                when A1_R2_p =>
                    if seg_3='1'then
                        estado<=R1_A2_p;
                    end if;
                when R1_A2_p =>
                    if seg_3='1'then
                        estado<=R1_V2;
                    end if;
            end case;
        end if;
    end process;
sel_mux <=  '1' when ((estado = R1_A2) OR (estado = A1_R2) OR (estado = A1_R2_p) OR (estado = R1_A2_p)) else
            '0';


sem1_v <=   '1' when estado = V1_R2 else
            '0';
sem1_a <=   '1' when ((estado = A1_R2) OR (estado = A1_R2_p)) else
            '0';
sem1_r <=   '1' when ((estado = R1_V2) OR (estado = R1_A2)  OR (estado = R1_A2_p)) else
            '0';

sem2_v <=   '1' when estado = R1_V2 else
            '0';
sem2_a <=   '1' when ((estado = R1_A2) OR (estado =  R1_A2_p)) else
            '0';
sem2_r <=   '1' when ((estado = V1_R2) OR (estado = A1_R2) OR (estado = A1_R2_p)) else
            '0';
end behavioral;
