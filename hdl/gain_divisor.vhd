-------------------------------------------------------
-- Design Name  : gain_multiplier
-- File Name    : offset_multiplier.vhd
-- Function     : 32x32 bit divisor -> 64 bit result
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gain_divisor is
port (
        data    : in std_logic_vector(31 downto 0); 
        gain    : in std_logic_vector(31 downto 0); 
        clk     : in std_logic; 
        reset   : in std_logic; 
        q       : out std_logic_vector(63 downto 0) 
);
end gain_divisor;

architecture rtl of gain_divisor is
   -- signal, component etc. declarations
    signal temp_result : std_logic_vector(63 downto 0);
begin

   -- architecture body
       division_process: process(clk, reset)
    begin
        if reset = '1' then
            -- Reset condition
            temp_result <= (others => '0');
        elsif rising_edge(clk) then
            -- Check for division by zero
            if unsigned(gain) = 0 then
                temp_result <= (others => '0'); -- Set result to all '0's
            else
                -- Divide only on the rising edge of the clock
                temp_result <= std_logic_vector(unsigned(data) / unsigned(gain));
            end if;
        end if;
    end process division_process;
        
        -- Output the result
        q <= temp_result;
   
   
end rtl;
