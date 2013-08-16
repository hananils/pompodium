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
<xsl:import href="kit/pagination.xsl" />

<xsl:variable name="title" />
<xsl:variable name="category" />
<xsl:variable name="year" />
<xsl:variable name="month" />
<xsl:variable name="author" />

<xsl:output method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes" />
	
<!--
	This template will be used by all content pages.
-->
<xsl:template match="data">
	<html>
		<head>
			<meta name="viewport" content="width=device-width" />
			<title>
				<xsl:value-of select="$website-name" />
				<xsl:text> · </xsl:text>
				<xsl:value-of select="$page-title" />
			</title>
			<link href="http://fonts.googleapis.com/css?family=Merriweather:300italic|Merriweather+Sans:300,300italic,400,400italic,700,700italic|Source+Code+Pro:400" rel="stylesheet" type="text/css" media="all" />
			<link href="{$workspace}/assets/pompodium.css" rel="stylesheet" type="text/css" media="all" />
			<link href="{$root}/feed/" rel="alternate" type="application/rss+xml" title="site feed" />
			<link href="{$root}/favicon.ico" rel="shortcut icon" type="image/x-icon" />
			<script>
				document.addEventListener('DOMContentLoaded', function() {
					document.querySelector('#header .column').addEventListener('touchend', function(event) {
						event.preventDefault();
						event.stopPropagation();
						document.querySelector('#header nav').classList.toggle('open');
					});
				});
			</script>
		</head>
		<body>
			<div id="wrapper">

				<!-- Site header -->
				<header id="header">
					<div class="column dark">
						<h1>
							<a href="{$root}">
								<img src="{$workspace}/assets/images/pompodium.svg" alt="pompodium" width="432" height="36" />
							</a>
						</h1>
						<xsl:apply-templates select="navigation[page]" />
					</div>
				</header>

				<!-- Content area -->
				<section id="content">
					<xsl:call-template name="feature" />
					<xsl:call-template name="main" />
				</section>

				<!-- Site footer -->
				<footer id="footer" class="dark column-wrapper">
					<div class="column">
						<p><a href="http://hananils.de">pompodium<span> by hana+nils</span></a> © 2007–<xsl:value-of select="$this-year" /></p>
						<nav>
							<ul>
								<li>
									<a href="http://pompodium.de/licence/">licence</a>
								</li>
								<li>
									<a href="http://github.com/hananils/pompodium">github</a>
								</li>
							</ul>
						</nav>
					</div>
				</footer>
			</div>
		</body>
	</html>
</xsl:template>

<!-- 
	Navigation 
-->
<xsl:template match="navigation">
	<nav>
		<ul>
			<xsl:apply-templates select="page" />
		</ul>
	</nav>
</xsl:template>

<!-- Pages -->
<xsl:template match="navigation/page">
	<li>
		<a href="{$root}/{@handle}/">
			<xsl:if test="@handle = $current-page">
				<xsl:attribute name="class">selected</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="name" />
		</a>
	</li>
</xsl:template>

<!--
	Default templates
-->
<xsl:template name="feature" priority="2">
</xsl:template>

<xsl:template name="main" priority="2">
</xsl:template>


</xsl:stylesheet>
