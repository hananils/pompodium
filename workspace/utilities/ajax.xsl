<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: ARTICLES
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:import href="archive.xsl" />
<xsl:import href="datetime.xsl" />
<xsl:import href="ninja.xsl" />

<xsl:output method="xml"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no"
	media-type="text/html" />

<!--
	AJAX ARCHIVE
	This template is used to fetch the site's archive via an asynchronous call
-->
<xsl:template match="data">
	<ul class="overview">
		<xsl:apply-templates select="archive//entry" mode="archive" />
	</ul>
</xsl:template>
	
	
</xsl:stylesheet>