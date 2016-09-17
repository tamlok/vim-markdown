" Vim syntax file
" Language:     Markdown
" Maintainer:   Gabriele Lana <gabriele.lana@gmail.com>
" Filenames:    *.md

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'markdown'
endif

if !exists('g:markdown_flavor')
  let g:markdown_flavor = 'github'
endif

if exists('g:markdown_enable_conceal') && g:markdown_enable_conceal
    let b:markdown_concealends = 'concealends'
    let b:markdown_conceal = 'conceal'
    set conceallevel=2
    set concealcursor=
else
    let b:markdown_concealends = ''
    let b:markdown_conceal = ''
endif

syn spell toplevel
syn sync fromstart
syn case ignore


" {{{ INLINE ELEMENTS

syn cluster markdownInline contains=
  \ markdownItalic,markdownBold,markdownBoldItalic,markdownStrike,markdownInlineCode,
  \ markdownPullRequestLinkInText,markdownUrlLinkInText,markdownUserLinkInText,
  \ markdownEmailLinkInText,markdownLinkContainer,markdownXmlComment,
  \ markdownXmlElement,markdownXmlEmptyElement,markdownXmlEntities

execute 'syn region markdownItalic matchgroup=markdownInlineDelimiter '
  \ . 'start="\%(\s\|_\|^\)\@<=\*\%(\s\|\*\|$\)\@!" end="\%(\s\|\*\)\@<!\*" '
  \ . 'contains=@markdownInline '
  \ . b:markdown_concealends
execute 'syn region markdownItalic matchgroup=markdownInlineDelimiter '
  \ . 'start="\%(\s\|\*\|^\)\@<=_\%(\s\|_\|$\)\@!" end="\%(\s\|_\)\@<!_" '
  \ . 'contains=@markdownInline '
  \ . b:markdown_concealends

execute 'syn region markdownBold matchgroup=markdownInlineDelimiter '
  \ . 'start="\%(\s\|__\|^\)\@<=\*\*\%(\s\|\*\|$\)\@!" end="\%(\s\|\*\*\)\@<!\*\*" '
  \ . 'contains=@markdownInline '
  \ . b:markdown_concealends
execute 'syn region markdownBold matchgroup=markdownInlineDelimiter '
  \ . 'start="\%(\s\|\*\*\|^\)\@<=__\%(\s\|_\|$\)\@!" end="\%(\s\|__\)\@<!__" '
  \ . 'contains=@markdownInline '
  \ . b:markdown_concealends

execute 'syn region markdownBoldItalic matchgroup=markdownInlineDelimiter '
  \ . 'start="\%(\s\|_\|^\)\@<=\*\*\*\%(\s\|\*\|$\)\@!" end="\%(\s\|\*\)\@<!\*\*\*" '
  \ . 'contains=@markdownInline '
  \ . b:markdown_concealends
execute 'syn region markdownBoldItalic matchgroup=markdownInlineDelimiter '
  \ . 'start="\%(\s\|\*\|^\)\@<=___\%(\s\|_\|$\)\@!" end="\%(\s\|_\)\@<!___" '
  \ . 'contains=@markdownInline '
  \ . b:markdown_concealends
execute 'syn region markdownBoldItalic matchgroup=markdownInlineDelimiter '
  \ . 'start="\%(\s\|_\|^\)\@<=\*\*_\%(\s\|_\|$\)\@!" end="\%(\s\|_\)\@<!_\*\*" '
  \ . 'contains=@markdownInline '
  \ . b:markdown_concealends
execute 'syn region markdownBoldItalic matchgroup=markdownInlineDelimiter '
  \ . 'start="\%(\s\|\*\|^\)\@<=__\*\%(\s\|\*\|$\)\@!" end="\%(\s\|\*\)\@<!\*__" '
  \ . 'contains=@markdownInline '
  \ . b:markdown_concealends

syn match markdownStrike /\%(\\\)\@<!\~\~\%(\S\)\@=\_.\{-}\%(\S\)\@<=\~\~/ contains=markdownStrikeDelimiter,@markdownInline
syn match markdownStrikeDelimiter /\~\~/ contained

