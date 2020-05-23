project('custom target shell pickle')

# This test doesn't make sense on Windows as ninja invokes commands via
# CreateProcess() rather than 'sh -c' (and thus meson_exe also should)

if host_machine.system() == 'windows'
  error('MESON_SKIP_TEST: Skipping test as a POSIX shell is not used to run commands')
endif

copy = find_program('copyfile.py')

tests = {
  'unpickled': '',
  'pickled': '\n',  # the presence of \n in command forces meson to wrap it
}

foreach name, whitespace : tests

  custom_target(name,
    input : [
      'static.txt',
    ],
    output: name + '.txt',
    command: [
      copy, '@INPUT@', '@OUTPUT@',
      '&&', 'echo', whitespace
    ],
    build_by_default: true,
  )

endforeach
