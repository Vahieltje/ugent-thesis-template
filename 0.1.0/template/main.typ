#import "@local/ugent-thesis-template:0.1.0": thesis, acronyms, ugent-titlepage

#ugent-titlepage(
  title: "Higher order interactions",
  subtitle: "Your Thesis Subtitle",
  authors: ("Thomas Van Giel"),
  student_nrs: ("01501578"),
  promotors: ("Prof. dr. John Smith", "Prof. dr. Jane Smith"),
  tutors: ("Dr. John Tutor", "Dr. Jane Tutor"),
  faculty: "Faculty of Bioscience Engineering",
  date: datetime.today().display("[month repr:long] [day], [year]")
)

#show: thesis.with(
  title: [A UGent Master's Dissertation Created Using Typst],
  authors: ("John Doe",),
  font: "New Computer Modern"
)

#acronyms(
  acros: (
    "ML": "Machine Learning",
    "AI": "Artificial Intelligence",
  )
)

= List of figures etc.
#lorem(200)

= Introduction
// #todo[Write this thesis]
#lorem(2000) 

= Continue
#lorem(200)
