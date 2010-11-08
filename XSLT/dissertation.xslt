<?xml version='1.0' encoding='utf-8'?>

<!-- XHTML-to-Memoir converter by Fletcher Penney
	specifically designed for use with MultiMarkdown created XHTML

	Uses the LaTeX memoir class for output as a dissertation
	
	MultiMarkdown Version 2.0.b6
	
	$Id: xhtml2memoirtwosided.xslt 98 2006-09-12 02:31:43Z fletcher $
-->

<!-- 
# Copyright (C) 2005-2008  Fletcher T. Penney <fletcher@fletcherpenney.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the
#    Free Software Foundation, Inc.
#    59 Temple Place, Suite 330
#    Boston, MA 02111-1307 USA
-->

	
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:html="http://www.w3.org/1999/xhtml"
	version="1.0">

	<xsl:import href="6x9book.xslt"/>
	
	<xsl:output method='text' encoding='utf-8'/>

	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<xsl:apply-templates select="html:html/html:head"/>
		<xsl:apply-templates select="html:html/html:body"/>
		<xsl:call-template name="latex-footer"/>
	</xsl:template>

	<xsl:template name="latex-document-class">
		<xsl:text>\documentclass[10pt,twoside]{memoir}
\usepackage{layouts}[2001/04/29]
\usepackage[round]{natbib}
\makeglossary
\makeindex

\def\mychapterstyle{default}
\def\mypagestyle{headings}
\def\revision{}

</xsl:text>
	</xsl:template>

		
	<!-- remove support for abstracts -->
	<xsl:template match="html:h2[1][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	'abcdefghijklmnopqrstuvwxyz') = 'abstract']">
		<xsl:text>\chapter{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template match="html:h2[preceding-sibling::html:h2[position()='1'][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'abcdefghijklmnopqrstuvwxyz') = 'abstract']]">
		<xsl:text>\chapter{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template match="html:h3[preceding-sibling::html:h2[position()='1'][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'abcdefghijklmnopqrstuvwxyz') = 'abstract']]">
		<xsl:text>\section{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template match="html:h4[preceding-sibling::html:h2[position()='1'][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'abcdefghijklmnopqrstuvwxyz') = 'abstract']]">
		<xsl:text>\subsection{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<!-- support for specifying table of contents -->
	<xsl:template match="html:h2[translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	'abcdefghijklmnopqrstuvwxyz') = 'toc']">
		<xsl:text>\clearpage
\tableofcontents

\clearpage
\listoffigures
\listoftables

\setlength{\parindent}{1em}

\mainmatter

</xsl:text>
	</xsl:template>


	<xsl:template match="html:p[preceding-sibling::html:h2[1][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	'abcdefghijklmnopqrstuvwxyz') = 'acknowledgments']]">
		<xsl:text>\begin{center}
</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>\end{center}

</xsl:text>
	</xsl:template>

	<!-- support for excerpts as special chapters -->
	<xsl:template match="html:h2[starts-with(translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'abcdefghijklmnopqrstuvwxyz'),'excerpt')]">
		<xsl:text>\chapter*{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>\label{</xsl:text>
		<xsl:value-of select="@id"/>
		<xsl:text>}</xsl:text>
		<xsl:text>\addcontentsline{toc}{chapter}{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>

	<xsl:template name="latex-begin-body">
	</xsl:template>

	<!-- natbib Support -->

	<xsl:template match="html:span[@class='externalcitation']">
		<xsl:text>\cite</xsl:text>
		<xsl:choose>
			<xsl:when test="child::html:span[@class='locator']">
				<xsl:apply-templates select="html:span" mode="citation"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>p*</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="html:a" mode="citation"/>
		<xsl:text>}</xsl:text>
	</xsl:template>

	<xsl:template match="html:span[@class='locator']" mode="citation">
		<xsl:choose>
			<xsl:when test="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
				'abcdefghijklmnopqrstuvwxyz') = 'textcite'">
				<xsl:text>t*</xsl:text>
			</xsl:when>
			<xsl:when test = "starts-with( translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
				'abcdefghijklmnopqrstuvwxyz'),'see')">
				<xsl:text>p*[see][</xsl:text>
				<xsl:value-of select="substring-after(.,'see')"/>
				<xsl:text>]</xsl:text>
			</xsl:when>
			<xsl:when test = "starts-with( translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
				'abcdefghijklmnopqrstuvwxyz'),'e.g.')">
				<xsl:text>p*[e.g.][</xsl:text>
				<xsl:value-of select="substring-after(.,'e.g.')"/>
				<xsl:text>]</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>p*[</xsl:text>
				<xsl:value-of select="."/>
				<xsl:text>]</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- special formatting for the roundtable "screenplay" quotation in Chapter 6 -->
	

	<xsl:template match = "html:blockquote/html:blockquote[preceding::html:h2[position() = '1'][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'abcdefghijklmnopqrstuvwxyz') = 'discussion']]">
		<xsl:text>\begin{quotation}
\setlength{\parindent}{0em}
\noindent
</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>\end{quotation}

</xsl:text>
	</xsl:template>

	<xsl:template match = "html:blockquote[child::html:blockquote][preceding::html:h2[position() = '1'][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'abcdefghijklmnopqrstuvwxyz') = 'discussion']]">
		<xsl:text>\begin{quotation}
\setlength{\parindent}{0em}
\noindent
</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>\end{quotation}

</xsl:text>
	</xsl:template>

	<!-- find the second block following an excerpt - this should be the first 
	blockquote paragraph.  Don't indent it -->
	<xsl:template match = "html:blockquote[preceding-sibling::*[position() = '2'][starts-with(translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'abcdefghijklmnopqrstuvwxyz'),'excerpt')]]">
		<xsl:text>\begin{quotation}
\noindent
</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>\end{quotation}

</xsl:text>
	</xsl:template>

	<!-- reset epigraph (so that Chapter 6 works as well) -->
	<!-- epigraph (a blockquote immediately following a header 1-3) -->
	<xsl:template match="html:blockquote[preceding-sibling::*[1][local-name() = 'h1' or local-name() = 'h2' or local-name() = 'h2' or local-name() = 'h3' ]]">
		<xsl:text>\epigraph{</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>}

\noindent </xsl:text>
	</xsl:template>

	<!-- epigraph author (a blockquote within blockquote) -->
	<xsl:template match="html:blockquote[last()][parent::*[preceding-sibling::*[1][local-name() = 'h1' or local-name() = 'h2' or local-name() = 'h2' or local-name() = 'h3']]] ">
		<xsl:text>}{</xsl:text>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
		
	<!-- Center blockquotes in special chapters at beginning -->

	<xsl:template match="html:blockquote[preceding-sibling::html:h2[1][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	'abcdefghijklmnopqrstuvwxyz') = 'abstract']]">
		<xsl:text>\begin{center}
</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>\end{center}

</xsl:text>
	</xsl:template>

	<xsl:template match="html:blockquote[preceding-sibling::html:h2[1][translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	'abcdefghijklmnopqrstuvwxyz') = 'dedication']]">
		<xsl:text>\begin{center}
</xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:text>\end{center}

</xsl:text>
	</xsl:template>

	
</xsl:stylesheet>