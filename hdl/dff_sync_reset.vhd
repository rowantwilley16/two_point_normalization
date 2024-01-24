-------------------------------------------------------
-- Design Name : dff_sync_reset
-- File Name   : dff_sync_reset.vhd
-- Function    : D flip-flop sync reset
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity dff_sync_reset is
    port (
        data  :in  std_logic; -- Data input
        clk   :in  std_logic; -- Clock input
        reset :in  std_logic; -- Reset input
        q     :out std_logic  -- Q output

    );
end entity;

architecture rtl of dff_sync_reset is

begin
    process (clk) begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                q <= '0';
            else
                q <= data;
            end if;
        end if;
    end process;

end architecture;
