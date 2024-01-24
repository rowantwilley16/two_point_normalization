-------------------------------------------------------
-- Design Name : gain_multiplier_tb
-- File Name   : gain_multiplier_tb.vhd
-- Function    : gain_multiplier_ testbench
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity gain_multiplier_tb is
end gain_multiplier_tb;

architecture behavioral of gain_multiplier_tb is

    constant clk_period : time := 10 ns; -- 100MHz

    --tb signals
    signal clk_tb   : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal data_tb    : std_logic_vector(31 downto 0) := (others => '0'); 
    signal gain_tb    : std_logic_vector(31 downto 0) := (others => '0');
    signal q_tb      : std_logic_vector(63 downto 0); 
    
    
    --component
    component gain_multiplier is
    port (
        data : in   std_logic_vector(31 downto 0); 
        gain : in   std_logic_vector(31 downto 0); 
        clk  : in   std_logic; 
        reset: in   std_logic; 
        q    : out  std_logic_vector(63 downto 0) 
    );
    end component;

begin

    --clk process
    clk_tb <= not clk_tb after (clk_period / 2.0 );

    -- Instantiate Unit Under Test:  gain_multiplier
    uut: gain_multiplier 
    port map (
            data    => data_tb, 
            gain    => gain_tb, 
            clk     => clk_tb, 
            reset   => reset_tb, 
            q       => q_tb
    ); 
    
    --stimulus process
    
    process 
    begin
        wait for clk_period;
        reset_tb <= '1'; 
        wait for clk_period *2; 
        reset_tb <= '0'; 
        wait for clk_period;
    
    --test case 1 
        
        gain_tb <= x"0001065b";
        data_tb <= x"00000001";
        
        wait for clk_period;
        
        --test case 2
        gain_tb <= x"0000fe3a";
        data_tb <= x"00000001";
        
        
--test case 2
        gain_tb <= x"001d4c42";
        data_tb <= x"0000f9cc";
        wait for clk_period;
        wait; 
        
    end process; 
    
    

end behavioral;

