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
        return options['c_winlibs'].value[:]

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
