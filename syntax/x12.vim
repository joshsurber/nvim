" syntax/x12.vim
if exists("b:current_syntax")
  finish
endif

" =====================================
" Detect separators from ISA segment
" =====================================
let firstline = getline(1)

" Default separators if ISA is missing
let sep  = '*'
let comp = ':'
let term = '~'

if firstline =~# '^ISA' && strlen(firstline) >= 106
  let sep  = firstline[3]     " 4th char: element separator
  let comp = firstline[104]   " 105th char: component separator
  let term = firstline[105]   " 106th char: segment terminator
endif

" Escape for regex (plain regex)
let sep_e  = escape(sep,  '\.^$*~[]')
let comp_e = escape(comp, '\.^$*~[]')
let term_e = escape(term, '\.^$*~[]')

" Temporary debug: show detected separators
" echom "X12 separators: sep=" . sep . ", comp=" . comp . ", term=" . term

" =====================================
" Core delimiters
" =====================================
execute 'syn match x12SegmentTerm "' . term_e . '"'
execute 'syn match x12ElementSep  "' . sep_e  . '"'
execute 'syn match x12ComponentSep "' . comp_e . '"'

hi def link x12SegmentTerm  Delimiter
hi def link x12ElementSep   Delimiter
hi def link x12ComponentSep Delimiter

" =====================================
" Segment IDs (2-3 alphanumeric chars before element separator)
" Works anywhere in the line
" =====================================
execute 'syn match x12SegmentID "[A-Z0-9]\{2,3\}' . sep_e . '"'
hi def link x12SegmentID Keyword

" =====================================
" Envelope segments
" =====================================
execute 'syn match x12Envelope "\(ISA\|GS\|ST\|SE\|GE\|IEA\)' . sep_e . '"'
hi def link x12Envelope Statement

" =====================================
" Common high-value segments
" =====================================
execute 'syn match x12Provider "\(NM1\|REF\|N3\|N4\|PRV\)' . sep_e . '"'
execute 'syn match x12Claim    "\(CLP\|HI\|SV1\|SV2\|SVC\|CAS\|DTM\)' . sep_e . '"'
execute 'syn match x12Status   "\(STC\|AAA\|IK3\|IK4\|IK5\|AK3\|AK4\|AK5\)' . sep_e . '"'

hi def link x12Provider Identifier
hi def link x12Claim    Type
hi def link x12Status   Constant

let b:current_syntax = "x12"
