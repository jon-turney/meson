project('option override', 'c',
  default_options : 'unity=on')

# exercise target-level option override
executable('mustunity', 'one.c', 'two.c',
  override_options : ['unity=on'])

executable('notunity', 'three.c', 'four.c',
  override_options : ['unity=off'])

# exercise project-level option override
if meson.is_unity()
  executable('mustunity_proj', 'one.c', 'two.c')
else
  executable('notunity_proj', 'three.c', 'four.c')
endif
