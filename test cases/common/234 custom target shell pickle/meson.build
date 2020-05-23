project('custom target shell pickle', 'c')

# This test doesn't make sense on Windows as: (i) ninja invokes commands via
# CreateProcess() (and thus meson_exe also should), (ii) even if a shell was
# used, we can't expect it to be one which supports POSIX shell control operators

if host_machine.system() == 'windows'
  error('MESON_SKIP_TEST: Skipping test as a POSIX shell is not used to run commands')
endif

toollib = shared_library('toolutil',
    'toollib.c',
    native: true,
)

tool = executable('tool',
    'tool.c',
    link_with: toollib,
    native: true,
)

# tool uses the shared library toollib, therefore on Cygwin (the Windows loader
# lacking rpath), when it is run, meson needs to interpose itself with meson_exe
# to perform the appropriate PATH manipulations

text_tmp = custom_target('text.tmp',
  output: 'text.tmp',
  command: tool,
  capture: true,
)

append = find_program('append.sh')

custom_target('combined.txt',
  input : [
    'static.txt',
    text_tmp,
  ],
  output: 'combined.txt',
  command: [
    'cp', '@INPUT0@', '@OUTPUT@',
    '&&', append, '@INPUT1@', '@OUTPUT@',
  ],
  build_by_default: true,
)
