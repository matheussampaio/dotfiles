syntax keyword liCommand display fields filter stats sort limit parse
syntax keyword liOperator as like and or not

" numeric operators
syntax keyword liNumericOperator abs ceil floor greatest least log sqrt

syntax keyword liGeneralFunction ispresent coalesce
syntax keyword liStringFunction isempty isblank concat ltrim rtrim trim strlen toupper tolower substr replace strcontains
syntax keyword liDateFunction datefloor dateceil fromMillis toMillis
syntax keyword liIpFunction isValidIp isValidIpV4 isValidIpV6 isIpInSubnet isIpv4InSubnet isIpv6InSubnet
syntax keyword liStatFunction avg max count min pct stddev sum earliest latest sortsFirst sortsLast


" Strings: '.*'
syntax match liString "'.*'"
syntax match liString '".*"'

" Regex: /.*/
syntax match liRegex '/.*/'

" Comment: #.*$
syntax match liComment '#.*$'

" Number: \d+
syntax match liNumber '\d'

highlight default link liCommand Keyword
highlight default link liOperator Keyword
highlight default link liNumericOperator jsFuncName
highlight default link liGeneralFunction jsFuncName
highlight default link liStringFunction jsFuncName
highlight default link liDateFunction jsFuncName
highlight default link liIpFunction jsFuncName
highlight default link liStatFunction jsFuncName
highlight default link liNumber Number
highlight default link liString String
highlight default link liRegex String
highlight default link liComment Comment

