\version "2.20.0"

\include "lilypond-shamisen/shamisen.ly"

first  = \markup { \typewriter \fontsize #-6 "Ⅰ" }
second = \markup { \typewriter \fontsize #-6 "Ⅱ" }
third  = \markup { \typewriter \fontsize #-6 "Ⅲ" }

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
  title = "さくらさくら"
  meter = "4/4 二上り"
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

main = \repeat unfold 2 {
  <f' g>4^\first q^\first g'^\third r
}

song = {
  \shamisenNotation
  \set TabStaff.tablatureFormat = #(custom-tab-format tsugaru-signs-ascii)

  \time 4/4

  \main

  \repeat unfold 2 {
    f'^\first g'^\first
    aes'^\second g'^\first
    f'^\first g'8^\third f'^\first \hajiki
    des'4\2^\second r

    \break

    c'4 aes^\first
    c' des'^\first
    c' c'8 aes^\first
    g4 r
  }

  \main

  \break

  bes^\first c'
  des'^\first r
  g'8^\third f'^\first \hajiki des'4\2^\second
  <g c'>2
}

verse = \lyricmode {
  さ く ら さ く ら
  や よ い の そ ら _ は
  み わ た す か ぎ _ り
  か す み か く も _ か
  に お い ぞ い ず _ る
  い ざ や い ざ や
  み _ に ゆ _ か ん
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
        stringTunings = #niagariTuning
      } {
        \song
      }
      \addlyrics \verse
    >>
  }

  \score {
    \unfoldRepeats \song
    \midi {
      \tempo 4 = 110
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
      \numericTimeSignature
      \stripShamisenArticulations \song
    }
    \addlyrics \verse
    \new TabStaff \with {
      stringTunings = #niagariTuning
    } {
      \song
    }
  >>
}