" Fenced code blocks in list items must be preceded by an empty line This is
" made this way so that the second rule could eat up something that is not a
" fenced code block like
"
"     * This is a list item
"       ```ruby
"       # this is not a fenced code block but it's a code block
"       def ruby;
"       ```
execute 'syn region markdownInlineCode matchgroup=markdownCodeDelimiter start=/\%(`\)\@<!`/ end=/`/ keepend contains=@NoSpell ' . b:markdown_concealends
execute 'syn region markdownInlineCode matchgroup=markdownCodeDelimiter start=/\%(`\)\@<!`\z(`\+\)/ end=/`\z1/ keepend contains=@NoSpell ' . b:markdown_concealends

" case insensitive
" preceded by something that is not a word
" could be surrounded by angle brackets
" could begin with / or // (path) or the url protocol
" inside the url pairs of balanced parentheses are allowed
" inside the url html entities are allowed
" the end block is different because ?!:,. are not included in the url if they
" appear at the end of the url
let b:markdown_syntax_url =
  \ '\c'
  \ . '\%(\W\)\@<='
  \ . '<\?'
  \ . '\%('
  \ .   '\%(\<\%(https\?\|ftp\|file\):\/\/\|www\.\|ftp\.\)'
  \ .   '\|'
  \ .   '\/\/\?'
  \ . '\)'
  \ . '\%('
  \ .   '&#\?[0-9A-Za-z]\{1,8};'
  \ .   '\|'
  \ .   '\\'
  \ .   '\|'
  \ .   '([-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?)'
  \ .   '\|'
  \ .   '\[[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?\]'
  \ .   '\|'
  \ .   '{[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?}'
  \ .   '\|'
  \ .   '[-A-Z0-9+&@#/%=~_|$?!:,.]'
  \ . '\)*'
  \ . '\%('
  \ .   '&#\?[0-9A-Za-z]\{1,8};'
  \ .   '\|'
  \ .   '\\'
  \ .   '\|'
  \ .   '([-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?)'
  \ .   '\|'
  \ .   '\[[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?\]'
  \ .   '\|'
  \ .   '{[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?}'
  \ .   '\|'
  \ .   '[-A-Z0-9+&@#/%=~_|$]\+'
  \ . '\)'
  \ . '>\?'
execute 'syn match markdownUrlLinkInText /' . b:markdown_syntax_url . '/ contains=@NoSpell display'

syn match markdownPullRequestLinkInText /\%(\w\)\@<!#\d\+/ display
syn match markdownUserLinkInText /\%(\w\)\@<!@[[:alnum:]._\/-]\+/ contains=@NoSpell display
syn match markdownEmailLinkInText /[[:alnum:]._%+-]\+@[[:alnum:].-]\+\.\w\{2,4}/ contains=@NoSpell display

" something encosed in square brackets
" could not be preceded by a backslash
" could contain pairs of square brackets
" could contain no more than two consecutive newlines
" could contain single square brackets (open or closed) escaped
" could not contain unbalanced square brackets like 'a [ b \] c'
" could not contain nested square brackets
let b:markdown_syntax_allowed_characters_in_square_brackets = '\%([^\[\]]\|\\\[\|\\\]\)*'
let b:markdown_syntax_square_brackets_block = ''
  \ . '\%(\\\)\@<!\['
  \ .   '\%('
  \ .     b:markdown_syntax_allowed_characters_in_square_brackets
  \ .     '\|'
  \ .     b:markdown_syntax_allowed_characters_in_square_brackets
  \ .     '\['
  \ .       b:markdown_syntax_allowed_characters_in_square_brackets
  \ .     '\]'
  \ .     b:markdown_syntax_allowed_characters_in_square_brackets
  \ .   '\)'
  \ .   '\%('
  \ .     '\n\%(\n\)\@!'
  \ .     '\%('
  \ .       b:markdown_syntax_allowed_characters_in_square_brackets
  \ .       '\|'
  \ .       b:markdown_syntax_allowed_characters_in_square_brackets
  \ .       '\['
  \ .         b:markdown_syntax_allowed_characters_in_square_brackets
  \ .       '\]'
  \ .       b:markdown_syntax_allowed_characters_in_square_brackets
  \ .     '\)'
  \ .   '\)*'
  \ . '\]'

