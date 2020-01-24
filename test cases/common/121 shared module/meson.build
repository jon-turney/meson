project('shared module', 'c')

# Windows on ARM doesn't appear to support the toolhelp API we use to emulate
# runtime symbol resolution in this test.
#
# XXX: This should be written as a check if the macro
# WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) evaluates to true?
if host_machine.system() == 'windows' and ['aarch64', 'arm'].contains(host_machine.cpu_family())
  error('MESON_SKIP_TEST windows on ARM does not support this test.')
endif

dl = meson.get_compiler('c').find_library('dl', required : false)
l = shared_library('runtime', 'runtime.c')
# Do NOT link the module with the runtime library. This
# is a common approach for plugins that are only used
# with dlopen. Any symbols are resolved dynamically
# at runtime.  This requires extra help on Windows, so
# should be avoided unless really necessary.
m = shared_module('mymodule', 'module.c')
e = executable('prog', 'prog.c',
  link_with : l, export_dynamic : true, dependencies : dl)
test('import test', e, args : m)

# Same as above, but module created with build_target()
m2 = build_target('mymodule2', 'module.c', target_type: 'shared_module')
test('import test 2', e, args : m2)

# Shared module that does not export any symbols
shared_module('nosyms', 'nosyms.c',
  install : true,
  install_dir : join_paths(get_option('libdir'), 'modules'))
