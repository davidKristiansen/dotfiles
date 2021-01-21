
if exists('g:vscode')
else 

	if has('termguicolors')
		set termguicolors
	end

	" set term=screen-256color

	set t_Co=256

	" if exists("$TMUX")
	"         set t_Co=256
	"         set notermguicolors
	" else
	"         set termguicolors
	" endif

	" set t_8f=^[[38;2;%lu;%lu;%lum
	" set t_8b=^[[48;2;%lu;%lu;%lum

	set background=dark

	let g:gruvbox_material_background = 'hard'

	colorscheme gruvbox-material
	let g:airline_theme='gruvbox_material'
  " highlight HighlightedyankRegion cterm=reverse gui=reverse
  hi HighlightedyankRegion term=bold ctermbg=0 guibg=#13354A
endif
