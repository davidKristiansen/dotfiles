"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/


let g:nvim_config_sub_paths = [
    \ 'vim-plug',
    \ 'keys',
    \ 'plug-conf',
    \ 'general'
    \]

let g:nvim_vscode_config_sub_paths = [
    \ 'vscode'
    \ ]





let g:nvim_config_root=expand('<sfile>:p:h')

let g:nvim_config_files = []
for path in g:nvim_config_sub_paths 
    let g:nvim_config_files += split(globpath(g:nvim_config_root . '/' . path, '*.vim'), '\n')
endfor


if exists('g:vscode')
    for path in g:nvim_vscode_config_sub_paths
        let g:nvim_config_files += split(globpath(g:nvim_config_root . '/' . path, '*.vim'), '\n')
    endfor
endif

for f in g:nvim_config_files
    execute 'source ' . f
endfor


