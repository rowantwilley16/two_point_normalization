-------------------------------------------------------
-- Design Name  : gain_divisor_tb
-- File Name    : gain_divisor_tb.vhd
-- Function     : 32x32 bit divisor -> 64 bit result
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity gain_divisor_tb is
end gain_divisor_tb;

architecture behavioral of gain_divisor_tb is

    --constants 
    constant clk_period : time := 10 ns; -- 100MHz

    --testbench signals
    signal clk_tb   : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal data_tb : std_logic_vector(31 downto 0) := (others =>'0'); 
    signal gain_tb : std_logic_vector(31 downto 0) := (others => '0'); 
    signal q_tb : std_logic_vector(63 downto 0); 
    
    --component
    component gain_divisor is
    port (
        data    : in std_logic_vector(31 downto 0); 
        gain    : in std_logic_vector(31 downto 0); 
        clk     : in std_logic; 
        reset   : in std_logic; 
        q       : out std_logic_vector(63 downto 0) 
    );
end component;
    
    
begin


    -- Clock Process
    clk_tb <= not clk_tb after (clk_period / 2.0 );

    --Stimulus Process 
    stimulus_process: process 
    begin 
    --initilization
    reset_tb <= '1'; 
    wait for clk_period; 
    reset_tb <= '0'; 
    wait for clk_period; 

    --test case 1 
    data_tb <= x"001D4C42"; 
    gain_tb <= x"0001065b"; 
    
    wait for clk_period *2; 
    wait; 
    --test case 2
    
    
    end process; 
    
    --instantiate the DUT
   uut: gain_divisor
   port map (
        data    => data_tb, 
        gain    => gain_tb, 
        clk     => clk_tb, 
        reset   => reset_tb, 
        q       => q_tb
   
   ); 
    

end behavioral;

