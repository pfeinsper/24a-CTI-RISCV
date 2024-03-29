library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library WORK;
use WORK.TOP_LEVEL_CONSTANTS.ALL;

entity STAGE_MEM is

    generic (
        GENERATE_REGISTERS : boolean := TRUE
    );
  
    port (
        clock          : in  std_logic;
        clear          : in  std_logic;
        enable         : in  std_logic;
        source         : in  t_SIGNALS_EX_MEM;
        control_memory : out t_CONTROL_MEM;
        address_memory : out t_DATA;
        data_memory    : out t_DATA;
        destination    : out t_SIGNALS_MEM_WB
    );

end entity;

architecture RTL of STAGE_MEM is

    signal source_0 : t_SIGNALS_EX_MEM := NULL_SIGNALS_EX_MEM;

begin

    PIPELINE : if (GENERATE_REGISTERS = TRUE) generate
        UPDATE : process(source, clear, clock, enable)
        begin
            if (rising_edge(clock)) then
                SET_RESET : if (enable = '1') then
                    source_0 <= source;
                elsif (clear = '1') then
                    source_0 <= NULL_SIGNALS_EX_MEM;
                end if;
            end if;
        end process;
    else generate
        source_0 <= source;
    end generate;

    destination.control_wb         <= source_0.control_wb;

    control_memory.enable_read     <= source_0.control_mem.enable_read;
    control_memory.enable_write    <= source_0.control_mem.enable_write;

    address_memory                 <= source_0.address_pointer;
    data_memory                    <= source_0.data_source_2;

    destination.data_memory        <= (others => '-');
    destination.data_destination   <= source_0.address_pointer;
    destination.select_destination <= source_0.select_destination;

end architecture;
