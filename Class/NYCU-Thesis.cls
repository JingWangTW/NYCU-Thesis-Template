%----------------------------------------------------------------------
% 本文件係採用創用 "CC 姓名標示-非商業性-相同方式分享 3.0 台灣" 授權條款授權
% (https://creativecommons.org/licenses/by-nc-sa/3.0/tw/legalcode)
%
% 本授權條款允許使用者重製、散布、傳輸以及修改著作，但不得為商業目的之使用。若使
% 用者修改該著作時，僅得依本授權條款或與本授權條款類似者來散布該衍生作品。使用時
% 必須按照著作人指定的方式表彰其姓名。
%----------------------------------------------------------------------
% Template Name: NYCU-Thesis
% Version: 2.1.0
% Version: Update: Sep. 09, 2021
% Author: JingWangTW
% Author's GitHub Page: https://github.com/JingWangTW
%----------------------------------------------------------------------
% Origin File: https://github.com/yungshenglu/NCTU-Thesis-Template/blob/master/Class/NCTUtran.cls
% Origin Author: Yung-Sheng Lu
% Origin Author's GitHub Page: https://github.com/yungshenglu
%----------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Class/NYCU-Thesis}[2021-09-09 v2.1.0 by JingWangTW]
\gdef\@ClassName{NYCU-Thesis}
%----------------------------------------------------------------------
% Table of Contents
%   1.0 - Document Options Declaration
%   2.0 - Include Required Package
%   3.0 - Macro Definition
%   4.0 - Font Configuration
%   5.0 - Page Layout
%       5.1 - Cover Page Layout
%       5.2 - Title Page Layout
%       5.3 - Authorization Page Layout
%       5.4 - Approval Page Layout
%       5.5 - Chinese Abstract Layout
%       5.6 - English Abstract Layout
%       5.7 - ToC, LoF, LoT Layout
%       5.8 - Chapter Contents Layout
%       5.9 - Reference Layout
%       5.10 - Appendices Layout
%   6.0 - Utility Command / Tools
%----------------------------------------------------------------------


%======================================================================
% 1.0 Document Options Declaration
%======================================================================

% Inherent existing options from document class "book"
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{book}
}

% Declare options for print modes: (default: draft)
%   1. draft    : draft for defence
%   2. final    : print version
\newif\ifThesisModeDraft        
\newif\ifThesisModeFinal        

% Default mode for print mode
\ThesisModeDrafttrue
\ThesisModeFinalfalse

\DeclareOption{draft}{
    \ThesisModeDrafttrue
    \ThesisModeFinalfalse
    
    \PackageWarningNoLine{\@ClassName}{Set \hbadness to 10000 in draft mode}
    \hbadness 10000
}

\DeclareOption{final}{
    \ThesisModeDraftfalse
    \ThesisModeFinaltrue
}

% Declare options for usage: (default: print)
%   1. print    : output with cover page
%   2. upload   : output without cover and auth page
\newif\ifThesisUsagePrint               
\newif\ifThesisUsageUpload              

% Default mode for usage
\ThesisUsagePrinttrue
\ThesisUsageUploadfalse

\DeclareOption{print}{
    \ThesisUsagePrinttrue
    \ThesisUsageUploadfalse
}

\DeclareOption{upload}{
    \ThesisUsagePrintfalse
    \ThesisUsageUploadtrue
}

% Load options passed to document class
\ProcessOptions
\LoadClass[a4paper, 12pt, oneside]{book}

