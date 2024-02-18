from decimal import Decimal

import pytest
import cocotb
from cocotb.binary import BinaryValue
from cocotb.triggers import Timer

import utils


class RV32I_ALU(utils.DUT):
    pass


@cocotb.test()
async def tb_RV32I_ALU(dut: RV32I_ALU):
    pass


@pytest.fixture(scope="module", autouse=True)
def build_RV32I_ALU():
    utils.runner.build(
        vhdl_sources=["src/RV32I_ALU.vhd"],
        hdl_toplevel="rv32i_alu",
        always=True,
    )

def test_RV32I_ALU():
    utils.runner.test(
        hdl_toplevel="rv32i_alu",
        test_module="test_RV32I_ALU",
        testcase="tb_RV32I_ALU",
        hdl_toplevel_lang="vhdl",
    )


if __name__ == "__main__":
    test_RV32I_ALU()
