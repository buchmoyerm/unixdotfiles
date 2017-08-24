#!/opt/bb/bin/python3

import sys
sys.path.append("/home/mbuchmoyer/mbig/dev/dev_tools")

import os
import getpass
from argparse import ArgumentParser
from pytools.PyCommand import Command

PYTHON_DPKG_VERSIONS = ['2.7', '3.5', '3.6']

DPKG_ROOT = 'dpkg-root'
DPKG_FORMAT = '3.0 (quilt)\n'
DPKG_DISTRO_DEV = '/opt/bb/bin/dpkg-distro-dev'
DPKG_DEBCHANGE = '/opt/bb/bin/dpkg-debchange'

DPKG_SOURCE = """Source: {{0}}
Maintainer: {{1}}
Section: python
Priority: extra
Build-Depends: 
    python-debhelper
  , {0}
Standards-Version: 3.9.7
\n""".format("\n  , ".join('python{0}-dev\n  , python{0}-setuptools'.format(v) for v in PYTHON_DPKG_VERSIONS))

DPKG_PACKAGE = """Package: python{0}-{1}
Architecture: all
Depends: python{0}
Description: python {1} package
\n"""

DPKG_PYTHON_RULES = """#!/usr/bin/make -f
# -*- makefile -*-

include $(DISTRIBUTION_REFROOT)/opt/bb/share/python-debhelper/python-debhelper.mk

{0}
""".format("\n".join([ "$(eval $(call PYDH_BINARY_TEMPLATE,{0},INDEP))".format(v) for v in PYTHON_DPKG_VERSIONS]))

class GitHubPackage(object):
    def __init__(self, args):
        self.root_url = args.githubpath
        self.version = args.version
        self.dlurl, self.dlFileName = GitHubPackage._getDLinfo(self.root_url, self.version)

    def name(self):
        return self.root_url.split('/')[-1]

    def source_dir(self, type = 'python'):
        return '{0}-{1}-{2}'.format(self.type, pkg_name, pkg_version)

    @classmethod
    def addGitHubArgs(cls, parser):
        parser.add_argument('githubpath',
                            help='url to github repo')
        parser.add_argument('version',
                            help='github version')

    @classmethod
    def _getDLinfo(cls, base_url, version):
        return ('{0}/archive/v{1}.tar.gz'.format(giturl, version), 'v{0}.tar.gz'.format(version))

class DpkgSource(object):
    def __init__(self, github, dir=os.getcwd(), type='python'):
        self.name = '{0}-{1}-{2}'.format(type, github.name(), github.version)
        self.archive_name = '{0}-{1}_{2}.orig.tar.gz'.format(type, github.name(), github.version)
        self.dir = dir
        self.version = github.version
        self.full_path = os.path.join(self.dir, self.name)
        self.archive_full_path = os.path.join(self.dir, self.archive_name)

class DpkgRepo(object):
    def __init__(self, name, version, type='python', directory=os.getcwd()):
        self.name = name
        self.version = version
        self.type = type
        self.git_dir = os.path.join(directory, self.repoName())

    def repoName(self):
        return '{0}-{1}'.format(self.type, self.name)

    def formatFile(self):
        return os.path.join(self.git_dir, 'debian/source/format')

    def controlFile(self):
        return os.path.join(self.git_dir, 'debian/control')

    def rulesFile(self):
        return os.path.join(self.git_dir, 'debian/rules')

    def maintainer(self):
        empInf = Command(['bbempinf.tsk', '-n', '-e', getpass.getuser()],
                         capture_stdout=True)
        assert empInf.Wait() == 0
        name, email = empInf.stdout.strip().split(';')
        return '{0} <{1}>'.format(name.replace('|', ' '), email)

def writeFormat(repo):
    f = repo.formatFile()
    os.makedirs(os.path.dirname(f), exist_ok=True)
    with open(f, 'w') as fout:
        fout.write(DPKG_FORMAT)

def writeControl(repo):
    f = repo.controlFile()
    os.makedirs(os.path.dirname(f), exist_ok=True)
    with open(f, 'w') as sout:
        sout.write(DPKG_SOURCE.format(repo.repoName(), repo.maintainer()))
        for v in PYTHON_DPKG_VERSIONS:
            sout.write(DPKG_PACKAGE.format(v, repo.name))

def writeRules(repo):
    f = repo.rulesFile()
    os.makedirs(os.path.dirname(f), exist_ok=True)
    with open(f, 'w') as rout:
        rout.write(DPKG_PYTHON_RULES)

GIT = '/opt/bb/bin/git'
def initRepo(repo):
    init = Command([GIT, 'init', repo.git_dir])
    assert init.Wait() == 0

def gitCommit(repo):
    assert Command([GIT, 'add', '--all'], cwd = repo.git_dir).Wait() == 0
    commit = Command([GIT, 'commit', '-a', '-m', '"{0} v{1} snapshot"'.format(repo.name, repo.version)],
                     cwd = repo.git_dir)
    assert commit.Wait() == 0

def writeChangeLog(repo):
    debchange = Command([DPKG_DEBCHANGE, '--version={0}-1'.format(repo.version), '--full-rewrite'],
                        cwd = repo.git_dir)

    assert debchange.Wait() == 0

def initDpkgRoot(directory):
    os.mkdir(os.path.join(directory, DPKG_ROOT))
    init = Command([DPKG_DISTRO_DEV, 'init'],
                    cwd = os.path.join(directory, DPKG_ROOT))
    assert init.Wait() == 0

def buildDpkg(directory, repo):
    build = Command([DPKG_DISTRO_DEV, 'build', repo.git_dir],
                    cwd = os.path.join(directory, DPKG_ROOT))
    assert build.Wait() == 0

def download(directory, github):
    c = ['curl']
    c.append('--proxy')
    c.append('http://devproxy.bloomberg.com:82')
    c.append('-k')
    c.append('-LO')
    c.append(github.dlurl)
    assert Command(c, cwd=directory).Wait() == 0

def extractFile(directory, github, source):
    if not os.path.isdir(source.full_path):
        os.mkdir(source.full_path)
    c = ['tar']
    c.append('--strip-components')
    c.append('1')
    c.append('-xf')
    c.append(github.dlFileName)
    c.append('-C')
    c.append(source.full_path)
    assert Command(c, cwd=directory).Wait() == 0

def create_archive(source):
    c = ['tar']
    c.append('-czf')
    c.append(source.archive_name)
    c.append(source.name) # do not use source.full_path otherwise build will fail
    assert Command(c, cwd=source.dir).Wait() == 0

def main():
    parser = ArgumentParser("Tool for converting github packages to dpkgs")
    parser.add_argument('-w',
                        '--workdir',
                        default=os.getcwd(),
                        help='directory to work in. default is cwd')

    GitHubPackage.addGitHubArgs(parser)
    args = parser.parse_args()

    github = GitHubPackage(args)
    d = args.workdir
    download(d, github)

    source = DpkgSource(github, dir=d)
    extractFile(d, github, source)
    create_archive(source)

    repo = DpkgRepo(github.name(), github.version, directory=d)
    initRepo(repo)
    writeFormat(repo)
    writeControl(repo)
    writeRules(repo)
    gitCommit(repo)
    writeChangeLog(repo)

    initDpkgRoot(d)
    buildDpkg(d, repo)

if  __name__ == "__main__":
    main()
