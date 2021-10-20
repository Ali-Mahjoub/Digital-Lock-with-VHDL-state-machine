--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:26:26 12/13/2020
-- Design Name:   
-- Module Name:   C:/Users/USER/Desktop/IIA4/Semestre1/VLSI/Nouveau dossier/Code-lock/finaltest.vhd
-- Project Name:  Code-lock
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: final
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY finaltest IS
END finaltest;
 
ARCHITECTURE behavior OF finaltest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT final
    PORT(
         clk : IN  std_logic;
         clear : IN  std_logic;
         m : IN  string(1 downto 1);
         b : in  string(4 downto 1);
         ncode : IN  string(4 downto 1);
         sortie : IN  std_logic;
         validation : IN  std_logic;
         vncode : IN  std_logic;
         conf : IN  std_logic;
         code : INOUT  std_logic_vector(31 downto 0);
         btn : INOUT  std_logic_vector(7 downto 0);
         q : OUT  std_logic_vector(3 downto 0);
         alarm : OUT  std_logic;
         right : OUT  std_logic;
         wrong : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal clear : std_logic := '0';
   signal m : string(1 downto 1) := (others => '0');
   signal ncode : string(4 downto 1) := (others => '0');
   signal sortie : std_logic := '0';
   signal validation : std_logic := '0';
   signal vncode : std_logic := '0';
   signal conf : std_logic := '0';
   signal b : string(4 downto 1):= (others => '0');
	--BiDirs
   
   signal code : std_logic_vector(31 downto 0);
   signal btn : std_logic_vector(7 downto 0);
   

 	--Outputs
   signal q : std_logic_vector(3 downto 0);
   signal alarm : std_logic;
   signal right : std_logic;
   signal wrong : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: final PORT MAP (
          clk => clk,
          clear => clear,
          m => m,
          b => b,
          ncode => ncode,
          sortie => sortie,
          validation => validation,
          vncode => vncode,
          conf => conf,
          code => code,
          btn => btn,
          
          q => q,
          alarm => alarm,
          right => right,
          wrong => wrong
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
   begin		
      -- hold reset state for 100 ns.
     
      b <= "azer";--code de la serrure
	  m <="a";--1er chiffre entré  
	  wait for 30 ns;
	  m <="z";--2éme chiffre entré 
	  wait for 10 ns;
	  m <="e";--3éme chiffre entré 
	  wait for 10 ns;
	  m <="r";--4éme chiffre entré 
	  wait for 10 ns;
     validation <='1';
	   wait for 20 ns;
		validation <='0';
	   wait for 10 ns;
     conf<='1';
	  ncode <="azeh";	
   wait for 10 ns;
     
	  conf<='0';
     vncode<='1';
	  wait for 10 ns;
	 
	  
	  m <="a";--1er chiffre entré  
	  wait for 10 ns;
	  m <="z";--2éme chiffre entré 
	  wait for 10 ns;
	  m <="e";--3éme chiffre entré 
	  wait for 10 ns;
	  m <="h";--4éme chiffre entré 
	  wait for 10 ns;
     validation <='1';
	   wait for 10 ns;
		validation <='0';
     sortie<='1';
   wait for 10 ns; 
     sortie<='0';
     m <="a";--1er chiffre entré  
	  wait for 10 ns;
	  m <="z";--2éme chiffre entré 
	  wait for 10 ns;
	  m <="e";--3éme chiffre entré 
	  wait for 10 ns;
	  m <="r";--4éme chiffre entré 
	  wait for 10 ns;
     validation <='1';
	   wait for 20 ns;
		validation <='0';
		 wait for 10 ns;
     sortie<='1';
   wait for 10 ns; 
     sortie<='0';
	  m <="a";--1er chiffre entré  
	  wait for 10 ns;
	  m <="z";--2éme chiffre entré 
	  wait for 10 ns;
	  m <="e";--3éme chiffre entré 
	  wait for 10 ns;
	  m <="r";--4éme chiffre entré 
	  wait for 10 ns;
     validation <='1';
	  wait for 20 ns;
	  validation <='0';
	  wait for 10 ns;
     sortie<='1';
   wait for 10 ns; 
     sortie<='0';
	  m <="a";--1er chiffre entré  
	  wait for 10 ns;
	  m <="z";--2éme chiffre entré 
	  wait for 10 ns;
	  m <="e";--3éme chiffre entré 
	  wait for 10 ns;
	  m <="r";--4éme chiffre entré 
	  wait for 10 ns;
     validation <='1';
	   wait for 20 ns;
		validation <='0';
		 wait for 10 ns;
     sortie<='1';
   wait for 10 ns; 
     sortie<='0';
      -- insert stimulus here 

      wait;
   end process;

END;
