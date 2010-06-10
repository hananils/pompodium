<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2005/Atom">

<!--
	POMPODIUM ENSEMBLE: FEED
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:import href="datetime.xsl" />
<xsl:import href="ninja.xsl" />

<xsl:output method="xml"
	omit-xml-declaration="no"
	encoding="UTF-8"
	indent="yes" />
	
<!--
	ARTICLE FEED
	The newest ten articles
-->
<xsl:template match="data">
	<feed>
	
		<!-- Feed title -->
		<title><xsl:value-of select="$website-name" /> | Articles</title>
		<link rel="self" href="{$root}/feed/"/>
		
		<!-- Last updated -->
		<updated><xsl:value-of select="concat(article-feed/entry[1]/datum, 'T', article-feed/entry[1]/datum/@time, ':00', $timezone)" /></updated>
		
		<!-- Authors -->
		<author>
			<name><xsl:value-of select="site-authors/entry[publisher = 'Yes']/full-name" /></name>
			<uri><xsl:value-of select="$root" />/about/#<xsl:value-of select="/data/site-authors/entry[publisher = 'Yes']/full-name/@handle" /></uri>
		</author>
		<xsl:apply-templates select="site-authors/entry[publisher != 'Yes' and full-name = /data/article-feed/entry/authors/item]" />
		
		<!-- Feed id -->
		<id><xsl:value-of select="concat('tag:', substring-after($root, 'http://'), ',', article-feed/entry[1]/date, ':/articles')" /></id>
		
		<!-- List of articles -->
		<xsl:apply-templates select="article-feed/entry" />
		
	</feed>	
</xsl:template>

<!--
	ARTICLE FEED
	List of articles
-->
<xsl:template match="article-feed/entry">
	<entry>
	
		<!-- Article title -->
		<title><xsl:value-of select="title" /></title>
		
		<!-- Link -->
		<link href="{$root}/articles/{title/@handle}" />
		<id><xsl:value-of select="concat('tag:', substring-after($root, 'http://'), ',', date, ':/articles/', title/@handle)" /></id>
		
		<!-- Date -->
		<updated><xsl:value-of select="concat(date, 'T', date/@time, ':00', $timezone)" /></updated>
		
		<!-- Author -->
		<author>
			<name><xsl:value-of select="authors/item[1]" /></name>
			<uri><xsl:value-of select="$root" />/about/#<xsl:value-of select="authors/item[1]/@handle" /></uri>
		</author>
		
		<!-- Category -->
		<category term="{category/item}" scheme="{$root}/archive/category/{category/item/@handle}" />
		
		<!-- Summary -->
		<summary type="xhtml">
			<div xmlns="http://www.w3.org/1999/xhtml">
			
				<!-- Cover image -->
				<img src="{$root}/image/1/400/0{cover-picture/item/image/@path}/{cover-picture/item/image/filename}" width="400" alt="{cover-picture/item/title}" />
				
				<!-- First paragraph -->
				<xsl:apply-templates select="body/p[1]" mode="ninja" />
				
				<!-- Link to website -->
				<p>
					<a href="{$root}/articles/{title/@handle}">Read full article.</a>
				</p>
				
			</div>
		</summary>
		
	</entry>
</xsl:template>

<!--
	ARTICLE FEEDS
	Contributors
-->
<xsl:template match="site-authors/entry">
	<contributor>
		<name><xsl:value-of select="full-name" /></name>
		<uri><xsl:value-of select="$root" />/about/#<xsl:value-of select="full-name/@handle" /></uri>
	</contributor>
</xsl:template>


</xsl:stylesheet>