from vunit import VUnit

vu = VUnit.from_argv()

lib_lfsr = vu.add_library('lfsr')
lib_lfsr.add_source_files('src/LFSR/*.vhd')
lib_lfsr_tb = vu.add_library('lfsr_tb')
lib_lfsr_tb.add_source_files('test/LFSR_TB/*.vhd')

vu.main()