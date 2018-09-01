<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:LogicalDataModel="http:///com/ibm/db/models/logical/logical.ecore" xmlns:xmi="http://www.omg.org/XMI">

	<xsl:output method="html"/>
	<xsl:template match="/">
	<html>
	<head>

	<style type='text/css'>
		h1 {font-family: Helvetica, sans-serif; font-weight: bold; font-size: 24pt; color: #676767;}
		h2 {font-family: Helvetica, sans-serif; font-weight: bold; font-size: 20pt; color: #767676;}
		h3 {font-family: Helvetica, sans-serif; font-size: 14pt; color: #777777;}
		h4 {font-family: Helvetica, sans-serif; font-size: 14pt; color: #888888;}
		li {font-family: Helvetica, sans-serif; font-size: 10pt; color: #474747;}
		a  {font-family: Helvetica, sans-serif; font-size: 10pt; color: #444444;}
		*  {font-family: Helvetica, sans-serif; font-size: 8pt; color: #333333;}
		tr {height:30; font-size: 8.5pt;}
		tr:hover {background: rgb(248,248,248);}
		table {
				border-spacing: 0 0;
				margin: 1px;
				border-right: 1px solid #CCCCCC;
				font-family: Helvetica, sans-serif; font-size: 8.5pt;}
		thead th {
				font-family: Helvetica, sans-serif; font-size: 8pt;
				background: #EFEFEF;
				border-left: 1px solid #CCCCCC;
				border-top: 1px solid #CCCCCC;}
        tbody td {
        		font-family: Helvetica, sans-serif; font-size: 8.5pt;
				border-bottom: 1px solid #E3E3E3;
				border-left: 1px solid #E3E3E3;}
	</style>

	<title>Analytics and Information Management</title>
	</head>
	<body>
	<!-- Subject Area list Section -->
	<h1>Bus Matrix
		<!--span style="font-size: 24px; color: #676767; -moz-transform: scaleX(-1); -o-transform: scaleX(-1); -webkit-transform: scaleX(-1); transform: scaleX(-1); display: inline-block;">
			&#169;
		</span-->
	</h1>
	<!--ul>
	<xsl:for-each select="//SubjectArea/SubjectAreaName"-->
		<!-- Creating the Subject Area list -->
		<!--li><a href="#{.}"><xsl:value-of select="."/></a></li>
	</xsl:for-each>
	</ul-->
	<br/>
	<!--xsl:for-each select="//SubjectArea/SubjectAreaName">
		<xsl:variable name="SubjectArea" select="."/>
	<xsl:for-each select="../BusinessModelID"-->
	<!--xsl:for-each select="//BusinessCatalog/BusinessCatalogID"-->
		<!-- Business Model Header Section -->
		<!--h2><a name="{.}" id="{.}"></a><xsl:value-of select="."/></h2-->
		<!--xsl:variable name="bmlength" select="string-length(.)"/-->
		<!-- Subject Area Section -->
		<!--xsl:for-each select="../PresentationCatalogIDList"-->
			<!--h3>Subject Areas</h3-->
			<!-- Creating the subject areas list -->
			<!--ul>
			<xsl:for-each select="PresentationCatalogID">
			<li><xsl:value-of select="."/></li>
			</xsl:for-each>
			</ul-->
		<!--/xsl:for-each-->
		<!--br/-->

		<!-- Matrix Section -->
		<!--h4><a name="{$SubjectArea}" id="{$SubjectArea}"></a><xsl:value-of select="$SubjectArea"></xsl:value-of>
		</h4-->
		<table>
		<tbody>
		<thead>
		<tr>
			<td style="text-align:center; font-family: Helvetica, sans-serif; font-size: 8pt; border-top: 1px solid #EFEFEF; border-left: 1px solid #EFEFEF; border-bottom: 1px solid #E3E3E3; background-color: rgb(250,250,250);">Fact tables (below) / Dimensions (right)</td>
			<!-- Dimension tables list -->
			<xsl:for-each select="//LogicalDataModel:Entity">
				<!--xsl:sort data-type="number" select="@joins" order="descending"/-->
				<xsl:variable name="dimID" select="@xmi:id"/>
				<xsl:if test="count(//LogicalDataModel:Relationship[@owningEntity = $dimID]) = 0 and count(//relationshipEnds[@entity = $dimID]) > 0">
					<th style="background: #EFEFEF; font-family: Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #555555;"><xsl:value-of select="@name"/></th>
				</xsl:if>
			</xsl:for-each>
		</tr>
		</thead>
			<!-- Fact tables list and ticks -->
			<xsl:for-each select="//LogicalDataModel:Entity">
				<xsl:variable name="factID" select="@xmi:id"/>
				<xsl:variable name="factName" select="@name"/>
				<xsl:if test="count(//LogicalDataModel:Relationship[@owningEntity = $factID]) > 0">
				<tr>
					<!-- Fact Table Name -->
					<td style="background: #EFEFEF; font-family: Helvetica, sans-serif; font-size: 8pt; font-weight: bold; color: #555555;"><xsl:value-of select="@name"/></td>
					<!-- Cycling through each dimension table -->
					<xsl:for-each select="//LogicalDataModel:Entity">
						<!--xsl:sort data-type="number" select="@joins" order="descending"/-->
						<xsl:variable name="dimID" select="@xmi:id"/>
						<xsl:variable name="dimName" select="@name"/>
						<xsl:if test="count(//LogicalDataModel:Relationship[@owningEntity = $dimID]) = 0 and count(//relationshipEnds[@entity = $dimID]) > 0">
						<!-- pick only those referenced in Relationships-->
							<td align="center" style="font-family: Helvetica, sans-serif;" width="130">&#160;
							<!-- Find the join, tick it off -->
							<xsl:if test="count(//LogicalDataModel:Relationship[@owningEntity = $factID and .//relationshipEnds/@entity = $dimID]) > 0">
								<li/>
							</xsl:if>
							</td>
						</xsl:if>
					</xsl:for-each>
				</tr>
				</xsl:if>
			</xsl:for-each>
		</tbody>
		</table>

		<br/><br/>

	<br/><br/>
	<hr style="height: 1px; border: 0; background-color: #AAAAAA; width: 70%;"/>

	<div style="padding-top: 20px;">
		<p style="color: rgb(128, 128, 128); float: left;">Mozilla Firefox&#8482; or Google Chrome&#169; are strongly recommended for best results.</p>
		<p style="color: rgb(128, 128, 128); float: right;">Generated using caffeine.</p>
	</div>
	</body>
	</html>
	</xsl:template>
</xsl:stylesheet>
