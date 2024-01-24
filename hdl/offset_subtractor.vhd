-------------------------------------------------------
-- Design Name : offset_subtractor
-- File Name   : offset_subtractor.vhd
-- Function    : bias subtractor
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity offset_subtractor is
port (
        data : in   std_logic_vector(31 downto 0); 
        bias : in   std_logic_vector(31 downto 0); 
        clk  : in   std_logic; 
        reset: in   std_logic; 
        q    : out  std_logic_vector(31 downto 0) 
);
end offset_subtractor;


architecture rtl of offset_subtractor is
    signal temp_result : std_logic_vector(31 downto 0);
begin
    subtraction_process: process(clk, reset)
    begin
        if reset = '1' then
            -- Reset condition
            temp_result <= (others => '0');
        elsif rising_edge(clk) then
            -- Subtract only on the rising edge of the clock
            temp_result <= std_logic_vector(unsigned(data) - unsigned(bias));
        end if;
        
        end process subtraction_process;
        -- Output the result
        q <= temp_result;
        
end rtl;
