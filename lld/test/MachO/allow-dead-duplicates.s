# REQUIRES: x86, llvm-64-bits

# RUN: rm -rf %t; split-file %s %t

# RUN: llvm-mc -filetype=obj -triple=x86_64-apple-macos \
# RUN:     %t/main.s -o %t/main.o
# RUN: llvm-mc -filetype=obj -triple=x86_64-apple-macos \
# RUN:     %t/duplicates.s -o %t/duplicates.o
# RUN: not %lld %t/main.o %t/duplicates.o -o %t/main 2>&1 | FileCheck %s

# CHECK:      duplicate symbol: _a
# CHECK-NEXT: >>> defined in {{.*}}/main.o
# CHECK-NEXT: >>> defined in {{.*}}/duplicates.o
# CHECK:      duplicate symbol: _b
# CHECK-NEXT: >>> defined in {{.*}}/main.o
# CHECK-NEXT: >>> defined in {{.*}}/duplicates.o

# RUN: %lld -dead_strip -allow_dead_duplicates \
# RUN:     %t/main.o %t/duplicates.o -o %t/main

#--- main.s
.globl _a
_a:
  retq

.globl _b
_b:
  retq

.globl _main
_main:
  callq	_c
  retq

.subsections_via_symbols
#--- duplicates.s
.globl _a
_a:
  retq

.globl _b
_b:
  retq

.globl _c
_c:
  retq

.subsections_via_symbols
