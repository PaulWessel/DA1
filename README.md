# DA1
Material for Volume 1 of Data Analysis Book

In order to build the DA1 book from source you will need some prerequisites:

	1. A recent GMT installation 6.x or higher
	2. The latex/pdflatex packages (TeTex, Live Tex, etc)

STUDENT BOOK:

If you have all prerequisites then you can build DA1_students.pdf by typing

make student

If you get errors it is probably related to missing prerequisite tools and libraries.

INSTRUCTOR BOOK:

Instructors need to get a copy of the private repository DA1_Answers and
place that directory at the same level as the DA1 directory is.
Then, you will just type

make instructor

See GNUmakefile for how details.
