-------------------------------------------------------
-- Design Name : offset_subtractor
-- File Name   : offset_subtractor.vhd
-- Function    : bias subtractor
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity offset_subtractor_tb is
end offset_subtractor_tb;

architecture behavioral of offset_subtractor_tb is

    constant clk_period : time := 10 ns; -- 10MHz

    component offset_subtractor is
    port (
        data : in   std_logic_vector(31 downto 0); 
        bias : in   std_logic_vector(31 downto 0); 
        clk  : in   std_logic; 
        reset: in   std_logic; 
        q    : out  std_logic_vector(31 downto 0) 
    );
    end component;

    signal data_tb  : std_logic_vector(31 downto 0) := (others => '0'); 
    signal bias_tb  : std_logic_vector(31 downto 0) := (others => '0'); 
    signal clk_tb   : std_logic := '0'; 
    signal reset_tb : std_logic := '0'; 
    signal q_tb     : std_logic_vector(31 downto 0); 
    
begin

    --clock process
    clk_tb <= not clk_tb after (clk_period/2);
    
    --stimulus process
    process 
    begin
   
        --initilization 
        wait for clk_period; 
        reset_tb <= '1'; 
        wait for clk_period *2; 
        reset_tb <= '0'; 
        wait for clk_period; 
        
        --test case 1 
        
        bias_tb <= x"0003df4a";
        data_tb <= x"00212b8c";
        
        wait for clk_period;
        
        --test case 2
        bias_tb <= x"0002d3e1";
        data_tb <= x"0002d3e3";
        
        wait for clk_period;
        wait; 
    end process; 
    
    
    
    --instantiate the DUT
    uut: offset_subtractor 
    port map (
            data => data_tb, 
            bias => bias_tb,
            clk  => clk_tb,
            reset => reset_tb, 
            q => q_tb 
    ); 
    
end behavioral;

