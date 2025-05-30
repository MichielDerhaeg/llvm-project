// RUN: %clangxx_asan -O0 -mllvm -asan-instrument-dynamic-allocas %s -o %t
// RUN: not %run %t 2>&1 | FileCheck %s
//
// XFAIL: msvc

#include "defines.h"
#include <assert.h>
#include <stdint.h>

ATTRIBUTE_NOINLINE void foo(int index, int len) {
  volatile char str[len] ATTRIBUTE_ALIGNED(128);
  assert(!(reinterpret_cast<uintptr_t>(str) & 127L));
  str[index] = '1'; // BOOM
// CHECK: ERROR: AddressSanitizer: dynamic-stack-buffer-overflow on address [[ADDR:0x[0-9a-f]+]]
// CHECK: WRITE of size 1 at [[ADDR]] thread T0
}

int main(int argc, char **argv) {
  foo(10, 10);
  return 0;
}
