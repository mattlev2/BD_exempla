<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="text"/>

    <xsl:template match="/">
        <!--Indiquer le nombre de persName sans attribut @ref-->
        <xsl:text># Il reste </xsl:text>
        <xsl:value-of select="count(//tei:persName[not(@*)])"/>
        <xsl:text> &lt;persName&gt; à indexer. Au boulot !
        </xsl:text>
        <!--Indiquer le nombre de persName sans attribut @ref-->
        <xsl:apply-templates/>
    </xsl:template>


    <!--<xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>-->
    <xsl:template match="//tei:rdg"/>
    <xsl:template match="text()"/>
    <xsl:template match="tei:teiHeader"/>
    <xsl:template match="tei:seg[@type = 'exemple']">
        <xsl:variable name="tokenized">
            <xsl:value-of select="tokenize(base-uri(), '/')[last()]"/>
        </xsl:variable>
        <xsl:text>insert into segments (id, name) values('</xsl:text>
        <xsl:value-of select="substring($tokenized, 1, 3)"/>
        <xsl:number count="tei:seg[@type = 'exemple']" level="any"/>
        <xsl:text>',</xsl:text>
        <xsl:text>'</xsl:text>
        <xsl:for-each select="tei:persName[@ref]">
            <xsl:choose>
                <xsl:when test="count(ancestor::tei:seg/tei:persName) = 1">
                    <xsl:value-of select="translate(@ref, '#', '')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="preceding-sibling::tei:persName/@ref = @ref"/>
                        <xsl:otherwise>
                            <xsl:if test="preceding-sibling::tei:persName[@ref]">
                                <xsl:text>,</xsl:text>
                            </xsl:if>
                            <xsl:value-of select="translate(@ref, '#', '')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:text>');
      </xsl:text>
    </xsl:template>


</xsl:stylesheet>
