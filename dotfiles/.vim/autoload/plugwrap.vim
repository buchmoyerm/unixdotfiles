
function! plugwrap#begin()
  call plug#begin()
  " ensure plugin flags exist
  if !has_key(g:,'enable_plugins')
    let g:enable_plugins = {}
  endif

  " create wrapper command
  command! -nargs=+ -bar PlugWrap call plugwrap#plug(<args>)
endfunction

function! plugwrap#end()
  call plug#end()
endfunction

function! plugwrap#plug(repo, ...)
  " get plugin name. replace [.-] with _
  let plugin = substitute(split(a:repo, '/')[1], '[.-]', '_', '')
  if get(g:enable_plugins, plugin, 1)
    let tmp = [a:repo] + a:000
    call call(function('plug#'), tmp)
  endif
endfunction
