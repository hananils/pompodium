<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM 2.0 – A Symphony Ensemble
	Copyright © 2007-2013 hana+nils · Büro für Web- und Textgestaltung, http://hananils.de
	License: http://pompodium.de/licence/
-->

<xsl:import href="kit/ninja.xsl" />
<xsl:import href="kit/datetime.xsl" />
<xsl:import href="kit/images.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<!--
	Atom
-->
<xsl:template match="data">
	<feed>
		<xsl:apply-templates select="authors/entry" />
		<title>
			<xsl:value-of select="$website-name"/>
		</title>
		<id>
			<xsl:value-of select="$root" />
		</id>
		<updated>
			<xsl:value-of select="articles-overview/entry[1]/date/date/start/@iso" />
		</updated>
		
		<!-- Articles -->
		<xsl:apply-templates select="articles-overview/entry" />
	</feed>
</xsl:template>

<!-- Authors -->
<xsl:template match="authors/entry">
	<author>
		<name>
			<xsl:value-of select="name" />
		</name>
	</author>
</xsl:template>

<!-- 
	Articles
-->
<xsl:template match="entry">
	<entry>
		<title>
			<xsl:value-of select="title" />
		</title>
		<link href="{$root}/{../section/@handle}/{title/@handle}/"/>
		<id>
			<xsl:value-of select="@id" />
		</id>
		<updated>
			<xsl:value-of select="date/date/start/@iso" />
		</updated>
		
		<!-- Content -->
		<content type="xhtml">
			<xsl:call-template name="image">
				<xsl:with-param name="image" select="/data/articles-media/entry[@id = current()/cover-image/item/@id]/file" />
				<xsl:with-param name="mode" select="2" />
				<xsl:with-param name="width" select="300" />
			</xsl:call-template>
			<xsl:apply-templates select="introduction/*" mode="ninja" />
		</content>
	</entry>
</xsl:template>


</xsl:stylesheet>
