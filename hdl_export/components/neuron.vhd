--------------------------------------------------------------------------------
-- Project :
Hardware_Implemented_Neural_Network
-- File    :
 
-- Autor   :
-- Date    :
 
--
--------------------------------------------------------------------------------
-- Description :
 
-- This is a neuron entity that computes the weighted sum of its inputs and applies the ReLU activation function.
--
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY neuron IS
    GENERIC (
        DATA_WIDTH : natural := 32;
        WEIGHT_WIDTH : natural := 32
    );
    PORT (
        clk : IN std_logic;
        rst : IN std_logic;
        inputs : IN std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
        weights : IN std_logic_vector(WEIGHT_WIDTH-1 DOWNTO 0);
        output : OUT std_logic_vector(DATA_WIDTH-1 DOWNTO 0)
    );
END neuron;

ARCHITECTURE Behavioral OF neuron IS
    COMPONENT ReLU
        PORT (
            x : IN std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
            y : OUT std_logic_vector(DATA_WIDTH-1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL weighted_sum : std_logic_vector(DATA_WIDTH-1 DOWNTO 0);

BEGIN

    PROCESS(clk, rst)
    BEGIN
        IF(rst='1') THEN
            weighted_sum <= (OTHERS => '0');
        ELSIF (rising_edge(clk)) THEN
            weighted_sum <= inputs * weights;
        END IF;
    END PROCESS;

    relu_inst : ReLU
        PORT MAP (
            x => weighted_sum,
            y => output
        );

END Behavioral;
