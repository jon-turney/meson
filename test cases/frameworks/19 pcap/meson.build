project('pcap test', 'c')

if host_machine.system() == 'cygwin'
  error('MESON_SKIP_TEST pcap is not packaged for Cygwin.')
endif

pcap_dep = dependency('pcap', version : '>=1.0')

pcap_ver = pcap_dep.version()
assert(pcap_ver.split('.').length() > 1, 'pcap version is "@0@"'.format(pcap_ver))

e = executable('pcap_prog', 'pcap_prog.c', dependencies : pcap_dep)

test('pcaptest', e)

# Ensure discovery bia the configuration tools work also
pcap_dep = dependency('pcap', version : '>=1.0', method : 'pcap-config')
pcap_dep = dependency('pcap', version : '>=1.0', method : 'config-tool')
