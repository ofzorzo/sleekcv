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

\RequirePackage{paracol}% allows multiple columns
\RequirePackage{eso-pic}% creates the gray rectangle in the background
\RequirePackage{xcolor}% allows color picking
\RequirePackage{tikz}% creates the rectangle aroung the name+profession
\RequirePackage{fontspec}% allows changing fonts settings
\RequirePackage{anyfontsize}% allows selection of different font sizes
\RequirePackage{fix-cm}
\RequirePackage{setspace}% changes space between lines
% \RequirePackage[showframe]{geometry} % shows the page layout
% \RequirePackage{layout} % shows the page layout and dimensions of the layout as an image
\RequirePackage{geometry}% changes page layout
\RequirePackage{changepage}% changes column width
\PassOptionsToPackage{pdfpagelabels=false}{hyperref}
\RequirePackage[hidelinks]{hyperref}%

\RequirePackage[english]{babel} % correctly and automatically hyphenate english words
\RequirePackage{lipsum}
\usepackage{lmodern}

% \backgroundcolor{c[0]}[rgb]{1,0.8,1} % visualize left  column
% \backgroundcolor{c[1]}[rgb]{1,1,0.8} % visualize right column

\geometry{
	total={210mm,297mm}, 	% set A4 size
	left=0.62in,				% make margins equal in every side
	right=0.62in,				% make margins equal in every side
	top=0.42in,				% make margins equal in every side
	bottom=0.55in,				% make margins equal in every side
	marginparwidth=0in,		% remove margin notes
	marginparsep=0in,		% remove margin notes
	headheight=0in,			% remove header
	headsep=0in,			% remove header
	footskip=0in			%remove footer
}

% sets the gray rectangle as background
\AddToShipoutPictureBG{\color[RGB]{244,244,244}%
	\AtPageLowerLeft{\rule{2.57in}{\paperheight}}} % this lines defines the rectangle position (lower left) and sizes(width = 2.57 inches, height = current paperheight (297mm))

\color[RGB]{33,33,33}

\newfontfamily{\mtstitle}[LetterSpace=12]{Montserrat} % creates a new font family with more spacing for the title
\newfontfamily{\mtssubtitle}[LetterSpace=24]{Montserrat}
\newfontfamily{\mtsl}[UprightFont={* Light}]{Montserrat} % creates a new font family for the light version of Montserrat

\pagenumbering{gobble} % disables page numbering

\newcommand*{\defname}[2]{\def\firstname{#1}\def\lastname{#2}}

\newcommand*{\defprofession}[1]{\def\profession{#1}}

\usepackage{float}
\newfloat{figure}{htbp}{figs}

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
\AtBeginDocument{\global\expandafter\let \csname @nodocument\endcsname \relax
	\cvheader%
	\fontspec{Montserrat}%
	\begin{paracol}{2}%
}
\AtEndDocument{\end{paracol}}

\newenvironment{margcol}{%
    \switchcolumn[0]*%
    \fontsize{8.4}{10.08}\selectfont%
    \begin{adjustwidth}{0in}{1.91in}%
    \sloppy%
}{
    \end{adjustwidth}
}

\newenvironment{bodycol}{%
    \switchcolumn[1]%
    \begin{adjustwidth}{-1.37in}{0in}%
    \sloppy%
}{
    \end{adjustwidth}
}

\newcommand*{\cventry}[2][]{%
	\def\temp{#1}\ifx\temp\empty% tests if subtitle is empty
	#2%
	\else% 		if it's not empty...
	{\fontsize{6.47}{7.76}\selectfont \textbf{#1}}% prints subtitle
	\vspace{0.03in}\newline%	... prints a newline so we have a space between subtitle and content
	{\fontsize{7.02}{8.42}\selectfont #2}%
	\fi
	\vspace{0.12in}\newline% defines spacing between each entry
}
%TODO: adjust spacing between \cvgrade and \cvimplicitlink and \cvexplicitlink and \cvemail elements
\newcommand*{\cvimplicitlink}[2]{%
%	\vspace{0.14in}\newline% defines spacing between each entry
	{\underline{\href{#2}{#1}}}% prints subtitle
	\vspace{0.12in}\newline% defines spacing between each entry
}

\newcommand*{\cvexplicitlink}[3][]{%
	{\fontsize{6.47}{7.76}\selectfont \textbf{#1}}% prints subtitle
	\def\temp{#1}\ifx\temp\empty% tests if subtitle is empty
	% nothing to add in case the subtitle is empty
	\else% 		if it's not empty...
	\newline%	... prints a newline so we have a space between subtitle and content
	\fi
	\href{#3}{#2}%
	\vspace{0.12in}\newline% defines spacing between each entry
}

\newcommand*{\cvemail}[3][]{%
	{\fontsize{6.47}{7.76}\selectfont \textbf{#1}}% prints subtitle
	\def\temp{#1}\ifx\temp\empty% tests if subtitle is empty
	% nothing to add in case the subtitle is empty
	\else% 		if it's not empty...
	\newline%	... prints a newline so we have a space between subtitle and content
	\fi
	{\fontsize{7.02}{8.42}\selectfont \href{mailto:#3}{#2}}%
	\vspace{0.12in}\newline% defines spacing between each entry
}

%https://tex.stackexchange.com/questions/238898/in-line-graphics-in-text-to-represent-a-loading-bar-for-language-skills-in-a-cv
\newcommand{\cvgrade}[2]{%
	#1\newline% prints subtitle
	\begin{tikzpicture}
		\clip (1em-.3em,-.3em) rectangle (5em +.5em ,.3em);
		\begin{scope}
			\clip (1em-.3em,-.3em) rectangle (#2em +.5em ,.3em);
			\foreach \x in {1,2,...,5}{
				\path[fill=black] (\x em,0) circle (.25em);
			}
		\end{scope}
		\foreach \x in {1,2,...,5}{
			\draw (\x em,0) circle (.25em);
		}
	\end{tikzpicture}%
	\vspace{0.12in}\newline% defines spacing between each entry
}

\newenvironment{margsection}[1][]{%
	{\mtssubtitle \fontsize{8.43}{10.12}\selectfont \textbf{#1}}%
	\vspace{0.09in}\hrule height 0.8pt \relax\vspace{0.16in}\noindent%
}{\vspace{0.05in}\newline}