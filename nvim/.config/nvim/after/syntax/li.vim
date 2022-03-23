syntax keyword liCommand display fields filter stats sort limit parse
syntax keyword liOperator as like and or not

" Stat functions
syntax keyword liStatFunction count\_distinct

" numeric operators
syntax keyword liNumericOperator abs ceil floor greatest least log sqrt

" Strings: '.*'
syntax match liString "'.*'"

" Regex: /.*/
syntax match liRegex '/.*/'

" Comment: #.*$
syntax match liComment '#.*$'

" Number: \d+
syntax match liNumber '\d'

highlight default link liCommand Keyword
highlight default link liOperator Keyword
highlight default link liStatFunction jsFuncName
highlight default link liNumericOperator jsFuncName
highlight default link liNumber Number
highlight default link liString String
highlight default link liRegex String
highlight default link liComment Comment

