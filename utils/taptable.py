"""
Convert the CSV tap table into the correct format for the VHDL constant body.
"""
with open('xapp_052_table_3.csv','r') as csv:
    for line in csv:
        s = line.split(',');
        print '({:>3}, {:>3}, {:>3}, {:>3}, {:>3}), -- {:>3}'.format(s[0], s[1], s[2], s[3], s[4].strip(), s[0])