---
title: Patterns in metadata standards and practices
author:
    name: Jakob Voß
    affiliation: Verbundzentrale des GBV (VZG), Göttingen, Germany
    email: jakob.voss@gbv.de
abstract: # at least 70 and at most 150 words
    This paper summarizes the analysis and description of metadata standards and
    practices by means of a pattern language. The goal of this work was to find
    common strategies and features in diverse data technologies.
    The deconstruction of metadata standards is
    based on a semiotic view of data as signs, communicated in form of digital
    documents.  The study was conducted by a phenomenological description of 
    different types of standards, such as encodings, identifiers, 
    formats, schemas, and models. The analysis resulted in a pattern language 
    of data structuring. The patterns show problems and solutions which occur 
    over and over again in data, independent from particular technologies. 
    Twenty general patterns were identified and described, each with its 
    benefits, consequences, pitfalls, and relations to other patterns. The 
    result can help to better understand metadata and its actual forms, both 
    for consumption and for creation of data.
keywords:
    - data description 
	- data modeling
	- pattern language
...

# Introduction

*We do not, it seems, have a very clear and commonly\
agreed upon set of notions about data.* --- George Mealy [@Mealy1967]

A plethora of standards and technologies, models, formats, languages, and other
methods exist to structure metadata in particular and data in general. These
data standards often build and depend on each other and are subject of ongoing
development and trends. Given the number of possible ways to encode the same
information in data (see table \ref{tab:aringencodings} and @Kent1988 for
simple examples), it can be sometimes be difficult to pinpoint the actual
semantics in data. 

Attempts to avoid or solve the confusion in metadata standards are confronted
with several fundamental problems. Just calling a data standard 'semantic' or
'simple' does not make data encoded in this standard more meaningful or easy to
understand. Attempts to create unifications or meta-descriptions of different
standards can help to some degree but they also increase complexity as noticed
by @Munroe2011 in his *xkcd* comic strip.

\begin{table}
\centering
\caption{Various character encodings of the capital letter \r{A}}
\begin{tabular}{lrr}
\hline
 encoding & hexadecimal & binary \\
\hline
 US-ASCII           & --- & --- \\
 ISO~646 DK/NO/SE   & \verb|5D| & \verb| 1011101| \\
 EBCDIC CP37 etc.   & \verb|67| & \verb|01100111| \\
 Mac~OS~Roman       & \verb|81| & \verb|10000001| \\
 Allegro-DOS/IBM437 & \verb|8F| & \verb|10001111| \\
 NeXTSTEP           & \verb|86| & \verb|10000110| \\
 ISO 8859-1         & \verb|C5| & \verb|11000101| \\
 ANSEL (MARC-8) combining \r{} + A & \verb|EA 41| 
  & \verb|11101010 01000001| \\
 UTF-16: \r{A}ngstr\"{o}m sign & \verb|21 2B|
& \verb|00100001 00101011| \\
 UTF-16: \r{A} & \verb|00 C5|
& \verb|00000000 11000101| \\
 UTF-8: \r{A} & \verb|C3 85|
& \verb|11000011 10000101| \\
 UTF-8: A + combining \r{} & \verb|41 CC 8A|
& \verb|01000001 11001100| \\ & &  \verb|10001010| \\
\hline
\end{tabular}
\label{tab:aringencodings}
\end{table}


First of all, standards are not always used as they were originally intended:
errors are made, elements are interpreted differently, and new requirements
squeezed into existing schemes [@McCallum2012; @Tennant2004]. Much data is also
created without a predefined standard or it is only based on very generic,
structures such the tabular grid of a spreadsheet.  Semi-structured data can
also be useful [@Malone1987] and the lack of an explicit standard does not mean
that there is no consistent structure. But the rules, ideas, and assumptions
that formed some given piece of data, are more hidden between delimiters,
fields, and other methods of data structuring.

The goal of the research summarized in this paper is to shine some light on
metadata standards and practices by means of a pattern language [@Voss2013]. The
study is based on the assumption that specific technologies come and go but all
of them are based on paradigms and more general ideas or strategies how to
structure and describe data. These common features of metadata standards can be
described as design patterns. The paper first summarizes background (section
\ref{s:background}) and research method (section \ref{s:method}) before
summarizing the collection of patterns in a pattern language (section
\ref{s:patterns}). It concludes with examples of applications
(section \ref{s:applications}) and a summary (section \ref{s:summary}).

# Background and previous works {#s:background}

