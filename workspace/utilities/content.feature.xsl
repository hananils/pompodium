<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM 2.0 – A Symphony Ensemble
	Copyright © 2007-2013 hana+nils · Büro für Web- und Textgestaltung, http://hananils.de
	License: http://pompodium.de/licence/
-->

<!-- 
	Feature 
-->
<xsl:template match="entry" mode="feature">
	<header id="feature" class="column-wrapper">

		<!-- Cover image -->
		<xsl:apply-templates select="/data/articles-media/entry[@id = current()/cover-image/item/@id]" mode="cover" />

		<!-- Introduction -->
		<xsl:apply-templates select="." mode="introduction" />
	</header>
</xsl:template>

<!-- Cover image -->
<xsl:template match="entry" mode="cover">
	<xsl:attribute name="style">
		<xsl:value-of select="concat('background-image: url(', $workspace, file/@path, '/', file/filename, ')')" />
	</xsl:attribute>

	<!-- Copyright information -->
	<xsl:apply-templates select="." mode="copyright" />
</xsl:template>

<!-- Introduction -->
<xsl:template match="entry" mode="introduction">
	<xsl:variable name="link" select="concat($root, '/', $current-page, '/', title/@handle, '/')" />
	<xsl:variable name="continue">
		<xsl:if test="$title = '' and name(..) != 'pages'">
			<xsl:text> </xsl:text>
			<a href="{$link}" class="continue">Continue reading …</a>
		</xsl:if>
	</xsl:variable>

	<div class="column introduction dark-text">

		<!-- Meta information -->
		<xsl:if test="author or date or category">
			<ul class="introduction-meta dark">
				<xsl:apply-templates select="author" mode="feature" />
				<xsl:apply-templates select="date" mode="feature" />
				<xsl:apply-templates select="category" mode="feature" />
			</ul>
		</xsl:if>

		<!-- Title -->
		<h2>
			<a href="{$link}">
				<xsl:value-of select="title" />
			</a>
		</h2>

		<!-- Introduction -->
		<xsl:apply-templates select="introduction/*" mode="ninja">
			<xsl:with-param name="suffix" select="$continue" />
		</xsl:apply-templates>
	</div>
</xsl:template>

<!-- Meta information -->
<xsl:template match="author | category" mode="feature">
	<li>
		<xsl:apply-templates select="item" mode="feature" />
	</li>
</xsl:template>

<!-- Authors and categories -->
<xsl:template match="item" mode="feature">
	<xsl:if test="position() != 1">, </xsl:if>
	<a href="{$root}/{$root-page}/{name(..)}/{@handle}/">
		<xsl:value-of select="." />
	</a>
</xsl:template>

<!-- Date -->
<xsl:template match="date" mode="feature">
	<xsl:variable name="year" select="substring(date/start, 1, 4)" />
	<xsl:variable name="month" select="substring(date/start, 6, 2)" />

	<li>
		<a href="{$root}/{$root-page}/date/{$year}/{$month}/">
			<xsl:call-template name="datetime">
				<xsl:with-param name="date" select="date/start" />
				<xsl:with-param name="format" select="'x M Y'" />
			</xsl:call-template>
		</a>
	</li>
</xsl:template>


</xsl:stylesheet>