" something encosed in round brackets
" could not be preceded by a backslash
" could contain pairs of round brackets
" could contain no more than two consecutive newlines
" could contain single round brackets (open or closed) escaped
" could not contain unbalanced round brackets like 'a ( b \) c'
" could not contain nested round brackets
let b:markdown_syntax_allowed_characters_in_round_brackets = '[^()]*'
let b:markdown_syntax_round_brackets_block = ''
  \ . '\%(\\\)\@<!('
  \ .   '\%('
  \ .     b:markdown_syntax_allowed_characters_in_round_brackets
  \ .     '\|'
  \ .     b:markdown_syntax_allowed_characters_in_round_brackets
  \ .     '('
  \ .       b:markdown_syntax_allowed_characters_in_round_brackets
  \ .     ')'
  \ .     b:markdown_syntax_allowed_characters_in_round_brackets
  \ .   '\)'
  \ .   '\%('
  \ .     '\n\%(\n\)\@!'
  \ .     '\%('
  \ .       b:markdown_syntax_allowed_characters_in_round_brackets
  \ .       '\|'
  \ .       b:markdown_syntax_allowed_characters_in_round_brackets
  \ .       '('
  \ .         b:markdown_syntax_allowed_characters_in_round_brackets
  \ .       ')'
  \ .       b:markdown_syntax_allowed_characters_in_round_brackets
  \ .     '\)'
  \ .   '\)*'
  \ . ')'

execute 'syn match markdownLinkContainer '
  \ . 'contains=markdownLinkTextContainer,markdownLinkUrlContainer transparent '
  \ . '/'
  \ . '!\?'
  \ . b:markdown_syntax_square_brackets_block
  \ . '\%(\s*\|\n\%\(\n\)\@!\)'
  \ . '\%('
  \ .   b:markdown_syntax_round_brackets_block
  \ .   '\|'
  \ .   b:markdown_syntax_square_brackets_block
  \ . '\)'
  \ . '/'

execute 'syn match markdownLinkTextContainer contained '
  \ . 'contains=markdownLinkText '
  \ . '/'
  \ . '!\?'
  \ . b:markdown_syntax_square_brackets_block
  \ . '/'

execute 'syn match markdownLinkText contained '
  \ . 'contains=@markdownInline,@NoSpell '
  \ . '/'
  \ . '!\?'
  \ . b:markdown_syntax_square_brackets_block
  \ . '/'
  \ . 'hs=s+1,he=e-1'

execute 'syn match markdownLinkUrlContainer contained '
  \ . 'contains=markdownLinkUrl,markdownLinkTitleSingleQuoted,markdownLinkTitleDoubleQuoted '
  \ . '/'
  \ . b:markdown_syntax_round_brackets_block
  \ . '/ '
  \ . b:markdown_conceal

execute 'syn match markdownLinkUrl contained '
  \ . 'contains=@NoSpell '
  \ . '/'
  \ . '\%((\)\@<='
  \ . '\%('
  \ .   '&#\?[0-9A-Za-z]\{1,8};'
  \ .   '\|'
  \ .   '\\'
  \ .   '\|'
  \ .   '([-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?)'
  \ .   '\|'
  \ .   '\[[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?\]'
  \ .   '\|'
  \ .   '{[-A-Z0-9+&@#/%=~_|$?!:,.]*\\\?}'
  \ .   '\|'
  \ .   '[-A-Z0-9+&@#/%=~_|$?!:,.]'
  \ .   '\|'
  \ .   '\s'
  \ . '\)\+'
  \ . '\%(\s\+["'']\|)\|\n\)\@='
  \ . '/'

execute 'syn region markdownLinkTitleSingleQuoted start=/\s*''/ skip=/\\''/ end=/''\_s*/ display '
  \ . 'keepend contained contains=@markdownInline '
  \ . b:markdown_conceal

