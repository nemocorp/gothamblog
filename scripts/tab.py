import os
import sys
import csv

with open(sys.argv[1]) as src:
    lines=src.readlines()
max_length = 0
for l in lines:
    if len(l) > max_length:
        max_length = len(l)
print(".. class::  well fiche pull-right")
print()
print ("\t+-%s-+" % ("-"*(max_length+1)))
print ("\t| **Fiche** %s |" % (" "*(max_length - 9)))
print ("\t+-%s-+" % ("-"*(max_length+1)))
for l in lines:
    l=l.strip()
    if l=='---':
        print ("\t+-%s-+" % ("-"*(max_length+1)))
    else:
        print ("\t| %s %s |" % (l, " "*(max_length-len(l))))

print ("\t+-%s-+" % ("-"*(max_length+1)))

