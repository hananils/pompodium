<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: ABOUT
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:import href="../utilities/master.xsl" />
<xsl:param name="title" />

<!--
	ABOUT
	Content area
-->
<xsl:template name="content">

	<!-- Generate headline -->
	<div id="headline">
	
		<!-- Header image -->
		<xsl:variable name="height" select="round(900 div header-image/entry/image/meta/@width * header-image/entry/image/meta/@height)" />
		<img src="{$root}/image/1/900/{$height}{header-image/entry/image/@path}/{header-image/entry/image/filename}" alt="{title}" width="900" height="{$height}"/>

		<!-- Generate caption with creator reference and copyright information -->
		<xsl:apply-templates select="header-image/entry" mode="caption" />
		
		<!-- Lead -->
		<div id="lead">
			<h2>About this site</h2>
			<p>
				<xsl:for-each select="information/entry[title/item = 'About']/body/p">
					<xsl:apply-templates select="* | text() | @*" mode="ninja" />
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</p>
		</div>
	</div>
	
	<!-- Generate content -->
	<div id="body">
	
		<!-- Authors list -->
		<h2>About the authors</h2>
		<ul class="authors">
			<xsl:apply-templates select="site-authors/entry" />
		</ul>
		
		<!-- Imprint > background.xsl & ninja.xsl -->
		<h2>Imprint</h2>
		<xsl:apply-templates select="information/entry[title/item = 'Imprint']/body/*" mode="ninja">
			<xsl:with-param name="level" select="1" />
		</xsl:apply-templates>
		
		<!-- Privacy Policy > ninja.xsl -->
		<div id="archive" class="columns">
			
			<div>
				<xsl:apply-templates select="information/entry[title/item = 'Privacy Policy']/body/*[node() != 'hr' and not(preceding-sibling::hr)]" mode="ninja">
					<xsl:with-param name="level" select="2" />
				</xsl:apply-templates>			
			</div>
			
			<div class="meta">
				<xsl:apply-templates select="information/entry[title/item = 'Privacy Policy']/body/*[node() != 'hr' and not(following-sibling::hr)]" mode="ninja">
					<xsl:with-param name="level" select="2" />
				</xsl:apply-templates>				
			</div>
			
		</div>
		
	</div>

</xsl:template>


</xsl:stylesheet>