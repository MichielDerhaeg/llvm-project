set(LLVM_LINK_COMPONENTS
  AggressiveInstCombine
  Analysis
  BitReader
  BitWriter
  CodeGenTypes
  Core
  Coroutines
  Coverage
  Demangle
  Extensions
  FrontendDriver
  FrontendHLSL
  FrontendOpenMP
  FrontendOffloading
  HIPStdPar
  IPO
  IRPrinter
  IRReader
  InstCombine
  Instrumentation
  LTO
  Linker
  MC
  ObjCARCOpts
  Object
  Passes
  ProfileData
  ScalarOpts
  Support
  Target
  TargetParser
  TransformUtils
  )

# Workaround for MSVC ARM64 performance regression:
# https://developercommunity.visualstudio.com/t/Compiling-a-specific-code-for-ARM64-with/10444970
# Since /O1 and /O2 represent a set of optimizations,
# our goal is to disable the /Og flag while retaining the other optimizations from the /O1|/O2 set
if(MSVC AND NOT CMAKE_CXX_COMPILER_ID MATCHES Clang
    AND MSVC_VERSION VERSION_GREATER_EQUAL 1932
    AND MSVC_VERSION VERSION_LESS 1939
    AND CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64")

  string(TOUPPER "${CMAKE_BUILD_TYPE}" uppercase_CMAKE_BUILD_TYPE)
  string(REGEX MATCHALL "/[Oo][12]" opt_flags "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_${uppercase_CMAKE_BUILD_TYPE}}")
  if (opt_flags)
    if(opt_flags MATCHES "1$")
      set(opt_flags "/Od;/Os;/Oy;/Ob2;/GF;/Gy")
    elseif (opt_flags MATCHES "2$")
      set(opt_flags "/Od;/Oi;/Ot;/Oy;/Ob2;/GF;/Gy")
    endif()
    set_source_files_properties(CGBuiltin.cpp PROPERTIES COMPILE_OPTIONS "${opt_flags}")
  endif()
endif()

add_clang_library(clangCodeGen
  ABIInfo.cpp
  ABIInfoImpl.cpp
  BackendUtil.cpp
  CGAtomic.cpp
  CGBlocks.cpp
  CGBuiltin.cpp
  CGCUDANV.cpp
  CGCUDARuntime.cpp
  CGCXX.cpp
  CGCXXABI.cpp
  CGCall.cpp
  CGClass.cpp
  CGCleanup.cpp
  CGCoroutine.cpp
  CGDebugInfo.cpp
  CGDecl.cpp
  CGDeclCXX.cpp
  CGException.cpp
  CGExpr.cpp
  CGExprAgg.cpp
  CGExprCXX.cpp
  CGExprComplex.cpp
  CGExprConstant.cpp
  CGExprScalar.cpp
  CGGPUBuiltin.cpp
  CGHLSLRuntime.cpp
  CGHLSLBuiltins.cpp
  CGLoopInfo.cpp
  CGNonTrivialStruct.cpp
  CGObjC.cpp
  CGObjCGNU.cpp
  CGObjCMac.cpp
  CGObjCRuntime.cpp
  CGOpenCLRuntime.cpp
  CGOpenMPRuntime.cpp
  CGOpenMPRuntimeGPU.cpp
  CGPointerAuth.cpp
  CGRecordLayoutBuilder.cpp
  CGStmt.cpp
  CGStmtOpenMP.cpp
  CGVTT.cpp
  CGVTables.cpp
  CodeGenABITypes.cpp
  CodeGenAction.cpp
  CodeGenFunction.cpp
  CodeGenModule.cpp
  CodeGenPGO.cpp
  CodeGenTBAA.cpp
  CodeGenTypes.cpp
  ConstantInitBuilder.cpp
  CoverageMappingGen.cpp
  ItaniumCXXABI.cpp
  HLSLBufferLayoutBuilder.cpp
  LinkInModulesPass.cpp
  MacroPPCallbacks.cpp
  MicrosoftCXXABI.cpp
  ModuleBuilder.cpp
  ObjectFilePCHContainerWriter.cpp
  PatternInit.cpp
  SanitizerMetadata.cpp
  SwiftCallingConv.cpp
  TargetInfo.cpp
  VarBypassDetector.cpp
  DEPENDS
  vt_gen
  intrinsics_gen
  ClangDriverOptions
  # These generated headers are included transitively.
  ARMTargetParserTableGen
  AArch64TargetParserTableGen

  LINK_LIBS
  clangAST
  clangAnalysis
  clangBasic
  clangFrontend
  clangLex
  clangSerialization
  clangCodeGenTargetBuiltins
  clangCodeGenTargets
  )

  target_include_directories(clangCodeGen
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/TargetBuiltins
    ${CMAKE_CURRENT_SOURCE_DIR}/Targets
  )
  
  add_subdirectory(TargetBuiltins)
  add_subdirectory(Targets)
