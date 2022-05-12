--------------------------------------------------------------------------------
-- Project : FPGA-NN
-- File    : 
-- Autor   :
-- Date    : 
--
--------------------------------------------------------------------------------
-- Description : This is a sigmoid function that takes an 8-bit input vector and outputs an 8-bit result vector.
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Sigmoid_Activation_Function IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    clock      : IN  std_logic;                    -- input bit example
    x        	: IN  std_logic_vector(7 DOWNTO 0); -- input vector example
  ------------------------------------------------------------------------------
  --Insert output ports below
    max        : OUT std_logic;                    -- output bit example
    y        	: OUT std_logic_vector(7 DOWNTO 0)  -- output vector example
    );
END Sigmoid_Activation_Function;

--------------------------------------------------------------------------------
-- VHDL Description
--------------------------------------------------------------------------------

ARCHITECTURE Behavioural OF Sigmoid_Activation_Function IS

-- creates a 16-bit wide intermediate signal to aid calculatons
signal temp : std_logic_vector(15 downto 0);

BEGIN

-- takes the negation of our input, and pads it with zeroes to make it 16 bits wide to be saved to the intermediate signal "temp"
temp <= NOT x + "0000000000000001";

-- takes the square negation of our input to save to output "y".
y <= std_logic_vector(unsigned(temp)*unsigned(temp));

END Behavioral;
