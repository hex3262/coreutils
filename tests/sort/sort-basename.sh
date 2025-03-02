#!/bin/sh
# exercise sort's -B|--basename option

# Copyright (C) 2008-2025 Free Software Foundation, Inc.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

. "${srcdir=.}/tests/init.sh"; path_prepend_ ./src
print_ver_ sort

cat > in << _EOF_
/usr/src/git
Zzzz
/
/a/b/z
/z/g/a
/1/ggg/B
/a/b/323
HHH
 s
////
/a/b/213
/z/a/9
GG

_EOF_

cat > exp << _EOF_
/
////

 s
/a/b/213
/a/b/323
/z/a/9
/1/ggg/B
GG
HHH
Zzzz
/z/g/a
/usr/src/git
/a/b/z
_EOF_

cat > expn << _EOF_
/
////

 s
/1/ggg/B
GG
HHH
Zzzz
/z/g/a
/usr/src/git
/a/b/z
/z/a/9
/a/b/213
/a/b/323
_EOF_

sort -B -o out in || fail=1
compare exp out || fail=1

tr ' ' '\0' <in >in0 || framework_failure_
sort -B -o out0 in0 || fail=1
tr '\0' ' ' <out0 >out1 || framework_failure_
compare exp out1 || fail=1

sort -Bn -o out in || fail=1
compare expn out || fail=1

tr ' ' '\0' <in >in0 || framework_failure_
sort -Bn -o out0 in0 || fail=1
tr '\0' ' ' <out0 >out1 || framework_failure_
compare expn out1 || fail=1

Exit $fail
