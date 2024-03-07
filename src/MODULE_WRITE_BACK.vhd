library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library WORK;
use WORK.TOP_LEVEL_CONSTANTS.ALL;

entity MODULE_WRITE_BACK is

    generic (
        DATA_WIDTH_0  : natural := DATA_WIDTH
    );
  
    port (
        source_ex     : in  std_logic_vector((DATA_WIDTH_0 - 1) downto 0);
        source_memory : in  std_logic_vector((DATA_WIDTH_0 - 1) downto 0);
        selector      : in  std_logic;
        destination   : out std_logic_vector((DATA_WIDTH_0 - 1) downto 0)
    );

end entity;

architecture RTL of MODULE_WRITE_BACK is
        
begin
    MUX : entity WORK.GENERIC_MUX_2X1
        port map (
            source_1 => source_ex,
            source_2 => source_memory,
            selector => selector,
            destination => destination
        );
    

end architecture;