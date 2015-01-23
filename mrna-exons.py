#!/usr/bin/env python
import argparse
import re
import sys

def mrna_exons(fp, convert=False):
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
        if convert:
          fields[2] = "mRNA"
          fields[8] = re.sub("ID=[^;\n]+;*", "", fields[8])
          fields[8] = fields[8].replace("Parent=", "ID=")
        else:
          fields[8] = re.sub("Parent=[^;\n]+;*", "", fields[8])
        yield "\t".join(fields)

if __name__ == "__main__":
  desc = "Extract mRNA-associated exons"
  usage = "%(prog)s [-h] [-c] < annot.gff3 > exons.gff3"
  parser = argparse.ArgumentParser(description=desc, usage=usage)
  parser.add_argument("-c", "--convert", action="store_true",
                      help="Convert to mature mRNA multifeatures")
  args = parser.parse_args()

  for exon in mrna_exons(sys.stdin, args.convert):
    print exon
