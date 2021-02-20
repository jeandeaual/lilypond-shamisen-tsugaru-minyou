\version "2.20.0"

\include "lilypond-shamisen/shamisen.ly"

first = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-5
  \typewriter
  " Ⅰ"
}
second = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-5
  \typewriter
  " Ⅱ"
}
third  = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-5
  \typewriter
  " Ⅲ"
}

#(set-global-staff-size 30)

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 4
  system-system-spacing.padding = 1
  #(define fonts
    (set-global-fonts
     #:roman "IPAexGothic"
     #:factor (/ staff-height pt 20) ; unnecessary if the staff size is default
    ))
}

\header {
  title = "津軽じょんがら節六段ー1段"
  subtitle = "オリンピックバージョン"
  meter = "二上り"
  tagline = ##f
  subject = \markup \concat {
    "Shamisen partition for “"
    \fromproperty #'header:title
    " ("
    \fromproperty #'header:subtitle
    ")"
    "”."
  }
  keywords = #(string-join '(
    "music"
    "partition"
    "shamisen"
  ) ", ")
}

song = {
  \shamisenNotation
  \set TabStaff.tablatureFormat = #(custom-tab-format tsugaru-signs-with-sharps-and-flats)
  \set Staff.ottavationMarkups = #ottavation-ordinals
  \override Staff.OttavaBracket.font-series = #'small

  \time 2/4

  c4 dis^\first |
  f^\third ais^\first |
  \trtr { c'16\2^\third ais^\third\hajiki g\sukui g\hajiki^\first } f4^\third |
  \time 7/8
  \trtr { f16^\third dis^\third\hajiki c\sukui c\hajiki^\first } c4. f4^\first |
  \time 2/4
  \slurDown
  \set TabStaff.minimumFret = #5
  \set TabStaff.restrainOpenStrings = ##t
  g^\third g |
  g_\markup{ \fontsize #-7 "スリ" }( ais) |
  \set TabStaff.minimumFret = #10
  ais( c') |
  \repeat unfold 2 {
    c'( d') |
    d'( c') |
  }
  c'( ais) |
  \set TabStaff.minimumFret = #5
  ais( g) |
  \time 1/4
  g( |
  \set TabStaff.minimumFret = #0
  \set TabStaff.restrainOpenStrings = ##f
  \time 17/32
  f8) f \trtr { f16^\third dis^\third\hajiki c16.\hajiki^\first } dis16^\first |
  \time 7/16
  dis8^\first dis^\first f^\third ais16^\first |
  \time 2/4
  g8 f^\third g ais^\first |
  c'8\2^\third dis'16^\first dis'\hajiki^\third c'8 ais8^\first |
  c'8\2^\third c'\2\sukui c'\2^\third c'\2^\third |
  \trtr { c'16\2^\third ais^\third\hajiki g\sukui g\hajiki^\first } ais8^\first ais |
  c'8\2^\third dis'^\first f'^\first g'^\first |
  g'^\first ais'\sukui^\first c''^\first d''^\first |
  \ottava #1
  \repeat unfold 2 {
    f''^\first a''16 16\sukui 8 8 |
    a''^\first a''\sukui g'' g'' |
  }
  f''8 f''\sukui g''^\third g''^\third |
  \time 3/4
  f''8 8\hajiki 16\sukui 16\hajiki d''8 8\hajiki 16\sukui 16\hajiki |
  \time 2/4
  c''8^\first c'' d''^\third d'' |
  \time 3/4
  c''8 8\hajiki 16\sukui 16\hajiki ais'8 8\hajiki 16\sukui 16\hajiki |
  \ottava #0
  \time 2/4
  g'8 g'\sukui ais'^\third ais'^\third |
  g'^\first ais'^\third g'^\first f'^\first |
  g'^\third f'^\first g'^\third f'^\third |
  \repeat unfold 2 {
    \trtr { f'16^\third dis'^\third\hajiki c'\sukui c'\hajiki^\first } dis'8^\first f'^\first |
    g'^\third g'\sukui g' f'^\third |
  }
  \repeat percent 3 {
    \trtr { f'16^\third dis'^\third\hajiki c'\sukui c'\hajiki^\first } dis'8^\first f'^\first |
  }
  \time 1/4
  \repeat percent 3 {
    \trtr { f'16^\third dis'^\third\hajiki c'\sukui c'\hajiki^\first } |
  }
  \time 2/4
  c'8 ais^\first c'\2^\third c'\2\sukui^\third |
  c'\2^\third c'16\2^\third ais\hajiki^\third c'8\2^\third r |
  <c c'\2 c'>4 q |
}

\layout {
  \context {
    \Staff
    \omit TextScript
    \omit TimeSignature
  }
  \context {
    \Score
    \omit BarNumber
  }
}

\book {
  \header {
    pdftitle = \markup \concat { \fromproperty #'header:title "（楽譜）" }
    meter = \markup \left-column {
      "4本（神仙）"
      "二上り（調弦 C G C）"
    }
  }

  \score {
    \new StaffGroup <<
      \new Staff {
        \clef "treble_8"
        \numericTimeSignature
        \stripShamisenArticulations \song
        \bar "|."
      }
      \new TabStaff \with {
        stringTunings = #niagariTuning
      } {
        \song
      }
    >>
    \layout {}
  }

  \score {
    \unfoldRepeats \song
    \midi {
      \tempo 4 = 110
      midiInstrument = "shamisen"
    }
  }
}

#(set-global-staff-size 36)

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 4
  system-system-spacing =
    #'((basic-distance . 5)
       (minimum-distance . 5)
       (padding . 1.2)
       (stretchability . 12))
  #(define fonts
    (set-global-fonts
     #:roman "IPAexGothic"
     #:factor (/ staff-height pt 20) ; unnecessary if the staff size is default
    ))
}

\book {
  \bookOutputSuffix "tab"

  \header {
    pdftitle = \markup \fromproperty #'header:title
  }

  \score {
    \new StaffGroup <<
      % Display the system start bar even with a single staff
      % Score.SystemStartBar.collapse-height needs to be lower than the number
      % of staff lines
      \override Score.SystemStartBar.collapse-height = #2
      \new TabStaff \with {
        stringTunings = #niagariTuning
      } {
        \song
      }
    >>
  }
}