%======================================================================
% 2.0 Include Required Package
%======================================================================
% Pass "final" option to package graphics at the very fist time
% Since package "graphicx" may be used by other packages
% We need to pass the option at the very first time
\PassOptionsToPackage{final}{graphicx}
% For chinese typing
\usepackage[BoldFont, SlantFont, CJKchecksingle, CJKmath=true]{xeCJK}
% To set space between lines
\usepackage{setspace}
% To include pdf file
\usepackage{pdfpages}
% For condition if (e.g., \ifthenelse)
\usepackage{ifthen}
% For exntend used of hypertext in the document(include  \phantomsection)
\usepackage{hyperref}
% For custom header and footer of
\usepackage{fancyhdr}
% Alternative headings for Toc, LoF, LoT
\usepackage{titletoc}
% For custom content in ToC, LoF, and LoT (add dots between title and page numbers)
\usepackage{tocloft}
% For page layout
\usepackage[a4paper]{geometry}
% For manipulation of length arithmetic
\usepackage{calc}
% For alternative section titles
\usepackage{titlesec}
% Indent first paragraph
\usepackage{indentfirst}
% To config figures
\usepackage{graphicx}
% For using "\bstctlcite"
\usepackage[retainorgcmds]{IEEEtrantools}
% For custom caption
\usepackage{caption}
% Using math tools, e.g. "equation" environment
\usepackage{amsmath}
% For special math symbol
\usepackage{amssymb}
% Specail Font in math zone
\usepackage{amsfonts}
% For caption in subfigure
\usepackage[list=true]{subcaption}
% For "algorithm" environment
\usepackage[ruled,vlined,algochapter]{algorithm2e}
% For floating object
\usepackage{float}
% For tabular spanning multiple rows
\usepackage{multirow}
% For diagnoal cell in the table
\usepackage{diagbox}
% For "tabularx" environment
\usepackage{tabularx}
% To create box that can over the page border
\usepackage{adjustbox}
% For double cline in table environment
\usepackage{hhline}
% For multiple footnotes in table
\usepackage{tablefootnote}
% For "TM" trademark
\usepackage{textcomp}
% For better bib (show "visited on" text after an url)
\usepackage[
    backend=biber,
    style=ieee,
    sorting=none,
    dashed=false
]{biblatex}
% For breaking url in bib
\usepackage{xurl}
% For unit transform
\usepackage{siunitx}
% For custom appendix
\usepackage{appendix}
% For converting arabic number to chinese number
\usepackage{Class/xCJKnumb}
% For the position of watermark 
\usepackage{tikz}
% For Watermark
\usepackage{eso-pic}

%======================================================================
% 3.0 Macro Definition
%======================================================================

% 中英文論文題目
\def\zhTitle#1{\gdef\@zhTitle{#1}}
\def\enTitle#1{\gdef\@enTitle{#1}}

% 中英文關鍵字
\def\zhKeywords#1{\gdef\@zhKeywords{#1}}
\def\enKeywords#1{\gdef\@enKeywords{#1}}

% 研究生中英文姓名
\def\zhStudentName#1{\gdef\@zhStudentName{#1}}
\def\enStudentName#1{\gdef\@enStudentName{#1}}

% 指導教授中英文姓名
\def\zhAdvisorName#1{\gdef\@zhAdvisorName{#1}}
\def\enAdvisorName#1{\gdef\@enAdvisorName{#1}}

% 中英文大學名稱
\def\zhUnivName#1{\gdef\@zhUnivName{#1}}
\def\enUnivName#1{\gdef\@enUnivName{#1}}

% 中英文學院名稱
\def\zhCollegeName#1{\gdef\@zhCollegeName{#1}}
\def\enCollegeName#1{\gdef\@enCollegeName{#1}}

% 中英文研究所名稱
\def\zhInstName#1{\gdef\@zhInstName{#1}}
\def\enInstName#1{\gdef\@enInstName{#1}}

% 英文學位名稱
\def\enDegree#1{\gdef\@enDegree{#1}}

% 英文領域名稱
\def\enField#1{\gdef\@enField{#1}}

% 英文地點名稱
\def\enLocation#1{\gdef\@enLocation{#1}}

% 中英文論文日期
\def\zhDegreeYear#1{\gdef\@zhDegreeYear{#1}}
\def\zhDegreeMonth#1{\gdef\@zhDegreeMonth{#1}}
\def\enDegreeYear#1{\gdef\@enDegreeYear{#1}}
\def\enDegreeMonth#1{\gdef\@enDegreeMonth{#1}}

% The path to watermark
\def\watermark#1{\gdef\@watermark{#1}}

%----------------------------------------------------------------------
% WATERMARK (浮水印)
%----------------------------------------------------------------------

% Set the source of watermark
\newcommand\BackgroundPicture{
    % For draft mode, print "DRAFT"
    \ifThesisModeDraft
        \setlength{\@tempdimb}{.5\paperwidth}
        \setlength{\@tempdimc}{.5\paperheight}
        \setlength{\unitlength}{1pt}
        \put(\strip@pt\@tempdimb,\strip@pt\@tempdimc){
        \makebox(0,0){\rotatebox{45}{\textcolor[gray]{0.75}
            {\fontsize{6cm}{6cm}\selectfont{DRAFT}}}}
        }
    \fi
    % HINT: For final mode, print the watermark specified by \watermark{}
    \ifThesisModeFinal
        \begin{tikzpicture}
            \node[minimum width=\paperwidth, minimum height=\paperheight, opacity=0.15]
                {\includegraphics[width=0.85\textwidth]{\@watermark}};
        \end{tikzpicture}
    \fi
}

