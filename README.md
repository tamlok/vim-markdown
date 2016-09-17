# Markdown for Vim
Fork from https://github.com/gabrielelana/vim-markdown.git.

Reduced for a more comfortable markdown editting experience.

## Installation
If you use [Vundle](https://github.com/gmarik/vundle), add the following line to your `~/.vimrc`:

    Bundle 'tamlok/vim-markdown'

And then execute the following command in your shell:

    $ vim +'PluginInstall! vim-markdown' +qall

You can update to the latest version with the following command in your shell:

    $ vim +PluginUpdate

If you use [NeoBundle](https://github.com/Shougo/neobundle.vim), add the following line to your `~/.vimrc`:

    NeoBundle 'tamlok/vim-markdown'

And then execute the following command in your shell:

    $ vim +NeoBundleInstall +qall

You can update to the latest version with the following command in your shell:

    $ vim +NeoBundleInstall! +qall

If you use [Pathogen](https://github.com/tpope/vim-pathogen), execute the following in your shell:

    $ cd ~/.vim/bundle
    $ git clone https://github.com/tamlok/vim-markdown.git

### Configuration
* `let g:markdown_include_jekyll_support = 0` to disable support for Jekyll files (enabled by default with: `1`)
  * `let g:markdown_enable_insert_mode_mappings = 0` to disable insert mode mappings (enabled by default with: `1`)
* `let g:markdown_enable_spell_checking = 0` to disable spell checking (enabled by default with: `1`)
* `let g:markdown_enable_conceal = 1` to enable conceal for italic, bold, inline-code and link (disabled by default with: `0`)

### Motions
* `]]` start of the next header
* `[[` start of the previous header

### While Editing in Insert Mode
* `|` in a table triggers the format command
* `<Tab>`/`<S-Tab>` on a list item it will indent/unindent the item
* `<Tab>`/`<S-Tab>` on a blockquote it will increase/decrease the quote level
* `<Enter>` on a list item with no text in it (freshly created) it will delete everything till the column 0
