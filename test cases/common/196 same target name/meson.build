project('same name', 'c')

if get_option('layout') == 'flat'
  error('MESON_SKIP_TEST: test not possible with flat layout')
endif

static_library('foo', 'file.c')
subdir('sub')
