" syntax/x12.vim
if exists("b:current_syntax")
  finish
endif

" =====================================
" Detect separators from ISA segment
" Note: assumes no leading BOM or whitespace on line 1.
" strlen() counts bytes; non-ASCII separators (unusual in X12) would need
" strcharlen() / strgetchar() instead.
" =====================================
let s:firstline = getline(1)
let s:sep  = '*'
let s:comp = ':'
let s:term = '~'

if s:firstline =~# '^ISA' && strlen(s:firstline) >= 106
  let s:sep  = s:firstline[3]
  let s:comp = s:firstline[104]
  let s:term = s:firstline[105]
endif

" Escape for use in regex atom context (outside character classes)
let s:sep_e  = escape(s:sep,  '\.^$*~[]')
let s:comp_e = escape(s:comp, '\.^$*~[]')
let s:term_e = escape(s:term, '\.^$*~[]')

" Escape for use inside a [] character class:
" Inside [], the meaningful specials are ] \ ^ - so escape those.
let s:sep_c  = escape(s:sep,  '\]^-')
let s:comp_c = escape(s:comp, '\]^-')
let s:term_c = escape(s:term, '\]^-')

" Convenience: "not a separator" atom used repeatedly
let s:ns = '[^' . s:sep_c . s:term_c . ']'

" =====================================
" Core delimiters
" Define separate groups so each can be re-linked independently later.
" =====================================
execute 'syn match x12SegmentTerm   "' . s:term_e . '"'
execute 'syn match x12ElementSep    "' . s:sep_e  . '"'
execute 'syn match x12ComponentSep  "' . s:comp_e . '"'

hi def link x12SegmentTerm   Delimiter
hi def link x12ElementSep    Delimiter
hi def link x12ComponentSep  Delimiter

" =====================================
" Segment ID anchor: \%(^\|<sep>\)\zs
" Reused as a string to keep patterns readable.
" =====================================
let s:anchor = '\%(^\|' . s:sep_e . '\)\zs'

" =====================================
" Generic segment IDs (2-3 alphanum before sep).
" Explicitly excludes envelope IDs so the groups are mutually exclusive
" by pattern rather than by definition order.
" =====================================
execute 'syn match x12SegmentID'
  \ '"' . s:anchor
  \ . '\%(\%(ISA\|GS\|ST\|SE\|GE\|IEA\)\|'
  \ . '\%(NM1\|REF\|DTP\|CAS\|SBR\|STC\|AAA\|IK3\|IK4\|IK5\|AK3\|AK4\|AK5\|'
  \ .         'CLP\|HI\|SV1\|SV2\|SVC\|N3\|N4\|PRV\)\)\@!'
  \ . '[A-Z0-9]\{2,3\}\ze' . s:sep_e . '"'

hi def link x12SegmentID Keyword

" =====================================
" Envelope segments (highest priority — defined after x12SegmentID)
" =====================================
execute 'syn match x12Envelope'
  \ '"' . s:anchor
  \ . '\%(ISA\|GS\|ST\|SE\|GE\|IEA\)\ze' . s:sep_e . '"'

hi def link x12Envelope Statement

" =====================================
" Provider / name / reference segments
"
" Two tiers per segment type:
"   x12Provider      — segment ID alone         (e.g. "PRV", "N3")
"   x12ProviderQual  — segment ID + qualifier   (e.g. "NM1*85", "REF*1K")
"
" Qualifier-bearing matches are intentionally broad so qualifiers are
" visible when scanning the file.  They are defined AFTER the bare-ID
" matches so Vim's last-match rule makes qualifier patterns win on overlap.
" =====================================
execute 'syn match x12Provider'
  \ '"' . s:anchor . '\%(N3\|N4\|PRV\)\ze' . s:sep_e . '"'

execute 'syn match x12ProviderQual'
  \ '"' . s:anchor . '\%(NM1\|REF\)' . s:sep_e . s:ns . '\+\ze' . s:sep_e . '"'

hi def link x12Provider     Identifier
hi def link x12ProviderQual Identifier

" =====================================
" Claim segments
" =====================================
execute 'syn match x12Claim'
  \ '"' . s:anchor . '\%(CLP\|HI\|SV1\|SV2\|SVC\)\ze' . s:sep_e . '"'

execute 'syn match x12ClaimQual'
  \ '"' . s:anchor . '\%(DTP\|CAS\)' . s:sep_e . s:ns . '\+\ze' . s:sep_e . '"'

hi def link x12Claim     Type
hi def link x12ClaimQual Type

" =====================================
" Status segments
" =====================================
execute 'syn match x12Status'
  \ '"' . s:anchor . '\%(STC\|AAA\|IK3\|IK4\|IK5\|AK3\|AK4\|AK5\)\ze' . s:sep_e . '"'

execute 'syn match x12StatusQual'
  \ '"' . s:anchor . 'SBR' . s:sep_e . s:ns . '\+\ze' . s:sep_e . '"'

hi def link x12Status     Constant
hi def link x12StatusQual Constant

" =====================================
" Sync: segments always start at column 0 after ftplugin splitting,
" so a single-line sync is sufficient and avoids full-file rescans.
" =====================================
syn sync minlines=1

let b:current_syntax = "x12"
