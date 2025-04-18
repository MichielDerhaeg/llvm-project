//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <map>

// class map

// template <class InputIterator>
//     map(InputIterator first, InputIterator last,
//         const key_compare& comp, const allocator_type& a);

#include <map>
#include <cassert>

#include "test_macros.h"
#include "../../../test_compare.h"
#include "test_allocator.h"
#include "min_allocator.h"

int main(int, char**) {
  {
    typedef std::pair<const int, double> V;
    V ar[] = {
        V(1, 1),
        V(1, 1.5),
        V(1, 2),
        V(2, 1),
        V(2, 1.5),
        V(2, 2),
        V(3, 1),
        V(3, 1.5),
        V(3, 2),
    };
    typedef test_less<int> C;
    typedef test_allocator<V> A;
    std::map<int, double, C, A> m(ar, ar + sizeof(ar) / sizeof(ar[0]), C(5), A(7));
    assert(m.get_allocator() == A(7));
    assert(m.key_comp() == C(5));
    assert(m.size() == 3);
    assert(std::distance(m.begin(), m.end()) == 3);
    assert(*m.begin() == V(1, 1));
    assert(*std::next(m.begin()) == V(2, 1));
    assert(*std::next(m.begin(), 2) == V(3, 1));
  }
#if TEST_STD_VER >= 11
  {
    typedef std::pair<const int, double> V;
    V ar[] = {
        V(1, 1),
        V(1, 1.5),
        V(1, 2),
        V(2, 1),
        V(2, 1.5),
        V(2, 2),
        V(3, 1),
        V(3, 1.5),
        V(3, 2),
    };
    typedef test_less<int> C;
    typedef min_allocator<V> A;
    std::map<int, double, C, A> m(ar, ar + sizeof(ar) / sizeof(ar[0]), C(5), A());
    assert(m.get_allocator() == A());
    assert(m.key_comp() == C(5));
    assert(m.size() == 3);
    assert(std::distance(m.begin(), m.end()) == 3);
    assert(*m.begin() == V(1, 1));
    assert(*std::next(m.begin()) == V(2, 1));
    assert(*std::next(m.begin(), 2) == V(3, 1));
  }
#  if TEST_STD_VER > 11
  {
    typedef std::pair<const int, double> V;
    V ar[] = {
        V(1, 1),
        V(1, 1.5),
        V(1, 2),
        V(2, 1),
        V(2, 1.5),
        V(2, 2),
        V(3, 1),
        V(3, 1.5),
        V(3, 2),
    };
    {
      typedef min_allocator<V> A;
      typedef test_less<int> C;
      A a;
      std::map<int, double, C, A> m(ar, ar + sizeof(ar) / sizeof(ar[0]), a);

      assert(m.size() == 3);
      assert(std::distance(m.begin(), m.end()) == 3);
      assert(*m.begin() == V(1, 1));
      assert(*std::next(m.begin()) == V(2, 1));
      assert(*std::next(m.begin(), 2) == V(3, 1));
      assert(m.get_allocator() == a);
    }
    {
      typedef explicit_allocator<V> A;
      typedef test_less<int> C;
      A a;
      std::map<int, double, C, A> m(ar, ar + sizeof(ar) / sizeof(ar[0]), a);

      assert(m.size() == 3);
      assert(std::distance(m.begin(), m.end()) == 3);
      assert(*m.begin() == V(1, 1));
      assert(*std::next(m.begin()) == V(2, 1));
      assert(*std::next(m.begin(), 2) == V(3, 1));
      assert(m.get_allocator() == a);
    }
  }
#  endif
#endif

  return 0;
}
