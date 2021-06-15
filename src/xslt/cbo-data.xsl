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

  <xsl:output omit-xml-declaration="yes" method="html"/>

  <xsl:param name="termName"></xsl:param>

  <xsl:template match="/">
    <xsl:call-template name="submenu">
      <xsl:with-param name="termName" select="$termName"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="header">
      <xsl:with-param name="termName" select="$termName"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="summary">
      <xsl:with-param name="termName" select="$termName"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="details">
      <xsl:with-param name="termName" select="$termName"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="data-properties">
      <xsl:with-param name="termName" select="$termName"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="object-properties">
      <xsl:with-param name="termName" select="$termName"></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="footer">
      <xsl:with-param name="termName" select="$termName"></xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- SUBMENU -->
  <xsl:template name="submenu" match="rdf:RDF">
    <xsl:param name="termName"></xsl:param>
    <xsl:variable name="object" select="//*[@rdf:about=$termName]"/>
    <xsl:variable name="object-local-name" select="local-name($object)"/>
    
    <xsl:variable name="object-name">
      <xsl:call-template name="getName">
        <xsl:with-param name="input" select="$object/@rdf:about"></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>

    <nav id="SubMenu" class="rounded-bottom">
      <nav id="Breadcrumbs">
        <a href="//comicmeta.org/cbo">
          <span>Comic Book Ontology</span></a> >
        <xsl:value-of select="$object-local-name"/>
        >
        <a href="//comicmeta.org/cbo/{$object-name}">
          <xsl:value-of select="$object-name"/>
        </a>
      </nav>
      <nav id="Format" prefix="dcterms: http://purl.org/dc/terms/" resource="{$object/@rdf:about}">
        <a property="dcterms:hasFormat" href="/cbo/{$object-name}.rdf">RDF/XML</a> |
        <a property="dcterms:hasFormat" href="/cbo/{$object-name}.ttl">Turtle</a> |
        <a property="dcterms:hasFormat" href="/cbo/{$object-name}.json">JSON</a> |
        <a property="dcterms:hasFormat" href="/cbo/{$object-name}.n3">N3</a> |
        <a property="dcterms:hasFormat" href="/cbo/{$object-name}.nt">N-Triples</a>
      </nav>
    </nav>

  </xsl:template>

  <!-- SUMMARY-->
  <xsl:template name="summary" match="rdf:RDF">
    <xsl:param name="termName"></xsl:param>
    <xsl:variable name="object" select="//*[@rdf:about=$termName]"></xsl:variable>
    <xsl:variable name="object-uri" select="$object/@rdf:about"></xsl:variable>
    <xsl:variable name="object-type" select="local-name($object)"></xsl:variable>
    <div id="Summary" class="vocab-data summary">
      <table>
        <caption>
          Summary
        </caption>
        <thead>
          <tr>
            <th scope="col">Property</th>
            <th scope="col">Value</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="property">
              Type
            </td>
            <td class="value">
              <xsl:value-of select="$object-type"/>
            </td>
          </tr>
          <tr class="property">
            <td>URI</td>
            <td class="value">
              <a href="{$object-uri}">
                <xsl:value-of select="$object-uri"></xsl:value-of>
              </a>
            </td>
          </tr>
          <xsl:call-template name="summary-status">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="summary-superclass">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="summary-subclasses">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="summary-properties">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="summary-individuals">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="summary-superproperties">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="summary-subproperties">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="summary-domain">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
          <xsl:call-template name="summary-range">
            <xsl:with-param name="object" select="$object"></xsl:with-param>
          </xsl:call-template>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <!--FORMATS-->
  <xsl:template name="summary-format" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="domain-set" select="$object/rdfs:domain[contains(@rdf:resource, 'cbo')]"/>
    <xsl:if test="count($domain-set)">
      <tr>
        <td class="property">Domain</td>
        <td class="value">
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
  </xsl:template>

  <!-- DOMAIN -->
  <xsl:template name="summary-domain" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="domain-set" select="$object/rdfs:domain[contains(@rdf:resource, 'cbo')]"/>
    <xsl:if test="count($domain-set)">
      <tr>
        <td class="property">Domain</td>
        <td class="value">
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
  </xsl:template>

  <!-- RANGE -->
  <xsl:template name="summary-range" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="range-set" select="$object/rdfs:range[contains(@rdf:resource, 'cbo')]"/>
    <xsl:if test="count($range-set)">
      <tr>
        <td class="property">Range</td>
        <td class="value">
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
  </xsl:template>

  <!-- SUBPROPERTIES -->
  <xsl:template name="summary-superproperties" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="superproperty-set" select="$object/rdfs:subPropertyOf[not(contains(@rdf:resource, 'owl'))]"/>
    <xsl:if test="count($superproperty-set)">
      <tr>
        <td class="property">Superproperties</td>
        <td class="value">
          <xsl:for-each select="$superproperty-set">
            <xsl:sort select="rdfs:label"/>
            <xsl:variable name="superproperty-uri" select="@rdf:resource"/>
            <xsl:variable name="superproperty-label">
              <xsl:call-template name="getName">
                <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <a href="{$superproperty-uri}">
              <xsl:value-of select="$superproperty-label"/>
            </a>
            <xsl:if test="position() != last()">, </xsl:if>
          </xsl:for-each>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>

  <!-- SUBPROPERTIES -->
  <xsl:template name="summary-subproperties" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="object-uri" select="$object/@rdf:about"></xsl:variable>
    <xsl:variable name="subproperty-set" select="//rdfs:subPropertyOf[@rdf:resource=$object-uri]"/>
    <xsl:if test="count($subproperty-set)">
      <tr>
        <td class="property">Subproperties</td>
        <td class="value">
          <xsl:for-each select="$subproperty-set">
            <xsl:sort select="rdfs:label"/>
            <xsl:variable name="subproperty-uri" select="../@rdf:about"/>
            <xsl:variable name="subproperty-label">
              <xsl:call-template name="getName">
                <xsl:with-param name="input" select="../@rdf:about"></xsl:with-param>
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
  </xsl:template>

  <!-- INDIVIDUALS -->
  <xsl:template name="summary-individuals" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="object-uri" select="$object/@rdf:about"></xsl:variable>
    <xsl:variable name="individual-set" select="//owl:NamedIndividual/rdf:type[@rdf:resource=$object-uri]"/>
    <xsl:if test="count($individual-set)">
      <tr>
        <td class="property">Individuals</td>
        <td class="property">
          <xsl:for-each select="$individual-set">
            <xsl:sort select="rdfs:label"/>
            <xsl:variable name="individual-uri" select="../@rdf:about"/>
            <xsl:variable name="individual-label">
              <xsl:call-template name="getName">
                <xsl:with-param name="input" select="../@rdf:about"></xsl:with-param>
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
  </xsl:template>

  <!-- PROPERTIES -->
  <xsl:template name="summary-properties" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="object-uri" select="$object/@rdf:about"></xsl:variable>
    <xsl:variable name="property-set" select="//rdfs:domain[@rdf:resource=$object-uri]"/>
    <xsl:if test="count($property-set)">
      <tr>
        <td class="property">Properties</td>
        <td class="value">
          <xsl:for-each select="$property-set">
            <xsl:sort select="rdfs:label"/>
            <xsl:variable name="property-uri" select="../@rdf:about"/>
            <xsl:variable name="property-label">
              <xsl:call-template name="getName">
                <xsl:with-param name="input" select="../@rdf:about"></xsl:with-param>
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
  </xsl:template>

  <!-- SUPERCLASSES -->
  <xsl:template name="summary-superclass" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="superclass-set" select="$object/rdfs:subClassOf[@rdf:resource]"/>
    <xsl:if test="count($superclass-set)">
      <tr>
        <td class="property">Superclasses</td>
        <td class="value">
          <xsl:for-each select="$superclass-set">
            <xsl:sort select="rdfs:label"/>
            <xsl:variable name="superclass-uri" select="@rdf:resource"/>
            <xsl:variable name="superclass-label">
              <xsl:call-template name="getName">
                <xsl:with-param name="input" select="@rdf:resource"></xsl:with-param>
              </xsl:call-template>
            </xsl:variable>
            <a href="{$superclass-uri}">
              <xsl:value-of select="$superclass-label"/>
            </a>
            <xsl:if test="position() != last()">, </xsl:if>
          </xsl:for-each>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>

  <!-- SUBCLASSES -->
  <xsl:template name="summary-subclasses" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:variable name="object-uri" select="$object/@rdf:about"></xsl:variable>
    <xsl:variable name="subclass-set" select="//owl:Class/rdfs:subClassOf[@rdf:resource=$object-uri]"/>
    <xsl:if test="count($subclass-set)">
      <tr>
        <td class="property">Subclasses</td>
        <td class="value">
          <xsl:for-each select="$subclass-set">
            <xsl:sort select="rdfs:label"/>
            <xsl:variable name="subclass-uri" select="../@rdf:about"/>
            <xsl:variable name="subclass-label">
              <xsl:call-template name="getName">
                <xsl:with-param name="input" select="../@rdf:about"></xsl:with-param>
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
  </xsl:template>

  <!-- STATUS -->
  <xsl:template name="summary-status" match="rdf:RDF">
    <xsl:param name="object"></xsl:param>
    <xsl:if test="$object/vs:term_status">
      <tr>
        <td class="property">Status</td>
        <td class="value">
          <span>
            <xsl:value-of select="$object/vs:term_status"/>
          </span>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>

  <!-- MENU -->
  <xsl:template name="menu" match="rdf:RDF">
    <xsl:param name="termName"></xsl:param>
    <xsl:variable name="object" select="//*[@rdf:about=$termName]"></xsl:variable>
    <xsl:variable name="dataproperty" select="//owl:DatatypeProperty/rdfs:domain[@rdf:resource=$termName]"/>
    <xsl:variable name="objectproperty" select="//owl:ObjectProperty/rdfs:domain[@rdf:resource=$termName]"/>
    <nav id="TermMenu" class="term-menu">
      <ul>
        <li>
          <a href="#Summary">Summary</a>
        </li>
        <li>
          <a href="#Details">Details</a>
        </li>
        <xsl:if test="count($dataproperty)">
          <li>
            <a href="#DataProperties">Data Properties</a>
          </li>
        </xsl:if>
        <xsl:if test="count($objectproperty)">
          <li>
            <a href="#ObjectProperties">Object Properties</a>
          </li>
        </xsl:if>
      </ul>
    </nav>
  </xsl:template>

  <!-- HEADER -->
  <xsl:template name="header" match="rdf:RDF">
    <xsl:param name="termName"></xsl:param>
    <xsl:variable name="object" select="//*[@rdf:about=$termName]"></xsl:variable>
    <xsl:variable name="rdfAbout" select="$object/@rdf:about"></xsl:variable>
    <xsl:variable name="rdfType" select="name($object)"></xsl:variable>

    <div id="TermHeader" class="vocab-data header rounded">
      <div prefix="cbo: http://comicmeta.org/cbo# dcterms: http://purl.org/dc/terms/ vs: http://www.w3.org/2003/06/sw-vocab-status/ns#" resource="{$rdfAbout}" typeof="{$rdfType}">
        <h1 property="rdfs:label">
          <xsl:variable name="label" select="$object/rdfs:label"/>
            <xsl:choose>
              <xsl:when test="$label">
                <xsl:value-of select="$label"/>
              </xsl:when>
              <xsl:otherwise>
                  <xsl:call-template name="getName">
                    <xsl:with-param name="input" select="$object/@rdf:about"></xsl:with-param>
                  </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
        </h1>
        <p property="rdfs:comment">
          <xsl:value-of select="$object/rdfs:comment"/>
        </p>
      </div>
      <xsl:call-template name="menu">
        <xsl:with-param name="termName" select="$termName"></xsl:with-param>
      </xsl:call-template>
    </div>

  </xsl:template>

  <!-- FOOTER -->
  <xsl:template name="footer" match="rdf:RDF">
    <xsl:param name="termName"></xsl:param>
    <xsl:variable name="object" select="//*[@rdf:about=$termName]"></xsl:variable>
    <xsl:variable name="rdfAbout" select="$object/@rdf:about"></xsl:variable>
    <xsl:variable name="rdfType" select="local-name($object)"></xsl:variable>

    <div id="TermFooter" resource="{$rdfAbout}" typeof="{$rdfType}" class="vocab-data footer rounded">
      <span>
        <a href="{$rdfAbout}">
          <xsl:value-of select="$object/rdfs:label"/>
        </a>
        is a <xsl:value-of select="$rdfType" />
        in the <a href="//comicmeta.org/cbo">Comic Book Ontology</a>. For more information visit <a href="//comicmeta.org">COMICMETA.ORG</a>.
      </span>
    </div>
  </xsl:template>

  <!-- DATAPROPERTIES-->
  <xsl:template name="data-properties" match="rdf:RDF">
    <xsl:param name="termName"></xsl:param>
    <xsl:variable name="data" select="//owl:DatatypeProperty/rdfs:domain[@rdf:resource=$termName]"/>
    <xsl:if test="count($data)">
      <div id="DataProperties" class="vocab-data data-properties">
        <table class="rounded">
          <caption>Data Properties</caption>
          <thead>
            <tr>
              <th scope="col">Name</th>
              <th scope="col">Description</th>
              <th scope="col">Range</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="$data">
              <xsl:sort select="name()"/>
              <xsl:call-template name="data-property-row">
                <xsl:with-param name="data" select="."></xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </tbody>
        </table>
      </div>
    </xsl:if>
  </xsl:template>

  <!-- DATAPROPERTY ROW-->
  <xsl:template name="data-property-row" match="rdf:RDF">
    <xsl:param name="data"></xsl:param>
    <xsl:variable name="range" select="$data/../rdfs:range/@rdf:resource"></xsl:variable>
    <xsl:variable name="range-label">
      <xsl:call-template name="getName">
        <xsl:with-param name="input" select="$range"></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="object-label" select="name($data/../@rdf:about)"></xsl:variable>
    <xsl:variable name="object-name" select="name($data/..)"/>
    <tr prefix="cbo: http://comicmeta.org/cbo# dcterms: http://purl.org/dc/terms/ vs: http://www.w3.org/2003/06/sw-vocab-status/ns#" resource="{$data/../@rdf:about}" typeof="{$object-name}">
      <td class="name">
        <a href="{$data/../@rdf:about}">
          <span property="rdfs:label">
              <xsl:call-template name="getName">
                <xsl:with-param name="input" select="$data/../@rdf:about"></xsl:with-param>
              </xsl:call-template>
          </span>
        </a>
      </td>
      <td class="desc">
        <span property="rdfs:comment">
          <xsl:value-of select="$data/../rdfs:comment"/>
        </span>
      </td>
      <xsl:choose>
        <xsl:when test="count($range)">
          <td class="range">
            <xsl:for-each select="$range">
              <a property="rdfs:range" href="{$range}">
                <xsl:value-of select="$range-label"/>
              </a>
              <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
            <span property="rdfs:domain" resource="{$data/../rdfs:domain}"></span>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td class="range">
            <span title="Any literal value">
              Literal
            </span>
          </td>
          <span property="rdfs:domain" resource="{$data/../rdfs:domain}"></span>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>

  <!-- OBJECTPROPERTIES-->
  <xsl:template name="object-properties" match="rdf:RDF">
    <xsl:param name="termName"></xsl:param>
    <xsl:variable name="data" select="//owl:ObjectProperty/rdfs:domain[@rdf:resource=$termName]"/>
    <xsl:if test="count($data)">
      <div id="ObjectProperties" class="vocab-data object-properties">
        <table class="rounded">
          <caption>Object Properties</caption>
          <thead>
            <tr>
              <th scope="col">Name</th>
              <th scope="col">Description</th>
              <th scope="col">Range</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="$data">
              <xsl:sort select="name()"/>
              <xsl:call-template name="object-property-row">
                <xsl:with-param name="data" select="."></xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </tbody>
        </table>
      </div>
    </xsl:if>
  </xsl:template>

  <!-- OBJECTPROPERTY ROW -->
  <xsl:template name="object-property-row" match="rdf:RDF">
    <xsl:param name="data"></xsl:param>
    <xsl:variable name="range" select="$data/../rdfs:range/@rdf:resource"></xsl:variable>
    <xsl:variable name="range-label">
      <xsl:call-template name="getName">
        <xsl:with-param name="input" select="$range"></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="object-label" select="name($data/../@rdf:about)"></xsl:variable>
    <xsl:variable name="object-name" select="name($data/..)"/>
    <tr prefix="cbo: http://comicmeta.org/cbo# dcterms: http://purl.org/dc/terms/ vs: http://www.w3.org/2003/06/sw-vocab-status/ns#" resource="{$data/../@rdf:about}" typeof="{$object-name}">
      <td class="name">
        <a href="{$data/../@rdf:about}" title="{$object-label}">
          <span property="rdfs:label">
              <xsl:call-template name="getName">
                <xsl:with-param name="input" select="$data/../@rdf:about"></xsl:with-param>
              </xsl:call-template>
          </span>
        </a>
      </td>
      <td class="desc">
        <span property="rdfs:comment">
          <xsl:value-of select="$data/../rdfs:comment"/>
        </span>
      </td>
      <xsl:choose>
        <xsl:when test="count($range)">
          <td class="range">
            <xsl:for-each select="$range">
              <a property="rdfs:range" href="{$range}">
                <xsl:value-of select="$range-label"/>
              </a>
              <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
            <span property="rdfs:domain" resource="{$data/../rdfs:domain}"></span>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td>
            <span title="Any URI">
              URI
            </span>
            <span property="rdfs:domain" resource="{$data/../rdfs:domain}"></span>
          </td>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>

  <!-- DETAILS -->
  <xsl:template name="details" match="rdf:RDF">
    <xsl:param name="termName"></xsl:param>
    <xsl:param name="object" select="//*[@rdf:about=$termName]"></xsl:param>
    <xsl:param name="object-name" select="name($object)"></xsl:param>
    <div id="Details" class="vocab-data details">
      <table prefix="cbo: http://comicmeta.org/cbo# dcterms: http://purl.org/dc/terms/ vs: http://www.w3.org/2003/06/sw-vocab-status/ns#" resource="{$object/@rdf:about}" typeof="{$object-name}" class="rounded">
        <caption>Details</caption>
        <thead>
          <tr>
            <th scope="col">Name</th>
            <th scope="col">Value</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="$object/*">
            <xsl:sort select="name()"/>
            <xsl:call-template name="detail-row">
              <xsl:with-param name="data" select="."></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <!-- DETAIL ROW-->
  <xsl:template name="detail-row" match="rdf:RDF">
    <xsl:param name="data"></xsl:param>
    <xsl:param name="namespace" select="namespace-uri($data)"></xsl:param>
    <xsl:param name="localname" select="local-name($data)"></xsl:param>
    <xsl:param name="name" select="name($data)"></xsl:param>
    <xsl:param name="qname" select="concat($namespace,$name)"></xsl:param>
    <xsl:param name="resource" select="$data/@rdf:resource"></xsl:param>
    <xsl:variable name="resource-label">
      <xsl:call-template name="getName">
        <xsl:with-param name="input" select="$resource"></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <tr>
      <td class="name">
        <a href="{$qname}" title="{$name}">
          <xsl:value-of select="$localname"/>
        </a>
      </td>
      <xsl:choose>
        <xsl:when test="$resource">
          <td class="value">
            <a property="{$name}" href="{$resource}">
              <xsl:choose>
                <xsl:when test="$resource-label">
                  <xsl:value-of select="$resource-label"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$resource"/>
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td class="value">
            <span property="{$name}">
              <xsl:value-of select="$data"/>
            </span>
          </td>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>

</xsl:stylesheet>
