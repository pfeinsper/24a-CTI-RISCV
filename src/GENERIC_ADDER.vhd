library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library WORK;
use WORK.TOP_LEVEL_CONSTANTS.ALL;

entity GENERIC_ADDER is

    generic (
        DATA_WIDTH       : natural := XLEN;
        DEFAULT_SOURCE_2 : integer := 1
    );

    port (
        source_1    : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
        source_2    : in  std_logic_vector((DATA_WIDTH - 1) downto 0) := std_logic_vector(to_signed(DEFAULT_SOURCE_2, DATA_WIDTH));
        destination : out std_logic_vector((DATA_WIDTH - 1) downto 0)
    );

end entity;

architecture RTL of GENERIC_ADDER is

    -- No signals

begin

    destination <= std_logic_vector(unsigned(source_1) + unsigned(source_2));

end architecture;
