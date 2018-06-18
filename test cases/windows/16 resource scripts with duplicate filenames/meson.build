project('foobar', 'c')

if get_option('layout') == 'flat'
  error('MESON_SKIP_TEST: test not possible with flat layout')
endif

win = import('windows')

subdir('a')
subdir('b')
subdir('c')

main = win.compile_resources('rsrc.rc')

testa = executable('testa', 'verify.c', a)
testb = executable('testb', 'verify.c', b)
testc = executable('testc', 'verify.c', c)
testmain = executable('testmain', 'verify.c', main)

test('a', testa, args: 'a')
test('b', testb, args: 'b')
test('c', testc, args: 'c')
test('main', testmain, args: 'main')
