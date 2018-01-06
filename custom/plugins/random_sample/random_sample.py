"""
Usage: random_sample <list> [<sample-count>]

Arguments:
  <list>          The path to a text file with newline-delimitted items from which to select.
  <sample-count>  The number of random samples [default: 100]
"""
import os
from docopt import docopt
from schema import Schema, Use
from numpy.random import randint

s = Schema({'<list>': Use(open), '<sample-count>': Use(int)})
args = s.validate(docopt(__doc__))

item_list = args['<list>'].readlines()

args['<list>'].close()

indexes = randint(len(item_list), size=args['<sample-count>'])

for index in indexes:
  print(item_list[index], end='')
