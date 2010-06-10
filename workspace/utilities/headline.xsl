<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: HEADLINE
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:template match="entry" mode="headline">

	<!-- Generate article path -->
	<xsl:param name="path" select="concat($root, '/articles/', title/@handle)" />
	
	<!-- Generate headline -->
	<div id="headline">
	
		<!-- Cover picture -->
		<xsl:if test="cover-picture/item">
		
			<!-- Resize cover picture to fit the stage -->
			<xsl:variable name="height" select="round(900 div cover-picture/item[1]/image/meta/@width * cover-picture/item[1]/image/meta/@height)" />
			<a href="{$path}" class="cover">
				<img src="{$root}/image/1/900/{$height}{cover-picture/item[1]/image/@path}/{cover-picture/item[1]/image/filename}" alt="{title}" width="900" height="{$height}"/>
			</a>
			
			<!-- Generate caption with creator reference and copyright information > images.xsl -->
			<xsl:apply-templates select="cover-picture/item" mode="caption" />

		</xsl:if>
		
		<!-- Article lead -->
		<div id="lead">
			<ul>
			
				<!-- Authors -->
				<li class="author">
					<xsl:apply-templates select="authors/item" mode="headline" />
				</li>
				
				<!-- Category -->
				<li>
					<xsl:choose>
						<xsl:when test="$title != '' "><xsl:attribute name="class">category list</xsl:attribute></xsl:when>
						<xsl:otherwise><xsl:attribute name="class">category archive</xsl:attribute></xsl:otherwise>
					</xsl:choose>
					<a href="{$root}/articles/category/{category/item[1]/@handle}"><xsl:value-of select="category/item[1]" /></a>
				</li>
				
				<!-- Publish date > datetime.xsl -->
				<li class="date">
					<a href="{$root}/articles/date/{substring(date, 1, 4)}/{substring(date, 6, 2)}">
						
						<xsl:call-template name="format-date">
							<xsl:with-param name="date" select="date" />
							<xsl:with-param name="format" select="'x M Y'" />
						</xsl:call-template>
					</a>
				</li>
			</ul>
			
			<!-- Title -->
			<h2>
				<a href="{$path}"><xsl:value-of select="title" /></a>
			</h2>
			
			<!-- Teaser -->
			<p>
				<xsl:apply-templates select="body/p[1]/text() | body/p[1]/@* | body/p[1]/*" mode="ninja" />
				<xsl:if test="$title = '' or $action != '' ">&#160;<a href="{$path}" class="continue">Read on &#187;</a></xsl:if>
			</p>
			
		</div>
				
	</div>
</xsl:template>

<!--
	AUTHORS
	Profile link
-->
<xsl:template match="authors/item" mode="headline">
	<xsl:if test="position() &gt; 1">, </xsl:if>
	<a href="{$root}/about/#{@handle}" class="author">
		<xsl:value-of select="." />
	</a>
</xsl:template>


</xsl:stylesheet>