\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sty/njustThesis}
%%
%%%%*************************** Declare Options *****************************************
%%
%% end-user parameters, each option is declared by one declare option command
%\newif\ifNJUST@typeinfo \NJUST@typeinfotrue       % turn on Copyright
\newif\ifNJUST@typeinfo \NJUST@typeinfofalse     % turn off Copyright

\DeclareOption{notypeinfo}{\NJUST@typeinfofalse}
\DeclareOption{draftinfo}{% draft information reminder
	\NJUST@typeinfotrue%
}
\DeclareOption*{% handle non-implemented options
	\PassOptionsToClass{\CurrentOption}{ctexbook}%
}
%% terminates all options processing
\ProcessOptions\relax
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%*************************** loadclass infomation ************************************
%%
%\LoadClass[cs4size,a4paper,fancyhdr,fntef,hyperref,UTF8]{ctexbook}
\LoadClass[a4paper,fontset=windowsnew,linespread=1.388888889,zihao=-4,UTF8,openany]{ctexbook}

\setlength{\parskip}{0pt}

%%%%% ------------------------------------------------------------------------------------------
%%
%%%%***************************** package infomation ***********************************
%%
%\PassOptionsToPackage{subfigure}{tocloft}
\RequirePackage{geometry,fancyhdr}
%% font
%% math packages
\RequirePackage{mathtools,amsthm,amsfonts,amssymb,bm}
%% graphics packages
\RequirePackage{graphicx,psfrag,flafter,subfigure}
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%************************ load class configuretion ************************************
%%
\AtEndOfPackage{%class cfg loaded after package, makes commands at preamble take effect
	\makeatletter
	\InputIfFileExists{sty/njustThesis.cfg}{}{}
	\makeatother
}
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%******************************* page layout ******************************************
\geometry{left=3cm, right=2.5cm, top=3cm, bottom=2.4cm}

%%%%********************* some style control commands ********************************
%%
%% redefine \cleardoublepage to handle both oneside and twoside modes
\def\cleardoublepage{%
	\clearpage%
	\if@twoside%
	\ifodd\c@page%
	% do nothing
	\else%
	\thispagestyle{empty}%
	\hbox{}%
	\newpage%
	\if@twocolumn%
	\hbox{}%
	\newpage%
	\fi%
	\fi%
	\fi}%
