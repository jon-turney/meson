project('gmock test', 'cpp')

if host_machine.system() == 'cygwin'
  error('MESON_SKIP_TEST gmock is not packaged for Cygwin.')
endif

# Using gmock without gtest is a pain so just
# don't support that then.

gtest = dependency('gtest', main : true)
gmock = dependency('gmock')

e = executable('gmocktest', 'gmocktest.cc', dependencies : [gtest, gmock])
test('gmock test', e)
