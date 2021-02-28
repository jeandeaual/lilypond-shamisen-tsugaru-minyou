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

scoreTitle = "津軽じょんがら節六段ー1段"
scoreSubtitle = "オリンピックバージョン"
scoreMeter = "二上り"

\header {
  pdftitle = \markup \concat { \scoreTitle "　" \scoreSubtitle }
  title = \markup {
    \override #'(baseline-skip . 3.25)
    \center-column {
      \scoreTitle
      \fontsize #-3
      \scoreSubtitle
    }
  }
  meter = \scoreMeter
  tagline = ##f
  subject = \markup \concat {
    "Shamisen partition for “"
    \scoreTitle
    " ("
    \scoreSubtitle
    ")"
    "”."
  }
  keywords = #(string-join '(
    "music"
    "partition"
    "shamisen"
  ) ", ")
}

% From https://lilypond.1069038.n5.nabble.com/Hammer-on-and-pull-off-td208307.html
after = #(define-music-function (t e m) (ly:duration? ly:music? ly:music?)
  #{
    \context Bottom <<
      #m
      { \skip $t <> -\tweak extra-spacing-width #empty-interval $e }
    >>
  #})

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
  \after 8 -\tweak X-offset #-0.25 _\markup{ \fontsize #-7 "スリ" } g( ais) |
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
  \break
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
    pdftitle = \markup \concat { \scoreTitle "　" \scoreSubtitle "（五線譜付き）" }
    meter = \markup {
      \override #'(baseline-skip . 3)
      \left-column {
        "4本（神仙）"
        \concat { \scoreMeter "（調弦 C G C）" }
      }
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

#(set-global-staff-size 50)

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 1
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
  oddHeaderMarkup = \markup \fill-line { " " \fontsize #-4 \on-the-fly #not-first-page \fromproperty #'page:page-number-string }
  evenHeaderMarkup = \markup \fill-line { \fontsize #-4 \on-the-fly #not-first-page \fromproperty #'page:page-number-string " " }
}

\book {
  \bookOutputSuffix "tab"

  \header {
    title = \markup {
      \override #'(baseline-skip . 2)
      \center-column {
        \fontsize #-3.5
        \scoreTitle
        \fontsize #-6.5
        \scoreSubtitle
      }
    }
    meter = \markup \fontsize #-3.5 \scoreMeter
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