execute 'syn region markdownLinkTitleDoubleQuoted start=/\s*"/ skip=/\\"/ end=/"\_s*/ display '
  \ . 'keepend contained contains=@markdownInline '
  \ . b:markdown_conceal

syn match markdownXmlComment /\c<\!--\_.\{-}-->/ contains=@NoSpell
syn match markdownXmlElement /\c<\([-A-Z0-9_$?!:,.]\+\)[^>]\{-}>\_.\{-}<\/\1>/ contains=@NoSpell
syn match markdownXmlEmptyElement /\c<\([-A-Z0-9_$?!:,.]\+\)\%(\s\+[^>]\{-}\/>\|\s*\/>\)/ contains=@NoSpell
syn match markdownXmlEntities /&#\?[0-9A-Za-z]\{1,8};/ contains=@NoSpell

" }}}


" {{{ ANCHORED BLOCKS

syn match markdownRule /^\s*\*\s*\*\s*\*[[:space:]*]*$/ display
syn match markdownRule /^\s*-\s*-\s*-[[:space:]-]*$/ display
syn match markdownRule /^\s*_\s*_\s*_[[:space:]_]*$/ display

if g:markdown_flavor ==? 'github'
  syn region markdownH1 matchgroup=markdownHeadingDelimiter start=/^#\%(\s\+\)\@=/      end=/#*\s*$/ display oneline contains=@markdownInline
  syn region markdownH2 matchgroup=markdownHeadingDelimiter start=/^##\%(\s\+\)\@=/     end=/#*\s*$/ display oneline contains=@markdownInline
  syn region markdownH3 matchgroup=markdownHeadingDelimiter start=/^###\%(\s\+\)\@=/    end=/#*\s*$/ display oneline contains=@markdownInline
  syn region markdownH4 matchgroup=markdownHeadingDelimiter start=/^####\%(\s\+\)\@=/   end=/#*\s*$/ display oneline contains=@markdownInline
  syn region markdownH5 matchgroup=markdownHeadingDelimiter start=/^#####\%(\s\+\)\@=/  end=/#*\s*$/ display oneline contains=@markdownInline
  syn region markdownH6 matchgroup=markdownHeadingDelimiter start=/^######\%(\s\+\)\@=/ end=/#*\s*$/ display oneline contains=@markdownInline

  syn match markdownH1 /^.\+\n=\+$/ display contains=@markdownInline,markdownHeadingUnderline
  syn match markdownH2 /^.\+\n-\+$/ display contains=@markdownInline,markdownHeadingUnderline
  syn match markdownHeadingUnderline /^[=-]\+$/ display contained
endif

if g:markdown_flavor ==? 'kramdown'
  syn match markdownHeaderContainer /^#\{1,6}.\+$/ display transparent
    \ contains=@markdownInline,markdownHeader,markdownHeaderId,markdownHeadingDelimiter
  syn match markdownHeader /\%(^#\+\)\@<=\%([^#]\+\%(#\+\s*\%($\|{\)\)\@=\|[^{]\{-}\%({\)\@=\|#$\)/

  syn match markdownHeader /^.\+\n=\+$/ display contains=@markdownInline,markdownHeadingUnderline,markdownHeaderId
  syn match markdownHeader /^.\+\n-\+$/ display contains=@markdownInline,markdownHeadingUnderline,markdownHeaderId
  syn match markdownHeadingUnderline /^[=-]\+$/ display contained

  syn match markdownHeaderId /{[^}]\+}\s*$/ display contained
  syn match markdownHeadingDelimiter /#\+\%(.\+\)\@=/ display contained
endif

execute 'syn match markdownLinkReference '
  \ . 'contains=@NoSpell '
  \ . 'display '
  \ . '/'
  \ . '^\s\{,3}'
  \ . b:markdown_syntax_square_brackets_block
  \ . ':.*'
  \ . '\%(\n\%\(\n\)\@!.*$\)*'
  \ . '/'

