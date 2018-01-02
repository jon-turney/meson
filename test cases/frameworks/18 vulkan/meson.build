project('vulkan test', 'c')

if host_machine.system() == 'cygwin'
  error('MESON_SKIP_TEST vulkan is not packaged for Cygwin.')
endif

vulkan_dep = dependency('vulkan')

e = executable('vulkanprog', 'vulkanprog.c', dependencies : vulkan_dep)

test('vulkantest', e)
