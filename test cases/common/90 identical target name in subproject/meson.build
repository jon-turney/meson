project('toplevel bar', 'c')

if get_option('layout') == 'flat'
  error('MESON_SKIP_TEST: test not possible with flat layout')
endif

subproject('foo')

executable('bar', 'bar.c')
run_target('nop', command : ['true'])
