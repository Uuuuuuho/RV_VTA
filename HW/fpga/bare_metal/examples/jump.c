// See LICENSE for license details.

// just jump from BRAM to DDR
#include <stdint.h>
#include "encoding.h"
#include "bits.h"
#include "memory.h"

void external_interrupt(){}

int main (void)
{
  uint32_t *memory_base = (uint8_t *)(get_ddr_base());
  // uint8_t *memory_base = (uint8_t *)(get_ddr_base());
  uintptr_t mstatus = read_csr(mstatus);
  mstatus = INSERT_FIELD(mstatus, MSTATUS_MPP, PRV_M);
  mstatus = INSERT_FIELD(mstatus, MSTATUS_MPIE, 1);
  write_csr(mstatus, mstatus);
  write_csr(mepc, memory_base);
  asm volatile ("mret");
}