syn region markdownBlockquote start=/^\s*\%(>\s\?\)\+\%(.\)\@=/ end=/\n\n/ contains=markdownBlockquoteDelimiter,@NoSpell
syn match markdownBlockquoteDelimiter /^\s*\%(>\s\?\)\+/ contained

syn region markdownFencedCodeBlock matchgroup=markdownCodeDelimiter start=/^\s\{,3}```\%(`*\).*$/ end=/^\s\{,3}```\%(`*\)\s*$/ contains=@NoSpell
syn region markdownFencedCodeBlock matchgroup=markdownCodeDelimiter start=/^\s\{,3}\~\~\~\%(\~*\).*$/ end=/^\s\{,3}\~\~\~\%(\~*\)\s*$/ contains=@NoSpell

syn match markdownCodeBlock /\%(^\n\)\@<=\%(\%(\s\{4,}\|\t\+\).*\n\)\+$/ contains=@NoSpell

let s:markdown_table_header_rows_separator = ''
  \ . '\%('
  \ .   '\s*|\?\%(\s*[-:]-\{1,}[-:]\s*|\)\+\s*[-:]-\{1,}[-:]\s*|\?\s*'
  \ .   '\|'
  \ .   '\s*|\s*[-:]-\{1,}[-:]\s*|\s*'
  \ .   '\|'
  \ .   '\s*|\s*[-:]-\{1,}[-:]\s*'
  \ .   '\|'
  \ .   '\s*[-:]-\{1,}[-:]\s*|\s*'
  \ . '\)'
execute 'syn match markdownTable '
  \ . 'transparent contains=markdownTableHeader,markdownTableDelimiter,@markdownInline '
  \ . '/'
  \ .   '^\s*\n'
  \ .   '\s*|\?\%([^|]\+|\)*[^|]\+|\?\s*\n'
  \ .   s:markdown_table_header_rows_separator . '\n'
  \ .   '\%('
  \ .     '\s*|\?\%([^|]\+|\)*[^|]\+|\?\s*\n'
  \ .   '\)*'
  \ .   '$'
  \ . '/'
syn match markdownTableDelimiter /|/ contained
execute 'syn match markdownTableDelimiter contained '
  \ . '/' . s:markdown_table_header_rows_separator . '/'
execute 'syn match markdownTableHeader contained contains=@markdownInline '
  \ . '/\%(|\?\s*\)\@<=[^|]\+\%(.*\n' . s:markdown_table_header_rows_separator . '\)\@=/'

" }}}


" {{{ NESTED BLOCKS

