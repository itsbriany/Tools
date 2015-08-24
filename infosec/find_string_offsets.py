"""
Copyright (C) 2015 itsbriany

Finds the offsets of a string in a file
"""

from optparse import OptionParser
from sys import exit


parser = OptionParser(usage="usage: %prog [options] <search string> <file>",
                      version="%prog 1.0")

parser.add_option('-b', action='store_true', default=False, dest='binary_read',
                  help="Read the file as a binary")

options, args = parser.parse_args()


try:
    if options.binary_read is True:
        hex_dump = open(args[1], "rb")
    else:
        hex_dump = open(args[1],)
    target = args[0]

except IOError:
    parser.error("Could not open " + args[1])
    exit(0)

except IndexError:
    parser.error("Wrong arguments")
    exit(0)


try:
    byte = hex_dump.read(1)
    result = ''

    while byte != '':
        offset_count = 0
        result += byte
        byte = hex_dump.read(1)

    offset_count = result.find(target)

    while offset_count != -1:
        print "Found offset at " + str(offset_count)
        beginning = offset_count
        offset_count = result.find(target, beginning + len(target), len(result))


finally:
    hex_dump.close()
