--------------------------------------------------------------------------------
-- Project :
Hardware_Implemented_Neural_Network
-- File    :
 
-- Autor   :
-- Date    :
 
--
--------------------------------------------------------------------------------
-- Description : This is a simplified sigmoid function that takes an 8-bit 
--               input vector and outputs an 8-bit result vector using a 
--               Taylor Series approximation.
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY Sigmoid IS
    GENERIC (
        DATA_WIDTH : natural := 32
    );
    PORT (
      ------------------------------------------------------------------------------
      --Insert input ports below
        x : IN  std_logic_vector(DATA_WIDTH-1 DOWNTO 0); -- input vector
      ------------------------------------------------------------------------------
      --Insert output ports below
        y : OUT std_logic_vector(DATA_WIDTH-1 DOWNTO 0)  -- output vector
    );
END Sigmoid;

--------------------------------------------------------------------------------
-- VHDL Description
--------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF Sigmoid IS
BEGIN
    PROCESS(x)
        VARIABLE x_float : REAL;         -- Variable to hold the real value of x
        VARIABLE exp_neg_x : REAL;       -- Variable to hold the value of exp(-x)
        VARIABLE sigmoid : REAL;         -- Variable to hold the sigmoid value
        VARIABLE y_int : INTEGER;        -- Variable to hold the integer value of sigmoid
    BEGIN
        -- Convert x to an integer
        x_float := TO_INTEGER(unsigned(x));

        -- Compute exp(-x) using a Taylor series approximation (4 term approximation)
        exp_neg_x := 1.0 + (-x_float) + ((-x_float)**2) / 2.0 + ((-x_float)**3) / 6.0 + ((-x_float)**4) / 24.0;

        -- standard sigmoid function
        sigmoid := 1.0 / (1.0 + exp_neg_x);

        -- Convert the result back to an 8-bit unsigned integer
        y_int := INTEGER(sigmoid * 255.0);  -- Scale to 8 bits
        y <= std_logic_vector(TO_UNSIGNED(y_int, 8));
    END PROCESS;
END Behavioral;
