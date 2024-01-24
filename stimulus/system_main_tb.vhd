-------------------------------------------------------
-- Design Name : system_main_tb
-- File Name   : system_main_tb.vhd
-- Function    : D flip-flop sync reset
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity system_main_tb is
end system_main_tb;

architecture behavioral of system_main_tb is

    --constants
    constant clk_period : time := 10 ns; -- 100MHz

    --testbench signals 
    signal clk_tb   : std_logic := '0';
    signal reset_tb : std_logic := '0';
    
    signal bias_tb      : std_logic_vector(31 downto 0); 
    signal gain_tb      : std_logic_vector(31 downto 0);
    signal data_tb      : std_logic_vector(31 downto 0);
    signal q_tb         : std_logic_vector(63 downto 0);
    --component
    component system_main
        port( 
            clk     : in std_logic;
            reset   : in std_logic;
            bias    : in std_logic_vector(31 downto 0);
            gain    : in std_logic_vector(31 downto 0);
            data    : in std_logic_vector(31 downto 0);
            q       : out std_logic_vector(63 downto 0)

        );
    end component;

begin

    -- Clock Driver
    clk_tb <= not clk_tb after (clk_period / 2.0 );

    -- Instantiate Unit Under Test:  system_main
    uut : system_main
        port map( 
        
            clk     => clk_tb,
            reset   => reset_tb,
            bias    => bias_tb,
            gain    => gain_tb,
            data    => data_tb,
            
            q => open


        );
        
        --stimulus process 
        
        process 
        begin 
        
            wait for clk_period; 
            reset_tb <='1'; 
            wait for clk_period; 
            reset_tb <= '0';
            
            -- test case 1: 
            
            gain_tb <= x"0001065b";
            bias_tb <= x"0003df4a";
            data_tb <= x"00212b8c";
            
            wait for clk_period *10; 
            wait;
            
        end process; 

end behavioral;

