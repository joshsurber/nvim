" syntax/x12.vim
if exists("b:current_syntax")
  finish
endif

" Core delimiters - Escape the tilde
syn match x12SegmentTerm "\~"
syn match x12ElementSep  "\*"

hi def link x12SegmentTerm Delimiter
hi def link x12ElementSep Delimiter

" Segment IDs - Escape tilde inside the very-magic group
syn match x12SegmentID "\v(^|\~)\zs[A-Z0-9]{2,3}\ze\*"
hi def link x12SegmentID Keyword

" Envelope segments - Escape tilde
syn match x12Envelope "\v(^|\~)\zs(ISA|GS|ST|SE|GE|IEA)\ze\*"
hi def link x12Envelope Statement

" Common high-value segments - Escape tildes
syn match x12Provider "\v(^|\~)\zs(NM1|REF|N3|N4|PRV)\ze\*"
syn match x12Claim    "\v(^|\~)\zs(CLP|HI|SV1|SV2|SVC|CAS|DTM)\ze\*"
syn match x12Status   "\v(^|\~)\zs(STC|AAA|IK3|IK4|IK5|AK3|AK4|AK5)\ze\*"

hi def link x12Provider Identifier
hi def link x12Claim    Type
hi def link x12Status   Constant

let b:current_syntax = "x12"
