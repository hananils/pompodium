<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: IMAGES
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:template match="cover-picture/item | header-image/entry | images/item" mode="caption">
	<strong class="image">
		<xsl:if test="creator">Image by </xsl:if>
		
		<!-- Divider -->
		<xsl:if test="licence/item = 'All rights reserved' ">&#169; </xsl:if>
		
		<!-- Add creator -->
		<xsl:choose>
			<xsl:when test="creator and link"><a href="{link}"><xsl:value-of select="creator" /></a></xsl:when>
			<xsl:when test="not(creator) and link"><a href="{link}"><xsl:value-of select="link" /></a></xsl:when>
			<xsl:otherwise><xsl:value-of select="creator" /></xsl:otherwise>
		</xsl:choose>
		
		<!-- Divider -->
		<xsl:if test="(licence and creator) or (licence and link)"> &#8211; </xsl:if>
		
		<!-- Select licence -->
		<xsl:choose> 
		
			<!-- Create commons -->
			<xsl:when test="licence/item = 'CC - attribution only' ">
				<a href="http://creativecommons.org/licenses/by/3.0/" alt="Creative Commons: Attribution only">Some rights reserved</a>
			</xsl:when>
			<xsl:when test="licence/item = 'CC - attribution (no derivatives)' ">
				<a href="http://creativecommons.org/licenses/by-nd/3.0/" alt="Creative Commons: Attribution (no derivatives)">Some rights reserved</a>
			</xsl:when>
			<xsl:when test="licence/item = 'CC - attribution (non commercial)' ">
				<a href="http://creativecommons.org/licenses/by-nc/3.0/" alt="Creative Commons: Attribution (non commercial)">Some rights reserved</a>
			</xsl:when>
			<xsl:when test="licence/item = 'CC - attribution (non commercial / no derivatives)' ">
				<a href="http://creativecommons.org/licenses/by-nc-nd/3.0/" alt="Creative Commons: Attribution (non commercial / no derivatives)">Some rights reserved</a>
			</xsl:when>
			<xsl:when test="licence/item = 'CC - attribution (non commercial / share alike)' ">
				<a href="http://creativecommons.org/licenses/by-nc-sa/3.0/" alt="Creative Commons: Attribution (non commercial / share alike)">Some rights reserved</a>
			</xsl:when>
			<xsl:when test="licence/item = 'CC - attribution (share alike)' ">
				<a href="http://creativecommons.org/licenses/by-sa/3.0/" alt="Creative Commons: Attribution (share alike)">Some rights reserved</a>
			</xsl:when>
			
			<!-- All rights reserved -->
			<xsl:otherwise>All rights reserved</xsl:otherwise>
			
		</xsl:choose>
		
	</strong>
</xsl:template>

<!--
	ARTICLE IMAGES
	Inline images
-->
<xsl:template match="img" mode="ninja" priority="1">

	<!-- Path -->
	<xsl:variable name="path" select="/data/article/entry/images/item[image/filename = substring-after(current()/@src, 'media/')]" />
	
	<!-- Generate image -->
	<xsl:choose>
		<xsl:when test="@title = 'landscape' ">
			<xsl:attribute name="class">image landscape</xsl:attribute>
			<img src="{$root}/image/1/825/0/{substring-after(@src, 'workspace/')}" alt="{$path/title}" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="class">image</xsl:attribute>
			<img src="{$root}/image/1/600/0/{substring-after(@src, 'workspace/')}" alt="{$path/title}" />
		</xsl:otherwise>
	</xsl:choose>
	
	<!-- Generate caption -->
	<xsl:apply-templates select="$path" mode="caption" />
	
	<!-- Get description -->
	<xsl:apply-templates select="$path/description" />
	
</xsl:template>

<!--
	ARTICLE IMAGES
	Image description
-->
<xsl:template match="description">
	<xsl:if test=". != ''">
		<em><xsl:value-of select="." /></em>
	</xsl:if>
</xsl:template>


</xsl:stylesheet>