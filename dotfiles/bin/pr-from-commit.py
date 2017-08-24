#!/opt/bb/bin/python2.7

from subprocess import check_output, CalledProcessError
from functools32 import lru_cache
from argparse import ArgumentParser
import os

GIT = '/opt/bb/bin/git'
COMMIT_FILE = 'COMMIT_EDITMSG'
END = '# ------------------------ >8 ------------------------\n'
CONFIG_FILE = 'config'
R_HEADS = 'refs/heads/'
BBGITHUB = 'bbgithub:'
HEAD = 'HEAD'
BBGH = '/opt/bb/bin/bbgh'

class gitutil:
  @classmethod
  @lru_cache(maxsize=16)
  def root(cls, dir=os.getcwd()):
    ''' returns the abolute path of the directory '''
    try:
      # check_output(['pushd', dir])
      base = check_output([GIT, 'rev-parse', '--show-toplevel'])
      # check_output(['popd'])
    except CalledProcessError:
      raise IOError("%s is not a git directory".format(dir))
    return base.strip()
  
  @classmethod
  def gitdir(cls, dir=os.getcwd()):
    return os.path.join(cls.root(), '.git')

  @classmethod
  def head(cls):
    path = os.path.join(cls.gitdir(), HEAD)
    with open(path, 'rb') as fd:
      line = fd.read()
      line = line.decode()
      if line.startswith('ref: '):
        return line[5:-1]
      return line[:-1]

  @classmethod
  def branch(cls):
    return cls.head()[len(R_HEADS):]

def _key(name):
  parts = name.split('.')
  if len(parts) < 2:
    return name.lower()
  parts[ 0] = parts[ 0].lower()
  parts[-1] = parts[-1].lower()
  return '.'.join(parts)

def getPRinfo():
    command = [GIT, 'log', '-1', '--pretty=%B']
    lines = check_output(command).split('\n')
    subject = lines[0]
    body = lines[1:]
    return (subject, "\n".join(body))

class Remote(object):
  """Configuration options related to a remote.
  """
  def __init__(self, config, name):
    self._config = config
    self.name = name
    self.url = self._Get('url')
    self.projectname = self._Get('projectname')

  def _Get(self, key, all_keys=False):
    key = 'remote.%s.%s' % (self.name, key)
    return self._config.GetString(key, all_keys = all_keys)

class GitConfig(object):
  def __init__(self):
    self.file = os.path.join(gitutil.gitdir(), CONFIG_FILE)
    self._cache_dict = None
    self._remotes = {}

  def GetRemote(self, name):
    """Get the remote.$name.* configuration values as an object.
    """
    try:
      r = self._remotes[name]
    except KeyError:
      r = Remote(self, name)
      self._remotes[r.name] = r
    return r

  def GetString(self, name, all_keys=False):
    """Get the first value for a key, or None if it is not defined.

    """
    try:
      v = self._cache[_key(name)]
    except KeyError:
      v = []

    if not all_keys:
      if v:
        return v[0]
      return None

    r = []
    r.extend(v)
    return r

  def _do(self, *args):
    command = [GIT, 'config', '--file', self.file]
    command.extend(args)

    return check_output( command )

  @property
  def _cache(self):
    if self._cache_dict is None:
      self._cache_dict = self._Read()
    return self._cache_dict

  def _Read(self):
    """
    Read configuration data from git.

    This internal method populates the GitConfig cache.

    """
    c = {}
    d = self._do('--null', '--list')
    if d is None:
      return c
    for line in d.decode('utf-8').rstrip('\0').split('\0'):  # pylint: disable=W1401
                                                             # Backslash is not anomalous
      if '\n' in line:
        key, val = line.split('\n', 1)
      else:
        key = line
        val = None

      if key in c:
        c[key].append(val)
      else:
        c[key] = [val]

    return c

def push(dry_run=False):
    command = [GIT, 'push', 'origin', '-u']
    command.append('{0}:{0}'.format(gitutil.branch()))

    if (dry_run):
        print(" ".join(command))
    else:
        check_output(command)

def createpull(srcurl, 
               desturl, 
               srcbranch, 
               subject,
               body,
               destbranch='master',
               dry_run=False):
    command = [BBGH,
               'create-pr',
               '--title', subject,
               '--body', body,
               '{0}:{1}'.format(srcurl, srcbranch),
               '{0}:{1}'.format(desturl, destbranch)]
    if (dry_run):
        print(" ".join(command))
    else:
        check_output(command)

def parse_args():
    parser = ArgumentParser(description="pushes current branch to bbgithub origin remote "
                             "and creates a pr to upstream remote using the most "
                             "recent commit message")
    parser.add_argument(
            '--dry-run',
            action='store_true',
            help='Dry run only')
    return parser.parse_args()

def main():
    args = parse_args()
    config = GitConfig()
    source = config.GetRemote('origin').url[len(BBGITHUB):]
    dest = config.GetRemote('upstream').url[len(BBGITHUB):]

    subject, body = getPRinfo()

    push(dry_run=args.dry_run)
    createpull(
            srcurl=source, 
            desturl=dest, 
            srcbranch=gitutil.branch(), 
            subject=subject, 
            body=body, 
            dry_run=args.dry_run)

if __name__ == "__main__":
    main()
