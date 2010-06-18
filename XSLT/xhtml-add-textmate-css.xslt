<?xml version="1.0"?>
<!-- based on http://www.xmlplease.com/xhtmlxhtml -->

<xsl:stylesheet version="1.0"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xhtml xsl">

<xsl:output method='xml' version="1.0" encoding='utf-8' doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN" doctype-system="http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd" indent="no"/>

<!-- the identity template -->
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<!-- template for the head section. Only needed if we want to change, delete or add nodes. In our case we need it to add a link element pointing to an external CSS stylesheet. -->

<xsl:template match="xhtml:head">
  <xsl:copy>
      <link rel="stylesheet" href="file:///Applications/TextMate.app/Contents/SharedSupport/Support/themes/default/style.css" type="text/css" />
	  <link rel="stylesheet" href="file:///Applications/TextMate.app/Contents/SharedSupport/Support/themes/bright/style.css" type="text/css" />
	  <style type="text/css">
      <xsl:comment>
        body {margin-top: -78px;}
      </xsl:comment>
      </style>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<!-- template for the body section. Only needed if we want to change, delete or add nodes. In our case we need it to add a div element containing a menu of navigation. -->
<xsl:template match="xhtml:body">
  <xsl:copy>
  <div id="tm_webpreview_content" class="bright"> 

    <xsl:apply-templates select="@*|node()"/>
  </div>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>