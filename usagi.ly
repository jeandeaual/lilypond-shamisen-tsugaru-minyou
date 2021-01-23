\version "2.20.0"

\include "lilypond-shamisen/shamisen.ly"

#(set-global-staff-size 36)

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 5
  system-system-spacing.padding = 2
  #(define fonts
    (set-global-fonts
     #:roman "IPAexGothic"
     #:factor (/ staff-height pt 20) ; unnecessary if the staff size is default
    ))
}

\header {
  title = "うさぎ"
  meter = "2/4 三下がり"
  tagline = ##f
  subject = \markup \concat {
    "Shamisen partition for “"
    \fromproperty #'header:title
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
  \set TabStaff.tablatureFormat = #(custom-tab-format tsugaru-signs-ascii)

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
  \paper {
    system-system-spacing =
      #'((basic-distance . 5)
         (minimum-distance . 6)
         (padding . 2)
         (stretchability . 12))
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

  \score {
    \unfoldRepeats \song
    \midi {
      \tempo 4 = 80
      midiInstrument = "shamisen"
    }
  }
}

\book {
  \bookOutputSuffix "score"

  \header {
    pdftitle = \markup \concat { \fromproperty #'header:title " (Score)" }
  }

  \new StaffGroup <<
    \new Staff {
      \clef "treble_8"
      \stripShamisenArticulations \song
    }
    \addlyrics \verse
    \new TabStaff \with {
      stringTunings = #sansagariTuning
    } {
      \song
    }
  >>
}
