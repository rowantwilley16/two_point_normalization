-------------------------------------------------------
-- Design Name : dff_sync_reset_32_tb
-- File Name   : dff_sync_reset_32_tb.vhd
-- Function    : D flip-flop sync reset 32 bit bus width testbench 
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity dff_sync_reset_32 is
end dff_sync_reset_32;

architecture behavioral of dff_sync_reset_32 is

    --constants
    constant clk_period : time := 10 ns; -- 100 MHz

    --testbench signals
    signal clk_tb       : std_logic := '0';
    signal reset_tb     : std_logic := '0';
    signal data_tb      : std_logic_vector(31 downto 0);
    signal q_tb         : std_logic_vector(31 downto 0); 
    
    
    --component
    
    component dff_sync_reset_32 is
    port (
        data  :in  std_logic_vector(31 downto 0); -- Data input
        clk   :in  std_logic; -- Clock input
        reset :in  std_logic; -- Reset input
        q     :out std_logic_vector(31 downto 0)   -- Q output

    );
end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            reset_tb <= '1';
            wait for ( clk_period );
            
            reset_tb <= '0';
            wait;
        end if;
    end process;

    -- Clock Driver
    clk_tb <= not clk_tb after (clk_period/2.0);

    -- Instantiate Unit Under Test: 
    
    uut: dff_sync_reset_32
    port map (
        data    => data_tb, 
        clk     => clk_tb, 
        reset   => reset_tb, 
        q       => q_tb
    ); 
    
    --stimulus process 
    process 
    begin 
        --test case 1: 
        wait for clk_period; 
        data_tb <= X"11111111"; 
        wait for clk_period; 
        data_tb <= X"FFFFFFFF"; 
        wait for clk_period; 
        wait; 
        
    end process; 

end behavioral;