<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM 2.0 – A Symphony Ensemble
	Copyright © 2007-2013 hana+nils · Büro für Web- und Textgestaltung, http://hananils.de
	License: http://pompodium.de/license/symphony
-->

<xsl:import href="../utilities/content.xsl" />
<xsl:import href="../utilities/content.authors.xsl" />
<xsl:import href="../utilities/content.copyright.xsl" />
<xsl:import href="../utilities/content.feature.xsl" />
<xsl:import href="../utilities/content.manipulation.xsl" />

<!--
	Features
-->
<xsl:template name="feature">
	<xsl:apply-templates select="pages/entry" mode="feature" />
</xsl:template>

<!-- 
	Articles
-->
<xsl:template name="main">
	<article class="main column-wrapper">
		<div class="column">
			<xsl:apply-templates select="pages/entry/body" mode="ninja" />
		</div>
	</article>
</xsl:template>


</xsl:stylesheet>
