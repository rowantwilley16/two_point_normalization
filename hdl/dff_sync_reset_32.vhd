-------------------------------------------------------
-- Design Name : dff_sync_reset_32
-- File Name   : dff_sync_reset_32.vhd
-- Function    : D flip-flop sync reset 32 bit bus width
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity dff_sync_reset_32 is
    port (
        data  :in  std_logic_vector(31 downto 0); -- Data input
        clk   :in  std_logic; -- Clock input
        reset :in  std_logic; -- Reset input
        q     :out std_logic_vector(31 downto 0)   -- Q output

    );
end entity;

architecture rtl of dff_sync_reset_32 is

begin
    process (clk,reset) begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                q <= (others => '0');
            else
                q <= data;
            end if;
        end if;
    end process;

end architecture;
