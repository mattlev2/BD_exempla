<?xml version="1.0" encoding="UTF-8"?>
<!--À faire: 
- regarder si l'encodage des charactères spéciaux (colonne nom) est accepté par la base de données
-->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <!--Indiquer le nombre de persName sans attribut @ref-->
        <xsl:text># Il reste </xsl:text>
        <xsl:value-of select="count(//tei:persName[not(@*)])"/>
        <xsl:text> &lt;persName&gt; à indexer. Au boulot !
            DELETE FROM personnages;
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
    <xsl:template match="tei:persName[@ref]">
        <xsl:variable name="thisPersonId2" select="translate(@ref, '#', '')"/>
        <xsl:variable name="tokenized">
            <xsl:value-of select="tokenize(base-uri(), '/')[last()]"/>
        </xsl:variable>




        <xsl:choose>
            <xsl:when
                test="ancestor::tei:TEI//tei:person[@xml:id = $thisPersonId2]/parent::tei:listPerson[@type = 'personnages']">
                <xsl:for-each select=".">
                    <xsl:variable name="nom_complet" select="translate(@ref, '#', '')"/>
                    <xsl:text>insert into personnages (id, nom, reference, segment) values('</xsl:text>
                    <xsl:value-of select="substring($tokenized, 1, 3)"/>
                    <xsl:text>_pers</xsl:text>
                    <xsl:number count="tei:persName[@ref]" level="any"/>
                    <xsl:text>',</xsl:text>
                    <xsl:text>'</xsl:text>
                    <!--Éviter les sauts de ligne-->
                    <xsl:value-of select="normalize-space(.)"/>
                    <!--Éviter les sauts de ligne-->
                    <xsl:text>','</xsl:text>
                    <xsl:value-of
                        select="translate(ancestor::tei:TEI//tei:listPerson[@type = 'personnages']/tei:person[@xml:id = $nom_complet]/tei:persName, '''', ' \''')"/>
                    <xsl:text>','</xsl:text>
                    <xsl:number count="tei:seg[@type = 'exemple']" level="any"/>
                    <xsl:text>');
      </xsl:text>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
