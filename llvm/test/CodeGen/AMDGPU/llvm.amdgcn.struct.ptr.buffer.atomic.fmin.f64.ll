; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=tahiti < %s | FileCheck -check-prefix=GFX6 %s
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=hawaii < %s | FileCheck -check-prefix=GFX7 %s
; Not supported in gfx8 or gfx9, except  90a/940
; xUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx90a < %s | FileCheck -check-prefixes=GFX9,GFX90A %s
; xUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx942 < %s | FileCheck -check-prefixes=GFX9,GFX942 %s

define double @struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset(double %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen glc
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen glc
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret double %ret
}

define double @struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset(double %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen offset:256 glc
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen offset:256 glc
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %voffset.add = add i32 %voffset, 256
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset.add, i32 %soffset, i32 0)
  ret double %ret
}

define double @struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__0_voffset__sgpr_soffset(double %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__0_voffset__sgpr_soffset:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v2, s[16:19], s20 idxen glc
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__0_voffset__sgpr_soffset:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v2, s[16:19], s20 idxen glc
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 0, i32 %soffset, i32 0)
  ret double %ret
}

define double @struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc(double %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen glc slc
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen glc slc
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 2)
  ret double %ret
}

define void @struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset(double %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 0)
  ret void
}

define void @struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset(double %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen offset:256
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen offset:256
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %voffset.add = add i32 %voffset, 256
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset.add, i32 %soffset, i32 0)
  ret void
}

; Natural mapping, no voffset
define void @struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__0_voffset__sgpr_soffset(double %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__0_voffset__sgpr_soffset:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v2, s[16:19], s20 idxen
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__0_voffset__sgpr_soffset:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v2, s[16:19], s20 idxen
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 0, i32 %soffset, i32 0)
  ret void
}

define void @struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc(double %val, ptr addrspace(8) inreg %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen slc
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_noret__vgpr_val__sgpr_rsrc__vgpr_voffset__sgpr_soffset_slc:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[2:3], s[16:19], s20 idxen offen slc
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset, i32 2)
  ret void
}

; Test waterfall loop on resource
define double @struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__vgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 inreg %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__vgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    s_mov_b64 s[6:7], exec
; GFX6-NEXT:  .LBB8_1: ; =>This Inner Loop Header: Depth=1
; GFX6-NEXT:    v_readfirstlane_b32 s8, v2
; GFX6-NEXT:    v_readfirstlane_b32 s9, v3
; GFX6-NEXT:    v_readfirstlane_b32 s10, v4
; GFX6-NEXT:    v_readfirstlane_b32 s11, v5
; GFX6-NEXT:    v_cmp_eq_u64_e32 vcc, s[8:9], v[2:3]
; GFX6-NEXT:    v_cmp_eq_u64_e64 s[4:5], s[10:11], v[4:5]
; GFX6-NEXT:    s_and_b64 s[4:5], vcc, s[4:5]
; GFX6-NEXT:    s_and_saveexec_b64 s[4:5], s[4:5]
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[6:7], s[8:11], s16 idxen offen offset:256 glc
; GFX6-NEXT:    ; implicit-def: $vgpr2_vgpr3_vgpr4_vgpr5
; GFX6-NEXT:    ; implicit-def: $vgpr6_vgpr7
; GFX6-NEXT:    s_xor_b64 exec, exec, s[4:5]
; GFX6-NEXT:    s_cbranch_execnz .LBB8_1
; GFX6-NEXT:  ; %bb.2:
; GFX6-NEXT:    s_mov_b64 exec, s[6:7]
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__vgpr_rsrc__vgpr_voffset_fmin__sgpr_soffset:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    s_mov_b64 s[6:7], exec
; GFX7-NEXT:  .LBB8_1: ; =>This Inner Loop Header: Depth=1
; GFX7-NEXT:    v_readfirstlane_b32 s8, v2
; GFX7-NEXT:    v_readfirstlane_b32 s9, v3
; GFX7-NEXT:    v_readfirstlane_b32 s10, v4
; GFX7-NEXT:    v_readfirstlane_b32 s11, v5
; GFX7-NEXT:    v_cmp_eq_u64_e32 vcc, s[8:9], v[2:3]
; GFX7-NEXT:    v_cmp_eq_u64_e64 s[4:5], s[10:11], v[4:5]
; GFX7-NEXT:    s_and_b64 s[4:5], vcc, s[4:5]
; GFX7-NEXT:    s_and_saveexec_b64 s[4:5], s[4:5]
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[6:7], s[8:11], s16 idxen offen offset:256 glc
; GFX7-NEXT:    ; implicit-def: $vgpr2_vgpr3_vgpr4_vgpr5
; GFX7-NEXT:    ; implicit-def: $vgpr6_vgpr7
; GFX7-NEXT:    s_xor_b64 exec, exec, s[4:5]
; GFX7-NEXT:    s_cbranch_execnz .LBB8_1
; GFX7-NEXT:  ; %bb.2:
; GFX7-NEXT:    s_mov_b64 exec, s[6:7]
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %voffset.add = add i32 %voffset, 256
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset.add, i32 %soffset, i32 0)
  ret double %ret
}

