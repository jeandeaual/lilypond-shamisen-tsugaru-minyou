\version "2.20.0"

\include "lilypond-shamisen/shamisen.ly"

first = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-3
  \typewriter
  " Ⅰ"
}
second = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-3
  \typewriter
  " Ⅱ"
}
third  = \markup {
  \override #'(font-name . "Libertinus Serif")
  \fontsize #-3
  \typewriter
  " Ⅲ"
}

#(set-global-staff-size 32)

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

scoreTitle = "うさぎ"
scoreMeter = "2/4 三下がり"

\header {
  title = \scoreTitle
  meter = \scoreMeter
  tagline = ##f
  subject = \markup \concat {
    "Shamisen partition for “"
    \scoreTitle
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

  \time 2/4

  fis4^\first fis8 ais |
  c'^\first ais c'4^\first |

  \break

  fis8^\first fis^\first fis^\first ais |
  c'^\first ais c'4^\first |

  \break

  ais8 c'^\first cis'^\third cis'^\third |
  c'^\first ais fis^\first f |

  \break

  ais fis^\first f4 |
  fis8^\first f f4\3^\first |
  f2 |
}

verse = \lyricmode {
  う さ ぎ う さ ぎ な に み て は ね る
  じゅ う ご や お つ き さ ま み て は _ ね る
}

\layout {
  \context {
    \Staff
    \omit TextScript
  }
  \context {
    \Score
    \omit BarNumber
  }
}

\book {
  \header {
    pdftitle = \markup \concat { \scoreTitle "（五線譜付き）" }
    meter = \markup \left-column {
      "4本（神仙）"
      \concat { \scoreMeter "（調弦 C G C）" }
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
      \addlyrics \verse
      \new TabStaff \with {
        stringTunings = #sansagariTuning
      } {
        \song
      }
    >>
    \layout {}
  }

  \score {
    \unfoldRepeats \song
    \midi {
      \tempo 4 = 80
      midiInstrument = "shamisen"
    }
  }
}

#(set-global-staff-size 42)

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 4
  system-system-spacing =
    #'((basic-distance . 5)
       (minimum-distance . 6)
       (padding . 2)
       (stretchability . 12))
  #(define fonts
    (set-global-fonts
     #:roman "IPAexGothic"
     #:factor (/ staff-height pt 20) ; unnecessary if the staff size is default
    ))
}

\layout {
  \context {
    \Score
    \override LyricText #'font-size = #-1
  }
}

\book {
  \bookOutputSuffix "tab"

  \header {
    title = \markup {
      \fontsize #-2
      \scoreTitle
    }
    meter = \markup \fontsize #-2 \scoreMeter
  }

  \score {
    \new StaffGroup <<
      % Display the system start bar even with a single staff
      % Score.SystemStartBar.collapse-height needs to be lower than the number
      % of staff lines
      \override Score.SystemStartBar.collapse-height = #2
      \new TabStaff \with {
        stringTunings = #sansagariTuning
      } {
        \song
      }
      \addlyrics \verse
    >>
  }
}
