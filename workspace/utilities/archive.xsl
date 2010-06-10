<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: ARCHIVE
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:template name="archive">
	<div id="archive" class="columns">

		<!-- Left column -->
		<div>	
			<xsl:choose>
				<xsl:when test="$current-page = 'date' ">
					<xsl:apply-templates select="archive/year/month" />
				</xsl:when>
				<xsl:when test="$current-page = 'tag' ">
					<h3>Tag &#187;<xsl:value-of select="archive//entry/tags/item[@handle = $tag]" />&#171;</h3>
					<ul class="overview">
						<xsl:apply-templates select="archive//entry" mode="archive"/>
					</ul>
				</xsl:when>
				<xsl:when test="$current-page = 'category' ">
					<h3>Category &#187;<xsl:value-of select="archive//entry/category/item[1]" />&#171;</h3>
					<ul class="overview">
						<xsl:apply-templates select="archive//entry" mode="archive"/>
					</ul>
				</xsl:when>
				<xsl:otherwise>
					<h3>About this site</h3>
					<xsl:apply-templates select="/data/about/entry/body/*" mode="ninja" />
				</xsl:otherwise>
			</xsl:choose>
		</div>

		<!-- Right column -->
		<xsl:if test="count(overview/entry) &gt; 1 or article/entry/category/item">
			<div class="meta">
				<h3>Articles by date</h3>
				<xsl:apply-templates select="/data/dates/year" />
				<h3>Articles by tag</h3>
				<p class="tags highlight">
					<xsl:apply-templates select="/data/tags/item">
						<xsl:sort select="@handle" order="ascending" />
					</xsl:apply-templates>
				</p>
				<h3>Articles by category</h3>
				<ul class="more">
					<xsl:apply-templates select="/data/categories/item">
						<xsl:sort select="@handle" order="ascending" />
					</xsl:apply-templates>
				</ul>
			</div>
		</xsl:if>
	</div>
</xsl:template>

<!--
	ARCHIVE SIDEBAR
	Category list
-->
<xsl:template match="/data/categories/item">
	<li><a href="{$root}/articles/category/{@handle}"><xsl:value-of select="." /></a></li>
</xsl:template>

<!--
	ARCHIVE SIDEBAR
	Tag list
-->
<xsl:template match="/data/tags/item">
	<xsl:if test="position() &gt; 1">, </xsl:if>
	<a href="{$root}/articles/tag/{@handle}"><xsl:value-of select="." /></a>
</xsl:template>

<!--
	ARCHIVE SIDEBAR
	Years
-->
<xsl:template match="/data/dates/year">
	<p class="date highlight">
		<em><xsl:value-of select="substring(@value, 3, 2)" /></em><xsl:apply-templates select="month" />
	</p>
</xsl:template>

<!--
	ARCHIVE SIDEBAR<
	Month list
-->
<xsl:template match="/data/dates/year/month">
	<xsl:if test="position() &gt; 1">, </xsl:if>
	<a href="{$root}/articles/date/{ancestor::year/@value}/{@value}">
	
		<!-- Date > datetime.xsl -->
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="concat(ancestor::year/@value, '-', @value, '-01')" />
			<xsl:with-param name="time" select="'00:00'" />
			<xsl:with-param name="weekday" select="'1'" />
			<xsl:with-param name="format" select="'M'" />
		</xsl:call-template>
		
	</a> 
</xsl:template>

<!--
	ARCHIVE OVERVIEW
	Ordered by date
-->
<xsl:template match="archive//year/month">
	<h3>

		<!-- Date > datetime.xsl -->
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="concat(ancestor::year/@value, '-', @value, '-01')" />
			<xsl:with-param name="time" select="'00:00'" />
			<xsl:with-param name="weekday" select="'1'" />
			<xsl:with-param name="format" select="'M Y'" />
		</xsl:call-template>

	</h3>
	<ul class="overview">
		<xsl:apply-templates select="entry" mode="archive"/>
	</ul>
</xsl:template>

<!-- 
	ARCHIVE ENTRY
	Article preview
-->
<xsl:template match="entry" mode="archive">
	<li>
		<h4 class="about without">
			<a href="{$root}/articles/{title/@handle}">
				<xsl:value-of select="title" />
			</a>
			<br />
			<em><xsl:apply-templates select="authors/item" /></em>
		</h4>
	</li>
</xsl:template>

<!--
	ARTICLE PREVIEW
	Authors
-->
<xsl:template match="authors/item">
	<xsl:if test="position() &gt; 1">, </xsl:if>
	<a href="{$root}/about/{@handle}"><xsl:value-of select="." /></a>
</xsl:template>


</xsl:stylesheet>
