-------------------------------------------------------
-- Design Name  : gain_multiplier
-- File Name    : offset_multiplier.vhd
-- Function     : 32x32 bit multiplier -> 64 bit result
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gain_multiplier is
port (
        data    : in std_logic_vector(31 downto 0); 
        gain    : in std_logic_vector(31 downto 0); 
        clk     : in std_logic; 
        reset   : in std_logic; 
        q       : out std_logic_vector(63 downto 0) 
);
end gain_multiplier;

architecture rtl of gain_multiplier is
   -- signal, component etc. declarations
    signal temp_result : std_logic_vector(63 downto 0);
begin

   -- architecture body
       multiplication_process: process(clk, reset)
    begin
        if reset = '1' then
            -- Reset condition
            temp_result <= (others => '0');
        elsif rising_edge(clk) then
            -- Multiply only on the rising edge of the clock
            temp_result <= std_logic_vector(unsigned(data) * unsigned(gain));
        end if;
        end process multiplication_process;
        
        -- Output the result
        q <= temp_result;
   
   
end rtl;
