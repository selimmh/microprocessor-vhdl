--
-- USV | 3112A | 25.05.2020
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
USE ieee.numeric_std.ALL;
 
ENTITY ACC IS
END ACC;
 
ARCHITECTURE behavior OF ACC IS 
 
 
    COMPONENT ControlUnit
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         S_IN : IN  std_logic_vector(15 downto 0);
         S_WR : OUT  std_logic;
         S_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal S_IN : std_logic_vector(15 downto 0) := (others => '0');

 
   signal S_WR : std_logic;
   signal S_OUT : std_logic_vector(15 downto 0);

   
   constant clk_period : time := 100 ns;
 
BEGIN
 
	
   uut: ControlUnit PORT MAP (
          clk => clk,
          reset => reset,
          S_IN => S_IN,
          S_WR => S_WR,
          S_OUT => S_OUT
        );

   
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   
   stim_proc: process
   begin
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		wait for clk_period;
		S_IN <= std_logic_vector(to_unsigned(5, 16));
		wait for clk_period*4;
		S_IN <= std_logic_vector(to_unsigned(13, 16));
		wait for clk_period;
		wait for 100000ns;
   end process;

END;
