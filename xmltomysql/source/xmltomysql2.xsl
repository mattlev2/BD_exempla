<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="text"/>




    <xsl:template match="/">
        <xsl:apply-templates select="tei:seg[@type = 'exempla']"/>
    </xsl:template>

    <xsl:template match="tei:seg[@type = 'exempla']">
        <xsl:text>insert into exempla (id, name) values('</xsl:text>
        <xsl:number count="tei:seg[@type = 'exemple']" level="any"/>
        <xsl:text>',</xsl:text>
        <xsl:text>'</xsl:text>
        <xsl:value-of select="translate(tei:persName/@ref, '#', '')"/>
        <xsl:text>');</xsl:text>
    </xsl:template>


</xsl:stylesheet>
