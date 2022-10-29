%-------------------------------------------------------------------------------
%                start of file sleekcv.cls
%-------------------------------------------------------------------------------


%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sleekcv}[2022-10-11 v0.0.9 sleek curriculum vitae document class]

%-------------------------------------------------------------------------------
%                class options
%-------------------------------------------------------------------------------

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

%-------------------------------------------------------------------------------
%                required packages
%-------------------------------------------------------------------------------

\RequirePackage{anyfontsize}% allows selection of different font sizes
\RequirePackage{eso-pic}% creates the gray rectangle in the background
\RequirePackage{etoolbox}% provides \AfterEndPreamble
\RequirePackage{fontspec}% allows changing fonts settings
\RequirePackage{setspace}% changes space between lines
\RequirePackage{tikz}% creates the rectangle aroung the name+profession
\RequirePackage{xcolor}% allows color picking

\newenvironment{description}{}{}% this environment is required by the enumitem package
\RequirePackage{enumitem}% allows us to remove the spacing before the itemize environment

\RequirePackage{float}% allows us to create a figure environment as if this was an article class
\newfloat{figure}{htbp}{figs}

\PassOptionsToPackage{pdfpagelabels=false}{hyperref}% supress annoying hyperref warning
\RequirePackage[hidelinks]{hyperref}% enables hypertext links in the document

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

%-------------------------------------------------------------------------------
%                class definition
%-------------------------------------------------------------------------------

% sets a gray column as background
\AddToShipoutPictureBG{\color[RGB]{244,244,244}%
	\AtPageLowerLeft{\rule{2.55in}{\paperheight}}} % this lines defines the rectangle position (lower left) and sizes(width = 2.57 inches, height = current paperheight (297mm))

\color[RGB]{33,33,33}% sets the default color for the document
\definecolor{softblack}{RGB}{33,33,33}% gives a name to that color

\newfontfamily{\mtstitle}[LetterSpace=12]{Montserrat}% creates a new font family with more spacing for the title
\newfontfamily{\mtssubtitle}[LetterSpace=24]{Montserrat}% even more spacing
\newfontfamily{\mtsl}[UprightFont={* Light}]{Montserrat}% creates a new font family for the light version of Montserrat

\setlength{\intextsep}{0.41in plus 2.0pt minus 2.0pt}% changes spacing between header and text

\pagenumbering{gobble}% disables page numbering

\newcounter{margcounter}% counts if the current margin section already has an entry
\newcounter{bodycounter}% counts if the current body section already has an entry

% \AfterEndPreamble code is part of the document body. Therefore, we can instantiate our header and initialize our two columns.
\AfterEndPreamble{
	\newlist{cvitemize}{itemize}{1}
	\setlist[cvitemize]{label={\mtsl•},topsep=0pt,itemsep=0.02in,labelsep=0.12in,leftmargin=*}
	\cvheader%
	\fontspec{Montserrat}%
	\setlength{\columnsep}{0.62in}
	\setcolumnwidth{1.58in}
	\begin{paracol}{2}%
}

% \AtEndDocument is still considered as being part of the document body. Therefore, we can finalize our multi-column document.
\AtEndDocument{\end{paracol}}

%-------------------------------------------------------------------------------
%                user commands
%-------------------------------------------------------------------------------

