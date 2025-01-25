#!/bin/bash
set -xue

QEMU=qemu-system-riscv32

# clang 경로와 컴파일 옵션
CC=clang  # Ubuntu 등 환경에 따라 경로 조정: CC=clang
CFLAGS="          \
 -std=c11         \
 -O2  -g3         \
 -Wall -Wextra    \
 --target=riscv32 \
 -ffreestanding -nostdlib \
"

# 커널 빌드
$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    kernel.c common.c

$QEMU               \
 -machine virt      \
 -bios default      \
 -nographic         \
 -serial mon:stdio  \
 --no-reboot        \
 -kernel kernel.elf
