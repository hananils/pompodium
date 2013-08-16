<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM 2.0 – A Symphony Ensemble
	Copyright © 2007-2013 hana+nils · Büro für Web- und Textgestaltung, http://hananils.de
	License: http://pompodium.de/licence/
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
	<xsl:apply-templates select="articles-current/entry" mode="feature" />
</xsl:template>

<!-- 
	Articles
-->
<xsl:template name="main">
	<xsl:choose>

		<!-- Single article -->
		<xsl:when test="$title != ''">
			<xsl:apply-templates select="articles-current/entry" mode="content" />
		</xsl:when>

		<!-- Article overview -->
		<xsl:otherwise>
			<xsl:apply-templates select="articles-overview/entry" mode="content" />

			<!-- Pagination -->
			<xsl:if test="articles-overview/pagination/@total-pages &gt; 1">
				<div class="pagination column-wrapper">
					<xsl:call-template name="pagination">
						<xsl:with-param name="pagination" select="articles-overview/pagination" />
						<xsl:with-param name="pagination-url" select="concat($root, '/', $root-page, '/?page=$')" />
						<xsl:with-param name="label-next" select="'older'" />
						<xsl:with-param name="label-previous" select="'newer'" />
						<xsl:with-param name="class-pagination" select="'column dark'" />
					</xsl:call-template>
				</div>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>

	<!-- Authors -->
	<xsl:apply-templates select="authors" mode="content" />
</xsl:template>

<xsl:template match="articles-overview/entry" mode="content">
	<article class="main column-wrapper">
		<xsl:apply-templates select="." mode="introduction" />
	</article>
</xsl:template>

<xsl:template match="articles-current/entry" mode="content">
	<article class="main column-wrapper">
		<div class="column">
			<xsl:apply-templates select="body" mode="ninja" />
			<xsl:apply-templates select="/data/articles-media/entry[@id != /data/articles-current/entry/cover-image/item/@id]" mode="image" />
		</div>
	</article>
</xsl:template>

<!-- Images -->
<xsl:template match="articles-media/entry" mode="image">
	<xsl:if test="count(/data/articles-current/entry/body/p[text() = concat('image: ', current()/file/filename)]) = 0">
		<figure>
			<xsl:call-template name="image">
				<xsl:with-param name="image" select="file" />
				<xsl:with-param name="mode" select="2" />
				<xsl:with-param name="width" select="600" />
			</xsl:call-template>
			<xsl:apply-templates select="." mode="figure" />
		</figure>
	</xsl:if>
</xsl:template>


</xsl:stylesheet>
