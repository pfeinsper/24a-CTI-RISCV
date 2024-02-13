import cocotb
from cocotb.binary import BinaryRepresentation, BinaryValue
from cocotb.triggers import Timer
from cocotb_test.simulator import run
from utils import source


@cocotb.test()
async def tb_nor(dut):
    inA = [
        BinaryValue('0', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('0', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('1', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('1', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT)
    ]
    inB = [
        BinaryValue('0', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('1', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('0', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('1', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT)
    ]
    out = [
        BinaryValue('1', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('0', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('0', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT),
        BinaryValue('0', binaryRepresentation=BinaryRepresentation.TWOS_COMPLEMENT)
    ]

    for i, (ia, ib, o) in enumerate(zip(inA, inB, out)):
        dut.a.value = ia
        dut.b.value = ib

        await Timer(1, units='ns')

        condition = (dut.q.value.binstr == o.binstr)

        if not condition:
            dut._log.error(
                f"Expected value: {o.binstr} Obtained value: {dut.q.value.binstr}")

        assert condition, f"Error in test {i}: inA={ia.binstr} inB={ib.binstr} inS={iS.binstr}"
        await Timer(1, units='ns')


def test_nor():
    run(vhdl_sources=[source("GENERIC_NOR.vhd")],
        toplevel="generic_nor",
        module="test_nor",
        testcase='tb_nor',
        toplevel_lang="vhdl")


if __name__ == "__main__":
    test_nor()