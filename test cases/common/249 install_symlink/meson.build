project('install_emptydir')

# this test will run, but does nothing with the visual studio backend, because we don't install files and hence can't verify what got installed

install_data('datafile.dat', install_dir: 'share/progname/C')
install_symlink('datafile.dat', pointing_to: '../C/datafile.dat', install_dir: 'share/progname/es')
install_symlink('rename_datafile.dat', pointing_to: '../C/datafile.dat', install_dir: 'share/progname/fr')
