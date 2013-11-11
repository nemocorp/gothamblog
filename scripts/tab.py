import os
import sys
import csv

with open(sys.argv[1]) as src:
    lines=csv.reader(src, delimiter=';')
    max_length = 0
    for i,l in enumerate(lines):
        if len(l[0]) > max_length:
            max_length = len(l[0])
print(".. class::  well fiche pull-right")
print()
print ("\t+-%s-+" % ("-"*(max_length+1)))
print ("\t| **Fiche** %s |" % (" "*(max_length - 9)))
print ("\t+-%s-+" % ("-"*(max_length+1)))
with open(sys.argv[1]) as src:
    lines=csv.reader(src, delimiter=';')
    for i,l in enumerate(lines):
        if l[0]=='---':
            print ("\t+-%s-+" % ("-"*(max_length+1)))
        else:
            print ("\t| %s %s |" % (l[0], " "*(max_length - len(l[0]))))

print ("\t+-%s-+" % ("-"*(max_length+1)))

