#pragma once

#include "InputFiles.h"
#include "Symbols.h"

#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SmallVector.h"

#include <sstream>

namespace lld {
namespace macho {

struct DuplicateSymbols {

  void add(const Symbol &sym, const InputFile &file1, const InputFile &file2);
  void report(bool allowDeadDuplicates);

  llvm::DenseMap<const Symbol *, llvm::SmallVector<const InputFile *, 2>>
      duplicateSymbols;
};

extern std::unique_ptr<DuplicateSymbols> duplicates;

} // namespace macho
} // namespace lld