Given the dominance of data-driven system in our environment, there is
surprisingly little research on *fundamental* properties of data.  Like its
latin root 'datum' for 'something given', the nature of data is usually given
as obvious. In philosophy of information, @Floridi2010 gives a more detailed
"diaphoric" definition of data as "x being distinct from y, where x and y are
two uninterpreted variables and the relation of ‘being distinct’, as well as
the domain, are left open to further interpretation." This definition roots
data in a lack of uniformity that allows to distinguish different symbols, such
as the digital digits 0 and 1.

An analysis of the actual use of the term data, conducted by
@BallsunStanton2012, shows that data is understood in three different meanings:
"data as communications, a container for meaning; data as subjective
observations, sense-impressions filtered by knowledge; and data as objective
facts, measurements revealing the relationships of reality". The predominant
notion of data in current discussions of big data and metadata follows the
third or second meaning by assuming that data is grounded in reality or at
least in it's observation.^[See @Shaw2015 for a call to shift "viewing Big Data
as scientific measurements toward viewing them as traces left by past
engagements".] The relationship between data and reality, however, has little
to do with questions of correctness but more with practical needs and
trade-offs, as illustrated by Kent [@Kent1978; @Kent1988].

The rather arbitrary connection between data and reality is not a problem for
the scope of this study as it does not focus on content but on form. The notion
of data as communications coincides with a semiotic view of data as signs,
communicated in form of digital documents. Although all data is explicitly or
(more often) implicitly based on some data modeling (see figure
\ref{fig:simplifieddatamodeling}), there is no straightforward mapping between
the different realms of data modeling nor between different technologies of the
same realm. Data descriptions on every level instead act as method of
communication in form of digital documents. These methods have rarely been
studied independet from particular standards.

\begin{figure}
\centering
\begin{tikzpicture}[orm]
\matrix[column sep=6mm] {
  \node[draw,cloud,cloud puffs=10,cloud ignores aspect,cloud puff arc=90,
        minimum width=8mm,minimum height=4mm,label=mind] (mind) {};
&
 \node[ellipse,minimum width=6mm,label=model,minimum height=4mm] (model) {};
 \draw (30:2mm) -- (-90:2mm) -- (150:2mm) -- cycle;
 \draw [draw,fill=white]  (-90:2mm) circle (.6mm);
 \draw [draw,fill=white] (30:2mm) circle (.6mm);
 \draw [draw,fill=white] (150:2mm) circle (.6mm);
&
 \node[rectangle,minimum width=6mm,minimum height=4mm,label=schema] (schema) {};
 \draw (schema.north west) rectangle (schema.center);
 \draw (schema.north) rectangle (schema.east);
 \draw (schema.west) rectangle (schema.south);
&
 \node[rectangle,minimum height=4mm] (data) {\texttt{01101}\ldots}; \\
};
\node[above=0.5mm of data] {implementation};
\draw[<->,shorten >=1mm,shorten <=2mm] (mind) to (model);
\draw[<->,shorten >=2mm,shorten <=1mm] (model) to (schema);
\draw[<->,shorten >=0mm,shorten <=2mm] (schema) to (data);
\end{tikzpicture}
\caption{Simplified data modeling process}
\label{fig:simplifieddatamodeling}
\end{figure}

The following works include a more general view at data: @Honig1975 developed a
general analysis model of data structures based on a review of 21 programming
languages and data base management systems in the early 1970s. His model is a
faceted classification with three major classes "aggregate", "association", and
"file data structures".  A summary of fundamental concepts in the field of
Object Orientation (abstraction, classes, encapsulation, inheritance, objects,
message passing, methods, and polymorphism) was identified by @Armstrong2006 by
literature analysis. A system of data types independent from particular
(programming) languages has been specified in ISO 11404 [@ISO11404].  Finally,
a categorization of metadata-related standards for libraries, archives, and
museums has been given by Zeng and Qin [@Zeng2016] with four general types
(data structures, data contents, data exchange, and data values).

# Research method and results {#s:method}

