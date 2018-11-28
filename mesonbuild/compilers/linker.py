# Copyright 2018 The Meson development team

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Linker:
    def __init__(self, compiler):
        self.compiler = compiler

    def get_linker_exelist(self):
        return self.compiler.exelist[:]

    def get_linker_always_args(self):
        return []

    def get_linker_output_args(self, outputname):
        return ['-o', outputname]

    def gen_import_library_args(self, implibname):
        """
        The arguments to set the name of the output import library

        This is only called for platforms and targets which have an import
        library
        """
        return ['-Wl,--out-implib=' + implibname]

    def get_option_link_args(self, options):
        if self.compiler.compiler_type.is_windows_compiler:
            return options['c_winlibs'].value[:]
        return []

    def get_std_shared_lib_link_args(self):
        return ['-shared']

    def get_std_shared_module_link_args(self, options):
        if self.compiler.compiler_type.is_osx_compiler:
            return ['-bundle', '-Wl,-undefined,dynamic_lookup']
        return ['-shared']

    @staticmethod
    def unix_args_to_native(args):
        "Always returns a copy that can be independently mutated"
        return args[:]

class VisualStudioLinker(Linker):
    def __init__(self, compiler):
        self.compiler = compiler

    def get_linker_exelist(self):
        # FIXME, should have same path as compiler.
        # FIXME, should be controllable via cross-file.
        if self.compiler.id in ['clang-cl', 'clang']:
            return ['lld-link']
        else:
            return ['link']

    def get_linker_always_args(self):
        always = ['/nologo']

        # clang doesn't emit directives that clang-cl does ???
        if self.compiler.id == 'clang':
            always += ['/defaultlib:libcmt']

        return always

    def get_linker_output_args(self, outputname):
        return ['/OUT:' + outputname]

    def get_linker_search_args(self, dirname):
        return ['/LIBPATH:' + dirname]

    def gen_import_library_args(self, implibname):
        return ['/IMPLIB:' + implibname]

    def get_option_link_args(self, options):
        # ???
        if self.compiler.id != 'clang':
            return options['c_winlibs'].value[:]
        return []

    def get_std_shared_lib_link_args(self):
        return ['/DLL']

    # XXX: needs splitting to deal with compiler and linker flags separately?
    @staticmethod
    def unix_args_to_native(args):
        result = []
        for i in args:
            # -mms-bitfields is specific to MinGW-GCC
            # -pthread is only valid for GCC
            if i in ('-mms-bitfields', '-pthread'):
                continue
            if i.startswith('-L'):
                i = '/LIBPATH:' + i[2:]
            # Translate GNU-style -lfoo library name to the import library
            elif i.startswith('-l'):
                from .c import VisualStudioCCompiler
                name = i[2:]
                if name in VisualStudioCCompiler.ignore_libs:
                    # With MSVC, these are provided by the C runtime which is
                    # linked in by default
                    continue
                else:
                    i = name + '.lib'
            # -pthread in link flags is only used on Linux
            elif i == '-pthread':
                continue
            result.append(i)
        return result

    def get_std_shared_module_link_args(self, options):
        return ['/DLL']


class ClangLinker(Linker):
    def __init__(self, compiler):
        self.compiler = compiler

    def get_linker_always_args(self):
        basic = super().get_linker_always_args()
        if self.compiler.compiler_type.is_osx_compiler:
            return basic + ['-Wl,-headerpad_max_install_names']
        return basic

class ArmLinker(Linker):
    pass
