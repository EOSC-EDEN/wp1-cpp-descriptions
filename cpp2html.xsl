<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cpp="https://eden-fidelis.eu/cpp/cpp/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.w3.org/1999/xhtml" xsi:schemaLocation="https://eden-fidelis.eu/cpp/cpp/ cpp.xsd" version="1.0">
    <xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" />

    <xsl:variable name="SPACE" select="' '"></xsl:variable>
    <xsl:variable name="USCORE" select="'_'"></xsl:variable>

    <xsl:template match="/cpp:cpp">

        <xsl:variable name="CPP" select="@ID"></xsl:variable>
        <xsl:variable name="LABEL" select="cpp:header/cpp:label"></xsl:variable>

        <html>
            <head>
                <style type="text/css">
                    body {
                        font-family: Arial, sans-serif;
                        width: 700px;
                        margin: auto;
                    }
                    table {
                        border-collapse: collapse;
                        margin-top: 20px;
                        width: 100%;
                        border: 1px solid #000;
                    }
                    .stepsColumn {
                        background-color: #fce5cd;
                    }
                    .stepsColumnHeader {
                        background-color: #f9cb9c;
                    }
                    th, td {
                        border: 2px solid #000;
                        padding: 8px;
                        text-align: left;
                        vertical-align: top;
                    }
                    th { background-color: #f2f2f2; }
                    table.intro td:nth-child(1) { font-weight: bold}
                    table.intro td.history { font-weight: normal; background-color: #fff;}
                </style>
                <title>
                    <xsl:text>EOSC-EDEN_</xsl:text>
                    <xsl:value-of select="$CPP" />
                    <xsl:text>_</xsl:text>
                    <xsl:value-of select="translate($LABEL,' ','_')" />
                </title>
            </head>
            <body>

                <xsl:call-template name="IntroSection">
                    <xsl:with-param name="CPP" select="$CPP" />
                    <xsl:with-param name="LABEL" select="$LABEL" />
                </xsl:call-template>

                <xsl:call-template name="descriptionSection" />

                <xsl:call-template name="dependenciesSection" />

                <xsl:call-template name="linksSection" />

                <xsl:call-template name="referencesSection" />

            </body>
        </html>
    </xsl:template>

    <xsl:template name="IntroSection" match="cpp:cpp">
        <xsl:param name="CPP" />
        <xsl:param name="LABEL" />

        <div class="introSection">

            <xsl:call-template name="title">
                <xsl:with-param name="CPP" select="$CPP" />
                <xsl:with-param name="LABEL" select="$LABEL" />
            </xsl:call-template>

            <xsl:apply-templates mode="introTable" select="cpp:header">
                <xsl:with-param name="CPP" select="$CPP" />
                <xsl:with-param name="LABEL" select="$LABEL" />
            </xsl:apply-templates>

        </div>

    </xsl:template>

    <xsl:template name="descriptionSection" match="cpp:cpp">

        <div class="descriptionSection">

            <h2>1. Description of the CPP</h2>

            <p>
                <xsl:value-of select="cpp:shortDefinition" />
            </p>

            <div class="inoutTable">

                <h3>Inputs and outputs</h3>

                <xsl:call-template name="inoutTable">
                    <xsl:with-param name="inputs" select="cpp:process/cpp:inputs" />
                    <xsl:with-param name="outputs" select="cpp:process/cpp:outputs" />
                </xsl:call-template>

            </div>


            <div class="definitionAndScope">

                <h3>Definition and scope</h3>

                <xsl:call-template name="copyContent">
                    <xsl:with-param name="data" select="cpp:descriptionAndScope" />
                </xsl:call-template>

            </div>

            <div class="processDescription">

                <h3>Process description</h3>

                <div class="triggerEvents">

                    <h4>Trigger event&#40;s&#41;</h4>

                    <xsl:call-template name="triggerEvents">
                        <xsl:with-param name="data" select="cpp:process/cpp:triggerEvents" />
                    </xsl:call-template>

                </div>

                <div class="processSteps">

                    <h4>Step-by-step description</h4>

                    <xsl:call-template name="stepTable">
                        <xsl:with-param name="data" select="cpp:process/cpp:stepByStepDescription" />
                    </xsl:call-template>

                </div>

            </div>


            <div class="rationaleAndWorstCases">

                <h3>Rationale&#40;s&#41; and worst case&#40;s&#41;</h3>

                <!-- TODO -->
                <xsl:call-template name="copyContent">
                    <xsl:with-param name="data" select="cpp:rationaleWorstCase" />
                </xsl:call-template>

            </div>

        </div>

    </xsl:template>

    <xsl:template name="dependenciesSection" match="cpp:cpp">

        <div class="dependenciesSection">

            <h2>2. Dependencies and relationships with other CPPs</h2>

            <div class="dependencies">

                <h3>Dependencies</h3>

                <!-- TODO -->
                <xsl:call-template name="copyContent">
                    <xsl:with-param name="data" select="cpp:cppRelationships/cpp:relationship[cpp:relationshipType='Requires']" />
                </xsl:call-template>

            </div>

            <div class="otherRelations">

                <h3>Other relations</h3>

                <!-- TODO -->
                <xsl:call-template name="copyContent">
                    <xsl:with-param name="data" select="cpp:cppRelationships/cpp:relationship[cpp:relationshipType!='Requires']" />
                </xsl:call-template>

            </div>

        </div>

    </xsl:template>

    <xsl:template name="linksSection" match="cpp:cpp">

        <div class="linksSection">

            <h2>3. Links to frameworks</h2>

            <div class="certification">

                <h3>Certification</h3>

                <!-- TODO -->
                <xsl:call-template name="copyContent">
                    <xsl:with-param name="data" select="cpp:frameworkMappings" />
                </xsl:call-template>

            </div>

            <div class="frameworks">

                <h3>Other frameworks and reference documents</h3>

                <!-- TODO -->
                <xsl:call-template name="copyContent">
                    <xsl:with-param name="data" select="cpp:frameworkMappings" />
                </xsl:call-template>

            </div>
        </div>

    </xsl:template>

    <xsl:template name="referencesSection">

        <div class="referencesSection">

            <h2>4. Reference implementations</h2>

            <div class="usecases">

                <h3>Use cases</h3>

                <xsl:call-template name="copyContent">
                    <xsl:with-param name="data" select="cpp:referenceImplementations/cpp:useCases" />
                </xsl:call-template>

            </div>

            <div class="documenation">

                <h3>Publicly available documentation</h3>

                <xsl:call-template name="publicDocumentationTable">
                    <xsl:with-param name="data" select="cpp:referenceImplementations" />
                </xsl:call-template>

            </div>
        </div>

    </xsl:template>

    <!-- Intro section templates -->

    <xsl:template name="title">
        <xsl:param name="CPP" />
        <xsl:param name="LABEL" />

        <div class="title">
            <h1>
                <xsl:value-of select="$LABEL" />
                <xsl:value-of select="$SPACE" />
                <xsl:text>&#40;</xsl:text>
                <xsl:value-of select="$CPP" />
                <xsl:text>&#41;</xsl:text>
            </h1>
        </div>

    </xsl:template>

    <xsl:template match="cpp:header" mode="introTable">
        <xsl:param name="CPP" />
        <xsl:param name="LABEL" />

        <div class="introTable">
            <table class="intro">
                <tr>
                    <td>CPP-Identifier</td>
                    <td>
                        <xsl:value-of select="$CPP" />
                    </td>
                </tr>
                <tr>
                    <td>CPP-Label</td>
                    <td>
                        <xsl:value-of select="$LABEL" />
                    </td>
                </tr>
                <xsl:apply-templates select="cpp:authors" />
                <xsl:apply-templates select="cpp:contributors" />
                <xsl:apply-templates select="cpp:evaluators" />
                <xsl:apply-templates select="cpp:dateCompleted" />
                <xsl:apply-templates select="cpp:history" />

            </table>
        </div>

    </xsl:template>

    <xsl:template name="authorRow" match="cpp:authors">
        <tr>
            <td>Author</td>
            <td>
                <xsl:for-each select="cpp:author">
                    <xsl:value-of select="." />
                    <xsl:if test="position() != last()">
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$SPACE" />
                    </xsl:if>
                </xsl:for-each>
            </td>
        </tr>
    </xsl:template>

    <xsl:template name="contributorRow" match="cpp:contributors">
        <tr>
            <td>Contributors</td>
            <td>
                <xsl:for-each select="cpp:contributor">
                    <xsl:value-of select="." />
                    <xsl:if test="position() != last()">
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$SPACE" />
                    </xsl:if>
                </xsl:for-each>
            </td>
        </tr>
    </xsl:template>

    <xsl:template name="evaluatorRow" match="cpp:evaluators">
        <tr>
            <td>Evaluators</td>
            <td>
                <xsl:for-each select="cpp:evaluator">
                    <xsl:value-of select="." />
                    <xsl:if test="position() != last()">
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="$SPACE" />
                    </xsl:if>
                </xsl:for-each>
            </td>
        </tr>
    </xsl:template>

    <xsl:template name="dateRow" match="cpp:dateCompleted">
        <tr>
            <td>Date of edition completed</td>
            <td>
                <xsl:value-of select="cpp:dateCompleted" />
            </td>
        </tr>
    </xsl:template>

    <xsl:template name="historyRows" match="cpp:history">
        <tr>
            <th>Change history</th>
            <th>Comments</th>
        </tr>
        <xsl:for-each select="cpp:version">
            <xsl:variable name="VERSION_MAJOR" select="cpp:versionNumber/cpp:majorVersion"></xsl:variable>
            <xsl:variable name="VERSION_MINOR" select="cpp:versionNumber/cpp:minorVersion"></xsl:variable>
            <xsl:variable name="VERSION_PATCH" select="cpp:versionNumber/cpp:patchVersion"></xsl:variable>
            <xsl:variable name="VERSION_DATE" select="cpp:versionDate"></xsl:variable>
            <tr>
                <td class="history">
                    <xsl:text>Version </xsl:text>
                    <xsl:value-of select="$VERSION_MAJOR" />
                    <xsl:text>.</xsl:text>
                    <xsl:value-of select="$VERSION_MINOR" />
                    <xsl:text>.</xsl:text>
                    <xsl:value-of select="$VERSION_PATCH" />
                    <xsl:text> - </xsl:text>
                    <xsl:value-of select="$VERSION_DATE" />
                </td>
                <td>
                    <xsl:value-of select="cpp:versionNotes" />
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <!-- Description section templates -->

    <xsl:template name="inoutTable">
        <xsl:param name="inputs" />
        <xsl:param name="outputs" />

        <table class="inout">
            <xsl:apply-templates select="$inputs" mode="inout_table" />
            <xsl:apply-templates select="$outputs" mode="inout_table" />
        </table>

    </xsl:template>

    <xsl:template name="triggerEvents">
        <xsl:param name="data" />

        <table class="triggerEvents">
            <tr>
                <th>Trigger Event</th>
                <th>CPP-identifier</th>
            </tr>

            <xsl:for-each select="$data/cpp:triggerEvent">
                <tr>
                    <td>
                        <xsl:call-template name="copyContent">
                            <xsl:with-param name="data" select="./cpp:description" />
                        </xsl:call-template>
                    </td>
                    <td>
                        <xsl:value-of select="./cpp:correspondingCPP" />
                    </td>
                </tr>
            </xsl:for-each>
        </table>

    </xsl:template>

    <xsl:template name="stepTable">
        <xsl:param name="data" />

        <table class="stepTable">
            <tr>
                <th>No</th>
                <th>Supplier</th>
                <th>Input</th>
                <th class="stepsColumnHeader">Steps</th>
                <th>Output</th>
                <th>Customer</th>
            </tr>

            <xsl:for-each select="$data/cpp:step">
                <xsl:call-template name="stepRow">
                    <xsl:with-param name="data" select="." />
                </xsl:call-template>
            </xsl:for-each>
        
        </table>

    </xsl:template>

    <xsl:template match="cpp:rationaleAndWorstCases">

        <div class="rationaleAndWorstCases">
            <xsl:call-template name="copyContent">
                <xsl:with-param name="data" select="." />
            </xsl:call-template>
        </div>

    </xsl:template>

    <!-- Use case template -->

    <xsl:template match="cpp:useCase">
        <xsl:call-template name="copyContent">
            <xsl:with-param name="data" select="." />
        </xsl:call-template>
    </xsl:template>

    <!-- Public documentation template -->

    <xsl:template name="publicDocumentationTable">
        <xsl:param name="data"/>

        <table class="publicDocumentation">
            <tr>
                <th style="width:20%">Institution</th>
                <th style="width:20%">Organisation type</th>
                <th style="width:10%">Language</th>
                <th style="width:50%">Hyperlink</th>
            </tr>

            <xsl:for-each select="$data/cpp:publicDocumentation">
                <xsl:apply-templates select="." />
            </xsl:for-each>

        </table>

    </xsl:template>

    <xsl:template match="cpp:publicDocumentation">

        <xsl:variable name="cnt" select="count(cpp:institution/cpp:institutionType)"></xsl:variable>
        <xsl:variable name="institution">
            <xsl:value-of select="cpp:institution/cpp:institutionLabel" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="cpp:institution/cpp:institutionCountry" />
        </xsl:variable>
        <xsl:variable name="language">
            <xsl:value-of select="cpp:documentationLanguage" />
        </xsl:variable>
        <xsl:variable name="hyperlink">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="cpp:linkToDocumentation/cpp:hyperlink" />
                </xsl:attribute>
                <xsl:value-of select="cpp:linkToDocumentation/cpp:hyperlink"/>
            </xsl:element>
            <xsl:if test="cpp:linkToDocumentation/cpp:comment">
                <xsl:element name="div">
                    <xsl:text>&#40;</xsl:text>
                    <xsl:value-of select="cpp:linkToDocumentation/cpp:comment" />
                    <xsl:text>&#41;</xsl:text>
                </xsl:element>
            </xsl:if>
        </xsl:variable>

        <xsl:for-each select="cpp:institution/cpp:institutionType">
            <tr>
                <xsl:if test="position()=1">
                    <xsl:element name="td">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="$cnt" />
                        </xsl:attribute>
                        <xsl:value-of select="$institution" />
                    </xsl:element>
                </xsl:if>
                <td>
                    <xsl:value-of select="." />
                </td>
                <xsl:if test="position()=1">
                    <xsl:element name="td">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="$cnt" />
                        </xsl:attribute>
                        <xsl:value-of select="$language" />
                    </xsl:element>
                    <xsl:element name="td">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="$cnt" />
                        </xsl:attribute>
                        <xsl:copy-of select="$hyperlink" />
                    </xsl:element>
                </xsl:if>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <!-- Input and output rows templates -->

    <xsl:template match="cpp:inputs" mode="inout_table">
        <tr>
            <th colspan="2">Input&#40;s&#41;</th>
        </tr>

        <xsl:call-template name="inoutTableElements">
            <xsl:with-param name="inout_data" select="." />
        </xsl:call-template>

    </xsl:template>

    <xsl:template match="cpp:outputs" mode="inout_table">
        <tr>
            <th colspan="2">Output&#40;s&#41;</th>
        </tr>

        <xsl:call-template name="inoutTableElements">
            <xsl:with-param name="inout_data" select="." />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="inoutTableElements">
        <xsl:param name="inout_data" />

        <xsl:call-template name="multiRowHeader">
            <xsl:with-param name="data" select="$inout_data/cpp:data/cpp:dataElement" />
            <xsl:with-param name="header" select="'Data'" />
        </xsl:call-template>

        <xsl:call-template name="multiRowHeader">
            <xsl:with-param name="data" select="$inout_data/cpp:metadata/cpp:metadataElement" />
            <xsl:with-param name="header" select="'Metadata'" />
        </xsl:call-template>

        <xsl:call-template name="multiRowHeader">
            <xsl:with-param name="data" select="$inout_data/cpp:guidance/cpp:guidanceElement" />
            <xsl:with-param name="header" select="'Documentation/guidance'" />
        </xsl:call-template>

        <xsl:call-template name="multiRowHeader">
            <xsl:with-param name="data" select="$inout_data/cpp:alerts/cpp:alert" />
            <xsl:with-param name="header" select="'Alerts'" />
        </xsl:call-template>

    </xsl:template>

    <!-- Generic template for multi-row headers-->
    <xsl:template name="multiRowHeader">
        <xsl:param name="data" />
        <xsl:param name="header" />

        <xsl:variable name="cnt" select="count($data)"></xsl:variable>

        <xsl:for-each select="$data">
            <tr>
                <xsl:if test="position()=1">
                    <xsl:element name="td">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="$cnt" />
                        </xsl:attribute>
                        <xsl:value-of select="$header" />
                    </xsl:element>
                </xsl:if>
                <td>
                    <xsl:value-of select="." />
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>

    <!-- Generic template for a single step -->
    <xsl:template name="stepRow">
        <xsl:param name="data" />

        <xsl:variable name="cntInput" select="count($data/cpp:input)" />
        <xsl:variable name="cntOutput" select="count($data/cpp:output)" />
        <xsl:variable name="cntMax">
            <xsl:choose>
                <xsl:when test="$cntInput &lt; $cntOutput">
                    <xsl:value-of select="$cntOutput" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$cntInput"></xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="stepDataRow">
            <xsl:with-param name="data" select="$data" />
            <xsl:with-param name="counter" select="1" />
            <xsl:with-param name="max" select="$cntMax" />
            <xsl:with-param name="maxInput" select="$cntInput" />
            <xsl:with-param name="maxOutput" select="$cntOutput" />
        </xsl:call-template>

    </xsl:template>

    <!-- Generic template for single data in step row -->
    <xsl:template name="stepDataRow">
        <xsl:param name="data" />
        <xsl:param name="counter" />
        <xsl:param name="max" />
        <xsl:param name="maxInput" />
        <xsl:param name="maxOutput" />

        <tr>
            <xsl:if test="$counter = 1">
                <!-- step number -->
                <xsl:element name="td">
                    <xsl:attribute name="rowspan">
                        <xsl:value-of select="$max" />
                    </xsl:attribute>
                    <xsl:value-of select="$data/@stepNumber"></xsl:value-of>
                </xsl:element>
            </xsl:if>
            <xsl:if test="$counter &lt;= $maxInput">
                <!-- input columns -->
                <xsl:call-template name="stepInput">
                    <xsl:with-param name="data" select="$data/cpp:input[$counter]" />
                    <xsl:with-param name="counter" select="$counter" />
                    <xsl:with-param name="max" select="$maxInput" />
                    <xsl:with-param name="total" select="$max" />
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="$counter = 1">
                <xsl:element name="td">
                    <xsl:attribute name="class">stepsColumn</xsl:attribute>
                    <xsl:attribute name="rowspan">
                        <xsl:value-of select="$max" />
                    </xsl:attribute>
                    <xsl:value-of select="$data/cpp:stepDescription" />
                </xsl:element>
            </xsl:if>
            <xsl:if test="$counter &lt;= $maxOutput">
                <xsl:call-template name="stepOutput">
                    <xsl:with-param name="data" select="$data/cpp:output[$counter]" />
                    <xsl:with-param name="counter" select="$counter" />
                    <xsl:with-param name="max" select="$maxOutput" />
                    <xsl:with-param name="total" select="$max" />
                </xsl:call-template>
            </xsl:if>
        </tr>

        <xsl:if test="$counter &lt;= $max">
            <xsl:call-template name="stepDataRow">
                <xsl:with-param name="data" select="$data" />
                <xsl:with-param name="counter" select="$counter + 1" />
                <xsl:with-param name="max" select="$max" />
                <xsl:with-param name="maxInput" select="$maxInput" />
                <xsl:with-param name="maxOutput" select="$maxOutput" />
            </xsl:call-template>
        </xsl:if>

    </xsl:template>

    <xsl:template name="stepInput">
        <xsl:param name="data" />
        <xsl:param name="counter" />
        <xsl:param name="max" />
        <xsl:param name="total" />

        <xsl:variable name="rowspan">
            <xsl:choose>
                <xsl:when test="$counter = $max">
                    <xsl:value-of select="$total - $counter + 1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:element name="td">
            <xsl:attribute name="rowspan">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:for-each select="$data/cpp:supplier">
                <xsl:value-of select="." />
                <xsl:if test="position() != last()">
                    <hr />
                </xsl:if>
            </xsl:for-each>
        </xsl:element>
        <xsl:element name="td">
            <xsl:attribute name="rowspan">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:value-of select="$data/cpp:inputElement" />
        </xsl:element>

    </xsl:template>

    <xsl:template name="stepOutput">
        <xsl:param name="data" />
        <xsl:param name="counter" />
        <xsl:param name="max" />
        <xsl:param name="total" />

        <xsl:variable name="rowspan">
            <xsl:choose>
                <xsl:when test="$counter = $max">
                    <xsl:value-of select="$total - $counter + 1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:element name="td">
            <xsl:attribute name="rowspan">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:value-of select="$data/cpp:outputElement" />
        </xsl:element>
        <xsl:element name="td">
            <xsl:attribute name="rowspan">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:for-each select="$data/cpp:customer">
                <xsl:value-of select="." />
                <xsl:if test="position() != last()">
                    <hr />
                </xsl:if>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <!-- Generic formatted text template -->
    <xsl:template name="copyContent">
        <xsl:param name="data" />

        <xsl:for-each select="$data/*">
            <xsl:copy-of select="."></xsl:copy-of>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>