for s:level in range(1, 16)
  let s:indented_as_content = '\%( \{' . (2*s:level) . '}\|\t\{' . (s:level) . '}\)'
  let s:indented_as_container = '\%( \{' . (2*(s:level-1)) . '}\|\t\{' . (s:level-1) . '}\)'
  let s:preceded_by_separator = '^\s*\n'

  execute 'syn region markdownListItemAtLevel' . (s:level) . ' '
    \ . 'matchgroup=markdownItemDelimiter '
    \ . (s:level > 1 ? 'contained ' : '')
    \ . 'keepend '
    \ . 'contains='
    \ .   'markdownTableInListItemAtLevel' . (s:level) . ','
    \ .   'markdownCodeBlockInListItemAtLevel' . (s:level) . ','
    \ .   'markdownFencedCodeBlockInListItemAtLevel' . (s:level) . ','
    \ .   'markdownH1InListItemAtLevel' . (s:level) . ','
    \ .   'markdownH2InListItemAtLevel' . (s:level) . ','
    \ .   'markdownH3InListItemAtLevel' . (s:level) . ','
    \ .   'markdownH4InListItemAtLevel' . (s:level) . ','
    \ .   'markdownH5InListItemAtLevel' . (s:level) . ','
    \ .   'markdownH6InListItemAtLevel' . (s:level) . ','
    \ .   'markdownRuleInListItemAtLevel' . (s:level) . ','
    \ .   'markdownBlockquoteInListItemAtLevel' . (s:level) . ','
    \ .   'markdownListItemAtLevel' . (s:level+1) . ','
    \ .   '@markdownInline '
    \ . 'start=/^' . (s:indented_as_container) . '\%([-*+]\|\d\+\.\)\%(\s\+\[[ x]\]\)\?\s\+/ '
    \ . 'end='
    \ .   '/'
    \ .     '\n\%(\n\n\)\@='
    \ .     '\|'
    \ .     '\n\%(' . (s:indented_as_container) . '\%([-*+]\|\d\+\.\)\s\+\)\@='
    \ .     '\|'
    \ .     '\n\%(\n' . (s:indented_as_container) . '\S\)\@='
    \ .   '/'

  " fenced code blocks could have leading spaces after the base level indentation
  " so at least it must be indented as content but could be indented more
  " there's no upper limit to the indentation because the following rule on
  " code blocks is going to take care of that
  " TL;DR: don't swap markdownFencedCodeBlockInListItemAtLevel* with
  " markdownCodeBlockInListItemAtLevel* :-)
  execute 'syn region markdownFencedCodeBlockInListItemAtLevel' . (s:level) . ' '
    \ . 'contained contains=@NoSpell '
    \ . 'matchgroup=markdownFencedCodeBlockInItemDelimiter '
    \ . 'start='
    \ .   '/'
    \ .     (s:preceded_by_separator)
    \ .     '\z( \{' . (2*s:level) . ',}\|\t\{' . (s:level) . ',}\)*```\%(`*\).*$'
    \ .   '/ '
    \ . 'end=/^\z1```\%(`*\)\s*$/'
  execute 'syn region markdownFencedCodeBlockInListItemAtLevel' . (s:level) . ' '
    \ . 'contained contains=@NoSpell '
    \ . 'matchgroup=markdownFencedCodeBlockInItemDelimiter '
    \ . 'start='
    \ .   '/'
    \ .     (s:preceded_by_separator)
    \ .     '\z( \{' . (2*s:level) . ',}\|\t\{' . (s:level) . ',}\)*\~\~\~\%(\~*\).*$'
    \ .   '/ '
    \ . 'end=/^\z1\~\~\~\%(\~*\)\s*$/'
  execute 'hi def link markdownFencedCodeBlockInListItemAtLevel' . (s:level) . ' String'

  execute 'syn match markdownCodeBlockInListItemAtLevel' . (s:level) . ' '
    \ . 'contained contains=@NoSpell '
    \ . '/' . (s:preceded_by_separator) . '\%(\%( \{' . (6+2*s:level)  . ',}\|\t\{' . (1+s:level) . ',}\).*\n\?\)\+$/'
  execute 'hi def link markdownCodeBlockInListItemAtLevel' . (s:level) . ' String'

  execute 'syn region markdownH1InListItemAtLevel' . (s:level) . ' '
    \ . 'contained display oneline '
    \ . 'matchgroup=markdownHeadingDelimiter '
    \ . 'contains=@markdownInline '
    \ . 'start=/' . (s:preceded_by_separator) . (s:indented_as_content) . '#\%(\s\+\)\@=/ '
    \ . 'end=/#*\s*$/'
  execute 'syn region markdownH2InListItemAtLevel' . (s:level) . ' '
    \ . 'contained display oneline '
    \ . 'matchgroup=markdownHeadingDelimiter '
    \ . 'contains=@markdownInline '
    \ . 'start=/' . (s:preceded_by_separator) . (s:indented_as_content) . '##\%(\s\+\)\@=/ '
    \ . 'end=/#*\s*$/'
  execute 'syn region markdownH3InListItemAtLevel' . (s:level) . ' '
    \ . 'contained display oneline '
    \ . 'matchgroup=markdownHeadingDelimiter '
    \ . 'contains=@markdownInline '
    \ . 'start=/' . (s:preceded_by_separator) . (s:indented_as_content) . '###\%(\s\+\)\@=/ '
    \ . 'end=/#*\s*$/'
  execute 'syn region markdownH4InListItemAtLevel' . (s:level) . ' '
    \ . 'contained display oneline '
    \ . 'matchgroup=markdownHeadingDelimiter '
    \ . 'contains=@markdownInline '
    \ . 'start=/' . (s:preceded_by_separator) . (s:indented_as_content) . '####\%(\s\+\)\@=/ '
    \ . 'end=/#*\s*$/'
  execute 'syn region markdownH5InListItemAtLevel' . (s:level) . ' '
    \ . 'contained display oneline '
    \ . 'matchgroup=markdownHeadingDelimiter '
    \ . 'contains=@markdownInline '
    \ . 'start=/' . (s:preceded_by_separator) . (s:indented_as_content) . '#####\%(\s\+\)\@=/ '
    \ . 'end=/#*\s*$/'
  execute 'syn region markdownH6InListItemAtLevel' . (s:level) . ' '
    \ . 'contained display oneline '
    \ . 'matchgroup=markdownHeadingDelimiter '
    \ . 'contains=@markdownInline '
    \ . 'start=/' . (s:preceded_by_separator) . (s:indented_as_content) . '######\%(\s\+\)\@=/ '
    \ . 'end=/#*\s*$/'
  execute 'hi def link markdownH1InListItemAtLevel' . (s:level) . ' Title'
  execute 'hi def link markdownH2InListItemAtLevel' . (s:level) . ' Title'
  execute 'hi def link markdownH3InListItemAtLevel' . (s:level) . ' Title'
  execute 'hi def link markdownH4InListItemAtLevel' . (s:level) . ' Title'
  execute 'hi def link markdownH5InListItemAtLevel' . (s:level) . ' Title'
  execute 'hi def link markdownH6InListItemAtLevel' . (s:level) . ' Title'

  execute 'syn match markdownH1InListItemAtLevel' . (s:level) . ' '
    \ . 'display contained contains=@markdownInline,markdownHeadingDelimiterInListItemAtLevel'. (s:level) . ' '
    \ . '/' . (s:preceded_by_separator) . (s:indented_as_content) . '.\+\n' . (s:indented_as_content) . '=\+$/'
  execute 'syn match markdownH1InListItemAtLevel' . (s:level) . ' '
    \ . 'display contained contains=@markdownInline,markdownHeadingDelimiterInListItemAtLevel'. (s:level) . ' '
    \ . '/' . (s:preceded_by_separator) . (s:indented_as_content) . '.\+\n' . (s:indented_as_content) . '-\+$/'
  execute 'syn match markdownHeadingDelimiterInListItemAtLevel' . (s:level) . ' '
    \ . 'display contained '
    \ . '/^' . (s:indented_as_content) . '\%(-\+\|=\+\)$/'
  execute 'hi def link markdownH1InListItemAtLevel' . (s:level) . ' Title'
  execute 'hi def link markdownH2InListItemAtLevel' . (s:level) . ' Title'
  execute 'hi def link markdownHeadingDelimiterInListItemAtLevel' . (s:level) . ' Special'

  execute 'syn match markdownRuleInListItemAtLevel' . (s:level) . ' '
    \ . '/' . (s:preceded_by_separator) . (s:indented_as_content) . '*\*\s*\*\s*\*[[:space:]*]*$/ display'
  execute 'syn match markdownRuleInListItemAtLevel' . (s:level) . ' '
    \ . '/' . (s:preceded_by_separator) . (s:indented_as_content) . '-\s*-\s*-[[:space:]-]*$/ display'
  execute 'syn match markdownRuleInListItemAtLevel' . (s:level) . ' '
    \ . '/' . (s:preceded_by_separator) . (s:indented_as_content) . '_\s*_\s*_[[:space:]_]*$/ display'
  execute 'hi def link markdownRuleInListItemAtLevel' . (s:level) . ' Identifier'

  execute 'syn region markdownBlockquoteInListItemAtLevel' . (s:level) . ' '
    \ . 'contained '
    \ . 'contains=markdownBlockquoteDelimiterInListItemAtLevel' . (s:level) . ',@NoSpell '
    \ . 'start=/' . (s:preceded_by_separator) . (s:indented_as_content) . '\%(>\s\?\)\+\%(.\)\@=/ '
    \ . 'end=/\n\n/'
  execute 'syn match markdownBlockquoteDelimiterInListItemAtLevel' . (s:level) . ' '
    \ . 'contained '
    \ . '/^' . (s:indented_as_content) . '\%(>\s\?\)\+/'
  execute 'hi def link markdownBlockquoteInListItemAtLevel' . (s:level) . ' Comment'
  execute 'hi def link markdownBlockquoteDelimiterInListItemAtLevel' . (s:level) . ' Delimiter'

  " " the only constraint here is that the table begins at least at the same
  " " level as the list item's content, se we could reuse the previous syntactic
  " " elements, we could do that because tables could have arbitrary indentation
  execute 'syn match markdownTableInListItemAtLevel' . (s:level) . ' '
    \ . 'transparent contained contains=markdownTableHeader,markdownTableDelimiter,@markdownInline '
    \ . '/'
    \ .   '^\s*\n'
    \ .   (s:indented_as_content) . '\s*|\?\%([^|]\+|\)*[^|]\+|\?\s*\n'
    \ .   s:markdown_table_header_rows_separator . '\n'
    \ .   '\%('
    \ .     '\s*|\?\%([^|]\+|\)*[^|]\+|\?\s*\n'
    \ .   '\)*'
    \ .   '$'
    \ . '/'