To study all data standards and practices in their diversity, one cannot simply
build on existing meta-descriptions or classifications because each of these
descriptions defines another standard by itself. For this reason a
phenomenological research method was chosen.  The phenomenological method views
data as social artefacts, that cannot be described from an absolute, objective
point of view. Instead occurrences of data standards are studied as
"'phenomena': appearances of things, or things as they appear in our
experience" [@Smith2009].  A phenomenological investigation, as summarized by
@Spiegelberg1982, is based on phenomenological intuiting, phenomenological
analyzing, and phenomenological describing. First, the phenomenon must be
experienced "without becoming absorbed in it to the point of no longer looking
critically". The advice of @Meek1995 for language-independent data standards
"to develop a healthy disrespect for all languages, and look for faults in them
all the time." was helpful in doing so.  Second, the phenomenon is examined in
all of its aspects without adhering to possibly known concepts and categories.
Finally, the phenomenological description "forces us to concentrate on the
central and decisive characteristics of the phenomenon and to abstract from its
accidentals". This description should reveal the essence of a phenomenon and
give a "reliable guide to the listener’s own actual or potential experience of
the phenomena."

\begin{table}
\centering
\caption{Prototype categorization of data structuring methods}
\begin{tabular}{lll}
\hline
category & main purpose & examples \\
\hline
encodings       & express data & Unicode, Base64 \\
storage systems & store data & NTFS, RDBMS \\
identifier and query languages   & refer to data  & URI, XPath \\
structuring and markup languages & structure data & XML, CSV, RDF \\
schema languages  & constrain data & BNF, XSD \\
conceptual models & describe data  & Mind Maps, ERM \\
\hline
\end{tabular}
\label{tab:protocat}
\end{table}

It should be clear that a phenomenological investigation of metadata standards
and practices "requires background knowledge and skills in databases, ontology
modeling, knowledge organization systems, and markup languages", as noted by
@Zeng2016 for a thoroughly understanding of metadata. The final study includes
phenomena from character and number encodings, identifiers, file systems,
databases, data structuring languages, markup languages, schema languages,
conceptual modeling languages, conceptual diagrams, and query languages
[@Voss2013, chapter 3]. Related areas not covered yet include standardized
forms, questionnaires, and visual notations such as electrical circuit
diagrams. The investigation resulted in a collection of twenty patterns (figure
\ref{fig:allpatterns}), a prototype categorization (figure
\ref{tab:protocat}), and a set of paradigms that deeply shape the way people
talk and think about data [@Voss2013, section 4.2]. An example of a paradigm is
the distinction between data values or documents on one side and data as
structures or objects on the other side.  Another example is the distinction
between entities (objects, records, items, resources...) and connections
(links, relationships, associations...). The distinction
is rather artificial and arbitrary in both cases. 

# Patterns in data {#s:patterns}