% defines applicant's name
% usage: \defname{<firstname>}{<lastname>}
\newcommand*{\defname}[2]{\def\firstname{#1}\def\lastname{#2}}

% defines job title
% usage: \defprofession{<job title>}
\newcommand*{\defprofession}[1]{\def\profession{#1}}

% left column environment
% usage:	\begin{margcol}
%				<content>
%			\end{margcol}
\newenvironment*{margcol}{%
	\switchcolumn[0]*%
	\fontsize{8.43}{10.12}\selectfont%
}{}

% environment that creates a section in the left column
% usage:	\begin{margsection}[<section title>]
%				<content>
%			\end{margsection}
\newenvironment*{margsection}[1][]{%
%	{\raggedright \par}%
	{\par \mtssubtitle \noindent \textbf{#1}}%
	\vspace{0.09in}\hrule height 1pt \relax\vspace{0.16in}\noindent%
	\sloppy%
}{%
	\setcounter{margcounter}{0}% resets counter in case we create more margsections
	\vspace{0.31in}%
}

% creates an entry for the left column (aka margin)
% usage: \margentry[<optional subtitle>]{<content>}
\newcommand*{\margentry}[2][]{%
	\handlemargcounter%
	\def\temp{#1}\ifx\temp\empty% tests if subtitle is empty
		{\fontsize{7.03}{8.44}\selectfont #2}%
	\else% 		if it's not empty...
		{\fontsize{6.47}{7.76}\selectfont \textbf{#1}}% prints subtitle
		\vspace{0.03in}\newline%	... prints a newline so we have a space between subtitle and content
		{\fontsize{7.03}{8.44}\selectfont #2}%
	\fi
}

% adds the appropriate spacing to start a normal block of text. can be used, for example, inside a margsection to create a section with normal text only and no special entries.
% usage: \margtext <content>
\newcommand*{\margtext}{%
	\handlemargcounter%
}

% usage: \marglink[<optional subtitle>]{<shown text>}{<url>}
\newcommand*{\marglink}[3][]{%
	\handlemargcounter%
	\def\temp{#1}\ifx\temp\empty% implicit link
		{\underline{\href{#3}{#2}}}%
	\else% explicit link
		{\fontsize{6.47}{7.76}\selectfont \textbf{#1}}% prints subtitle
		\vspace{0.03in}\newline%	... prints a newline so we have a space between subtitle and content
		{\fontsize{7.03}{8.44}\selectfont \href{#3}{#2}}%
	\fi%
}

% just like \marglink, but creates a mailto link
% usage: \margemail[<optional subtitle>]{<shown text>}{<email>}
\newcommand*{\margemail}[3][]{%
	\marglink[#1]{#2}{mailto:#3}
}

% presents a grade to a skill in the form of circles. only works for integers and half integers.
% based on: https://tex.stackexchange.com/questions/238898/in-line-graphics-in-text-to-represent-a-loading-bar-for-language-skills-in-a-cv
% usage: \margrade{<skill name>}{<grade>}
\newcommand*{\margrade}[2]{%
	\ifnum\value{margcounter}=0%
		\stepcounter{margcounter}%
	\else%
		\vspace{-0.02in}\newline%
	\fi%
	{\raggedright\par#1\vspace{0.03in}\newline}%
%	\begin{flushleft}
%		\vspace{-0.11in}#1\vspace{-0.11in}% prints subtitle
%	\end{flushleft}
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
}

% right column environment
% usage:	\begin{bodycol}
	%				<content>
	%			\end{bodycol}
\newenvironment*{bodycol}{%
	\switchcolumn[1]%
	\fontsize{8.43}{12.5}\selectfont%
}{}

% environment that creates a section in the right column
% usage:	\begin{bodysection}[<section title>]
	%				<content>
	%			\end{bodysection}
\newenvironment*{bodysection}[1][]{%
	\ifnotempty{#1}{%
		{\mtssubtitle \noindent\textbf{#1}}%
		\vspace{0.09in}\hrule height 1pt \relax\vspace{0.16in}\noindent%
	}%
	\sloppy%
}{%
	\setcounter{bodycounter}{0}% resets counter in case we create more bodysections
	\par\vspace{0.28in}%
}

% creates an entry for the right column. any combination of parameters can be omited and an appropriate entry will get created. you can even omit all parameters; however, if you're thinking about doing it, you should probably use \bodytext.
% usage: \bodyentry{<subtitle>}{<place>}{<start date>}{<end date>}{<summary>}
\newcommand*{\bodyentry}[5]{%
	\ifnum\value{bodycounter}=0%
		\stepcounter{bodycounter}%
	\else%
		\vspace{0.24in} \par \noindent%
	\fi%
	\ifnotempty{#1}{%
		\begin{minipage}[t]{3.57in}%
			\begin{flushleft}%
				{\noindent \fontsize{9.53}{11.44}\selectfont \textbf{#1}}%
			\end{flushleft}%
			\fixedvspace{-0.05in}%
		\end{minipage}%
	}%
	\ifnotempty{#2}{%
		\hfill%
		{\mtsl \fontsize{7.53}{9.04}\selectfont #2}%
	}%
	\ifnotempty{#3}{%
		\vspace{0.02in} \par \noindent%
		#3%
		\ifnotempty{#4}{{ — #4}}%
	}%
	\ifnotempty{#5}{%
		\vspace{0.08in} \par \noindent%
		\textit{#5}%
	}%
}

% adds the appropriate spacing to start a normal block of text. can be used, for example, after a \bodyentry to add normal text to that entry.
% usage: \bodytext <content>
\newcommand*{\bodytext}{%
	\ifnum\value{bodycounter}=0%
		\stepcounter{bodycounter}%
	\else%
		\vspace{0.08in} \par \noindent%
	\fi%
}

%-------------------------------------------------------------------------------
%                internal commands
%      (shouldn't be called by normal users)
%-------------------------------------------------------------------------------

% creates the title/header (rectangle with applicant's name and job title)
% usage: \cvheader
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

% handles spacing between margin entries
% usage: \handlemargcounter
\newcommand{\handlemargcounter}{%
	\ifnum\value{margcounter}=0%
		\stepcounter{margcounter}%
	\else%
		\vspace{0.12in}\newline%
	\fi%
}

% tests if an argument is not empty and executes given commands if true
% usage: \ifnotempty{<argument>}{<commands>}
\newcommand{\ifnotempty}[2]{%
	\def\temp{#1}\ifx\temp\empty%
		% do nothing
	\else%
		#2%
	\fi%
}

% prevents descenders from affecting line spacing
% based on: https://tex.stackexchange.com/questions/421791/preventing-letters-with-descenders-g-q-y-from-affecting-line-spacing
% usage \fixedvspace{<vspace>}
\newcommand*{\fixedvspace}[1]{%
	\par\kern-\prevdepth\vspace{#1}%
}

%-------------------------------------------------------------------------------
%                end of file sleekcv.cls
%-------------------------------------------------------------------------------
