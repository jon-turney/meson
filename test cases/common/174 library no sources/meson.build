project('libnosources', 'c')

shared_library('libnosources-shared')
static_library('libnosources-static')

libmain = static_library('libmain', 'main.c')
executable('exenosource', link_with: libmain)
