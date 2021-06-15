<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
     xml:base="http://www.w3.org/2002/07/owl"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:foaf="http://xmlns.com/foaf/0.1/"
     xmlns:frbr="http://purl.org/vocab/frbr/core#"
     xmlns:cbo="http://comicmeta.org/cbo#"
     xmlns:vs="http://www.w3.org/2003/06/sw-vocab-status/ns#"
     xmlns:dcterms="http://purl.org/dc/terms/"
     xmlns:schema="http://schema.org"
     xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
     xmlns:owl="http://www.w3.org/2002/07/owl#"
     xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="xsl dc foaf frbr cbo vs dcterms schema rdfs owl xsd rdf skos msxml">
  
  <xsl:output omit-xml-declaration="yes" method="html"/>
  <xsl:template name="overview" match="rdf:RDF">
    <xsl:call-template name="overview-block">
      <xsl:with-param name="type">Classes</xsl:with-param>
      <xsl:with-param name="nodes" select="//owl:Class[contains(@rdf:about, 'cbo')]"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="overview-block">
      <xsl:with-param name="type">Data Properties</xsl:with-param>
      <xsl:with-param name="nodes" select="//owl:DatatypeProperty[contains(@rdf:about, 'cbo')]"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="overview-block">
      <xsl:with-param name="type">Object Properties</xsl:with-param>
      <xsl:with-param name="nodes" select="//owl:ObjectProperty[contains(@rdf:about, 'cbo')]"></xsl:with-param>
    </xsl:call-template>
    <!--<xsl:call-template name="overview-block">
      <xsl:with-param name="type">Individuals</xsl:with-param>
      <xsl:with-param name="nodes" select="//owl:NamedIndividual[contains(@rdf:about, 'vocab')]"></xsl:with-param>
    </xsl:call-template>-->
  </xsl:template>
  <xsl:template name="overview-block">
    <xsl:param name="type"></xsl:param>
    <xsl:param name="nodes"></xsl:param>
    <div class="overview rounded">
      <div class="overview-header rounded-top">
        <xsl:call-template name="overview-header">
          <xsl:with-param name="type" select="$type"></xsl:with-param>
        </xsl:call-template>
      </div>
      <div class="overview-list rounded-bottom">
        <ul>
          <xsl:for-each select="$nodes">
            <xsl:call-template name="overview-item">
              <xsl:with-param name="label" select="rdfs:label"></xsl:with-param>
              <xsl:with-param name="about" select="@rdf:about"></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </ul>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template name="overview-header">
    <xsl:param name="type"></xsl:param>
    <h3>
      <xsl:value-of select="$type"></xsl:value-of>
    </h3>
  </xsl:template>
  
  <xsl:template name="overview-item">
    
    <xsl:param name="label"></xsl:param>
    <xsl:param name="about"></xsl:param>

    <xsl:variable name="name">
      <xsl:call-template name="getName">
        <xsl:with-param name="input" select="$about"></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <li>
      <a href="#{$name}">
        <xsl:value-of select="$name"/>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>