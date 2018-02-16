<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">




    <xsl:template match="/">
        <resultset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

            <table>
                <xsl:apply-templates/>
            </table>
        </resultset>
    </xsl:template>




    <xsl:template match="tei:teiHeader"/>
    <xsl:template match="text()"/>

    <xsl:template match="//tei:seg">
        <xsl:choose>
            <xsl:when test="@type = 'exemple' or @type = 'ejemplo' or @type = 'exemplum'">
                <!--Récupérer le nom du document transformé-->
                <xsl:variable name="tokenized">
                    <xsl:value-of select="tokenize(base-uri(), '/')[last()]"/>
                </xsl:variable>
                <!--Récupérer le nom du document transformé-->
                <xsl:for-each select=".">
                    <xsl:element name="row">
                        <xsl:element name="field">
                            <xsl:attribute name="name">document</xsl:attribute>
                            <!--<xsl:value-of select="$tokenized"/>-->
                        </xsl:element>
                        <xsl:element name="field">
                            <xsl:attribute name="name">identifiant</xsl:attribute>
                            <!--Ajouter en début d'identifiant les 3 premiers caractères du documents de provenance-->
                            <xsl:value-of select="substring($tokenized, 1, 3)"/>
                            <!--Ajouter en début d'identifiant les 3 premiers caractères du documents de provenance-->
                            <xsl:number count="tei:seg[@type = 'exemple']" level="any"/>
                        </xsl:element>
                        <xsl:element name="field">
                            <xsl:attribute name="name">personnages</xsl:attribute>
                            <xsl:for-each select="tei:persName">
                                <xsl:choose>

                                    <!--Si il n'y a qu'un élément persName-->
                                    <xsl:when test="count(parent::tei:seg/tei:persName) = 1">
                                        <xsl:value-of select="translate(./@ref, '#', '')"/>
                                    </xsl:when>
                                    <!--Si il n'y a qu'un élément persName-->

                                    <xsl:otherwise>
                                        <!--N'indiquer qu'une occurrence de chaque nom de personnage-->

                                        <xsl:choose>
                                            <xsl:when
                                                test="preceding-sibling::tei:persName/@ref = @ref"/>
                                            <xsl:otherwise>
                                                <xsl:if test="preceding-sibling::tei:persName">
                                                  <xsl:text>,</xsl:text>
                                                </xsl:if>
                                                <xsl:value-of select="translate(@ref, '#', '')"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <!--N'indiquer qu'une occurrence de chaque nom de personnage-->
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="field">
                            <xsl:attribute name="name">nomenclature</xsl:attribute>
                        </xsl:element>
                        <xsl:element name="field">
                            <xsl:attribute name="name">typepers</xsl:attribute>
                            <xsl:variable name="thisPersonId2" select="translate(./@ref, '#', '')"/>
                            <xsl:value-of
                                select="ancestor::tei:TEI//tei:listPerson//tei:person[@xml:id = $thisPersonId2]//tei:state"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:for-each>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
