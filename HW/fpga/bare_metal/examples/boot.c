// See LICENSE for license details.

//#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#include <memory.h>
#include "encoding.h"
#include "mini-printf.h"
#include "diskio.h"
#include "ff.h"
#include "bits.h"
#include "hid.h"
#include "elfriscv.h"
#include "lowrisc_memory_map.h"

//on purpose for pause
#include <stdio.h>
#include <unistd.h>

const struct { char scan,lwr,upr; } scancode[] = {
#include "scancode.h"
  };



FATFS FatFs;   // Work area (file system object) for logical drive

// max size of file image is 16M
#define MAX_FILE_SIZE 0x1000000

// max size of file image is from 16M to 128M
//#define MAX_FILE_SIZE 0x10000000

// 4K size read burst
#define SD_READ_SIZE 4096

char md5buf[SD_READ_SIZE];

int main (void)
{
//=======================  
//on purpose to pause
//=======================

//#define DELAY_ARRAY 10000
//  uint64_t cnt=1;
//  
//  int i = 0;
//  for(i=0;i<DELAY_ARRAY;i++){
//   while(cnt++ != 0);
//	cnt = 1;
//	printf("current index : %d done\n", i);
//  }
  
  
  
  FIL fil;                // File object
  FRESULT fr;             // FatFs return code
  uint8_t *boot_file_buf = (uint8_t *)(get_ddr_base()) + ((uint64_t)get_ddr_size()) - MAX_FILE_SIZE; // at the end of DDR space
  uint8_t *memory_base = (uint8_t *)(get_ddr_base());
  int sw;
  

  printf("lowRISC copy program\n=====================================\n");

  // Register work area to the default drive
  if(f_mount(&FatFs, "", 1)) {
    printf("Fail to mount SD driver!\n");
    return 1;
  }

  // Open a file
  printf("\nopending a file\n");
  fr = f_open(&fil, "hello.bin", FA_READ);
  if (fr) {
    printf("Failed to open hello.bin!\n");
    return (int)fr;
  }

  printf("\nLoad hello.bin into memory\n");
  // Read file into memory
  uint8_t *hashbuf;
  uint32_t fsize = 0;           // file size count
  uint32_t br;                  // Read count
  do {
     char *sum;
     fr = f_read(&fil, boot_file_buf+fsize, SD_READ_SIZE, &br);  // Read a chunk of source file
     if (!fr){
 	      hid_send('\b');
 	      hid_send("|/-\\"[(fsize/SD_READ_SIZE)&3]);
 	      fsize += br;
      }
   } while(!(fr || br == 0));
   fsize = fil.fsize;

  printf("Loaded %d bytes to memory address %x from hello.bin of %d bytes.\n\n", fsize, boot_file_buf, fsize);
       
  // Close the file
  if(f_close(&fil)) {
    printf("fail to close file!");
    return 1;
  }

  if(f_mount(NULL, "", 1)) {         // unmount it
    printf("fail to umount disk!");
    return 1;
  }

  printf("boot_file_buf_addr: %x\n", &boot_file_buf);
  printf("br: %x\n", br);

#if 0 
  hashbuf = hash_buf(boot_file_buf, fsize);
  printf("hash = %s\n", hashbuf);
#endif 

  // read elf
  printf("load elf to DDR memory\n\n");
  if(br = load_elf(boot_file_buf, fsize)){
  // if(br = load_elf(&boot_file_buf-fsize, fsize)){
    printf("elf read failed with code %d\n", br);
    return 0;
  }
  printf("Run the loaded program...\n\n");
  

  uintptr_t mstatus = read_csr(mstatus);
  mstatus = INSERT_FIELD(mstatus, MSTATUS_MPP, PRV_M);
  mstatus = INSERT_FIELD(mstatus, MSTATUS_MPIE, 1);
  write_csr(mstatus, mstatus);
  write_csr(mepc, memory_base);
  asm volatile ("mret");
}

void external_interrupt(void)
{
  int i, claim, handled = 0;
#ifdef VERBOSE
  printf("Hello external interrupt! "__TIMESTAMP__"\n");
#endif  
}

int lowrisc_init(unsigned long addr, int ch, unsigned long quirks);
void tohost_exit(long code);

unsigned long get_tbclk (void)
{
	unsigned long long tmp = 1000000;
	return tmp;
}

char *env_get(const char *name)
{
  return (char *)0;
}

void *malloc(size_t len)
{
  static unsigned long rused = 0;
  char *rd = rused + (char *)(ddr_base_addr+0x6800000);
  rused += ((len-1)|7)+1;
  return rd;
}

void *calloc(size_t nmemb, size_t size)
{
  size_t siz = nmemb*size;
  char *ptr = malloc(siz);
  if (ptr)
    {
      memset(ptr, 0, siz);
      return ptr;
    }
  else
    return (void*)0;
}

void free(void *ptr)
{

}

int init_mmc_standalone(int sd_base_addr){};

DSTATUS isk_initialize (uint8_t pdrv)
{
  printf("\nu-boot based first stage boot loader\n");
  init_mmc_standalone(sd_base_addr);
  return 0;
}

int ctrlc(void)
{
	return 0;
}

void *find_cmd_tbl(const char *cmd, void *table, int table_len)
{
  return (void *)0;
}

unsigned long timer_read_counter(void)
{
  return read_csr(0xb00) / 10;
}

void __assert_fail (const char *__assertion, const char *__file,
                           unsigned int __line, const char *__function)
{
  printf("assertion %s failed, file %s, line %d, function %s\n", __assertion, __file,  __line, __function);
  tohost_exit(1);
}

void *memalign(size_t alignment, size_t size)
{
  char *ptr = malloc(size+alignment);
  return (void*)((-alignment) & (size_t)(ptr+alignment));
}

int do_load(void *cmdtp, int flag, int argc, char * const argv[], int fstype)
{
  return 1;
}

int do_ls(void *cmdtp, int flag, int argc, char * const argv[], int fstype)
{
  return 1;
}

int do_size(void *cmdtp, int flag, int argc, char * const argv[], int fstype)
{
                return 1;
}

DRESULT isk_read (uint8_t pdrv, uint8_t *buff, uint32_t sector, uint32_t count)
{
  while (count--)
    {
//      read_block(buff, sector++);
      buff += 512;
    }
  return FR_OK;
}

DRESULT isk_write (uint8_t pdrv, const uint8_t *buff, uint32_t sector, uint32_t count)
{
  return FR_INT_ERR;
}

DRESULT isk_ioctl (uint8_t pdrv, uint8_t cmd, void *buff)
{
  return FR_INT_ERR;
}

DSTATUS isk_status (uint8_t pdrv)
{
  return FR_INT_ERR;
}

void part_init(void *bdesc)
{

}

void part_print(void *desc)
{

}

void dev_print(void *bdesc)
{

}

unsigned long mmc_berase(void *dev, int start, int blkcnt)
{
        return 0;
}

unsigned long mmc_bwrite(void *dev, int start, int blkcnt, const void *src)
{
        return 0;
}

const char version_string[] = "LowRISC minimised u-boot for SD-Card";
