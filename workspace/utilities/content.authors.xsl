<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM 2.0 – A Symphony Ensemble
	Copyright © 2007-2013 hana+nils · Büro für Web- und Textgestaltung, http://hananils.de
	License: http://pompodium.de/license/symphony
-->

<!--
	Authors
-->
<xsl:template match="authors" mode="content">
	<footer id="authors" class="column-wrapper">
		<ul class="column">
			<xsl:choose>
				<xsl:when test="$title != ''">
					<xsl:apply-templates select="entry[name/@handle = /data/params/ds-articles-current.author/item]" mode="content" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="entry" mode="content" />
				</xsl:otherwise>
			</xsl:choose>
		</ul>
	</footer>
</xsl:template>

<xsl:template match="authors/entry" mode="content">
	<li>
		<img src="http://www.gravatar.com/avatar/{email/@hash}?s=170" width="85" height="85" />
		<p>
			<a href="{$root}/{$root-page}/author/{name/@handle}">
				<xsl:value-of select="name" />
			</a>
			<xsl:apply-templates select="about/p/* | about/p/text()" mode="ninja" />
		</p>
	</li>
</xsl:template>


</xsl:stylesheet>