<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: SYSTEM MESSAGES
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />

<!--
	SYSTEM MESSAGES
	This template is used for error pages and the maintenance mode
-->
<xsl:template match="/">
	<html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<xsl:choose>
			
				<!-- Maintenance mode -->
				<xsl:when test="$current-page = 'maintenance' ">
					<title>Pompodium | Maintenance</title>
				</xsl:when>
				
				<!-- Page not found -->
				<xsl:when test="$current-page = '404' ">
					<title>Pompodium | Page not found</title>
				</xsl:when>
				
				<!-- Forbidden -->
				<xsl:when test="$current-page = '403' ">
					<title>Pompodium | Forbidden</title>
				</xsl:when>
				
				<!-- Generic error -->
				<xsl:otherwise>
					<title>Pompodium | Error</title>
				</xsl:otherwise>
				
			</xsl:choose>
			<link href="{$workspace}/assets/pompodium.css" rel="stylesheet" type="text/css" media="all" />
		</head>
		<body>
			<div id="container">
				<div id="navigation">
					<h1>
						<a href="{$root}" class="logo">
							<img src="{$workspace}/assets/images/logo.gif" alt="image" width="219" height="36"/>
							<em>pompodium</em>
						</a>
					</h1>
				</div>
				<div id="content" class="message">
					<xsl:choose>
					
						<!-- Maintenance mode -->
						<xsl:when test="$current-page = 'maintenance' ">
							<h2>Taking a break</h2>
							<p>We will be back soon.</p>
						</xsl:when>
						
						<!-- Page not found -->
						<xsl:when test="$current-page = '404' ">
							<h2>Page not found (Error 404)</h2>
							<p>The requested page could not be found.</p>
						</xsl:when>
						
						<!-- Forbidden -->
						<xsl:when test="$current-page = '403' ">
							<h2>Forbidden (Error 403)</h2>
							<p>You don't have sufficient permissions to access this page.</p>
						</xsl:when>
						
					</xsl:choose>
				</div>
			</div>
		</body>
	</html>
</xsl:template>


</xsl:stylesheet>