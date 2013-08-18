<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM 2.0 – A Symphony Ensemble
	Copyright © 2007-2013 hana+nils · Büro für Web- und Textgestaltung, http://hananils.de
	License: http://pompodium.de/licence/
-->

<!--
	Copyright
-->
<xsl:template match="articles-media/entry" mode="copyright">
	<aside class="copyright">
		<span>
			<xsl:apply-templates select="." mode="author" />
			<xsl:apply-templates select="licence/item" />
		</span>
	</aside>
</xsl:template>

<!-- Figure -->
<xsl:template match="articles-media/entry" mode="figure">
	<figcaption>
			<xsl:apply-templates select="." mode="author" />
			<xsl:apply-templates select="licence/item" />
	</figcaption>
</xsl:template>

<!-- Copyright holder -->
<xsl:template match="articles-media/entry" mode="author">
	<xsl:text>Image by </xsl:text>
	<xsl:choose>
		<xsl:when test="link">
			<a href="{link}">
				<xsl:value-of select="author" />
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="author" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Licence -->
<xsl:template match="licence/item">
	<xsl:if test="ancestor::entry/author"> – </xsl:if>
	<xsl:choose>
		<xsl:when test="starts-with(@handle, 'cc')">
			<a href="http://creativecommons.org/licenses/{substring-after(@handle, 'cc-')}/3.0/" title="{.}">Some rights reserved</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="." />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


</xsl:stylesheet>
