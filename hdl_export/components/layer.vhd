--------------------------------------------------------------------------------
-- Project :
Hardware_Implemented_Neural_Network
-- File    :
 
-- Autor   :
-- Date    :
 
--
--------------------------------------------------------------------------------
-- Description :
 
-- This is a layer entity that consists of multiple neurons.
--
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY layer IS
    GENERIC (
        DATA_WIDTH : natural := 8;
        WEIGHT_WIDTH : natural := 8;
        NUM_NEURONS : natural := 8
    );
    PORT (
        clk : IN std_logic;
        rst : IN std_logic;
        inputs : IN std_logic_vector((DATA_WIDTH * NUM_NEURONS)-1 DOWNTO 0);
        weights : IN std_logic_vector((WEIGHT_WIDTH * NUM_NEURONS)-1 DOWNTO 0);
        outputs : OUT std_logic_vector((DATA_WIDTH * NUM_NEURONS)-1 DOWNTO 0)
    );
END layer;

ARCHITECTURE Behavioral OF layer IS
    COMPONENT neuron
        GENERIC (
            DATA_WIDTH : natural;
            WEIGHT_WIDTH : natural
        );
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            inputs : IN std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
            weights : IN std_logic_vector(WEIGHT_WIDTH-1 DOWNTO 0);
            output : OUT std_logic_vector(DATA_WIDTH-1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL neuron_outputs : std_logic_vector((DATA_WIDTH * NUM_NEURONS)-1 DOWNTO 0);

BEGIN

    GEN_NEURONS : FOR i IN 0 TO NUM_NEURONS-1 GENERATE
        neuron_inst : neuron
            GENERIC MAP (
                DATA_WIDTH => DATA_WIDTH,
                WEIGHT_WIDTH => WEIGHT_WIDTH
            )
            PORT MAP (
                clk => clk,
                rst => rst,
                inputs => inputs((i * DATA_WIDTH) + DATA_WIDTH - 1 DOWNTO i * DATA_WIDTH),
                weights => weights((i * WEIGHT_WIDTH) + WEIGHT_WIDTH - 1 DOWNTO i * WEIGHT_WIDTH),
                output => neuron_outputs((i * DATA_WIDTH) + DATA_WIDTH - 1 DOWNTO i * DATA_WIDTH)
            );
    END GENERATE GEN_NEURONS;

    PROCESS(clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            outputs <= neuron_outputs;
        END IF;
    END PROCESS;

END Behavioral;
