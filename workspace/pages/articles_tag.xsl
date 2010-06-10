<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: ARCHIVE BY TAG
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:import href="../utilities/master.xsl" />
<xsl:param name="title" />

<!--
	ARCHIVE BY TAG
	Content area
-->
<xsl:template name="content">

	<!-- Headline > headline.xsl -->
	<xsl:apply-templates select="article/entry" mode="headline" />
	
	<!-- Archive > archive.xsl -->
	<xsl:call-template name="archive" />
	
</xsl:template>


</xsl:stylesheet>