#!/usr/bin/env python
import re
import sys

def exons_to_mature_mrna(fp):
  mrnaids = {}
  for line in fp:
    line = line.rstrip()
    fields = line.split("\t")
    if len(fields) != 9:
      continue
    if fields[2] == "mRNA":
      mrnaid = re.search("ID=([^;\n]+)", fields[8]).group(1)
      mrnaids[mrnaid] = 1
    elif fields[2] == "exon":
      parentid = re.search("Parent=([^;\n]+)", fields[8]).group(1)
      if parentid in mrnaids:
        fields[2] = "mRNA"
        fields[8] = re.sub("ID=[^;\n]+;*", "", fields[8])
        fields[8] = fields[8].replace("Parent=", "ID=")
        yield "\t".join(fields)

if __name__ == "__main__":
  for mrna in exons_to_mature_mrna(sys.stdin):
    print mrna
