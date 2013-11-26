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
print ("\t+-%s-+" % ("-"*(max_length)))
print ("\t| **Fiche** %s |" % (" "*(max_length - 10)))
print ("\t+-%s-+" % ("-"*(max_length)))
for l in lines:
    l=l.strip()
    if l=='---':
        print ("\t+-%s-+" % ("-"*(max_length)))
    else:
        print ("\t|%s %s |" % (l, " "*(max_length-len(l))))

print ("\t+-%s-+" % ("-"*(max_length)))

