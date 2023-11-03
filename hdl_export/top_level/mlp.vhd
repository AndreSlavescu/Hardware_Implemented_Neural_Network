LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MLP IS
  PORT (
    clk       : IN  std_logic;
    rst       : IN  std_logic;
    data_in   : IN  std_logic_vector(7 DOWNTO 0);
    data_out  : OUT std_logic_vector(7 DOWNTO 0)
    );
END MLP;

ARCHITECTURE Behavioral OF MLP IS
    COMPONENT weight_register
        PORT(
            clk : IN std_logic;
            rst : IN std_logic;
            data : IN std_logic_vector(7 DOWNTO 0);
            queue : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT neuron
        GENERIC (
            DATA_WIDTH : natural := 8;
            WEIGHT_WIDTH : natural := 8
        );
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            inputs : IN std_logic_vector(7 DOWNTO 0);
            weights : IN std_logic_vector(7 DOWNTO 0);
            output : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT layer
        GENERIC (
            DATA_WIDTH : natural := 8;
            WEIGHT_WIDTH : natural := 8;
            NUM_NEURONS : natural := 8
        );
        PORT (
            clk : IN std_logic;
            rst : IN std_logic;
            inputs : IN std_logic_vector(63 DOWNTO 0); 
            weights : IN std_logic_vector(63 DOWNTO 0); 
            outputs : OUT std_logic_vector(63 DOWNTO 0) 
        );
    END COMPONENT;
    
    COMPONENT gradient_descent
        PORT(
            x : IN std_logic_vector(7 DOWNTO 0);
            y : IN std_logic_vector(7 DOWNTO 0);
            clk : IN std_logic;
            rst : IN std_logic;
            done : OUT std_logic;
            weight_out : OUT std_logic_vector(7 DOWNTO 0) -- Updated weight output
        );
    END COMPONENT;
    
    SIGNAL wr_queue, layer_inputs, layer_outputs, neuron_output, gd_x, gd_y : std_logic_vector(7 DOWNTO 0);
    SIGNAL weights : std_logic_vector(63 DOWNTO 0);
    SIGNAL updated_weight : std_logic_vector(7 DOWNTO 0); -- New signal for updated weight
    
BEGIN
    wr: weight_register PORT MAP(
        clk => clk,
        rst => rst,
        data => data_in,
        queue => wr_queue
    );
    
    n: neuron PORT MAP(
        clk => clk,
        rst => rst,
        inputs => wr_queue,
        weights => weights(7 DOWNTO 0),
        output => neuron_output
    );
    
    l: layer PORT MAP(
        clk => clk,
        rst => rst,
        inputs => layer_inputs,
        weights => weights,
        outputs => layer_outputs
    );
    
    gd: gradient_descent PORT MAP(
        x => neuron_output,
        y => data_in,
        clk => clk,
        rst => rst,
        done => OPEN,
        weight_out => updated_weight -- Updated weight
    );
    
    data_out <= gd_y; 
    
END Behavioral;
