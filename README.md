# sleekcv <!-- omit in toc -->
sleekcv is a TeX class that provides a sleek layout for curricula vitae. You can see a demonstration resume [here](template.pdf).

# Table of contents <!-- omit in toc -->
- [1. Dependencies](#1-dependencies)
- [2. Documentation](#2-documentation)
  - [2.1. Basic form](#21-basic-form)
  - [2.2. margcol commands](#22-margcol-commands)
    - [2.2.1. margsection](#221-margsection)
    - [2.2.2. margentry](#222-margentry)
    - [2.2.3. margtext](#223-margtext)
    - [2.2.4. marglink](#224-marglink)
    - [2.2.5. margemail](#225-margemail)
    - [2.2.6. margrade](#226-margrade)
  - [2.3. bodycol commands](#23-bodycol-commands)
    - [2.3.1. bodysection](#231-bodysection)
    - [2.3.2. bodyentry](#232-bodyentry)
    - [2.3.3. bodytext](#233-bodytext)

# 1. Dependencies
You must have the [Montserrat](https://fonts.google.com/specimen/Montserrat/about) font installed to properly compile documents that utilize this class. Besides that, since a custom font is used, you must use the LuaTeX compiler.

# 2. Documentation

## 2.1. Basic form
A complete example that shows all of sleekcv's functionality can be found [here](template.tex). On the other hand, a minimal example of sleekcv's form looks like this:
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

## 2.2. margcol commands
### 2.2.1. margsection
This is the environment that creates a section in the left column.

**Usage**:
```tex
\begin{margsection}[<optional title>]
    % <your content>
\end{margsection}
```

### 2.2.2. margentry
This command creates an entry for the left column. An entry consists of an optional title and text in a smaller font.

**Usage**:
```tex
\margentry[<optional title>]{<text>}
```

### 2.2.3. margtext
Creates a normal block of text. Works pretty much like [`\margentry`](#222-margentry) with no optional title, but the text font isn't small.

**Usage**:
```tex
\margtext <text>
```

### 2.2.4. marglink
Creates a link to a web address. The style of the link depends on wether you provide a title or not. If you do, then the link will look just like a [`\margentry`](#222-margentry); if you don't, it will be bigger and underlined.

**Usage**:
```tex
\marglink[<optional title>]{<shown text>}{<url>}
```

### 2.2.5. margemail
Works exactly like [`\marglink`](#224-marglink), but for emails.

**Usage**:
```tex
\margemail[<optional title>]{<shown text>}{<email>}
```

### 2.2.6. margrade
Provides a graphical way to grade skills. The grade must be an integer or half-integer in the interval [0, 5].

**Usage**:
```tex
\margrade{<skill title>}{<grade>}
```

## 2.3. bodycol commands
### 2.3.1. bodysection
This is the environment that creates a section in the right column.

**Usage**:
```tex
\begin{bodysection}[<optional title>]
    % <your content>
\end{bodysection}
```

### 2.3.2. bodyentry
This command creates an entry for the right column. An entry consists of five optional elements: a title, a place, a start date, an end date and a summary. You can omit any combination of these parameters and an appropriate entry will be created. However, if you're thinking about omiting all of them, you should probably use the [`\bodytext`](#233-bodytext) command.

**Usage**:
```tex
\bodyentry{<title>}{<place>}{<start date>}{<end date>}{<summary>}
```

### 2.3.3. bodytext
Creates a normal block of text. Can be used, for example, after a [`\bodyentry`](#232-bodyentry) to add normal text to that entry.

**Usage**:
```tex
\bodytext <text>
```