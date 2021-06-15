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

  <xsl:include href="../utility/core.xsl"/>
  <xsl:include href="cbo-overview.xsl"/>
  <xsl:include href="cbo-index.xsl"/>
  
  <xsl:output omit-xml-declaration="yes" method="html"/>
  <xsl:template match="/">
    <section id="Overview">
      <h2>Overview</h2>
      <xsl:call-template name="overview"></xsl:call-template>
    </section>
    <section id="Classes">
      <h2>Classes</h2>
      <xsl:call-template name="classes"></xsl:call-template>
    </section>
    <section id="DataProperties">
      <h2>Data Properties</h2>
      <xsl:call-template name="data-properties"></xsl:call-template>
    </section>
    <section id="ObjectProperties">
      <h2>Object Properties</h2>
      <xsl:call-template name="object-properties"/>
    </section>
    <section id="TermIndex">
      <h2>Term Index</h2>
      <xsl:call-template name="term-index"></xsl:call-template>
    </section>
  </xsl:template>
  
  <!-- CLASSES -->
  <xsl:template name="classes" match="rdf:RDF">
    <xsl:for-each select="//owl:Class[contains(@rdf:about, 'cbo')]">

      <xsl:variable name="class-name">
        <xsl:call-template name="getName">
          <xsl:with-param name="input" select="@rdf:about"></xsl:with-param>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="uri" select="@rdf:about"/>
      <xsl:variable name="status" select="vs:term_status"/>
      <div id="{$class-name}" prefix="cbo: http://comicmeta.org/cbo# dcterms: http://purl.org/dc/terms/ vs: http://www.w3.org/2003/06/sw-vocab-status/ns#" resource="{$uri}" typeof="owl:Class" class="vocab-element class rounded">
        <div class="vocab-header class rounded-top">
            <h3 property="rdfs:label">
              <xsl:value-of select="rdfs:label"/>
            </h3>
            <p property="rdfs:comment">
              <xsl:value-of select="rdfs:comment"/>
            </p>
        </div>
        <div class="vocab-content">
          <table>
            <thead>
              <tr>
                <th class="property">Property</th>
                <th class="value">Value</th>                
              </tr>
            </thead>
            <tbody>
              <!-- URI -->
              <tr>
                <td>URI</td>
                <td>
                  <a href="{$uri}">
                    <xsl:value-of select="$uri"/>
                  </a>
                </td>
              </tr>
              <!-- URI -->
              <xsl:if test="count($status)">
                <tr>
                  <td>Status</td>
                  <td>
                    <span property="vs:term_status"><xsl:value-of select="$status"/>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              <!-- SUBCLASSES -->
              <xsl:variable name="subclass-set" select="//owl:Class/rdfs:subClassOf[@rdf:resource=$uri]"/>
              <xsl:if test="count($subclass-set)">
                <tr>
                  <td>Subclasses</td>
                  <td>
                    <xsl:for-each select="$subclass-set">
                      
                      <xsl:variable name="subclass-uri" select="../@rdf:about"/>
                      
                      <xsl:variable name="subclass-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="$subclass-uri"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a href="{$subclass-uri}">
                        <xsl:value-of select="$subclass-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- SUPERCLASSES -->
              <xsl:variable name="superclass-set" select="rdfs:subClassOf[@rdf:resource]"/>
              <xsl:if test="count($superclass-set)">
                <tr>
                  <td>Superclasses</td>
                  <td>
                    <xsl:for-each select="$superclass-set">
                      <xsl:variable name="superclass-uri" select="@rdf:resource"/>
                      
                      <xsl:variable name="superclass-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="$superclass-uri"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a property="rdfs:subClassOf" href="{$superclass-uri}">
                        <xsl:value-of select="$superclass-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- PROPERTIES -->
              <xsl:variable name="property-set" select="//rdfs:domain[@rdf:resource=$uri]"/>
              <xsl:if test="count($property-set)">
                <tr>
                  <td>Properties</td>
                  <td>
                    <xsl:for-each select="$property-set">
                      <xsl:sort select="rdfs:label"/>
                      
                      <xsl:variable name="property-uri" select="../@rdf:about"/>
                      
                      <xsl:variable name="property-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="$property-uri"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a href="{$property-uri}">
                        <xsl:value-of select="$property-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- INDIVIDUALS -->
              <xsl:variable name="individual-set" select="//owl:NamedIndividual/rdf:type[@rdf:resource=$uri]"/>
              <xsl:if test="count($individual-set)">
                <tr>
                  <td>Individuals</td>
                  <td>
                    <xsl:for-each select="$individual-set">
                      <xsl:sort select="rdfs:label"/>
                      <xsl:variable name="individual-uri" select="../@rdf:about"/>

                      <xsl:variable name="individual-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="$individual-uri"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>

                      <a href="{$individual-uri}">
                        <xsl:value-of select="$individual-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
            </tbody>
          </table>
        </div>
        <div class="vocab-footer rounded-bottom">
          <div class="options">
            <a href="#{$class-name}_index">Index</a>
            <a href="#Classes">Classes</a>
            <a href="#Overview">Overview</a>
          </div>
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>
  
  <!-- OBJECT-PROPERTIES -->
  <xsl:template name="object-properties" match="rdf:RDF">
    <xsl:for-each select="//owl:ObjectProperty[contains(@rdf:about, 'cbo')]">
      
      <xsl:variable name="property-name">
        <xsl:call-template name="getName">
          <xsl:with-param name="input" select="@rdf:about"></xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:variable name="property-uri" select="@rdf:about"/>
      <xsl:variable name="status" select="vs:term_status"/>
      <div id="{$property-name}" prefix="cbo: http://comicmeta.org/cbo# dcterms: http://purl.org/dc/terms/ vs: http://www.w3.org/2003/06/sw-vocab-status/ns#" resource="{$property-uri}" typeof="owl:ObjectProperty" class="vocab-element property rounded">
        <div class="vocab-header rounded-top">
          <h3 property="rdfs:label">
            <xsl:value-of select="rdfs:label"/>
          </h3>
          <p property="rdfs:comment">
            <xsl:value-of select="rdfs:comment"/>
          </p>
        </div>
        <div class="vocab-content">
          <table>
            <thead>
              <tr>
                <th class="property">Property</th>
                <th class="value">Value</th>
              </tr>
            </thead>
            <tbody>
              <!-- URI -->
              <tr>
                <td>URI</td>
                <td>
                  <a href="{$property-uri}">
                    <xsl:value-of select="$property-uri"/>
                  </a>
                </td>
              </tr>
              <!-- URI -->
              <xsl:if test="count($status)">
                <tr>
                  <td>Status</td>
                  <td>
                    <span property="vs:term_status">
                      <xsl:value-of select="$status"/>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              <!-- SUBPROPERTIES -->
              <xsl:variable name="subproperty-set" select="//rdfs:subPropertyOf[@rdf:resource=$property-uri]"/>
              <xsl:if test="count($subproperty-set)">
                <tr>
                  <td>Subproperties</td>
                  <td>
                    <xsl:for-each select="$subproperty-set">
                      <xsl:variable name="subproperty-uri" select="../@rdf:about"/>
                      
                      <xsl:variable name="subproperty-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="$subproperty-uri"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a href="{$subproperty-uri}">
                        <xsl:value-of select="$subproperty-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- SUPERPROPERTIES -->
              <xsl:variable name="superproperty-set" select="rdfs:subPropertyOf[not(contains(@rdf:resource, 'owl'))]"/>
              <xsl:if test="count($superproperty-set)">
                <tr>
                  <td>Superproperties</td>
                  <td>
                    <xsl:for-each select="$superproperty-set">
                      <xsl:variable name="superproperty-uri" select="@rdf:resource"/>
                      
                      <xsl:variable name="superproperty-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a property="rdfs:subPropertyOf" href="{$superproperty-uri}">
                        <xsl:value-of select="$superproperty-label"/>
                      </a>
                      
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- RANGE -->
              <xsl:variable name="range-set" select="rdfs:range[contains(@rdf:resource, 'cbo')]"/>
              <xsl:if test="count($range-set)">
                <tr>
                  <td>Range</td>
                  <td>
                    <xsl:for-each select="$range-set">
                      <xsl:variable name="range-uri" select="@rdf:resource"/>

                      <xsl:variable name="range-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a property="rdfs:range" href="{$range-uri}">
                        <xsl:value-of select="$range-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- DOMAIN -->
              <xsl:variable name="domain-set" select="rdfs:domain[contains(@rdf:resource, 'cbo')]"/>
              <xsl:if test="count($domain-set)">
                <tr>
                  <td>Domain</td>
                  <td>
                    <xsl:for-each select="$domain-set">
                      <xsl:variable name="domain-uri" select="@rdf:resource"/>
                      
                      <xsl:variable name="domain-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a property="rdfs:domain" href="{$domain-uri}">
                        <xsl:value-of select="$domain-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
            </tbody>
          </table>
        </div>
        <div class="vocab-footer rounded-bottom">
          <div class="options">
            <a href="#{$property-name}_index">Index</a>
            <a href="#ObjectProperties">Object Properties</a>
            <a href="#Overview">Overview</a>
          </div>
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>
  
  <!-- DATA-PROPERTIES -->
  <xsl:template name="data-properties" match="rdf:RDF">
    <xsl:for-each select="//owl:DatatypeProperty[contains(@rdf:about, 'cbo')]">

      <xsl:variable name="property-name">
        <xsl:call-template name="getName">
          <xsl:with-param name="input" select="@rdf:about"></xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:variable name="property-uri" select="@rdf:about"/>
      <xsl:variable name="status" select="vs:term_status"/>
      <div id="{$property-name}" prefix="cbo: http://comicmeta.org/cbo# dcterms: http://purl.org/dc/terms/ vs: http://www.w3.org/2003/06/sw-vocab-status/ns#" resource="{$property-uri}" typeof="owl:DatatypeProperty" class="vocab-element property rounded">
        <div class="vocab-header rounded-top">
          <h3 property="rdfs:label">
            <xsl:value-of select="rdfs:label"/>
          </h3>
          <p property="rdfs:comment">
            <xsl:value-of select="rdfs:comment"/>
          </p>
        </div>
        <div class="vocab-content">
          <table>
            <thead>
              <tr>
                <th class="property">Property</th>
                <th class="value">Value</th>
              </tr>
            </thead>
            <tbody>
              <!-- URI -->
              <tr>
                <td>URI</td>
                <td>
                  <a href="{$property-uri}">
                    <xsl:value-of select="$property-uri"/>
                  </a>
                </td>
              </tr>
              <!-- URI -->
              <xsl:if test="count($status)">
                <tr>
                  <td>Status</td>
                  <td>
                    <span property="vs:term_status">
                      <xsl:value-of select="$status"/>
                    </span>
                  </td>
                </tr>
              </xsl:if>
              <!-- SUBPROPERTIES -->
              <xsl:variable name="subproperty-set" select="//rdfs:subPropertyOf[@rdf:resource=$property-uri]"/>
              <xsl:if test="count($subproperty-set)">
                <tr>
                  <td>Subproperties</td>
                  <td>
                    <xsl:for-each select="$subproperty-set">
                      <xsl:variable name="subproperty-uri" select="../@rdf:about"/>
                      
                      <xsl:variable name="subproperty-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="$subproperty-uri"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a href="{$subproperty-uri}">
                        <xsl:value-of select="$subproperty-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- SUPERPROPERTIES -->
              <xsl:variable name="superproperty-set" select="rdfs:subPropertyOf[@rdf:resource]"/>
              <xsl:if test="count($superproperty-set)">
                <tr>
                  <td>Superproperties</td>
                  <td>
                    <xsl:for-each select="$superproperty-set">
                      <xsl:variable name="superproperty-uri" select="@rdf:resource"/>
                      
                      <xsl:variable name="superproperty-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a property="rdfs:subPropertyOf" href="{$superproperty-uri}">
                        <xsl:value-of select="$superproperty-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- RANGE -->
              <xsl:variable name="range-set" select="rdfs:range[contains(@rdf:resource, 'cbo')]"/>
              <xsl:if test="count($range-set)">
                <tr>
                  <td>Range</td>
                  <td>
                    <xsl:for-each select="$range-set">
                      <xsl:variable name="range-uri" select="@rdf:resource"/>
                      
                      <xsl:variable name="range-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a property="rdfs:range" href="{$range-uri}">
                        <xsl:value-of select="$range-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
              <!-- DOMAIN -->
              <xsl:variable name="domain-set" select="rdfs:domain[contains(@rdf:resource, 'cbo')]"/>
              <xsl:if test="count($domain-set)">
                <tr>
                  <td>Domain</td>
                  <td>
                    <xsl:for-each select="$domain-set">
                      <xsl:variable name="domain-uri" select="@rdf:resource"/>
                      
                      <xsl:variable name="domain-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      
                      <a property="rdfs:domain" href="{$domain-uri}">
                        <xsl:value-of select="$domain-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
            </tbody>
          </table>
        </div>
        <div class="vocab-footer rounded-bottom">
          <div class="options">
            <a href="#{$property-name}_index">Index</a>
            <a href="#DataProperties">Data Properties</a>
            <a href="#Overview">Overview</a>
          </div>
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>
  
  <!-- INDIVIDUALS -->
  <xsl:template name="individuals" match="rdf:RDF">
    <xsl:for-each select="//owl:NamedIndividual[contains(@rdf:about, 'cbo')]">

      <xsl:variable name="individual-name">
        <xsl:call-template name="getName">
          <xsl:with-param name="input" select="@rdf:about"></xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:variable name="uri" select="@rdf:about"/>
      <xsl:variable name="status" select="vs:term_status"/>
      <div id="{$individual-name}" class="vocab-element individual rounded">
        <div class="vocab-header rounded-top">
          <h3>
            <xsl:value-of select="rdfs:label"/>
          </h3>
          <p>
            <xsl:value-of select="rdfs:comment"/>
          </p>
        </div>
        <div class="vocab-content">
          <table>
            <thead>
              <tr>
                <th class="property">Property</th>
                <th class="value">Value</th>
              </tr>
            </thead>
            <tbody>
              <!-- URI -->
              <tr>
                <td>URI</td>
                <td>
                  <a href="{$uri}">
                    <xsl:value-of select="$uri"/>
                  </a>
                </td>
              </tr>
              <!-- STATUS -->
              <xsl:if test="count($status)">
                <tr>
                  <td>Status</td>
                  <td>
                    <xsl:value-of select="$status"/>
                  </td>
                </tr>
              </xsl:if>
              <!-- TYPE -->
              <xsl:variable name="type-set" select="rdf:type[contains(@rdf:resource, 'cbo')]"/>
              <xsl:if test="count($type-set)">
                <tr>
                  <td>Type</td>
                  <td>
                    <xsl:for-each select="$type-set">
                      <xsl:variable name="type-uri" select="@rdf:resource"/>
                      <xsl:variable name="type-label">
                        <xsl:call-template name="getName">
                          <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
                        </xsl:call-template>
                      </xsl:variable>
                      <a href="{$type-uri}">
                        <xsl:value-of select="$type-label"/>
                      </a>
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:if>
            </tbody>
          </table>
        </div>
        <div class="vocab-footer rounded-bottom">
          <div class="options">
            <a href="#{individual-name}_index">Index</a>
            <a href="#Individuals">Individuals</a>
            <a href="#Overview">Overview</a>
          </div>
        </div>
      </div>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>