endfor
hi def link markdownItemDelimiter Special
hi def link markdownFencedCodeBlockInItemDelimiter Special

" }}}

" {{{ HIGHLIGHT DEFINITION

hi def Italic                       term=italic cterm=italic gui=italic
hi def Bold                         term=bold cterm=bold gui=bold
hi def BoldItalic                   term=bold,italic cterm=bold,italic gui=bold,italic

hi def link markdownItalic                  Italic
hi def link markdownBold                    Bold
hi def link markdownBoldItalic              BoldItalic

hi def link markdownPullRequestLinkInText   Underlined
hi def link markdownUserLinkInText          Underlined
hi def link markdownUrlLinkInText           Underlined
hi def link markdownEmailLinkInText         Underlined

hi def link markdownLinkText                Underlined
hi def link markdownLinkUrl                 Underlined
hi def link markdownLinkTitleSingleQuoted   Bold
hi def link markdownLinkTitleDoubleQuoted   Bold
hi def link markdownLinkUrlContainer        Delimiter
hi def link markdownLinkTextContainer       Delimiter
hi def link markdownLinkReference           NonText

hi def link markdownCodeDelimiter           Delimiter
hi def link markdownInlineCode              String
hi def link markdownFencedCodeBlock         String
hi def link markdownCodeBlock               String

