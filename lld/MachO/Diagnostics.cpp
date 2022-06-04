#include "Diagnostics.h"

namespace lld {
namespace macho {

void Diagnostics::addDuplicate(const Symbol &sym, const InputFile &file1,
                               const InputFile &file2) {
  auto &files = duplicateSymbols[&sym];
  const auto insert = [&files](const auto &file) {
    auto it = std::find(files.begin(), files.end(), &file);
    if (it == files.end()) {
      files.push_back(&file);
    }
  };
  insert(file1);
  insert(file2);
}

void Diagnostics::reportDuplicates(bool allowDeadDuplicates) {
  std::string msg;
  bool errorReported = false;

  for (const auto &duplicate : duplicateSymbols) {
    const auto *sym = duplicate.first;
    const auto &files = duplicate.second;

    if (allowDeadDuplicates && !sym->used)
      continue;

    if (errorReported)
      msg += "\n";

    errorReported = true;
    msg += "duplicate symbol: ";
    msg += sym->getName();
    for (const auto &file : files) {
      msg += "\n>>> defined in " + toString(file);
    }
  }

  if (errorReported)
    error(msg);
}

} // namespace macho
} // namespace lld
