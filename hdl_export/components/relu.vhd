--------------------------------------------------------------------------------
-- Project :
Hardware_Implemented_Neural_Network
-- File    :
 
-- Autor   :
-- Date    :
 
--
--------------------------------------------------------------------------------
-- Description : This is a ReLU function that takes an 8-bit input vector and 
--               outputs an 8-bit result vector.
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ReLU IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    x        : IN  std_logic_vector(7 DOWNTO 0); -- input vector
  ------------------------------------------------------------------------------
  --Insert output ports below
    y        : OUT std_logic_vector(7 DOWNTO 0)  -- output vector
    );
END ReLU;

--------------------------------------------------------------------------------
-- VHDL Description
--------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF ReLU IS
BEGIN
    PROCESS(x)
    BEGIN
        -- relu 
        IF x >= "00000000" THEN
            y <= x;
        ELSE
            y <= "00000000";
        END IF;
    END PROCESS;
END Behavioral;