%% space used in items title
\newcommand\NJUSTspace{\qquad}
%% underline
\def\NJUST@underline[#1]#2{%
	\CTEXunderline{\hbox to #1{\hfill#2\hfill}}}
\def\NJUSTunderline{\@ifnextchar[\NJUST@underline\CTEXunderline}
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%********************** chinese titlepage items **************************************
%% predefine all the items which will be used later
%%
%% ==============================================
%% header
\newcommand\classification[1]{\def\NJUST@value@classification{#1}}
\newcommand\UDC[1]{\def\NJUST@value@UDC{#1}}
\newcommand\UDCfootnote[1]{\def\NJUST@value@UDCfootnote{#1}}
\newcommand\confidential[1]{\def\NJUST@value@confidential{#1}}
%%
%% ==============================================
%% title & author
\newcommand\incoverthesis[1]{\def\NJUST@value@incoverthesis{#1}}
\renewcommand\title[2][\NJUST@value@title]{%
	\def\NJUST@value@title{#2}
	\def\NJUST@value@titlemark{#1}}
\renewcommand\author[1]{\def\NJUST@value@author{#1}}
%%
%% ==============================================
%% advisor & others
\newcommand\advisor[1]{\def\NJUST@value@advisor{#1}}
\newcommand\advisortitle[1]{\def\NJUST@value@advisortitle{#1}}
\newcommand\coadvisor[1]{\def\NJUST@value@coadvisor{#1}}
\newcommand\coadvisortitle[1]{\def\NJUST@value@coadvisortitle{#1}}
\newcommand\degree[1]{\def\NJUST@value@degree{#1}}
\newcommand\major[1]{\def\NJUST@value@major{#1}}
\newcommand\interest[1]{\def\NJUST@value@interest{#1}}
%
\newcommand\school[1]{\def\NJUST@value@school{#1}}
%
%% ==============================================
%% about date
\newcommand\submitdate[1]{\def\NJUST@value@submitdate{#1}}
\newcommand\incoverdate[1]{\def\NJUST@value@incoverdate{#1}}
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%**************************** make chinese titlepage ********************************
%% 1. cover page
\renewcommand\maketitle{%
	\cleardoublepage
	\thispagestyle{empty}
	\begin{center}
		%% ==============================================
		%% header
		\songti\zihao{5}
		\NJUST@label@classification~               %% header
		\NJUSTunderline[120pt]{\NJUST@value@classification}
		\hfill
		\NJUST@label@confidential~
		\NJUSTunderline[120pt]{\NJUST@value@confidential}\hspace{1.4cm}
		\vskip 10pt
		\NJUST@label@UDC~
		\NJUSTunderline[113pt]{\NJUST@value@UDC}
		\hfill
		\NJUSTunderline[0pt]{}
		\vskip 10pt
		%% ==============================================
		%% logo
		\parbox[c][4cm][c]{\textwidth}{%
			\centering
			\includegraphics[width=12cm]{img/logo/njust.eps}
		}%
		%% ==============================================
		%% title & author
		\vskip 10pt
		\bf\kaishu{\fontsize{32bp}{1em}\selectfont\NJUST@label@thesis}     %% Thesis title
		\vskip \stretch{2}
		\bf\heiti\zihao{-1}\NJUSTunderline{~\NJUST@value@title~}
		\vskip \stretch{2}
		\bf\kaishu\zihao{-2}\NJUSTunderline{~\NJUST@value@author~}
		\vskip \stretch{2}
		%% ==============================================
		%% advisor and others
		\normalfont\songti\zihao{4}
		\def\tabcolsep{1pt}
		\def\arraystretch{1.5}
		\begin{tabular}{cc}
			\bf\songti\zihao{4}\NJUST@label@advisor   &  \NJUSTunderline[299pt]{{\bf\kaishu\zihao{3}\NJUST@value@advisor} \hspace{4pt} {\kaishu\zihao{4}\NJUST@value@advisortitle}}  \\
			%%\bf\songti\zihao{4}\NJUST@label@coadvisor & \NJUSTunderline[299pt]{{\bf\kaishu\zihao{3}\NJUST@value@coadvisor} \hspace{4pt} {\kaishu\zihao{4}\NJUST@value@coadvisortitle}}  \\
			\bf\songti\zihao{4}\NJUST@label@degree    & \NJUSTunderline[299pt]{\bf\kaishu\zihao{3}\NJUST@value@degree}  \\
			\bf\songti\zihao{4}\NJUST@label@major    &  \NJUSTunderline[299pt]{\bf\kaishu\zihao{3}\NJUST@value@major}  \\
			\bf\songti\zihao{4}\NJUST@label@interest   & \NJUSTunderline[299pt]{\bf\kaishu\zihao{3}\NJUST@value@interest}  \\
			\bf\songti\zihao{4}\NJUST@label@submitdate & \NJUSTunderline[299pt]{\bf\rmfamily\zihao{3}\NJUST@value@submitdate}
		\end{tabular}
	\end{center}
	%% ==============================================
	%% footnote
	\vspace{2em}
	\NJUST@value@UDCfootnote
	\clearpage
	\if@twoside
	\thispagestyle{empty}
	\ifNJUST@typeinfo
	\vspace*{\stretch{1}}
	\begin{footnotesize}
		\noindent
		Typeset by \LaTeXe{} at \CTEX@todayold \\
		With package \NJUSTfileinfo \hspace{2pt} \NJUSTfileversion (\NJUSTfiledate) from https://github.com/jiec827/njustThesis
	\end{footnotesize}
	\fi
	\cleardoublepage
	\fi
}
%%%%% ------------------------------------------------------------------------------------------
%% 2. page uncover
\newcommand\makeincovertitle{%
	\cleardoublepage
	\thispagestyle{empty}
	\begin{center}
		%% ================================================
		%% incoverthesis
		%%\bf\songti\zihao{-2}\NJUST@value@incoverthesis
           \songti\zihao{-2}\NJUST@value@incoverthesis
		\\[2cm]
		%% ================================================
		%% title
		\bf\heiti\zihao{2}\NJUST@value@title
		\\[3cm]
		%% ================================================
		%% info
		\begin{tabular}{rl}
			\bf\kaishu\zihao{-2}\NJUST@label@incoverauthor & \bf\kaishu\zihao{-2}\NJUST@value@author
			\\[25pt]
			\bf\kaishu\zihao{-2}\NJUST@label@incoveradvisor & {\bf\kaishu\zihao{-2}\NJUST@value@advisor\hspace{4pt}}{\kaishu\zihao{-2}\NJUST@value@advisortitle}
			\\
			\bf\kaishu\zihao{-2}\NJUST@label@incovercoadvisor & {\bf\kaishu\zihao{-2}\NJUST@value@coadvisor\hspace{4pt}}{\kaishu\zihao{-2}\NJUST@value@coadvisortitle}
		\end{tabular}
		%% ================================================
		%% school & date
		\vskip \stretch{2}
		\bf\songti\zihao{-2}\NJUST@value@school
		\vskip 8pt
		\bf\songti\zihao{-2}\NJUST@value@incoverdate
	\end{center}
	\clearpage
	\if@twoside
	\thispagestyle{empty}
	\cleardoublepage
	\fi
}
%%%%% ------------------------------------------------------------------------------------------
%%
\newcommand\englishtitle[1]{\def\NJUST@value@englishtitle{#1}}
\newcommand\englishauthor[1]{\def\NJUST@value@englishauthor{#1}}
\newcommand\englishadvisor[1]{\def\NJUST@value@englishadvisor{#1}}
\newcommand\englishadvisortitle[1]{\def\NJUST@value@englishadvisortitle{#1}}
\newcommand\englishcoadvisor[1]{\def\NJUST@value@englishcoadvisor{#1}}
\newcommand\englishcoadvisortitle[1]{\def\NJUST@value@englishcoadvisortitle{#1}}
\newcommand\englishdegree[1]{\def\NJUST@value@englishdegree{#1}}
\newcommand\englishmajor[1]{\def\NJUST@value@englishmajor{#1}}
\newcommand\englishinstitute[1]{\def\NJUST@value@englishinstitute{#1}}
\newcommand\englishdate[1]{\def\NJUST@value@englishdate{#1}}
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%*********************** make english titlepage **************************************
%%
\newcommand\makeenglishtitle{%
	\cleardoublepage
	\thispagestyle{empty}
	\begin{center}
		\vspace*{-18pt}
		%% ================================================
		%% degree
		\rmfamily\zihao{-2} \NJUST@label@englishdegree\NJUST@value@englishdegree
		\vskip 60pt
		%% ================================================
		%% title
		\rmfamily\bf\zihao{2} \NJUST@value@englishtitle
		\vskip 30pt
		%% ================================================
		%% author
		\normalfont\it\zihao{-2}\NJUST@label@englishauthor
		\\
		\bf\zihao{-2}\emph\NJUST@value@englishauthor
		\vskip 60pt
		%% ================================================
		%% supervisor
		\begin{tabular}{rl}
			\normalfont\it\zihao{-2} \NJUST@label@englishadvisor & \bf\emph\NJUST@value@englishadvisor\\
			\normalfont\it\zihao{-2} \NJUST@label@englishcoadvisor \hspace{45pt} & \normalfont\it\zihao{-2} \bf\emph\NJUST@value@englishcoadvisor
		\end{tabular}
		\vskip \stretch{2}
		%% ================================================
		%% institute & date
		\normalfont\zihao{-2} \NJUST@value@englishinstitute
		\vskip 12pt
		\normalfont\zihao{-2} \NJUST@value@englishdate
	\end{center}
	%% ================================================
	%% degree
	\clearpage
	\if@twoside
	\thispagestyle{empty}
	\cleardoublepage
	\fi
}
%%%%*********************** make statement titlepage *************************************
%% 1. statement
\cleardoublepage
\thispagestyle{empty}
\newcommand\statement[1]{%
	\vskip -5pt
	\parbox{\textwidth}{\centering\bf\songti\zihao{3}\NJUST@label@statement}
	\vskip 13pt
	\parbox{\textwidth}{\normalfont\zihao{4}\renewcommand{\baselinestretch}{1.6}\hspace{2em}\zihao{4}#1}
	\vskip 1.8cm
	\parbox{\textwidth}{\noindent{}\zihao{4}\NJUST@label@authorsign\hspace{3.5cm}\NJUST@label@signdate}
	\vskip 4.45cm
}%
%% 2. accredit
\newcommand\accredit[1]{%
	\parbox{\textwidth}{\centering\bf\songti\zihao{3}\NJUST@label@accredit}
	\vskip 1.6cm
	\parbox{\textwidth}{\normalfont\zihao{4}\renewcommand{\baselinestretch}{1.6}\hspace{2em}\zihao{4}#1}%
	\vskip 1.8cm
	\parbox{\textwidth}{\noindent{}\zihao{4}\NJUST@label@authorsign\hspace{3.5cm}\NJUST@label@signdate}%
}%
\clearpage
\if@twoside
\thispagestyle{empty}
\cleardoublepage
\fi
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%**************************** page setting **************************************
%% set page style by fancyhdr:
%% The syntax is: \fancyhead[selectors]{output you want}
%% E Even page
%% O Odd page
%% L Left field
%% C Center field
%% R Right field
%% H Header
%% F Footer
%% so [CE,RO] will refer to the center of the even pages and to the right side of the odd pages.
%% configure fancy style
\newcommand\pageDegree[1]{\def\NJUST@value@pageDegree{#1}}
%% change page NO to Roman only for frontmatter
\renewcommand\frontmatter{\pagenumbering{Roman}}
%%

\pagestyle{fancy}
\fancyhf{}
\fancyhead{} % clear all fields
\fancyhead[LO]{\songti\zihao{-5}\NJUST@value@pageDegree}
\fancyhead[RO]{\songti\zihao{-5}\NJUST@value@titlemark}
\fancyhead[LE]{\songti\zihao{-5}\leftmark}%
\fancyhead[RE]{\songti\zihao{-5}\NJUST@value@pageDegree}%
\fancyfoot[RO,LE]{\zihao{-5}\thepage}
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%**************************** make abstract & keywords *****************************
%% 1. CHN abstract
\newenvironment{abstract}
{{\centering\Nchapter{\NJUST@label@abstract}}}
{}
%% 2. CHN kewords
\newcommand\keywords[1]{%
	%\vspace{2ex}\noindent{\heiti \NJUST@label@keywords} #1}
	\vspace{2ex}\noindent{\bf\songti\zihao{4} \NJUST@label@keywords} #1}



%% 3. Eng abstract
\newenvironment{englishabstract}
{{\centering\Nchapter{\NJUST@label@englishabstract}}}
{}
%% 4. Eng keywords
\newcommand\englishkeywords[1]{%
	\vspace{2ex}\noindent{\bf\songti\zihao{4} \NJUST@label@englishkeywords} #1
	%% ================================================
	%% degree
	%\clearpage
	\if@twoside
	%\cleardoublepage
	\mbox{}\newpage\mbox{}
	\thispagestyle{fancy}
	\fi
}
%%


%% 5. other settings
\renewcommand*\l@chapter[2]{%
	\ifnum \c@tocdepth >\m@ne
	\addpenalty{-\@highpenalty}%
%	\vskip 1.0em \@plus\p@
	\setlength\@tempdima{1.5em}%
	\begingroup
	\parindent \z@ \rightskip \@pnumwidth
	\parfillskip -\@pnumwidth
	\leavevmode \bfseries\songti\zihao{4}
	\advance\leftskip\@tempdima
	\hskip -\leftskip
	#1\nobreak
	\leaders\hbox{$\m@th\mkern 1mu\bm{\bm\cdot}\mkern 1mu$}
	\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
	\penalty\@highpenalty
	\endgroup
	\fi
}%
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%******************************** make contents **************************************
%%

\renewcommand\tableofcontents{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	{\centering\chapter*{\zihao{3}\contentsname}}%
	\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
	\@starttoc{toc}%
	\if@restonecol\twocolumn\fi
	%% ================================================
	%% degree
	%\clearpage
	\if@twoside
	%\cleardoublepage
	\mbox{}\newpage
	\thispagestyle{fancy}
	\fi
}

\addtocontents{toc}{\let\string\quad\relax}
\newcommand\Nchapter[1]{%
	\ctexset{chapter/format={\bfseries\songti\zihao{3}}}
	\if@mainmatter%
	\@mainmatterfalse%
	\chapter{#1}%
	\@mainmattertrue%
	\else
	\chapter{#1}%
	\fi
	\ctexset{chapter/format={\bfseries\songti\zihao{-3}}}
}

%%%%******************************** make listoffigures **************************************
\renewcommand\listoffigures{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	{\centering\chapter*{\zihao{3}\listfigurename}}%
	\@mkboth{\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}%
	\@starttoc{lof}%
	\if@restonecol\twocolumn\fi
}

%%%%******************************** make listoftables **************************************
\renewcommand\listoftables{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	{\centering\chapter*{\zihao{3}\listtablename}}%
	\@mkboth{\MakeUppercase\listtablename}{\MakeUppercase\listtablename}%
	\@starttoc{lot}%
	\if@restonecol\twocolumn\fi
	%% ================================================
	%% degree
	%\clearpage
	\if@twoside
	%\cleardoublepage
	\mbox{}\newpage\mbox{}
	\thispagestyle{fancy}
	\fi
}

%%% 

%% 1. thanks
\renewenvironment{thanks}
{{\centering\Nchapter{\NJUST@label@thanks}}}
{}

%% 2. appendix
\renewenvironment{appendix}
{{\centering\Nchapter{\NJUST@label@appendix}}}
{}
%%
%%%************ for Algorithms **************




%%
%%%%% ------------------------------------------------------------------------------------------
%%
%%%%*************************** public vars for thesis ***********************************
%%
\newcounter{nlgcounter}
\newenvironment{nlglist}{%
	\begin{list}{{(\arabic{nlgcounter})}} %
		{
			\usecounter{nlgcounter}
			\setlength{\leftmargin}{0cm}
			\setlength{\parsep}{\parskip}
			\setlength{\topsep}{1ex}
			\setlength{\itemsep}{0.4ex plus 0.5ex}
			\setlength{\labelsep}{0.3em}
			\setlength{\itemindent}{46pt}
			\setlength{\listparindent}{27pt}
		}}
		{\end{list}}
	\renewcommand{\labelenumi}{(\theenumi)}
	
	\endinput
	%%
	%% End of file `njustThesis.cls'.

