#!/usr/bin/env python

from __future__ import print_function

import os
from argparse import ArgumentParser
from subprocess import check_call

file_path = os.path.dirname(__file__)

try:
    from pydotfileinstaller import pyinstaller
except ImportError:
    check_call(['git', 'submodule', 'update', '--init', '--recursive'], file_path)
    from pydotfileinstaller import pyinstaller

envirnments = ['bbrgdev', 'bbrgvm', 'win']

def parse_args():
    parser = ArgumentParser(description='install the dot files into the current settings')
    parser.add_argument('--env', action='store',
                        choices=envirnments,
                        help='Chooose the environment specific options to load',
                        required=True)
    parser.add_argument('--no-backup', action='store_true',
                        help="Don't keep backups of the current settings")
    parser.add_argument('-d', '--destination',
                        help='Destination to install dotfiles',
                        default=os.path.expanduser('~'))
    return parser.parse_args()


def run_setup(opts):
    installer = pyinstaller(root_dir=os.path.join(file_path, 'dotfiles'),
                            destination=opts.destination)
    installer.add_directories(['.bash', '.vim', '.tmux'])
    installer.add_files_from_dir()

    installer.install()


if __name__ == '__main__':
    run_setup(parse_args())
