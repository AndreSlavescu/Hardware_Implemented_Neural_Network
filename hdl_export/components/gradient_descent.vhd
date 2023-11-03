--------------------------------------------------------------------------------
-- Project :
Hardware_Implemented_Neural_Network
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
-- This is a gradient descent algorithm.
-- The purpose of the algorithm is to find the weights that minimize the error 
-- between the predicted values and the actual values. 
--
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY gradient_descent IS
PORT(
    x : IN std_logic_vector(7 downto 0);
    y : IN std_logic_vector(7 downto 0);
    clk : IN std_logic;
    rst : IN std_logic;
    done : OUT std_logic;
    weight_out : OUT std_logic_vector(7 DOWNTO 0) -- Output the updated weight
    );
END gradient_descent;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF gradient_descent IS

signal weight : std_logic_vector(7 DOWNTO 0) := (others => '0'); -- Initialize weight
signal error : std_logic_vector(7 DOWNTO 0);
signal gradient : std_logic_vector(7 DOWNTO 0);
constant learning_rate : std_logic_vector(7 DOWNTO 0) := "00001010"; -- Learning rate as a fixed-point value

BEGIN

process(clk, rst)
begin
    if(rst = '1') then
        weight <= (others => '0'); -- Reset weight
    elsif(rising_edge(clk)) then
        error <= x - y; -- Compute error
        gradient <= error * x; -- Compute gradient descent
        weight <= weight - (learning_rate * gradient); -- Update weight
    end if;
end process;

done <= '1' when error = "00000000" else '0'; -- Complete when error is reaches 0
weight_out <= weight; 

END Behavioral;