Patterns as systematic tools for describing good design practice were first
intro- duced by Alexander et al. [@Alexander1977] and later adopted in other
fields of engineering, especially in software engineering [@Beck1987;
@Gamma1994].^[Incidentally the first wiki was created to host a collection of
patterns: the Portland Pattern Repository "WikiWikiWeb" is still active at
<http://c2.com/cgi/wiki>.] The latter refers to dynamic processes and
automation instead of static document structures as analyzed in this work.
Design patterns in data should neither be confused with statistical patterns
which are subject of pattern recognition and data mining: design patterns are
not based on correlation but on intentions and meaning.   In short, a pattern
is a named description of "a problem which occurs over and over again in our
environment" [@Alexander1977]. Patterns can be found by observing current
practice and then looking for commonalities in solutions to a problem. The
pattern does not solve the problem by providing a particular solution, but it
describes benefits and consequences of a general types of solutions.  The full
potential of patterns unfolds if a set of patterns is collected and combined in
a *pattern language*. A pattern language is "a network of patterns that call
upon one another. Patterns help us remember insights and knowledge about design
and can be used in combination to create solutions." [@Alexander1977] Each
pattern in a pattern language consists of name, problem, solution, and
consequences. In the pattern language of data standards, these parts are
further divided into: name and aliases; idea, context, and motivation;
implementations, examples, and counter examples; difficulties, related
patterns, implied patterns, and specialized patterns.  A full example of a
pattern is given in figure \ref{ex:pattern}. The pattern language can further
be organized in a classification (figure \ref{fig:allpatterns}) and by
visualization of their connections (figure \ref{fig:compatterns}). The full
pattern language is available online.^[See <http://aboutdata.org/patterns.html>
and chapter 5 of @Voss2013.]

\begin{figure}
\centering
\begin{tikzpicture}
\tikzstyle{garc}=[solid,thick,->,shorten >=0.75pt,>=latex]
\matrix[column sep=3mm,row sep=5mm,
 ] {
  & \node (graph) {\textbf{\textit{graph}}}; &
    \node (sequence) {\textbf{\textit{sequence}}}; &
    \node (separator) {\textit{separator}};  \\
  & \node (atomicity) {\textit{atomicity}}; &
    \node (container) {\textbf{\textit{container}}}; & 
    \node (etcetera) {\textit{etcetera}}; \\
    \node (dependence) {\textbf{\textit{dependence}}}; &
  \node (size) {\textit{size}}; &
  \node (embedding) {\textbf{\textit{embedding}}}; & \\
};
\draw[garc] (graph) to (container);
\draw[garc] (graph) to[out=-160,in=90] (dependence);
\draw[garc] (atomicity) to (size);
\draw[garc] (container) to (size);
\draw[garc] (container) to (embedding);
\draw[garc] (etcetera) to (embedding);
\draw[garc] (etcetera) to (container);
\draw[garc] (sequence) to (container);
\draw[garc] (separator) to[out=0,in=0,looseness=2] (embedding);
\draw[garc] (separator) to (sequence);
\end{tikzpicture}
\caption{Connections between some patterns, combining patterns in bold}
\label{fig:compatterns}
\end{figure}

\begin{figure}
\begin{description}
\item[Name]~\\
Etcetera
\item[Alias]~\\
Ellipsis, partial collection, explicit abbreviating.
\item[Idea]~\\
Indicate that a collection of data elements is incomplete.
\item[Context]~\\
A \pattern{container} or \pattern{embedding} of elements.
\item[Motivation]~\\
Collections may be too large to be expressed, or parts of a collection
may be unimportant or already implied by context. This pattern allows
for abbreviating and to show that a collection contains more then
explicitly expressed.
\item[Implementations]~\\
First, one needs to decide which parts to omit:

\begin{itemize}
\tightlist
\item
  Only express the first or the most important parts.
\item
  Only express mandatory parts and omit the rest (\pattern{optionality}).
\item
  Give a random sample of of elements (\pattern{garbage}).
\end{itemize}

Second, the etcetera indicator can be expressed in several ways:

\begin{itemize}
\tightlist
\item
  Use a special element as etcetera indicator. This element must be a
  \pattern{prohibition} to not be confused with normal parts.
\item
  Use obviously wrong elements as placeholders (\pattern{garbage}).
\item
  Define a fixed cut, for instance a maximum length.
\end{itemize}
\item[Examples]\hfill
\begin{itemize}
\tightlist
\item
  \texttt{...} or \texttt{et\ al.} to indicate an abbreviated
  \pattern{sequence}.
\item
  \texttt{e.g.} to indicate that the included elements are examples from
  a larger set.
\item
  Omission of parts in the middle of an element with \texttt{{[}...{]}}.
\item
  Library cataloging rules exist to only include three authors in a
  record, so the list of authors is always abbreviated if there are more
  then three authors.
\end{itemize}
\item[Counter examples]~\\
Omission of details can also be an example of generalization and
abstraction (\pattern{encoding}) instead of abbreviation.
\item[Difficulties]\hfill
\begin{itemize}
\tightlist
\item
  Type and number of omitted parts and the reason for abbreviating are
  often unclear.
\item
  An etcetera indicator and normal parts of a collection must not be
  confused (for instance strings that actually end with \texttt{...}).
\item
  Indicators could also be used to tell that a collection may be
  extended or that an element can be repeated (see \pattern{container}
  and \pattern{schema} patterns).
\end{itemize}
\item[Related patterns]~\\
With a fixed cut this pattern also uses the \pattern{void} pattern
instead of an explicit etcetera indicator. The void pattern is also
similar because it indicates elements. The etcetera pattern in contrast
indicates the existence of more elements.
\item[Implied patterns]~\\
The etcetera indicator only makes sense as part of an \pattern{embedding}
(typically a \pattern{container} or \pattern{sequence}).
\end{description}

\caption{The \textit{etcetera} pattern as example}
\label{ex:pattern}
\end{figure}

\hidebegin{figure}
\hidebegin{multicols*}{2}

1. basic patterns
      a)  pure data elements
          i.  *label*
          ii.  *atomicity*
      b)  data elements with content
          i.  *size*
          i.  *optionality*
          iii.  *prohibition*
\smallskip
2. combining patterns
      a)  elements on the same level
          i.  *sequence*
          ii.  *graph*
      b)  elements by subsumption
          i.  *container*
          ii.  *dependence*
          iii.  *embedding*
\columnbreak
3. relationing patterns
      a)  primary
          i.  *identifier*
          ii.  *derivation*
      b)  secondary
          i.  *encoding*
          ii.  *flag*
      c)  tertiary
          i.  *normalization*
          ii.  *schema*
