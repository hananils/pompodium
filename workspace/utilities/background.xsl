<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: ARTICLE BACKGROUND INFORMATION
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:template name="background">
	<div id="archive" class="columns">
	
		<!-- The authors -->
		<div>
			<h3>
				<xsl:text>The author</xsl:text>
				<xsl:if test="count(author-details/entry) &gt; 1">s</xsl:if>
			</h3>
			<ul class="overview">
				<xsl:apply-templates select="/data/author-details/entry" />
			</ul>
		</div>
		
		<!-- Meta information -->
		<xsl:if test="count(overview/entry) &gt; 1 or article/entry/category/item">
			<div class="meta">
			
				<!-- Related tags -->
				<xsl:if test="article/entry/tags/item">
					<h3>Tags</h3>
					<p class="tags highlight">
						<xsl:apply-templates select="article/entry/tags/item" />
					</p>
				</xsl:if>
				
				<!-- Related articles -->
				<xsl:if test="count(overview/entry) &gt; 1">
					<h3>
						<xsl:text>Related article</xsl:text>
						<xsl:if test="count(related-articles/entry[title/@handle != $title]) &gt; 1">s</xsl:if>
					</h3>
					<ul class="more list">
						<xsl:apply-templates select="related-articles/entry[title/@handle != $title]" />
					</ul>
				</xsl:if>
				
			</div>
		</xsl:if>
	</div>
</xsl:template>

<!--
	ARTICLE SIDEBAR
	Category list
-->
<xsl:template match="related-articles/entry">
	<li><a href="{$root}/articles/{title/@handle}"><xsl:value-of select="title" /></a></li>
</xsl:template>

<!--
	ARTICLE SIDEBAR
	Tag lists
-->
<xsl:template match="article/entry/tags/item">
	<xsl:if test="position() &gt; 1">, </xsl:if>
	<a href="{$root}/articles/tag/{@handle}"><xsl:value-of select="." /></a>
</xsl:template>

<!--
	ARTICLE AUTHORS
	Statistic information
-->
<xsl:template match="author-details/entry">
	<li>
		<h4 class="about">
		
			<!-- User photo -->
			<xsl:choose>
			
				<!-- Custom photo -->
				<xsl:when test="photo"><img src="{$root}/image/2/40/40/5{photo/@path}/{photo/filename}" width="40" height="40" /></xsl:when>
				
				<!-- Fallback -->
				<xsl:otherwise><img src="{$root}/image/2/40/40/5/assets/images/placeholder.png" width="40" height="40" /></xsl:otherwise>
				
			</xsl:choose>
			
			<!-- Link to profile -->
			<a href="{$root}/about/#{full-name/@handle}"><xsl:value-of select="full-name" /></a>
			
			<!-- Article count -->
			<br />
			<em>
				<xsl:value-of select="@articles" />
				<xsl:text> article</xsl:text>
				<xsl:if test="@articles &gt; 1">s</xsl:if>
			</em>
			
		</h4>
	</li>
</xsl:template>

<!--
	SITE AUTHORS
	Background information on the about page
-->
<xsl:template match="site-authors/entry">
	<li id="{full-name/@handle}">
		<h4 class="about">
		
			<!-- User photo -->
			<xsl:choose>
			
				<!-- Custom photo -->
				<xsl:when test="photo"><img src="{$root}/image/2/40/40/5{photo/@path}/{photo/filename}" width="40" height="40" /></xsl:when>
				
				<!-- Fallback -->
				<xsl:otherwise><img src="{$root}/image/2/40/40/5/assets/images/placeholder.png" width="40" height="40" /></xsl:otherwise>
				
			</xsl:choose>
			
			<!-- Link to profile -->
			<a href="{$root}/about/{full-name/@handle}"><xsl:value-of select="full-name" /></a>
			
			<!-- Article count -->
			<br />
			<em>
				<xsl:value-of select="@articles" />
				<xsl:text> article</xsl:text>
				<xsl:if test="@articles != 1">s</xsl:if>
			</em>
			
		</h4>
		
		<!-- Biography -->
		<xsl:apply-templates select="biography/*" mode="ninja" />
		
	</li>
</xsl:template>

<!--
	ADDRESS COLUMNS
	Contact information on the about page
-->
<xsl:template match="entry[title/item = 'Imprint']/body/ul" mode="ninja" priority="1">
	<div class="columns imprint">
	
		<!-- Name, phone number, mail address -->
		<div>
			<p>
				<xsl:apply-templates select="li[1]/* | li[1]/@* | li[1]/text()" mode="ninja" />
			</p>
		</div>
		
		<!-- Postal address -->
		<div class="address">
			<p>
				<xsl:apply-templates select="li[2]/* | li[2]/@* | li[2]/text()" mode="ninja" />
			</p>
		</div>
		
	</div>	
</xsl:template>


</xsl:stylesheet>
