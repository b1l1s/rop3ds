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
	rop_file_read(THIS, THIS+0x20, 0x100000, SPIDER_ARM_CODE_SIZE)
	rop_sleep(1000000000)
	.word 0x100000
FileName:
	.string16 "dmc:/arm11.bin"
