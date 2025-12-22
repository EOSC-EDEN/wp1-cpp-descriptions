<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpp="https://eden-fidelis.eu/cpp/cpp/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.w3.org/1999/xhtml"
    xsi:schemaLocation="https://eden-fidelis.eu/cpp/cpp/ cpp.xsd"
    version="1.0">
    <xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" />

    <xsl:variable name="SPACE" select="' '"></xsl:variable>
    <xsl:variable name="USCORE" select="'_'"></xsl:variable>

    <xsl:variable name="frameworks" select="document('frameworks.xml')" />

    <xsl:variable name="languages" select="document('languages.xml')" />

    <xsl:template match="/cpp:cpp">

        <xsl:variable name="CPP" select="@ID"></xsl:variable>
        <xsl:variable name="LABEL" select="cpp:header/cpp:label"></xsl:variable>

        <html>
            <head>
                <style type="text/css">
                    :root {
                        --main-width: 800px;
                        --main-margin: auto;
                        --main-font-family: Arial, sans-serif;
                        --main-font-size: 12pt;
                        --main-line-height: 1.5;
                        --main-background-color: #fff;
                        --main-color: #000;
                        --border-color: #222;
                        --header-background-color: #e0e0e0;
                        --table-font-size: 12pt;
                    }

                    body {
                        font-family: var(--main-font-family);
                        font-size: var(--main-font-size);
                        line-height: var(--main-line-height);
                        margin: var(--main-margin);
                        max-width: var(--main-width);
                        background-color: var(--main-background-color);
                        color: var(--main-color);
                    }

                    h1 {
                        font-size: 26pt;
                        font-weight: normal;
                    }

                    h2 {
                        font-size: 20pt;
                        font-weight: normal;
                        margin-top: 20px;
                    }

                    h3 {
                        font-size: 16pt;
                        font-weight: normal;
                        margin-top: 15px;
                    }

                    h4 {
                        font-size: 14pt;
                        font-weight: normal;
                        margin-top: 10px;
                    }

                    table {
                        border-collapse: collapse;
                        margin: 10px 0;
                        width: 100%;
                        border: 2px solid var(--border-color);
                        font-size: var(--table-font-size);
                    }

                    th,
                    td {
                        border: 2px solid var(--border-color);
                        padding: 8px;
                        text-align: left;
                        vertical-align: top;
                    }

                    th {
                        background-color: var(--header-background-color);
                        font-weight: bold;
                    }

                    th, td {
                        border: 2px solid #000;
                        padding: 8px;
                        text-align: left;
                        vertical-align: top;
                    }

                    table.intro td:first-child {
                        font-weight: bold;
                    }

                    table.intro td.history {
                        font-weight: normal;
                        background-color: var(--main-background-color);
                    }

                    .stepsColumn {
                        background-color: #fce5cd;
                    }

                    .stepsColumnHeader {
                        background-color: #f9cb9c;
                    }

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

                <xsl:call-template name="rationaleTable">
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

                <xsl:call-template name="dependencyTable">
                    <xsl:with-param name="data" select="cpp:cppRelationships/cpp:relationship[cpp:relationshipType='Requires']" />
                </xsl:call-template>

            </div>

            <div class="otherRelations">

                <h3>Other relations</h3>

                <xsl:call-template name="relationTable">
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

                <xsl:call-template name="certificationTable">
                    <xsl:with-param name="data" select="cpp:frameworkMappings" />
                </xsl:call-template>

            </div>

            <div class="frameworks">

                <h3>Other frameworks and reference documents</h3>

                <xsl:call-template name="frameworkTable">
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

                <xsl:call-template name="useCases">
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

    <!-- Rationale and worst case table -->

    <xsl:template name="rationaleTable">
        <xsl:param name="data" />

        <table class="rationaleAndWorstCases">
            <tr>
                <th>Rational</th>
                <th>Impact of inaction or failure of the process</th>
            </tr>

            <xsl:for-each select="$data/cpp:purpose">
                <tr>
                    <td>
                        <xsl:call-template name="copyContent">
                            <xsl:with-param name="data" select="./cpp:purposeDescription" />
                        </xsl:call-template>
                    </td>
                    <td>
                        <xsl:call-template name="copyContent">
                            <xsl:with-param name="data" select="./cpp:worstCase" />
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>

        </table>

    </xsl:template>

    <!-- dependencies table -->

    <xsl:template name="dependencyTable">

        <xsl:param name="data"/>

        <table class="dependencies">
            <tr>
                <th>CPP-ID</th>
                <th>CPP-Title</th>
                <th>Relationship description</th>
            </tr>

            <xsl:for-each select="$data">
                <tr>
                    <td>
                        <xsl:value-of select="cpp:relatedCPP" />
                    </td>
                    <td></td>
                    <td>
                        <xsl:call-template name="copyContent">
                            <xsl:with-param name="data" select="cpp:relationshipDescription" />
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>

        </table>

    </xsl:template>

    <!-- relations table -->

    <xsl:template name="relationTable">

        <xsl:param name="data"/>

        <table class="relations">
            <tr>
                <th>Relation</th>
                <th>CPP-ID</th>
                <th>CPP-Title</th>
                <th>Relationship description</th>
            </tr>

            <xsl:for-each select="$data">
                <tr>
                    <td>
                        <xsl:value-of select="cpp:relationshipType" />
                    </td>
                    <td>
                        <xsl:value-of select="cpp:relatedCPP" />
                    </td>
                    <td></td>
                    <td>
                        <xsl:call-template name="copyContent">
                            <xsl:with-param name="data" select="cpp:relationshipDescription" />
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>

        </table>
    </xsl:template>

    <!-- certification table -->

    <xsl:template name="certificationTable">
        <xsl:param name="data"/>

        <table class="certificationTable">
            <tr>
                <th>Certification framework</th>
                <th>Term used in framework to refer to the CPP</th>
                <th>Section</th>
            </tr>

            <xsl:for-each select="$data/cpp:mapping">
                <xsl:variable name="frameworkName" select="cpp:frameworkName/text()" />
                <xsl:variable name="frameworkDef" select="$frameworks//framework[@code=$frameworkName]" />
                <xsl:if test="$frameworkDef/@type = 'certification'">
                    <tr>
                        <td>
                            <xsl:value-of select="$frameworkDef/name" />
                            <xsl:value-of select="$SPACE" />
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="$frameworkDef/link" />
                                </xsl:attribute>
                                Link
                            </xsl:element>
                        </td>
                        <td>
                            <xsl:call-template name="copyContent">
                                <xsl:with-param name="data" select="cpp:correspondingTerm" />
                            </xsl:call-template>
                        </td>
                        <td>
                            <xsl:call-template name="copyContent">
                                <xsl:with-param name="data" select="cpp:correspondingSection" />
                            </xsl:call-template>
                        </td>
                    </tr>
                </xsl:if>
            </xsl:for-each>

        </table>

    </xsl:template>

    <!-- framework table -->

    <xsl:template name="frameworkTable">

        <xsl:param name="data"/>

        <table class="frameworks">
            <tr>
                <th>Reference Document</th>
                <th>Term used in framework to refer to the process</th>
                <th>Section</th>
            </tr>

            <xsl:for-each select="$data/cpp:mapping">   
                <xsl:variable name="frameworkName" select="cpp:frameworkName">
                </xsl:variable>
                <xsl:variable name="frameworkDef" select="$frameworks//framework[@code=$frameworkName]" />
                <xsl:if test="$frameworkDef/@type='other'">
                    <tr>
                        <td>
                            <xsl:value-of select="$frameworkDef/name" />
                            <xsl:value-of select="$SPACE" />
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="$frameworkDef/link" />
                                </xsl:attribute>
                                Link
                            </xsl:element>
                        </td>
                        <td>
                            <xsl:call-template name="copyContent">
                                <xsl:with-param name="data" select="cpp:correspondingTerm" />
                            </xsl:call-template>
                        </td>
                        <td>
                            <xsl:call-template name="copyContent">
                                <xsl:with-param name="data" select="cpp:correspondingSection" />
                            </xsl:call-template>
                        </td>
                    </tr>
                </xsl:if>
            </xsl:for-each>

        </table>

    </xsl:template>

    <!-- Use case section -->

    <xsl:template name="useCases">
        <xsl:param name="data"/>

        <xsl:for-each select="$data/cpp:useCase">

            <h4>
                <xsl:value-of select="cpp:useCasetitle" />
            </h4>

            <xsl:call-template name="useCaseTable">
                <xsl:with-param name="data" select="." />
            </xsl:call-template>
        </xsl:for-each>

    </xsl:template>

    <!-- Use case table -->

    <xsl:template name="useCaseTable">
        <xsl:param name="data"/>

        <table class="useCaseTable">
            <tr>
                <th colspan="2">Institutional background</th>
            </tr>

            <tr>
                <td style="width:20%">Institution</td>
                <td>
                    <xsl:value-of select="$data/cpp:institution/cpp:institutionLabel" />
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="$data/cpp:institution/cpp:institutionCountry" />
                </td>
            </tr>

            <xsl:if test="$data/cpp:linkToDocumentation">
                <tr>
                    <td style="width:20%">Hyperlink</td>
                    <td>
                        <xsl:for-each select="$data/cpp:linkToDocumentation">
                            <xsl:if test="position() &gt; 1"><br/></xsl:if>
                            <xsl:if test="cpp:comment">
                                <xsl:value-of select="cpp:comment"/>
                                <xsl:value-of select="$SPACE"/>
                            </xsl:if>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="cpp:hyperlink" />
                                </xsl:attribute>
                                <xsl:value-of select="cpp:hyperlink"/>
                            </xsl:element>
                        </xsl:for-each>
                    </td>
                </tr>
            </xsl:if>

            <tr>
                <th colspan="2">Description</th>
            </tr>

            <xsl:if test="$data/cpp:triggerEvent">
                <tr>
                    <td>Trigger event</td>
                    <td>
                        <xsl:call-template name="copyContent">
                            <xsl:with-param name="data" select="$data/cpp:triggerEvent" />
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:if>

            <xsl:if test="$data/cpp:problemStatement">
                <tr>
                    <td>Problem statement</td>
                    <td>
                        <xsl:call-template name="copyContent">
                            <xsl:with-param name="data" select="$data/cpp:problemStatement" />
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:if>

            <xsl:if test="$data/cpp:proposedSolution">
                <tr>
                    <td>Proposed solution</td>
                    <td>
                        <xsl:call-template name="copyContent">
                            <xsl:with-param name="data" select="$data/cpp:proposedSolution" />
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:if>

        </table>
                
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

        <xsl:variable name="cnt" select="count(cpp:linkToDocumentation)"></xsl:variable>
        <xsl:variable name="institution">
            <xsl:value-of select="cpp:institution/cpp:institutionLabel" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="cpp:institution/cpp:institutionCountry" />
        </xsl:variable>
        <xsl:variable name="institutionTypes" select="cpp:institution/cpp:institutionType/text()"/>

        <xsl:for-each select="cpp:linkToDocumentation">
            <xsl:variable name="langcode" select="./@xml:lang" />
            <xsl:variable name="hyperlink">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="./cpp:hyperlink" />
                    </xsl:attribute>
                    <xsl:value-of select="./cpp:hyperlink"/>
                </xsl:element>
                <xsl:if test="./cpp:comment">
                    <xsl:element name="div">
                        <xsl:text>&#40;</xsl:text>
                        <xsl:value-of select="./cpp:comment" />
                        <xsl:text>&#41;</xsl:text>
                    </xsl:element>
                </xsl:if>
            </xsl:variable>

            <tr>
                <xsl:if test="position()=1">
                    <xsl:element name="td">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="$cnt" />
                        </xsl:attribute>
                        <xsl:value-of select="$institution" />
                    </xsl:element>
                    <xsl:element name="td">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="$cnt" />
                        </xsl:attribute>
                        <xsl:for-each select="$institutionTypes">
                            <xsl:value-of select="." />
                            <xsl:if test="position() != last()">
                                <hr />
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:if>

                <xsl:call-template name="debug"><xsl:with-param name="msg" select="$langcode" /></xsl:call-template>
                <xsl:call-template name="debug"><xsl:with-param name="msg" select="$languages//language[@code=$langcode]/label" /></xsl:call-template>
                <xsl:call-template name="debug"><xsl:with-param name="msg" select="$hyperlink" /></xsl:call-template>

                <td>
                    <xsl:value-of select="$languages//language[@code=$langcode]/label" />
                </td>

                <td>
                    <xsl:copy-of select="$hyperlink" />
                </td>
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
                    <xsl:call-template name="copyContent">
                        <xsl:with-param name="data" select="$data/cpp:stepDescription" />
                    </xsl:call-template>
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
                <xsl:if test="position()!=1">
                    <hr/>
                </xsl:if>
                <xsl:value-of select="." />
            </xsl:for-each>
        </xsl:element>
        <xsl:element name="td">
            <xsl:attribute name="rowspan">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:call-template name="copyContent">
                <xsl:with-param name="data" select="$data/cpp:inputElement" />
            </xsl:call-template>
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
            <xsl:call-template name="copyContent">
                <xsl:with-param name="data" select="$data/cpp:outputElement" />
            </xsl:call-template>
        </xsl:element>
        <xsl:element name="td">
            <xsl:attribute name="rowspan">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:for-each select="$data/cpp:customer">
                <xsl:if test="position()!=1">
                    <hr/>
                </xsl:if>
                <xsl:value-of select="." />
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

    <!-- debug -->

    <xsl:template name="debug">
        <xsl:param name="msg" />
        <xsl:message>
            <xsl:text>DEBUG: </xsl:text>
            <xsl:copy-of select="string($msg)" />
        </xsl:message>
    </xsl:template>

</xsl:stylesheet>
