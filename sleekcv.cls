\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{sleekcv}[2022-10-11 v0.0.9 sleek curriculum vitae document class]

\DeclareOption{a4paper}{
	\setlength\paperheight{297mm}
	\setlength\paperwidth{210mm}
}

% font size options
\newcommand\@ptsize{}
\DeclareOption{11pt}{\renewcommand\@ptsize{0}}

% execute default options
\ExecuteOptions{a4paper,11pt}

% process given options
\ProcessOptions\relax
\input{size1\@ptsize.clo}

\RequirePackage{anyfontsize}% allows selection of different font sizes
\RequirePackage[english]{babel} % correctly and automatically hyphenate english words
\RequirePackage{changepage}% changes column width
\RequirePackage{eso-pic}% creates the gray rectangle in the background
\RequirePackage{etoolbox}% provides \AfterEndPreamble
\RequirePackage{fontspec}% allows changing fonts settings
\RequirePackage{setspace}% changes space between lines
\RequirePackage{tikz}% creates the rectangle aroung the name+profession
\RequirePackage{xcolor}% allows color picking

\PassOptionsToPackage{pdfpagelabels=false}{hyperref}% supress annoying hyperref warning
\RequirePackage[hidelinks]{hyperref}% enables hypertext links in the document

\RequirePackage{float}% allows us to create a figure environment as if this was an article class
\newfloat{figure}{htbp}{figs}

\RequirePackage{paracol}% allows multiple columns
% \backgroundcolor{c[0]}[rgb]{1,0.8,1} % visualize left  column
% \backgroundcolor{c[1]}[rgb]{1,1,0.8} % visualize right column

\RequirePackage{geometry}% changes page margins and overall layout
% \RequirePackage[showframe]{geometry} % shows the page layout
% \RequirePackage{layout} % shows the page layout and dimensions of the layout as an image
\geometry{
	a4paper,
	left=0.62in,
	right=0.62in,
	top=0.42in,
	bottom=0.55in,
	marginparwidth=0in,		% remove margin notes
	marginparsep=0in,		% remove margin notes
	headheight=0in,			% remove header
	headsep=0in,			% remove header
	footskip=0in			%remove footer
}

% sets a gray vertical rectangle as background
\AddToShipoutPictureBG{\color[RGB]{244,244,244}%
	\AtPageLowerLeft{\rule{2.55in}{\paperheight}}} % this lines defines the rectangle position (lower left) and sizes(width = 2.57 inches, height = current paperheight (297mm))

\color[RGB]{33,33,33}% sets the default color for the document
\definecolor{softblack}{RGB}{33,33,33}% gives a name to that color

\newfontfamily{\mtstitle}[LetterSpace=12]{Montserrat}% creates a new font family with more spacing for the title
\newfontfamily{\mtssubtitle}[LetterSpace=24]{Montserrat}% even more spacing
\newfontfamily{\mtsl}[UprightFont={* Light}]{Montserrat}% creates a new font family for the light version of Montserrat

\pagenumbering{gobble}% disables page numbering

