<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
	POMPODIUM ENSEMBLE: COMMENTS
	
	Johanna Hörrmann <http://www.johannahoerrmann.de>
	Nils Hörrmann <http://www.nilshoerrmann.de>

	Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
-->

<xsl:template match="comments">
	<h2>Comments</h2>
	<ul>
		<xsl:apply-templates select="entry" />
	</ul>
</xsl:template>

<!--
	COMMENTS
	List view
-->
<xsl:template match="comments/entry">
	<li>
	
		<!-- Author and time -->
		<h4 class="about">
		
			<!-- User image -->
			<img src="http://www.gravatar.com/avatar/{mail/@hash}.jpg?s=40&amp;d={$workspace}/assets/images/placeholder.png" width="40" height="40" alt="{name}'s Gravatar" />
			
			<!-- Name -->
			<a id="comment{@id}">
				<xsl:if test="website">
					<xsl:attribute name="href"><xsl:value-of select="website" /></xsl:attribute>
				</xsl:if>
				<xsl:value-of select="name" />
			</a>
			<br />
			
			<!-- Visible date -->
			<xsl:variable name="rfc2822">
				<xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date" />
					<xsl:with-param name="format" select="'rfc2822'" />
				</xsl:call-template>
			</xsl:variable>
			
			<!-- Full date for JavaScript processing -->
			<abbr title="{$rfc2822}">
				<xsl:call-template name="format-date">
					<xsl:with-param name="date" select="date" />
					<xsl:with-param name="format" select="'x M Y, h'" />
				</xsl:call-template>
			</abbr>
			
		</h4>
		
		<!-- Comment -->
		<xsl:apply-templates select="comment" mode="ninja" />
		
	</li>
</xsl:template>

<!--
	COMMENTS
	Form
-->
<xsl:template name="commentform">	
	<h3>Add your comment</h3>

	<!-- Processing error -->
	<xsl:if test="/data/events/add-comment/@result = 'error' ">
		<p class="error">We encountered an error while saving your comment. Please try again later.</p>
	</xsl:if>

	<!-- Form -->
	<form class="comments" method="post" action="" enctype="multipart/form-data">
	
		<!-- Name -->
		<label for="fields[name]">
			<xsl:text>My name </xsl:text>
			<i>
				<xsl:choose>
					<xsl:when test="/data/events/add-comment/name/@type = 'missing' ">
						<xsl:attribute name="class">error</xsl:attribute>
						<xsl:text>is missing</xsl:text>
					</xsl:when>
					<xsl:otherwise>is required</xsl:otherwise>
				</xsl:choose>
			</i>
		</label>
		<input name="fields[name]" type="text" value="{/data/events/add-comment/post-values/name}">
			<xsl:if test="/data/events/add-comment/name/@type = 'missing' ">
				<xsl:attribute name="class">error</xsl:attribute>
			</xsl:if>
		</input>
		
		<!-- Mail address -->
		<label for="fields[mail]">
			<xsl:text>My mail address </xsl:text>
			<i>
				<xsl:choose>
					<xsl:when test="/data/events/add-comment/mail/@type = 'missing' ">
						<xsl:attribute name="class">error</xsl:attribute>
						<xsl:text>is missing</xsl:text>
					</xsl:when>
					<xsl:when test="/data/events/add-comment/mail/@type = 'invalid' ">
						<xsl:attribute name="class">error</xsl:attribute>
						<xsl:text>is not valid</xsl:text>
					</xsl:when>
					<xsl:otherwise>will not be displayed</xsl:otherwise>
				</xsl:choose>
			</i>
		</label>
		<input name="fields[mail]" type="text" value="{/data/events/add-comment/post-values/mail}">
			<xsl:if test="/data/events/add-comment/mail/@type = 'missing' or /data/events/add-comment/mail/@type = 'invalid' ">
				<xsl:attribute name="class">error</xsl:attribute>
			</xsl:if>
		</input>
		
		<!-- Website -->
		<label for="fields[website]">
			<xsl:text>My website </xsl:text>
			<i>is optional</i>
		</label>
		<input name="fields[website]" type="text" value="{/data/events/add-comment/post-values/website}" />
		
		<!-- Comment -->
		<label for="fields[comment]">
			<xsl:text>My comment </xsl:text>
			<i>
				<xsl:choose>
					<xsl:when test="/data/events/add-comment/comment/@type = 'missing' ">
						<xsl:attribute name="class">error</xsl:attribute>
						<xsl:text>is missing</xsl:text>
					</xsl:when>
					<xsl:otherwise>is welcome</xsl:otherwise>
				</xsl:choose>
			</i>
		</label>
		<textarea name="fields[comment]">
			<xsl:if test="/data/events/add-comment/comment/@type = 'missing' ">
				<xsl:attribute name="class">error</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="/data/events/add-comment/post-values/comment" />
		</textarea>
		
		<!-- Settings -->
		<input name="fields[article]" value="{article/entry/@id}" type="hidden" />
		<input name="canofspam" value="{$canofspam}" type="hidden" />
		<input name="redirect" type="hidden" value="{$root}/{$current-page}/{$title}/comment-added" />

		<!-- Send button -->
		<button name="action[add-comment]" type="submit"><span>Send comment</span></button>
		
	</form>	
</xsl:template>


</xsl:stylesheet>