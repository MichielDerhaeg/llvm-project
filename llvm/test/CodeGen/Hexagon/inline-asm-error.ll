; RUN: not llc -mtriple=hexagon < %s 2>&1 | FileCheck %s

; CHECK: error: Don't know how to handle indirect register inputs yet for constraint 'r'

%s.0 = type { ptr, i32, %s.1 }
%s.1 = type { %s.2 }
%s.2 = type { i32, ptr }

define void @f0(ptr byval(%s.0) align 8 %a0) {
b0:
  call void asm sideeffect ".weak OFFSET_0;jump ##(OFFSET_0 + 0x14c15f0)", "*r"(ptr elementtype(%s.0) nonnull %a0), !srcloc !0
  ret void
}

!0 = !{i32 10}