4. continuing patterns
      i.  *separator*
      ii.  *etcetera*
      iii.  *garbage*
      iv.  *void*

\vfill
.

\hideend{multicols*}
\caption{Summary of patterns in data structuring}
\label{fig:allpatterns}
\hideend{figure}

\FloatBarrier

# Applications and examples {#s:applications}

The application of data patterns shall be introduced with a small example.  A
digital document is given as a sequence of of twelve bytes (figure
\ref{fig:pieceofdata} *a*).  How can this particular piece of data be
structured and described? 

\begin{figure}
\centering
\begin{tabular}{cc}
\multicolumn{2}{c}{\textit{a)} \texttt{44 75 62 6c 69 6e 2c 20 4f 68 69 6f}} 
\\[2mm]
\textit{b)} \texttt{Dublin, Ohio} &
\textit{c)} $\underbrace{\texttt{Dublin}}_{1}%
\underbrace{\texttt{, }}_{2}%
\underbrace{\texttt{Ohio}}_{3}$
\\
\end{tabular}
\caption{Example of a digital document in different interpretations}
\label{fig:pieceofdata}
\end{figure}

To start with, we need at least some context or indication. Let's assume each
byte corresponds to one character. This kind of correspondence is an example of 
the \pattern{encoding} pattern. In ASCII or Unicode
the sequence is a string of characters (figure \ref{fig:pieceofdata} *b*).
Several patterns provide obvious solutions to further description:

\begin{itemize}
\item It may just refer to the name ``Dublin, Ohio''
     (\pattern{label} pattern).

\item It may be a list of two elements, \texttt{Dublin} 
      and \texttt{Ohio}	(\pattern{sequence} pattern).

\item It may consist of two elements as part of an unsorted collection
      (\pattern{container} pattern), so
      \texttt{Ohio, Dublin} should be equal to \texttt{Dublin, Ohio}.

\item It may consist of two words, one of which "\texttt{Ohio}" being 
      used as qualifier to control the interpretation of 
      the other "\texttt{Dublin}" (\pattern{flag} pattern).
\end{itemize}

One can further deconstruct the structure of a data element into parts, a
typical process in data description (\pattern{schema} pattern, figure
\ref{fig:pieceofdata} *c*). The third part could be attached as additional
element to the first (\pattern{dependence} pattern), and it may unambiguously
refer into a registry of allowed qualification values (\pattern{identifier}
pattern). The second part acts as connection or delimiter (\pattern{separator}
pattern). Even its two bytes (\texttt{, }) can have structure: the whitespace
character is often used as filling without significance (\pattern{garbage}
pattern).

The example shows that several typical structuring methods can be identified
even in small pieces of data. The interpretation does not need to be right ---
depending on context the sequence could mean virtually anything --- but
patterns can help to reveal interpretations that were most likely intended when
the data was created. Patterns can in reverse help data modeling to build
better metadata schemes and formats. Two possible domains of application can be
identified: First *Data archaeology* as future recovery of digital data in
unknown, obsolete, or incompletely defined formats ('reverse data modeling')
will gain importance with the ongoing rise of data collection. Second *Data
literacy* has gained popularity in recent years to describe the increasing need
for creating and using data. By now the focus of this competence is on
numerical data, following the notions of data as observations or facts, but the
notion of data as communicated documents will gain importance as well
[@Shaw2015].

# Summary and outlook {#s:summary}

The number of different metadata standards and their actual usage often makes
it difficult to find out what was actually intended. This work is based on the
assumption that common strategies and features exist to structure and describe
data independent from specific technologies and trends. These features of
metadata standards can best be documented by design patterns. 

Different types of standards and practice such as encodings, identifiers,
formats, schemas, and models have been studied by phenomenological
investigation to find common categories, paradigms, and patterns.  The
resulting pattern language (outlined in figure \ref{fig:allpatterns}) with
twenty patterns does not try to unify all metdata standards and methods, but to
analyze and reveal unspelled assumptions that deeply shape how data is and will
be structured and described in practice.  The identified categories, paradigms,
and patterns can help to better understand data and its actual forms, both for
consumption and for creation of data.  Two concrete domains of application are
data archaeology and data literary.  Ideally, the results will foster an
understanding of metadata standards in general.

Further research is needed to apply the investigation to related methods not
covered yet (e.g. forms and diagrams), to deeper look at social application of
data and standardization (for instance to better spot common errors and
misconceptions) and to extend the prototype categorization (figure
\ref{tab:protocat}) with facets and related classifications such as the one by
@Zeng2016.