; Test waterfall loop on soffset
define double @struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__vgpr_soffset(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset, i32 %soffset) {
; GFX6-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__vgpr_soffset:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX6-NEXT:    s_mov_b64 s[6:7], exec
; GFX6-NEXT:  .LBB9_1: ; =>This Inner Loop Header: Depth=1
; GFX6-NEXT:    v_readfirstlane_b32 s8, v2
; GFX6-NEXT:    v_readfirstlane_b32 s9, v3
; GFX6-NEXT:    v_readfirstlane_b32 s10, v4
; GFX6-NEXT:    v_readfirstlane_b32 s11, v5
; GFX6-NEXT:    v_cmp_eq_u64_e32 vcc, s[8:9], v[2:3]
; GFX6-NEXT:    v_cmp_eq_u64_e64 s[4:5], s[10:11], v[4:5]
; GFX6-NEXT:    v_readfirstlane_b32 s12, v8
; GFX6-NEXT:    s_and_b64 s[4:5], vcc, s[4:5]
; GFX6-NEXT:    v_cmp_eq_u32_e32 vcc, s12, v8
; GFX6-NEXT:    s_and_b64 s[4:5], s[4:5], vcc
; GFX6-NEXT:    s_and_saveexec_b64 s[4:5], s[4:5]
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[6:7], s[8:11], s12 idxen offen offset:256 glc
; GFX6-NEXT:    ; implicit-def: $vgpr2_vgpr3_vgpr4_vgpr5
; GFX6-NEXT:    ; implicit-def: $vgpr8
; GFX6-NEXT:    ; implicit-def: $vgpr6_vgpr7
; GFX6-NEXT:    s_xor_b64 exec, exec, s[4:5]
; GFX6-NEXT:    s_cbranch_execnz .LBB9_1
; GFX6-NEXT:  ; %bb.2:
; GFX6-NEXT:    s_mov_b64 exec, s[6:7]
; GFX6-NEXT:    s_waitcnt vmcnt(0) expcnt(0)
; GFX6-NEXT:    s_setpc_b64 s[30:31]
;
; GFX7-LABEL: struct_ptr_buffer_atomic_fmin_f64_ret__vgpr_val__sgpr_rsrc__vgpr_voffset_fmin__vgpr_soffset:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX7-NEXT:    s_mov_b64 s[6:7], exec
; GFX7-NEXT:  .LBB9_1: ; =>This Inner Loop Header: Depth=1
; GFX7-NEXT:    v_readfirstlane_b32 s8, v2
; GFX7-NEXT:    v_readfirstlane_b32 s9, v3
; GFX7-NEXT:    v_readfirstlane_b32 s10, v4
; GFX7-NEXT:    v_readfirstlane_b32 s11, v5
; GFX7-NEXT:    v_cmp_eq_u64_e32 vcc, s[8:9], v[2:3]
; GFX7-NEXT:    v_cmp_eq_u64_e64 s[4:5], s[10:11], v[4:5]
; GFX7-NEXT:    v_readfirstlane_b32 s12, v8
; GFX7-NEXT:    s_and_b64 s[4:5], vcc, s[4:5]
; GFX7-NEXT:    v_cmp_eq_u32_e32 vcc, s12, v8
; GFX7-NEXT:    s_and_b64 s[4:5], s[4:5], vcc
; GFX7-NEXT:    s_and_saveexec_b64 s[4:5], s[4:5]
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    buffer_atomic_fmin_x2 v[0:1], v[6:7], s[8:11], s12 idxen offen offset:256 glc
; GFX7-NEXT:    ; implicit-def: $vgpr2_vgpr3_vgpr4_vgpr5
; GFX7-NEXT:    ; implicit-def: $vgpr8
; GFX7-NEXT:    ; implicit-def: $vgpr6_vgpr7
; GFX7-NEXT:    s_xor_b64 exec, exec, s[4:5]
; GFX7-NEXT:    s_cbranch_execnz .LBB9_1
; GFX7-NEXT:  ; %bb.2:
; GFX7-NEXT:    s_mov_b64 exec, s[6:7]
; GFX7-NEXT:    s_waitcnt vmcnt(0)
; GFX7-NEXT:    s_setpc_b64 s[30:31]
  %voffset.add = add i32 %voffset, 256
  %ret = call double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double %val, ptr addrspace(8) %rsrc, i32 %vindex, i32 %voffset.add, i32 %soffset, i32 0)
  ret double %ret
}

declare double @llvm.amdgcn.struct.ptr.buffer.atomic.fmin.f64(double, ptr addrspace(8), i32, i32, i32, i32 immarg)
