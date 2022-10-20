# sleekcv
sleekcv is a TeX class that provides a sleek layout for curricula vitae. You can see a demonstration resume [here](template.pdf).

# Documentation
- [sleekcv](#sleekcv)
- [Documentation](#documentation)
  - [Basic form](#basic-form)
  - [margcol commands](#margcol-commands)
    - [margsection](#margsection)
    - [margentry](#margentry)
    - [margtext](#margtext)
    - [marglink](#marglink)
    - [margemail](#margemail)
    - [margrade](#margrade)

## Basic form
A complete example that shows all of sleekcv's functionality can be found [here](template.tex). A minimal example of sleekcv's form, however, looks like this:
```tex
\documentclass{sleekcv}

\usepackage[english]{babel}% change to your desired language

\defname{YOUR}{NAME}
\defprofession{JOB TITLE}

\begin{document}

\begin{margcol}% responsible for the left column (aka margin)
    % <your content>
\end{margcol}

\begin{bodycol}% responsible for the right column (aka body)
    % <your content>
\end{bodycol}

\end{document}
```
## margcol commands
### margsection
This is the environment that creates a section in the left column.

**Usage**:
```tex
\begin{margsection}[<optional title>]
    % <your content>
\end{margsection}
```

### margentry
This command creates an entry for the left column. An entry consists of a optional subtitle and text in a smaller font.

**Usage**:
```tex
\margentry[<optional subtitle>]{<text>}
```

### margtext
Creates a normal block of text. Works pretty much like `\margentry` with no optional subtitle, but the text font isn't small.

**Usage**:
```tex
\margtext <text>
```

### marglink
Creates a link to a web address. The style of the link depends on wether you provide a subtitle or not. If you do, then the link will look just like a `\margentry`; if you don't, it will be bigger and underlined.

**Usage**:
```tex
\marglink[<optional subtitle>]{<shown text>}{<url>}
```

### margemail
Works exactly like `\marglink`, but for emails.

**Usage**:
```tex
\margemail[<optional subtitle>]{<shown text>}{<email>}
```

### margrade
Provides a graphical way to grade skills. The grade must be an integer or half-integer in the interval [0, 5].

**Usage**:
```tex
\margrade{<skill title>}{<grade>}