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

  <!-- TERM INDEX -->
  <xsl:template name="term-index" match="rdf:RDF">
    <xsl:call-template name="class-index">
      <xsl:with-param name="data" select="//owl:Class[contains(@rdf:about, 'cbo')]"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="objectproperty-index">
      <xsl:with-param name="data" select="//owl:ObjectProperty[contains(@rdf:about, 'cbo')]"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="dataproperty-index">
      <xsl:with-param name="data" select="//owl:DatatypeProperty[contains(@rdf:about, 'cbo')]"></xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!--CLASS INDEX-->
  <xsl:template name="class-index">
    <xsl:param name="data"></xsl:param>
    <div id="ClassIndex">
      <table>
        <caption>Class Index</caption>
        <thead>
            <tr>
              <th scope="col">Term</th>
              <th scope="col">Status</th>
              <th scope="col">Description</th>
            </tr>
        </thead>
        <tbody>
          <xsl:for-each select="$data">
            <xsl:call-template name="index-item">
              <xsl:with-param name="label" select="rdfs:label"></xsl:with-param>
              <xsl:with-param name="status" select="vs:term_status"></xsl:with-param>
              <xsl:with-param name="comment" select="rdfs:comment"></xsl:with-param>
              <xsl:with-param name="about" select="@rdf:about"></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <!--OBJECTPROPERTY INDEX-->
  <xsl:template name="objectproperty-index">
    <xsl:param name="data"></xsl:param>
    <div id="ObjectPropertyIndex">
      <table>
        <caption>ObjectProperty Index</caption>
        <thead>
            <tr>
              <th scope="col">Term</th>
              <th scope="col">Status</th>
              <th scope="col">Description</th>
            </tr>
        </thead>
        <tbody>
          <xsl:for-each select="$data">
            <xsl:call-template name="index-item">
              <xsl:with-param name="label" select="rdfs:label"></xsl:with-param>
              <xsl:with-param name="status" select="vs:term_status"></xsl:with-param>
              <xsl:with-param name="comment" select="rdfs:comment"></xsl:with-param>
              <xsl:with-param name="about" select="@rdf:about"></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <!--DATAPROPERTY INDEX-->
  <xsl:template name="dataproperty-index">
    <xsl:param name="data"></xsl:param>
    <div id="DataPropertyIndex">
      <table>
        <caption>DataProperty Index</caption>
        <thead>
          <tr>
              <th scope="col">Term</th>
              <th scope="col">Status</th>
              <th scope="col">Description</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="$data">
            <xsl:call-template name="index-item">
              <xsl:with-param name="label" select="rdfs:label"></xsl:with-param>
              <xsl:with-param name="status" select="vs:term_status"></xsl:with-param>
              <xsl:with-param name="comment" select="rdfs:comment"></xsl:with-param>
              <xsl:with-param name="about" select="@rdf:about"></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <!-- INDEX ITEM-->
  <xsl:template name="index-item">
    <xsl:param name="label"></xsl:param>
    <xsl:param name="status"></xsl:param>
    <xsl:param name="comment"></xsl:param>
    <xsl:param name="about"></xsl:param>

    <xsl:variable name="name">
      <xsl:call-template name="getName">
        <xsl:with-param name="input" select="$about"></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>

    <tr id="{$name}_index">
      <th scope="row" class="name">
        <a href="//comicmeta.org/cbo/{$name}" title="{$about}">
          <xsl:value-of select="$name"/>
        </a>
      </th>
      <td class="status">
        <xsl:value-of select="$status"/>
      </td>
      <td class="desc">
        <xsl:value-of select="$comment"/>
      </td>
    </tr>
  </xsl:template>

  <!-- INDEX HEADER (DEPRECATED)-->
  <xsl:template name="index-header">
    <xsl:param name="type"></xsl:param>
    <xsl:variable name="type-clean" select="translate($type, ' ', '')"></xsl:variable>
    <tbody>
      <tr>
        <th colspan="3">
          <xsl:value-of select="$type"/>
        </th>
      </tr>
      <tr>
        <th scope="col">Name</th>
        <th scope="col">Status</th>
        <th scope="col">Description</th>
      </tr>
    </tbody>
  </xsl:template>

</xsl:stylesheet>