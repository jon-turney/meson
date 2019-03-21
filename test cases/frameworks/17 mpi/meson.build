project('mpi', 'c', 'cpp', default_options: ['b_asneeded=false'])

cc = meson.get_compiler('c')

if build_machine.system() == 'windows' and cc.get_id() != 'msvc'
  error('MESON_SKIP_TEST: MPI not available on Windows without MSVC.')
endif

mpic = dependency('mpi', language : 'c', required : false)
if not mpic.found()
  error('MESON_SKIP_TEST: MPI not found, skipping.')
endif
exec = executable('exec',
  'main.c',
  dependencies : [mpic])

test('MPI C', exec)

if build_machine.system() != 'windows'
  # C++ MPI not supported by MS-MPI
  mpicpp = dependency('mpi', language : 'cpp')
  if meson.get_compiler('cpp').compiles('''
#include <mpi.h>

int main(int argc, char **argv)
{
    MPI::Init(argc, argv);
}
''', dependencies: mpicpp)
    # MPI C++ bindings are deprecated
    #
    # if OpenMPI was built without --enable-mpi-cxx, the C++ bindings won't be
    # present (see https://github.com/open-mpi/ompi/issues/3173)

    execpp = executable('execpp',
      'main.cpp',
      dependencies : [mpicpp])

    test('MPI C++', execpp)
  endif
endif

# OpenMPI is broken with Fortran on Ubuntu Artful.
# Remove this once the following bug has been fixed:
#
# https://bugs.launchpad.net/ubuntu/+source/gcc-defaults/+bug/1727474

ubudetector = find_program('is_broken_ubuntu.py')
uburesult = run_command(ubudetector)

if uburesult.returncode() != 0 and add_languages('fortran', required : false)
  mpifort = dependency('mpi', language : 'fortran')
  # Mixing compilers (msvc/clang with gfortran) does not seem to work on Windows.
  if build_machine.system() != 'windows' or cc.get_id() == 'gnu'
    exef = executable('exef',
      'main.f90',
      dependencies : [mpifort])
    test('MPI Fortran', exef)
  endif
endif

# Check we can apply a version constraint
if mpic.version() != 'unknown'
  dependency('mpi', version: '>=@0@'.format(mpic.version()))
endif
