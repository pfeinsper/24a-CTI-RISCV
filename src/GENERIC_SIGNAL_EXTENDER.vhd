library ieee;
use ieee.std_logic_1164.all;

library WORK;
use WORK.TOP_LEVEL_CONSTANTS.ALL;

entity GENERIC_SIGNAL_EXTENDER is

    generic (
        SOURCE_WIDTH      : DATA_WIDTH;
        DESTINATION_WIDTH : DATA_WIDTH
    );

    port (
        source          : in  std_logic_vector((SOURCE_WIDTH - 1) downto 0);
        enable_unsigned : in  std_logic := '0';
        destination     : out std_logic_vector((DESTINATION_WIDTH - 1) downto 0)
    );

end entity;

architecture LOWER_EXTEND of GENERIC_SIGNAL_EXTENDER is

    signal upper : std_logic_vector((DESTINATION_WIDTH - 1) downto SOURCE_WIDTH);

begin

    upper <= (others => '0') when (enable_unsigned = '1') else
             (others => source(SOURCE_WIDTH - 1));

    destination((DESTINATION_WIDTH - 1) downto SOURCE_WIDTH) <= upper;
    destination((SOURCE_WIDTH - 1) downto 0) <= source;

end architecture;

architecture LOGICAL_UPPER of GENERIC_SIGNAL_EXTENDER is

    -- No signals

begin

    destination((DESTINATION_WIDTH - 1) downto (DESTINATION_WIDTH - SOURCE_WIDTH)) <= source;
    destination((DESTINATION_WIDTH - SOURCE_WIDTH - 1) downto 0) <= (others => '0');

end architecture;
