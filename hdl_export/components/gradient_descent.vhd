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
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;  -- Updated library for arithmetic operations

ENTITY gradient_descent IS
    GENERIC (
        DATA_WIDTH : natural := 32
    );
    PORT (
        x : IN std_logic_vector(DATA_WIDTH-1 downto 0);
        y : IN std_logic_vector(DATA_WIDTH-1 downto 0);
        clk : IN std_logic;
        rst : IN std_logic;
        done : OUT std_logic;
        weight_out : OUT std_logic_vector(DATA_WIDTH-1 DOWNTO 0) -- Output the updated weight
    );
END gradient_descent;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF gradient_descent IS

signal weight : std_logic_vector(DATA_WIDTH-1 DOWNTO 0) := (others => '0'); -- Initialize weight
signal error : std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
signal gradient : std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
constant learning_rate : std_logic_vector(DATA_WIDTH-1 DOWNTO 0) := x"0000000A"; -- Learning rate as a fixed-point value

BEGIN

process(clk, rst)
begin
    if(rst = '1') then
        weight <= (others => '0'); -- Reset weight
    elsif(rising_edge(clk)) then
        error <= std_logic_vector(signed(x) - signed(y)); -- Compute error
        gradient <= std_logic_vector(signed(error) * signed(x)); -- Compute gradient descent
        weight <= std_logic_vector(signed(weight) - (resize(signed(learning_rate), DATA_WIDTH) * signed(gradient))); -- Update weight
    end if;
end process;

done <= '1' when error = std_logic_vector(to_signed(0, DATA_WIDTH)) else '0'; -- Complete when error is reaches 0
weight_out <= weight; 

END Behavioral;
