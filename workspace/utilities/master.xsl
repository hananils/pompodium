<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: MASTER
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:import href="ninja.xsl" />
<xsl:import href="headline.xsl" />
<xsl:import href="images.xsl" />
<xsl:import href="background.xsl" />
<xsl:import href="archive.xsl" />
<xsl:import href="comments.xsl" />
<xsl:import href="copyright.xsl" />
<xsl:import href="datetime.xsl" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<!-- 
	MASTER TEMPLATE	
	This template is used to generate the general page layout
-->
<xsl:template match="data">
	<html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			
			<!-- Site title -->
			<title>
				<xsl:text>Pompodium</xsl:text>
				<xsl:if test="article/entry/title">
					<xsl:text> | </xsl:text>
					<xsl:value-of select="article/entry/title" />
				</xsl:if>
				
				<!-- Highlight maintenance mode in the browser window -->
				<xsl:if test="$site-mode = 'maintenance' "> [MAINTENANCE]</xsl:if>
				
			</title>
			
			<!-- Feed -->
			<link rel="alternate" type="application/rss+xml" title="{$website-name} | Articles" href="{$root}/feed/" />
						
			<!-- Stylesheets -->
			<link href="{$workspace}/assets/pompodium.css" rel="stylesheet" type="text/css" media="all" />
			
			<!-- Javascripts -->
			<script src="{$workspace}/assets/mootools.js" type="text/javascript"></script>
			<script src="{$workspace}/assets/pompodium.js" type="text/javascript"></script>
			
		</head>
		<body>
		
			<!-- Container -->
			<div id="container">
			
				<!-- Header -->
				<div id="navigation">
				
					<!-- Page title -->
					<h1>
						<a href="{$root}" class="logo">
							<img src="{$workspace}/assets/images/logo.gif" alt="image" width="219" height="36"/>
							<em>
								<xsl:value-of select="$website-name" />
							</em>
						</a>
					</h1>
					
					<!-- Navigation -->
					<ul>
						<xsl:for-each select="navigation/page">
							<li>
								<xsl:if test="$current-page = @handle">
									<xsl:attribute name="class">active</xsl:attribute>
								</xsl:if>
								<a href="{$root}/{@handle}/"><xsl:value-of select="name" /></a>
							</li>
						</xsl:for-each>
					</ul>
					
				</div>
				
				<!-- Content > /pages/ -->
				<div id="content">
					
					<xsl:call-template name="content" />
				
				</div>
				
				<!-- Contact and Imprint -->
				<div id="contact">
					<p>
					
						<!-- Template authors -->
						<span>
							<xsl:text>pompodium was made by </xsl:text>
							<a href="http://www.johannahoerrmann.de">hana</a>
							<xsl:text>+</xsl:text>
							<a href="http://www.nilshoerrmann.de">nils</a>
							<xsl:text> &#169; </xsl:text>
							
							<!-- Copyright > copyright.xsl -->
							<xsl:call-template name="copyright">
								<xsl:with-param name="start" select="'2008'" />
							</xsl:call-template>
							
						</span>
						
						<!-- Imprint -->
						<xsl:text> </xsl:text>
						<a href="{$root}/about">imprint</a>					
						<a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">licence</a>
						<a href="http://github.com/nilshoerrmann/pompodium">download</a>
						
					</p>
				</div>
				
			</div>
		</body>
	</html>
</xsl:template>


</xsl:stylesheet>