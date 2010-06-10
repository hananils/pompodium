<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: ARTICLES
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:import href="../utilities/master.xsl" />

<!-- 
	ARTICLES
	Content area
-->
<xsl:template name="content">

	<!-- Generate headline > headline.xsl -->
	<xsl:apply-templates select="article/entry" mode="headline" />
	
	<!-- Content -->	
	<xsl:choose>
	
		<!-- Article view -->
		<xsl:when test="$title != '' and $action = '' ">
		
			<!-- Body -->
			<div id="body">

				<!-- Article -->
				<xsl:apply-templates select="article/entry/body/*[position() &gt; 1]" mode="ninja">
					<xsl:with-param name="level" select="1" />
				</xsl:apply-templates>

				<!-- Background information -->
				<xsl:call-template name="background" />
				
			</div>
			
			<!-- Comments > comments.xsl -->
			<xsl:if test="article/entry/@comments &gt; 0 or article/entry/comments = 'Yes'">
				<div id="comments">
					<xsl:if test="article/entry/@comments &gt; 0">
						<xsl:apply-templates select="comments" />
					</xsl:if>
					<xsl:if test="article/entry/comments = 'Yes'">
						<xsl:call-template name="commentform" />
					</xsl:if>
				</div>
			</xsl:if>
			
		</xsl:when>
		
		<!-- Comment added -->
		<xsl:when test="$action = 'comment-added' ">
			<div id="body">
				<h2>Your comment has been added</h2>
				<p>Thank you for your comment that we just added to &#187;<a href="{$root}/{$current-page}/{$title}"><xsl:value-of select="article/entry/title" /></a>&#171;.</p>
				<ul>
					<li><a href="{$root}/{$current-page}/{$title}">Click here to jump back to the article.</a></li>
					<li><a href="{$root}/{$current-page}/{$title}/#comments">Click here to see all comments related to this article.</a></li>
				</ul>
			</div>
		</xsl:when>
		
		<!-- Archives > archive.xsl -->
		<xsl:otherwise>
			<xsl:call-template name="archive" />
		</xsl:otherwise>
		
	</xsl:choose>
	
</xsl:template>

<!--
	TYPOGRAPHY
	Ordered lists
 -->
<xsl:template match="body/ol/li" mode="ninja" priority="1">
	<li><em><xsl:value-of select="position() div 2" /></em><xsl:apply-templates select="* | @* | text()" mode="ninja" /></li>
</xsl:template>

<!--
	TYPOGRAPHY
	Footnotes 
-->
<xsl:template match="div[@class = 'footnotes']" mode="ninja" priority="1">
	<div id="footnotes">
		<h3>Footnotes</h3>
		<ul>
			<xsl:apply-templates select="ol/li" mode="footnotes" />
		</ul>
	</div>
</xsl:template>

<!--
	TYPOGRAPHY
	Single footnote 
-->
<xsl:template match="ol/li" mode="footnotes">
	<li id="fn{substring(@id, 4)}">
		<em><xsl:value-of select="substring(@id, 4)" /></em>
		<xsl:apply-templates select="* | text()" mode="ninja" />
	</li>
</xsl:template>

<!--
	TYPOGRAPHY
	Reference link 
-->
<xsl:template match="a[@rev = 'footnote']" mode="ninja" priority="1">
	<a href="#ref{substring-after(@href, ':')}" rev="reference">&#8593;</a>
</xsl:template>

<!--
	TYPOGRAPHY
	Link to footnote 
-->
<xsl:template match="sup" mode="ninja" priority="1">
	<a href="#fn{a}" id="ref{a}" rel="footnote" class="reference"><xsl:value-of select="a" /></a>
</xsl:template>


</xsl:stylesheet>