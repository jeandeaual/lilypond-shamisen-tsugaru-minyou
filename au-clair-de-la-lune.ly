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

\paper{
  indent = 0\mm
  markup-system-spacing.padding = 4
  system-system-spacing.padding = 1
  #(define fonts
    (set-global-fonts
     #:roman "IPAexGothic"
     #:factor (/ staff-height pt 20) ; unnecessary if the staff size is default
    ))
}

scoreTitle = "Au clair de la lune"
scoreMeter = "4/4 二上り"

\header {
  pdftitle = \scoreTitle
  title = \markup {
    \override #'(font-name . "C059 Roman")
    \scoreTitle
  }
  meter = \scoreMeter
  subject = \markup \concat {
    "Shamisen partition for “"
    \scoreTitle
    "”."
  }
  source = "https://en.wikipedia.org/wiki/Au_clair_de_la_lune"
  keywords = #(string-join '(
    "music"
    "partition"
    "shamisen"
  ) ", ")
  tagline = ##f
}

main = {
  g4 g g a | b2 a | g4 b a a | g1 |
}

song = {
  \shamisenNotation
  \set TabStaff.tablatureFormat = #(custom-tab-format tsugaru-signs-with-sharps-and-flats)

  \time 4/4

  \main
  \break
  \main
  \break
  a4 a a a | e2 e | a4 g fis e | d1 |
  \break
  \main
}

verse = \lyricmode {
  \override LyricText #'font-name = "C059 Roman"
  Au clair de la lu -- ne,
  Mon a -- mi Pier -- rot,
  Prê -- te -- moi ta plu -- me
  Pour é -- crire un mot.
  Ma chan -- delle est mor -- te,
  Je n’ai plus de feu ;
  Ou -- vre -- moi ta por -- te,
  Pour l’a -- mour de Dieu.
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
      \tempo 4 = 105
      midiInstrument = "shamisen"
    }
  }
}

#(set-global-staff-size 42)

\paper{
  indent = 0\mm
  markup-system-spacing.padding = 4
  system-system-spacing =
    #'((basic-distance . 5)
       (minimum-distance . 6)
       (padding . 3)
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
        stringTunings = #niagariTuning
      } {
        \song
      }
      \addlyrics \verse
    >>
  }
}
