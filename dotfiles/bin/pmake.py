#!/usr/bin/python

from optparse import OptionParser


parser = OptionParser()
parser.add_option("-t", "--top",
                  action="store_true", dest="topdir", default=False,
                  help="go to top directory to build")
parser.add_option("-c", "--clean",
                  action="store_true", dest="cean", default=False,
                  help="clean a project's build and install directories")
parser.add_option("-p", "--platform", dest="platform",
                  help="platform to build")
parser.add_option("-a", "--all",
                  action="store_true", dest="buildall", default=False,
                  help="build all configured platforms")
parser.add_option("-i", "--install",
                  action="store_true", dest="install", default=False,
                  help="install locally")

parser.add_option("-C", "--Clean-All",
                  action="store_true", dest="cleanall", default=False,
                  help="clean the entire projmake build and install directories")

(option, args) = parser.parse_args()
