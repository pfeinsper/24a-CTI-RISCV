library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library WORK;
use WORK.TOP_LEVEL_CONSTANTS.ALL;

entity STAGE_MEM is
  
    port (
        clock             : in  std_logic;
        enable            : in  std_logic;
        enable_read       : in  std_logic;
        enable_write      : in  std_logic;
        source_ex         : in  std_logic_vector((ADDRESS_WIDTH - 1) downto 0);
        register_source_2 : in  std_logic_vector((DATA_WIDTH_0 - 1) downto 0);
        destination       : out std_logic_vector((DATA_WIDTH_0 - 1) downto 0)
    );

end entity;

architecture RTL of STAGE_MEM is
        
begin
    MODULE_MEMORY : entity WORK.MODULE_MEMORY
        port map (
            clock             => clock,
            enable            => enable,      
            enable_read       => enable_read,
            enable_write      => enable_write,
            source_ex         => source_ex,    
            register_source_2 => register_source_2,      
            destination       => destination 
        );
    

end architecture;