hi def link markdownTableDelimiter          Delimiter
hi def link markdownTableHeader             Bold

hi def link markdownStrike                  NonText
hi def link markdownStrikeDelimiter         Delimiter
hi def link markdownBlockquote              Comment
hi def link markdownBlockquoteDelimiter     Delimiter
hi def link markdownInlineDelimiter         Delimiter
hi def link markdownListDelimiter           Delimiter

hi def link markdownHeaderId                Delimiter
hi def link markdownHeadingDelimiter        Delimiter
hi def link markdownHeadingUnderline        Delimiter
hi def link markdownHeader                  Title
hi def link markdownH1                      Title
hi def link markdownH2                      Title
hi def link markdownH3                      Title
hi def link markdownH4                      Title
hi def link markdownH5                      Title
hi def link markdownH6                      Title

hi def link markdownRule                    Identifier

hi def link markdownXmlComment              NonText
hi def link markdownXmlElement              NonText
hi def link markdownXmlEmptyElement         NonText
hi def link markdownXmlEntities             Special

" }}}


if !exists('g:markdown_include_jekyll_support') || g:markdown_include_jekyll_support
  execute 'runtime! syntax/markdown_jekyll.vim'
endif

let b:current_syntax = "markdown"
if main_syntax ==# 'markdown'
  unlet main_syntax
endif