\newcommand*{\defname}[2]{\def\firstname{#1}\def\lastname{#2}}% sets name and last name

\newcommand*{\defprofession}[1]{\def\profession{#1}}% sets profession

% HACK: the line below is a hack that affects the spacing between every float and the underlying text. Shouldn't be a problem since this is the only float we're going to use.
\setlength{\intextsep}{0.41in plus 2.0pt minus 2.0pt} % changes spacing between title and text
\newcommand*{\cvheader}{
	% creates the rectangle that contains the name and profession
	\begin{figure}[!ht]
		\centering
		\begin{tikzpicture}
			\node[rectangle, draw, fill=white, very thick, align=center, font=\setstretch{2}, minimum width = 4.4in, minimum height = 1.5in] (r) at (0,0)
			{%
				{\mtstitle \fontsize{18}{21.6}\selectfont \textbf{\firstname~\lastname}}\\%
				{\mtsl \fontsize{10}{12}\selectfont \profession}%
			};
		\end{tikzpicture}
	\end{figure}
}

% \AfterEndPreamble code is part of the document body. Therefore, we can instantiate our header and initialize our two columns.
\AfterEndPreamble{
	\cvheader%
	\fontspec{Montserrat}%
	\begin{paracol}{2}%
}

% \AtEndDocument is still considered as being part of the document body. Therefore, we can finalize our multi-column document.
\AtEndDocument{\end{paracol}}

\newcommand*{\cventry}[2][]{%
	\def\temp{#1}\ifx\temp\empty% tests if subtitle is empty
	{\fontsize{7.03}{8.44}\selectfont #2}%
	\else% 		if it's not empty...
	{\fontsize{6.47}{7.76}\selectfont \textbf{#1}}% prints subtitle
	\vspace{0.03in}\newline%	... prints a newline so we have a space between subtitle and content
	{\fontsize{7.03}{8.44}\selectfont #2}%
	\fi
	\vspace{0.12in}\newline% defines spacing between each entry
}

\newcommand*{\cvimplicitlink}[2]{%
	%	\vspace{0.14in}\newline% defines spacing between each entry
	{\underline{\href{#2}{#1}}}% prints subtitle
	\vspace{0.12in}\newline% defines spacing between each entry
}

\newcommand*{\cvexplicitlink}[3][]{%
	\def\temp{#1}\ifx\temp\empty% tests if subtitle is empty
	{\fontsize{7.03}{8.44}\selectfont \href{#3}{#2}}%
	\else% 		if it's not empty...
	{\fontsize{6.47}{7.76}\selectfont \textbf{#1}}% prints subtitle
	\vspace{0.03in}\newline%	... prints a newline so we have a space between subtitle and content
	{\fontsize{7.03}{8.44}\selectfont \href{#3}{#2}}%
	\fi
	\vspace{0.12in}\newline% defines spacing between each entry
}

\newcommand*{\cvemail}[3][]{%
	\def\temp{#1}\ifx\temp\empty% tests if subtitle is empty
	{\fontsize{7.03}{8.44}\selectfont \href{mailto:#3}{#2}}%
	\else% 		if it's not empty...
	{\fontsize{6.47}{7.76}\selectfont \textbf{#1}}% prints subtitle
	\vspace{0.03in}\newline%	... prints a newline so we have a space between subtitle and content
	{\fontsize{7.03}{8.44}\selectfont \href{mailto:#3}{#2}}%
	\fi
	\vspace{0.12in}\newline% defines spacing between each entry
}

% based on https://tex.stackexchange.com/questions/238898/in-line-graphics-in-text-to-represent-a-loading-bar-for-language-skills-in-a-cv
\newcommand{\cvgrade}[2]{%
	#1\newline\vspace{-0.11in}\newline% prints subtitle
	\begin{tikzpicture}
%		\draw [fill=red] (1.2em -.32em,-.32em) rectangle (6em +.32em ,.32em);% visualize outer clipping box
		\clip (1.2em -.32em,-.32em) rectangle (6em +.32em ,.32em);
		\begin{scope}
%			\draw [color=green] (1.2em -.32em,-.32em) rectangle (1.2*#2 em +.54em ,.32em);% visualize inner clipping box
			\clip (1.2em -.32em,-.32em) rectangle (1.2*#2 em +.6em ,.32em);
			\foreach \x in {1,2,...,5}{
				\path [fill=softblack] (1.2*\x em,0) circle [radius=0.27em];
			}
		\end{scope}
		\foreach \x in {1,2,...,5}{
			\draw [thick] (1.2*\x em,0) circle [radius=0.27em];
		}
	\end{tikzpicture}%
	\vspace{0.12in}\newline% defines spacing between each entry
}

\newenvironment{margcol}{%
	\switchcolumn[0]*%
	\fontsize{8.43}{10.12}\selectfont%
	\begin{adjustwidth}{0in}{1.93in}%
		\sloppy%
	}{
	\end{adjustwidth}
}

\newenvironment{margsection}[1][]{%
	{\raggedright \par}%
	{\mtssubtitle \noindent\textbf{#1}}%
	\vspace{0.09in}\hrule height 0.8pt \relax\vspace{0.16in}\noindent%
}{\vspace{0.05in}}

\newenvironment{bodycol}{%
	\switchcolumn[1]%
	\begin{adjustwidth}{-1.37in}{0in}%
		\sloppy%
	}{
	\end{adjustwidth}
}