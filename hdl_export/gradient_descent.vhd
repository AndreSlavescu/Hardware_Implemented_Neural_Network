--------------------------------------------------------------------------------
-- Project : Hardware_Implemented_Neural_Network
-- File    :
-- Autor   :
-- Date    : 
--
--------------------------------------------------------------------------------
-- Description : 
-- This is a gradient descent algorithm implemented in VHDL.
-- The purpose of the algorithm is to find the weights that minimize the error between the predicted values and the actual values. 
-- The inputs to the entity are the data (x) and the actual values (y). The clock (clk) and reset (rst) signals are also inputs.
-- The output (done) is '1' when the predicted values match the actual values. 
-- The algorithm consists of four states. In state 0, the error is calculated for each bit of data.
-- In state 1, the delta is calculated. In state 2, the weights are updated. In state 3, the predicted values are updated.
--
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY gradient_descent IS
PORT(
    x : IN std_logic_vector(7 downto 0);
    y : IN std_logic_vector(7 downto 0);
    clk : IN std_logic;
    rst : IN std_logic;
    done : OUT std_logic
    );
END gradient_descent;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF gradient_descent IS

signal state : integer range 0 to 3 := 0;
signal count : integer range 0 to 7 := 0;
signal error : std_logic_vector(3 downto 0) := (others => '0');
signal y_hat : std_logic_vector(7 downto 0) := (others => '0');
signal delta : std_logic_vector(3 downto 0) := (others => '0');
signal weight : std_logic_vector(3 downto 0) := "0001";
constant learning_rate : real := 0.1;

BEGIN

process(clk, rst)
begin
    if(rst = '1') then
        state <= 0;
        count <= 0;
        error <= (others => '0');
        y_hat <= (others => '0');
    elsif(rising_edge(clk)) then
        case state is
            when 0 =>
                if(count < 8) then
                    error <= error + (x(count) xor y_hat(count));
                    count <= count + 1;
                else
                    count <= 0;
                    state <= 1;
                end if;
            when 1 =>
                delta <= error * weight;
                state <= 2;
            when 2 =>
                weight <= weight - (learning_rate * delta);
                state <= 3;
            when 3 =>
                state <= 0;
                y_hat <= y_hat + delta;
        end case;
    end if;
end process;

done <= '1' when y_hat = y else '0';

END Behavioral;
