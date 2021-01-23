\version "2.20.0"

\include "lilypond-shamisen/shamisen.ly"

#(set-global-staff-size 36)

\paper{
  indent = 0\mm
  markup-system-spacing.padding = 5
  system-system-spacing.padding = 2
  #(define fonts
    (set-global-fonts
     #:roman "IPAexGothic"
     #:factor (/ staff-height pt 20) ; unnecessary if the staff size is default
    ))
}

songTitle = "Au clair de la lune"

\header {
  pdftitle = \songTitle
  title = \markup {
    % \override #'(font-name . "Libertinus Serif")
    \override #'(font-name . "C059 Roman")
    \songTitle
  }
  meter = "4/4 二上り"
  subject = \markup \concat {
    "Shamisen partition for “"
    \songTitle
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

song = \relative c''' {
}

song = {
  \shamisenNotation
  \set TabStaff.tablatureFormat = #(custom-tab-format tsugaru-signs-ascii)

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
  % \override LyricText #'font-name = "Libertinus Serif"
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
      \tempo 4 = 105
      midiInstrument = "shamisen"
    }
  }
}

\book {
  \bookOutputSuffix "score"

  \header {
    pdftitle = \markup \concat { \songTitle " (Score)" }
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
