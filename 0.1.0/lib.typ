#import "@preview/acrostiche:0.3.1": init-acronyms, print-index
#import "lib/research-questions.typ": init-rqs
#import "lib/utils.typ": current-academic-year


#let ugent-yellow = rgb(
  255,
  210,
  0
)
#let ugent-blue = rgb(
  30,
  100,
  200
)
#let fbw-blue = rgb(
  39,
  171,
  173
)

#let single_or_array(value) = {
  if type(value) == str [
    #value
  ] else [
    #value.join(", ")
  ]
}


#let ugent-titlepage(
  title: "<title>",
  subtitle: "<subtitle>",
  pretitle: "Master’s Dissertation submitted to Ghent University in partial fulfilment of the requirements for the degree of <select master programme>",
  authors: ("First name + last name author 1", "First name + last name author 2"),
  student_nrs: ("Student number 1", "Student number 2"),
  promotors: ("Prof. dr. First name + last name Promotor 1 ", "Prof. dr. First name + last name Promotor 2 "),
  tutors: ("First name + last name tutor 1", "First name + last name tutor 2"),
  faculty: "Faculty of Bioscience Engineering",
  date: datetime.today().display("[month repr:long] [day], [year]"),
) = {

  set document(
    author: authors,
    title: title,
  )

  set page(margin: (
    top: 30mm,
    left: 21.2mm,
    right: 21.2mm,
    bottom: 40mm
  ))
  set text(font: (
    "UGent Panno Text",
  ))
  set par(
    linebreaks: "optimized",
    // We adjust it manually
    spacing: 0pt,
  )

  let faculty_top = 25mm
  let faculty_left = 14.2mm
  // First the top part with the vub logo and triangle
  place(
    top + left,
    dx: -faculty_left,
    dy: -faculty_top,
    image(
      "template/assets/fbw_logo.png",
      width: 10cm,
    ),
  )

  
    // Overlay a semi-transparent rectangle
    place(
      top + left,
      dx: -faculty_left,
      dy: -faculty_top,
      rect(
        width: 10cm,
        height: 10cm, // Adjust height as needed
        fill: rgb(255, 255, 255, 150), // 20% opacity white overlay
      ),
    )

  // place(
  //   top + right,
  //   vub-triangle,
  // )

  // Account for space of triangle
  // v(triangle-height)

  v(1fr)

  // Title + author + date
  h(25mm)
  pad(x: 0mm)[

    #par(leading: 0.3em // Make it a bit more tight
    )[

      

      #v(5mm)

      // Title
      #text(
        size: 28pt,
        fill: ugent-blue,
        strong(
          underline(upper(title)),
        ),
      )
    ]
    #v(5mm)

    // Subtitle
    #text(
      size: 24pt,
      fill: ugent-blue,
      subtitle,
    )

    #v(3cm)

    // Authors
    #text(
      size: 16pt,
      fill: black,
      single_or_array(authors),
    )


    #v(3mm)
    
    // Student numbers
    #text(
      size: 12pt,
      fill: black,
      single_or_array(student_nrs),
    )
    #v(10mm)

    // Promotors:
    #text(
      size: 14pt,
      fill: black,
      "Promotor(s): " + single_or_array(promotors),
    )
    #v(3mm)

    // Tutors:
    #text(
      size: 14pt,
      fill: black,
      "Tutor(s): " + single_or_array(tutors),
    )

    #v(10mm)
    
    // Pretitle
      #text(
        size: 12pt,
        fill: black,
        pretitle,
      )
    
    #v(5mm)
    #text(
      size: 12pt,
      fill: black,
      "Academic year: " + current-academic-year(),
    )
  ]

  v(1fr)



  pagebreak(weak: true)
}



#let thesis(
  // The title of this thesis [content]
  title: none,
  // the authors of this thesis [array of strings]
  authors: none,
  // the font that's used for the thesis [string]
  font: "UGent Panno Text",
  // optionally align pagebreaks to odd pages [bool]
  body
) = {
  // title, authors are required (return clear error message if not given)
  assert.ne(title, none, message: "`title` is a required argument")
  assert.ne(authors, none, message: "`authors` is a required argument")

  set document(
    title: title, 
    author: authors,
  )
  
  // make new sections appear on the right hand side
  set pagebreak(weak: true, to: "odd")



  show par: set block(spacing: 20pt)
  set par(leading: 12pt, justify: true)
  set page(
    margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),  
    paper: "a4",
    numbering: "I",
    header: context {
      let elems = query(
        selector(heading).before(here()))

      let headings_at_this_page = query(
        heading.where(level: 1)
      ).find(h => h.location().page() == here().page())

      let page_has_no_heading = headings_at_this_page == none 

      if elems.len() != 0 and page_has_no_heading {
        let body = elems.last().body
        align(right, emph(body))
      }
    },
  )
  
  show heading.where(
    level: 1
  ): it => {
    pagebreak()
    text(size: 26pt, it)
    v(1.25em)
  }

  show heading.where(
    level: 2
  ): it => {
    text(size: 22pt, it)
    v(1em)
  }
  
  show heading.where(
    level: 3
  ): it => {
    text(size: 17pt, it)
    v(.75em)
  }
  
  set text(font: font)
  // don't break up words in justified text
  set text(hyphenate: false)

  body
}

#let main-content(body) = {
  set heading(numbering: "1.1", supplement: "Chapter")

  set page(numbering: "1")
  counter(page).update(1)

  body
}

// whether to show text black or white based on background colour
#let bw-text(colour) = {
  if oklab(colour).components().at(0) > 70% {
    black
  } else {
    white
  }
}

#let acronyms(
  acros: (
    "ML": "Machine Learning",
    "AI": "Artificial Intelligence",
  )
) = {
  init-acronyms(acros)
}

#let show-acronyms() = {
  print-index()
}

#let rqs(
  questions: ("RQ1": "What is the impact of X on Y?",)
) = {
  init-rqs(questions)
}
