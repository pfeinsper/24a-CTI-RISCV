library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library WORK;
use WORK.TOP_LEVEL_CONSTANTS.ALL;

entity STAGE_WB is

    generic (
        GENERATE_REGISTERS : boolean := TRUE
    );
  
    port (
        clock              : in  std_logic;
        clear              : in  std_logic;
        enable             : in  std_logic;
        source             : in  t_SIGNALS_MEM_WB;
        enable_destination : out std_logic;
        select_destination : out t_REGISTER;
        destination        : out t_DATA
    );

end entity;

architecture RTL of STAGE_WB is

    signal source_0 : t_SIGNALS_MEM_WB := NULL_SIGNALS_MEM_WB;

begin

    PIPELINE : if (GENERATE_REGISTERS = TRUE) generate
        UPDATE : process(source, clear, clock, enable)
        begin
            if (rising_edge(clock)) then
                SET_RESET : if (enable = '1') then
                    source_0 <= source;
                elsif (clear = '1') then
                    source_0 <= NULL_SIGNALS_MEM_WB;
                end if;
            end if;
        end process;
    else generate
        source_0 <= source;
    end generate;

    MODULE_WRITE_BACK : entity WORK.MODULE_WRITE_BACK
        port map (
            source_memory => source_0.data_memory,
            source_ex     => source_0.data_destination,
            selector      => source_0.control_wb.select_destination,
            destination   => destination
        );

    select_destination <= source_0.select_destination;
    enable_destination <= source_0.control_wb.enable_destination;

end architecture;
