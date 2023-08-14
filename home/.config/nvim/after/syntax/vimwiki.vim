syntax match JournalDone /^\s*- \[X\]\s.*/     " lines containing 'done'  items: ×
syntax match JournalCancelled /^\s*- \[-\]\s.*/    " lines containing 'note'  items: -
syntax match JournalMoved /^\s*- \[>\]\s.*/    " lines containing 'moved' items: >
syntax match JournalNote /^\s*- \w.*/    " lines containing 'note'  items: -
syntax match JournalEvent /^\s*\* .*/    " lines containing 'event' items: o
