-------------------------------------------------------
-- Design Name : dff_sync_reset
-- File Name   : dff_sync_reset.vhd
-- Function    : D flip-flop sync reset
-- Author       : Rowan Twilley
-- Targeted device: <Family::PolarFire> <Die::MPF100T> <Package::FCG484>
-------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity dff_sync_reset_tb is
end dff_sync_reset_tb;

architecture architecture_dff_sync_reset_tb of dff_sync_reset_tb is

--Declaration of the DUT
component dff_sync_reset is
    port (
        data  :in  std_logic; -- Data input
        clk   :in  std_logic; -- Clock input
        reset :in  std_logic; -- Reset input
        q     :out std_logic  -- Q output

    );  
end component;

    signal tb_clk     : std_logic := '0';
    signal tb_reset   : std_logic := '0';
    signal tb_data    : std_logic := '0';
    signal tb_q       : std_logic;

--ARCHITECTURE
begin

    -- Instantiate the dff_sync_reset component
    uut: dff_sync_reset
        port map (
            data  => tb_data, --current to external (signal mapping)
            clk   => tb_clk,
            reset => tb_reset,
            q     => tb_q
        );
    --Clock Process
    

    tb_clk <= not tb_clk after 10ns; -- for 100MHz clock signal 
 
    --Stimulus Process
    
    process 
    begin 
        wait for 10 ns;  -- Initial wait
        tb_reset <= '1'; -- Deassert reset
        wait for 20 ns;  -- Wait for some time
        tb_reset <= '0';
        
        -- Test 1: D = '1'
        tb_data <= '1';
        wait for 40 ns;
        assert(tb_q = '1') report "Test 1 failed" severity error;

        -- Test 2: D = '0'
        tb_data <= '0';
        wait for 20 ns;
        assert(tb_q = '0') report "Test 2 failed" severity error;

        --add more test cases if needed
        
        wait;
    end process; 
    
    
end architecture_dff_sync_reset_tb;
