LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY tb_MLP IS
END tb_MLP;

ARCHITECTURE behavior OF tb_MLP IS 

    -- Component Declaration for the test
    COMPONENT MLP
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         data_in : IN  std_logic_vector(31 downto 0);
         data_out : OUT std_logic
        );
    END COMPONENT;

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal data_in : std_logic_vector(31 downto 0) := (others => '0');

    --Outputs
   signal data_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate test
   uut: MLP PORT MAP (
          clk => clk,
          rst => rst,
          data_in => data_in,
          data_out => data_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
      FILE data_file : text;
      variable data_line : line;
      variable value : std_logic_vector(31 downto 0);
   begin
        -- reset
        rst <= '1';
        wait for clk_period;
        rst <= '0';

        -- open the data file
        FILE_OPEN(data_file, "data.csv", READ_MODE);

        while not ENDFILE(data_file) loop
            -- read a line from the data file
            readline(data_file, data_line);
            -- convert the line to a std_logic_vector
            read(data_line, value);
            -- pass data to MLP input
            data_in <= value;
            -- wait length of clk cycle
            wait for clk_period;
        end loop;

        -- close the data file
        FILE_CLOSE(data_file);

        -- indicate done
        assert false report "Simulation complete" severity note;
        wait;
   end process;

END;