% Update \cleardoublepage to handle watermark
% 	\chapter{} implicity calls \cleardoublepage first, then starts to print chapter title and contents
\let\oldcleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{
	% Remove watermark if previous page is a blank even page in twoside mode.
	\newpage
	\ClearShipoutPicture
	\oldcleardoublepage
	% Add watermark
	\AddToShipoutPicture{\BackgroundPicture}
}

%======================================================================
% 4.0 Font Configuration
%======================================================================

%%% CHINESE Font %%%
\newcommand{\zhFont}[1]{
    \ifx &#1&
        \PackageError{\@ClassName}{請透過\zhFont設定中文字型}{請提供中文字型的名稱}
    \else
        \setCJKmainfont{#1}
    \fi
}

%%% English Font %%%
\newcommand{\enFont}[1]{
    \ifx &#1&
        \PackageError{\@ClassName}{請透過\enFont設定英文字型}{請提供英文字型的名稱}
    \else
        \setmainfont{#1}
    \fi
}

%%% TypeWriter Font %%%
\newcommand{\ttFont}[1]{
    \ifx \NOT &#1&
        \CJKttdefault{#1}
    \fi
}

%%% URL Font %%%
\urlstyle{same}

%======================================================================
% 5.0 Page Layout
%======================================================================

%%% Page Layout %%%
\geometry{
    a4paper,
    left=3cm,
    right=2cm,
    top=2.5cm,
    bottom=2.5cm,
    footskip=1cm,
}

%%% Header and Footer %%%
\pagestyle{fancy}
\fancyhf{} % Clear origin header and footer configuration
\renewcommand{\headrulewidth}{0pt}
\cfoot{\thepage}

%%% Show link in draft mode either %%%
\hypersetup{final}

%=================================  5.1 Cover Page Layout  =================================

%%% Cover Page Generator %%%
\def\makeCoverPage{

    % Cover Page Layout rule provided by NYCU
    \newgeometry{
        left=2cm,
        right=2cm,
        top=3cm,
        bottom=3cm,
        footskip=0cm,
    }

    %  Produces empty heads and feet - no page numbers.
    \thispagestyle{empty}

    \begin{center}
        \begin{doublespacing}

            \fontsize{18}{27}{\selectfont \@zhUnivName} \\
            \fontsize{18}{27}{\selectfont \@zhInstName} \\
            \fontsize{18}{27}{\selectfont 碩士論文}      \\

            \vfill

            \fontsize{14}{14}{\selectfont \@enInstName} \\
            \fontsize{16}{16}{\selectfont \@enUnivName} \\
            \fontsize{16}{16}{\selectfont Master Thesis} \\

            \vfill

            \fontsize{18}{18}{\selectfont \@zhTitle} \\
            \fontsize{18}{18}{\selectfont \@enTitle} \\

            \vfill

            \ifThesisModeDraft
                \fontsize{18}{18}{\selectfont 初稿} \\
                \vfill
            \fi

            \fontsize{18}{18}{\selectfont 研究生：\@zhStudentName（\@enStudentName）} \\
            \vspace{1\baselineskip}
            \fontsize{18}{18}{\selectfont 指導教授：\@zhAdvisorName（\@enAdvisorName）} \\

            \vfill

            \fontsize{18}{18}{\selectfont 中華民國 \@zhDegreeYear 年 \@zhDegreeMonth 月} \\
            \vspace{1.5\baselineskip}
            \fontsize{18}{18}{\selectfont \@enDegreeMonth\ \@enDegreeYear} \\
        \end{doublespacing}
    \end{center}

    % Restore Normal Page Layout
    \restoregeometry
}

%=================================  5.2 Title Page Layout  =================================

%%% Title Page Generator %%%
\def\makeTitlePage{

    \thispagestyle{empty}

	% Add watermark
	\AddToShipoutPicture*{\BackgroundPicture}

    \begin{center}
        \begin{doublespacing}

            \fontsize{18}{18}{\selectfont \@zhTitle} \\
            \fontsize{18}{18}{\selectfont \@enTitle} \\

        \end{doublespacing}

        \vfill
        
        \renewcommand{\arraystretch}{1.5}
        \fontsize{14}{14}{\selectfont
            \begin{tabularx}{\textwidth}{@{}p{2.5cm}@{}Xl@{}}
                \makebox[2.5cm][s]{研究生：}   & \@zhStudentName \hfill Student：       & \@enStudentName      \\
                \makebox[2.5cm][s]{指導教授：} & \@zhAdvisorName\ 博士 \hfill Advisor： & Dr.\ \@enAdvisorName \\
            \end{tabularx}
        }
        \renewcommand{\arraystretch}{1}

        \vfill

        \begin{doublespacing}
            \fontsize{14}{14}{\selectfont \@zhUnivName} \\
            \fontsize{14}{14}{\selectfont \@zhInstName} \\
            \fontsize{14}{14}{\selectfont 碩士論文} \\
        \end{doublespacing}

        \vfill

        \ifThesisModeDraft
            \fontsize{18}{18}{\selectfont 初稿} \\
            \vfill
        \fi

        \fontsize{14}{14}{\selectfont
            A Thesis \\
            Submitted to \@enInstName \\
            \@enCollegeName \\
            \@enUnivName \\
            in partial Fulfillment of the Requirements \\
            for the Degree of \\
            \@enDegree
            \ifthenelse{\equal{\@enField}{}}{}{\\ in \\ \@enField}
        }

        \vfill

        \fontsize{14}{14}{\selectfont \@enDegreeMonth\ \@enDegreeYear} \\
        \fontsize{14}{14}{\selectfont \@enLocation} \\
        \vspace{1.5\baselineskip}
        \fontsize{14}{14}{\selectfont 中華民國\ \@zhDegreeYear\ 年\ \@zhDegreeMonth\ 月} \\

    \end{center}
}

%=================================  5.3 Authorization Page Layout  =========================

%%% Authorization Page %%%
\newcommand{\makeAuthPage}[1]{
    % include the authorization page only when it's a final edtion and is used to print out
    \ifThesisModeFinal
        \ifThesisUsagePrint
            \includepdf{#1}
        \fi
    \fi
}

%=================================  5.4 Approval Page Layout  ==============================

%%% Approval Page %%%
\newcommand{\makeApprovalPage}[1]{
    % include the approval page only when it's a final edtion and is used to print out
    \ifThesisModeFinal
        \ifThesisUsagePrint
            \includepdf{#1}
        \fi
    \fi
}

%=================================  5.5 Acknowledgement Page Layout  =======================

%%% Acknowledgement Page %%%
\newenvironment{acknowledgement}{

    \cleardoublepage
    \thispagestyle{empty}

    \begin{center}
        \LARGE \bf \makebox[3em][s]{誌謝}
    \end{center}\
    \par
} {

}

%=================================  5.5 Chinese Abstract Layout  ===========================

%%% Environment %%%
\newenvironment{zhAbstract}{

    \cleardoublepage

    \phantomsection
    \addcontentsline{toc}{chapter}{\textbf{摘要}}

    \begin{center}
        \LARGE \bf \makebox[3em][s]{摘要}
    \end{center}\
    \par

} {
}

%%% Chinese Keyword %%%
\def\zhAbsKeywords{
    \begin{flushleft}
        {關鍵字：\textbf{\@zhKeywords}}
    \end{flushleft}
}

%=================================  5.6 English Abstract Layout  ===========================

%%% Environment %%%
\newenvironment{enAbstract}{

    \cleardoublepage

    \phantomsection
    \addcontentsline{toc}{chapter}{\textbf{Abstract}}

    \begin{center}
        \LARGE \bf {Abstract}
    \end{center}\
    \par

} {
}

%%% English Keyword %%%
\def\enAbsKeywords{
    \begin{flushleft}
        {Keywords: \textbf{\@enKeywords}}
    \end{flushleft}
}

%=================================  5.7 ToC, LoF, LoT Layout  ==============================

% Add dots between title and page number
\renewcommand{\cftchapdotsep}{\cftdotsep}

%%% Font setting for title of these tables %%%
\renewcommand{\cfttoctitlefont}{\hspace*{\fill}\Huge\bfseries}
\renewcommand{\cftaftertoctitle}{\hspace*{\fill}}
\renewcommand{\cftbeforetoctitleskip}{0in}
\renewcommand{\cftlottitlefont}{\hspace*{\fill}\Huge\bfseries}
\renewcommand{\cftafterlottitle}{\hspace*{\fill}}
\renewcommand{\cftbeforelottitleskip}{0in}
\renewcommand{\cftloftitlefont}{\hspace*{\fill}\Huge\bfseries}
\renewcommand{\cftafterloftitle}{\hspace*{\fill}}
\renewcommand{\cftbeforeloftitleskip}{0in}

%%% Title for these tables %%%
\renewcommand{\contentsname}{\makebox[3em][s]{目錄}}
\renewcommand{\listfigurename}{\makebox[4em][s]{圖目錄}}
\renewcommand{\listtablename}{\makebox[4em][s]{表目錄}}

%%% Numbering label %%%
\renewcommand{\tablename}{表}
\renewcommand{\figurename}{圖}
\DeclareCaptionLabelSeparator{colon}{：}    % Re-defined colon in caption to fullwidth form

%%% ToC Generator %%%
\def\maketoc{
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\textbf{目錄}}
    \tableofcontents
}

%%% LoF Generator %%%
\def\makelof{
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\textbf{圖目錄}}
    \listoffigures
}

%%% LoT Generator %%%
\def\makelot{    
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\textbf{表目錄}}
    \listoftables
}

%=================================  5.8 Chapter Contents Layout  ===========================

%%% Chapter Title Content %%%
\titleformat{\chapter}[block]
{\centering\Huge\bfseries}
{第\xCJKnumber{\thechapter}章}
{1em}
{}

%%% Chapter Title Format %%%
\titlespacing{\chapter}{0em}{0pt}{*6}

%%% Algorithm Content %%%
\ResetInOut{Input}
\SetKwInOut{Input}{\textbf{輸入}~}
\ResetInOut{Output}
\SetKwInOut{Output}{\textbf{輸出}~}
\DontPrintSemicolon

%%% Algorithm Title Format %%%
\renewcommand{\algorithmcfname}{演算法}

%%% Layout Setting %%%

% Set indent width for first line in a paragraph to two space(Fullwidth forms)
\setlength{\parindent}{(\widthof{　} * 2)}

% Set space between paragraphs
\setlength{\parskip}{(.5\baselineskip)}%

% Re-set line height
\renewcommand{\baselinestretch}{1.1}

% Custom Equation Label
\numberwithin{equation}{chapter} % This line resets equation numbering when starting a new chapter.
\renewcommand{\theequation}{式 \thechapter.\arabic{equation}} % This line add "式" in front of equation numbering.

% Set default figures placement
\graphicspath{{Figures/}}

%=================================  5.9 Reference Layout  ==================================

%%% Bibliography Generator %%%
\newcommand{\makeBib}{
    
    % Add Bibliography to ToC
    \cleardoublepage
    \phantomsection
    \addcontentsline{toc}{chapter}{\textbf{參考文獻}}

    % Print bib and set its title
    \printbibliography[title={\makebox[5.5em][s]{參考文獻}}]
}

%=================================  5.10 Appendices Layout  ================================

\newcounter{appendix}
\setcounter{appendix}{0}

% new title show in toc
\renewcommand{\addappheadtotoc}[1]{
    \phantomsection
    \addcontentsline{toc}{chapter}{\texorpdfstring{附錄\xCJKnumber{\theappendix}、#1}{#1}}
}

% new title for appendix
\renewcommand{\appendixname}[1]{
    \begin{flushleft}
        \LARGE\bfseries{附錄\xCJKnumber{\theappendix}、#1}
    \end{flushleft}
}

%%% Appendix Page %%%
\newenvironment{Appx}[1]{
    
    % Increase appendix counter by one
    \stepcounter{appendix}

    % Start a new appendix
    \appendix

    % Add appendix to toc
    \addappheadtotoc{#1}

    % Clear a new page
    \cleardoublepage

    % Show appendix title
    \appendixname{#1}

    % New label counter for seciotn under appendix
    \renewcommand\thesection{\arabic{section}}
} {

    % Restore section label
    \renewcommand\thesection{\thechapter.\arabic{section}}
}

%======================================================================
% 6.0 Utility Command / Tools
%======================================================================

% Horizon Line in Algorithm Block
\newcommand{\AlgoHRule}[0]{\vspace{1mm} \hrule \vspace{1mm}}

% Evenly distributing column widths
\newcolumntype{Y}{>{\centering\arraybackslash}X}

% Centralized the wrapped table 
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
