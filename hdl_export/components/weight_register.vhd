--------------------------------------------------------------------------------
-- Project :
Hardware_Implemented_Neural_Network
-- File    :
 
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
 
-- This is a weight register that takes in data and outputs it on the next clock cycle.
--
--------------------------------------------------------------------------------

-- The weight_register entity has a clock (clk), reset (rst), data, and queue port. 
-- When the reset port is high, the temp signal is set to all 0's. When the clock 
-- port is high (on the rising edge), the temp signal is set to the data. The queue 
-- port is always equal to the temp signal.

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity weight_register is
    generic (
        DATA_WIDTH : natural := 8
    );
    port(
        clk : IN std_logic;
        rst : IN std_logic;
        data : IN std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
        output : OUT std_logic_vector(DATA_WIDTH-1 DOWNTO 0)
    );
END weight_register;

ARCHITECTURE Behavioral OF weight_register IS

signal temp : std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
    
BEGIN

process(clk, rst)
BEGIN
   IF(rst='1') THEN
       temp <= (OTHERS => '0');
   ELSIF(rising_edge(clk)) THEN
       temp <= data;
   END IF;
END PROCESS;

output <= temp;
    
END Behavioral;
