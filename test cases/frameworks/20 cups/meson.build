project('cups test', 'c')

if host_machine.system() == 'cygwin'
  error('MESON_SKIP_TEST cups is not packaged for Cygwin.')
endif

cups_dep = dependency('cups', version : '>=1.4')

e = executable('cups_prog', 'cups_prog.c', dependencies : cups_dep)

test('cupstest', e)

# ensure we can find the cups dependency via the legacy and modern config-tool
# options
dep = dependency('cups', version : '>=1.4', method : 'cups-config')
dep = dependency('cups', version : '>=1.4', method : 'config-tool')
