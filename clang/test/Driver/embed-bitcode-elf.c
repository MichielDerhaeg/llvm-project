// REQUIRES: aarch64-registered-target

// RUN: %clang -c -target aarch64-linux-android21 %s -fembed-bitcode -o %t.o \
// RUN: -ffunction-sections -fdata-sections -fstack-protector-strong

// RUN: llvm-readobj -S %t.o | FileCheck --check-prefix=CHECK %s
// CHECK:   Name: .text.foo
// CHECK:   Name: .llvmbc
// CHECK:   Name: .llvmcmd

// RUN: llvm-objcopy %t.o --dump-section=.llvmcmd=%t.llvmcmd
// RUN: FileCheck --check-prefix=CMD %s < %t.llvmcmd
// CMD: ffunction-sections
// CMD: fdata-sections

int foo() { return 42; }
