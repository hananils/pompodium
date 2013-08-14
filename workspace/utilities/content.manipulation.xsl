<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM 2.0 – A Symphony Ensemble
	Copyright © 2007-2013 hana+nils · Büro für Web- und Textgestaltung, http://hananils.de
	License: http://pompodium.de/license/symphony
-->

<!-- 
	Content manipulation
-->

<!-- Unified headlines -->
<xsl:template match="h1 | h2 | h3 | h4 | h5" mode="ninja" priority="1">
	<h3>
		<xsl:apply-templates select="* | @* | text()" mode="ninja" />
	</h3>
</xsl:template>

<!-- Blockquote citation -->
<xsl:template match="blockquote/p[position() = last() and child::strong]" mode="ninja" priority="1">
	<footer>
		<xsl:value-of select="strong" />
	</footer>
</xsl:template>

<!-- Figures -->
<xsl:template match="p[starts-with(., 'image:')]" mode="ninja" priority="1">
	<xsl:variable name="file" select="normalize-space(substring-after(., 'image:'))" />

	<xsl:if test="/data/articles-media/entry/file/filename = $file">
		<figure>
			<xsl:call-template name="image">
				<xsl:with-param name="image" select="/data/articles-media/entry/file[filename = $file]" />
				<xsl:with-param name="mode" select="2" />
				<xsl:with-param name="width" select="600" />
			</xsl:call-template>
			<xsl:apply-templates select="/data/articles-media/entry[@id = /data/params/ds-articles-current.media/item]" mode="figure" />
		</figure>
	</xsl:if>
</xsl:template>


</xsl:stylesheet>