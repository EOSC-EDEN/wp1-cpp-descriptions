<?xml version="1.0" encoding="UTF-8"?>
<!--
    Transforms a CPP-xxx/cpp-xxx.xml file into an XSL-FO document that can be
    rendered to PDF (e.g. with Apache FOP). Mirrors the section structure of
    cpp2html.xsl, but targets print/PDF output instead of HTML.
-->
<xsl:stylesheet xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cpp="https://eden-fidelis.eu/cpp/cpp/" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:exslt="http://exslt.org/common" xmlns:func="http://exslt.org/functions" extension-element-prefixes="exslt func" version="1.0">
    <xsl:output method="xml" encoding="utf-8" indent="yes" />

    <xsl:variable name="SPACE" select="' '"></xsl:variable>

    <xsl:variable name="frameworks" select="document('frameworks.xml')" />
    <xsl:variable name="languages" select="document('languages.xml')" />
    <xsl:variable name="cpps" select="document('cpps.xml')" />

    <xsl:variable name="group-sequence-hue">210</xsl:variable>
    <xsl:variable name="group-alternative-hue">150</xsl:variable>
    <xsl:variable name="group-parallel-hue">330</xsl:variable>
    <xsl:variable name="base-lightness">95</xsl:variable>
    <xsl:variable name="lightness-step">5</xsl:variable>

    <xsl:variable name="page-height" select="'29.7cm'"></xsl:variable>
    <xsl:variable name="page-width" select="'21cm'"></xsl:variable>
    <xsl:variable name="page-landscape-height" select="'21cm'"></xsl:variable>
    <xsl:variable name="page-landscape-width" select="'29.7cm'"></xsl:variable>

    <xsl:variable name="page-margin-top" select="'1.2cm'"></xsl:variable>
    <xsl:variable name="page-margin-bottom" select="'1.2cm'"></xsl:variable>
    <xsl:variable name="page-margin-left" select="'1.5cm'"></xsl:variable>
    <xsl:variable name="page-margin-right" select="'1.5cm'"></xsl:variable>

    <xsl:variable name="page-margin-header" select="'1cm'"></xsl:variable>
    <xsl:variable name="page-margin-footer" select="'1cm'"></xsl:variable>

    <xsl:variable name="title-font-size" select="'22pt'" />
    <xsl:variable name="h1-font-size" select="'20pt'" />
    <xsl:variable name="h2-font-size" select="'16pt'" />
    <xsl:variable name="h3-font-size" select="'14pt'" />
    <xsl:variable name="body-font-size" select="'12pt'" />
    <xsl:variable name="table-font-size" select="'10pt'" />
    <xsl:variable name="header-font-size" select="'9pt'" />
    <xsl:variable name="footer-font-size" select="'9pt'" />

    <xsl:variable name="title-font-weight" select="'bold'" />
    <xsl:variable name="h1-font-weight" select="'bold'" />
    <xsl:variable name="h2-font-weight" select="'bold'" />
    <xsl:variable name="h3-font-weight" select="'normal'" />
    <xsl:variable name="body-font-weight" select="'normal'" />
    <xsl:variable name="table-font-weight" select="'normal'" />
    <xsl:variable name="header-font-weight" select="'normal'" />
    <xsl:variable name="footer-font-weight" select="'bold'" />

    <xsl:variable name="title-font-style" select="'normal'" />
    <xsl:variable name="h1-font-style" select="'normal'" />
    <xsl:variable name="h2-font-style" select="'italic'" />
    <xsl:variable name="h3-font-style" select="'italic'" />
    <xsl:variable name="body-font-style" select="'normal'" />
    <xsl:variable name="table-font-style" select="'normal'" />
    <xsl:variable name="header-font-style" select="'normal'" />
    <xsl:variable name="footer-font-style" select="'normal'" />

    <xsl:variable name="title-space-before" select="'18pt'" />
    <xsl:variable name="h1-space-before" select="'16pt'" />
    <xsl:variable name="h2-space-before" select="'14pt'" />
    <xsl:variable name="h3-space-before" select="'12pt'" />
    <xsl:variable name="body-space-before" select="'12pt'" />
    <xsl:variable name="table-space-before" select="'12pt'" />
    <xsl:variable name="header-space-before" select="'12pt'" />
    <xsl:variable name="footer-space-before" select="'12pt'" />

    <xsl:variable name="title-space-after" select="'18pt'" />
    <xsl:variable name="h1-space-after" select="'16pt'" />
    <xsl:variable name="h2-space-after" select="'14pt'" />
    <xsl:variable name="h3-space-after" select="'12pt'" />
    <xsl:variable name="body-space-after" select="'12pt'" />
    <xsl:variable name="table-space-after" select="'12pt'" />
    <xsl:variable name="header-space-after" select="'12pt'" />
    <xsl:variable name="footer-space-after" select="'12pt'" />

    <xsl:variable name="left-column-width" select="'1'"/>
    <xsl:variable name="right-column-width" select="'2'"/>

    <xsl:variable name="header-left-column-width" select="'1'"/>
    <xsl:variable name="header-right-column-width" select="'1'"/>

    <xsl:variable name="footer-left-column-width" select="'1'"/>
    <xsl:variable name="footer-right-column-width" select="'1'"/>

    <xsl:variable name="space-after" select="'12pt'" />

    <!-- Number of narrow "step number" columns, derived from the deepest stepGroup nesting -->
    <xsl:variable name="maxStepDepth" select="number(cpp:maxGroupDepth(/cpp:cpp/cpp:process/cpp:stepByStepDescription))" />
    <xsl:variable name="dataColumnCount" select="5" />
    <xsl:variable name="totalColumnCount" select="$maxStepDepth + $dataColumnCount" />

    <!-- Reusable cell formatting, called at the start of fo:table-cell content
         (xsltproc does not expand use-attribute-sets on literal result elements) -->
    <xsl:template name="cellAttrs">
        <xsl:attribute name="border">0.5pt solid #222</xsl:attribute>
        <xsl:attribute name="padding">4pt</xsl:attribute>
    </xsl:template>

    <xsl:template name="cell2Attrs">
        <xsl:attribute name="border-top">0.5pt solid #222</xsl:attribute>
        <xsl:attribute name="padding">4pt</xsl:attribute>
    </xsl:template>

    <xsl:template name="headerCellAttrs">
        <xsl:call-template name="cellAttrs" />
        <xsl:attribute name="background-color">#e0e0e0</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:template>

    <xsl:template match="/cpp:cpp">

        <xsl:variable name="CPP" select="@ID"></xsl:variable>
        <xsl:variable name="LABEL" select="$cpps//cpp[@identifier=$CPP]/label"></xsl:variable>

        <fo:root font-family="Helvetica" font-size="{$body-font-size}">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="cpp-page" page-height="{$page-height}" page-width="{$page-width}" margin-top="{$page-margin-top}" margin-bottom="{$page-margin-bottom}" margin-left="{$page-margin-left}" margin-right="{$page-margin-right}">
                    <fo:region-body margin-top="{$page-margin-top}" margin-bottom="{$page-margin-bottom}" />
                    <fo:region-before extent="{$page-margin-header}" />
                    <fo:region-after extent="{$page-margin-footer}" />
                </fo:simple-page-master>
                <fo:simple-page-master master-name="cpp-page-landscape" page-height="{$page-landscape-height}" page-width="{$page-landscape-width}" margin-top="{$page-margin-top}" margin-bottom="{$page-margin-bottom}" margin-left="{$page-margin-left}" margin-right="{$page-margin-right}">
                    <fo:region-body margin-top="{$page-margin-top}" margin-bottom="{$page-margin-bottom}" />
                    <fo:region-before extent="{$page-margin-header}" />
                    <fo:region-after extent="{$page-margin-footer}" />
                </fo:simple-page-master>
            </fo:layout-master-set>

            <!-- Part 1 (portrait): title, intro table, description up to Process description -->
            <fo:page-sequence master-reference="cpp-page">

                <xsl:call-template name="pageHeader">
                    <xsl:with-param name="CPP" select="$CPP" />
                    <xsl:with-param name="LABEL" select="$LABEL" />
                </xsl:call-template>

                <xsl:call-template name="pageFooter">
                    <xsl:with-param name="CPP" select="$CPP" />
                </xsl:call-template>

                <fo:flow flow-name="xsl-region-body">

                    <xsl:call-template name="title">
                        <xsl:with-param name="CPP" select="$CPP" />
                        <xsl:with-param name="LABEL" select="$LABEL" />
                    </xsl:call-template>

                    <xsl:apply-templates mode="introTable" select="cpp:header">
                        <xsl:with-param name="CPP" select="$CPP" />
                        <xsl:with-param name="LABEL" select="$LABEL" />
                    </xsl:apply-templates>

                    <xsl:call-template name="descriptionSectionIntro" />

                </fo:flow>

            </fo:page-sequence>

            <!-- Part 2 (landscape): Process description (trigger events + step table) -->
            <fo:page-sequence master-reference="cpp-page-landscape">

                <xsl:call-template name="pageHeader">
                    <xsl:with-param name="CPP" select="$CPP" />
                    <xsl:with-param name="LABEL" select="$LABEL" />
                </xsl:call-template>

                <xsl:call-template name="pageFooter">
                    <xsl:with-param name="CPP" select="$CPP" />
                </xsl:call-template>

                <fo:flow flow-name="xsl-region-body">

                    <xsl:call-template name="descriptionSectionProcess" />

                </fo:flow>

            </fo:page-sequence>

            <!-- Part 3 (portrait): Rationale, Dependencies, Links -->
            <fo:page-sequence master-reference="cpp-page">

                <xsl:call-template name="pageHeader">
                    <xsl:with-param name="CPP" select="$CPP" />
                    <xsl:with-param name="LABEL" select="$LABEL" />
                </xsl:call-template>

                <xsl:call-template name="pageFooter">
                    <xsl:with-param name="CPP" select="$CPP" />
                </xsl:call-template>

                <fo:flow flow-name="xsl-region-body">

                    <xsl:call-template name="descriptionSectionRationale" />

                    <xsl:call-template name="dependenciesSection" />

                    <xsl:call-template name="linksSection" />

                </fo:flow>

            </fo:page-sequence>

            <!-- Part 4 (landscape): References -->
            <fo:page-sequence master-reference="cpp-page-landscape">

                <xsl:call-template name="pageHeader">
                    <xsl:with-param name="CPP" select="$CPP" />
                    <xsl:with-param name="LABEL" select="$LABEL" />
                </xsl:call-template>

                <xsl:call-template name="pageFooter">
                    <xsl:with-param name="CPP" select="$CPP" />
                </xsl:call-template>

                <fo:flow flow-name="xsl-region-body">

                    <xsl:call-template name="referencesSection" />

                    <!-- marker block used to compute the total page count -->
                    <fo:block id="lastPage" />

                </fo:flow>

            </fo:page-sequence>

        </fo:root>
    </xsl:template>

    <!-- Repeated page header/footer, called from each page-sequence -->
    <xsl:template name="pageHeader">
        <xsl:param name="CPP" />
        <xsl:param name="LABEL" />

        <fo:static-content flow-name="xsl-region-before">
            <fo:block font-size="{$header-font-size}" border-bottom="0.5pt solid #222" padding-bottom="4pt">
                <fo:table width="100%" table-layout="fixed">
                    <fo:table-column column-width="proportional-column-width({$header-left-column-width})" />
                    <fo:table-column column-width="proportional-column-width({$header-right-column-width})" />
                    <fo:table-body>
                        <fo:table-row keep-together.within-page="always">
                            <fo:table-cell>
                                <fo:block font-weight="bold">
                                    <xsl:value-of select="$CPP" />
                                    <xsl:text>:</xsl:text>
                                    <xsl:value-of select="$SPACE" />
                                    <xsl:value-of select="$LABEL" />
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="end">
                                <fo:block>EOSC-EDEN Core Preservation Process</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="pageFooter">
        <xsl:param name="CPP" />

        <fo:static-content flow-name="xsl-region-after">
            <fo:block font-size="{$footer-font-size}" border-top="0.5pt solid #222" padding-top="4pt">
                <fo:table width="100%" table-layout="fixed">
                    <fo:table-column column-width="proportional-column-width({$footer-left-column-width})" />
                    <fo:table-column column-width="proportional-column-width({$footer-right-column-width})" />
                    <fo:table-body>
                        <fo:table-row keep-together.within-page="always">
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="$CPP" />
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell text-align="end">
                                <fo:block>
                                    <xsl:text>Page </xsl:text>
                                    <fo:page-number />
                                    <xsl:text> of </xsl:text>
                                    <fo:page-number-citation-last ref-id="lastPage" />
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:static-content>
    </xsl:template>

    <!-- Intro section templates -->

    <xsl:template name="title">
        <xsl:param name="CPP" />
        <xsl:param name="LABEL" />

        <fo:block font-size="{$title-font-size}" font-weight="{$title-font-weight}" font-style="{$title-font-style}" space-before="{$title-space-before}" space-after="{$title-space-after}">
            <xsl:value-of select="$LABEL" />
            <xsl:value-of select="$SPACE" />
            <xsl:text>&#40;</xsl:text>
            <xsl:value-of select="$CPP" />
            <xsl:text>&#41;</xsl:text>
        </fo:block>

    </xsl:template>

    <xsl:template match="cpp:header" mode="introTable">
        <xsl:param name="CPP" />
        <xsl:param name="LABEL" />

        <fo:block space-after="{$body-space-after}">
            <fo:table width="100%" table-layout="fixed" space-after="12pt" font-size="{$table-font-size}">
                <fo:table-column column-width="proportional-column-width({$left-column-width})" />
                <fo:table-column column-width="proportional-column-width({$right-column-width})" />
                <fo:table-body>
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block font-weight="bold">CPP-Identifier</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:value-of select="$CPP" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block font-weight="bold">CPP-Label</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:value-of select="$LABEL" />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:apply-templates select="cpp:authors" />
                    <xsl:apply-templates select="cpp:contributors" />
                    <xsl:apply-templates select="cpp:evaluators" />
                    <xsl:apply-templates select="cpp:dateCompleted" />
                    <xsl:apply-templates select="cpp:history" />
                </fo:table-body>
            </fo:table>
        </fo:block>

    </xsl:template>

    <xsl:template name="authorRow" match="cpp:authors">
        <fo:table-row keep-together.within-page="always">
            <fo:table-cell>
                <xsl:call-template name="cellAttrs" />
                <fo:block font-weight="bold">Author</fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <xsl:call-template name="cellAttrs" />
                <fo:block>
                    <xsl:for-each select="cpp:author">
                        <xsl:value-of select="." />
                        <xsl:if test="position() != last()">
                            <xsl:text>,</xsl:text>
                            <xsl:value-of select="$SPACE" />
                        </xsl:if>
                    </xsl:for-each>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template name="contributorRow" match="cpp:contributors">
        <fo:table-row keep-together.within-page="always">
            <fo:table-cell>
                <xsl:call-template name="cellAttrs" />
                <fo:block font-weight="bold">Contributors</fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <xsl:call-template name="cellAttrs" />
                <fo:block>
                    <xsl:for-each select="cpp:contributor">
                        <xsl:value-of select="." />
                        <xsl:if test="position() != last()">
                            <xsl:text>,</xsl:text>
                            <xsl:value-of select="$SPACE" />
                        </xsl:if>
                    </xsl:for-each>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template name="evaluatorRow" match="cpp:evaluators">
        <fo:table-row keep-together.within-page="always">
            <fo:table-cell>
                <xsl:call-template name="cellAttrs" />
                <fo:block font-weight="bold">Evaluators</fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <xsl:call-template name="cellAttrs" />
                <fo:block>
                    <xsl:for-each select="cpp:evaluator">
                        <xsl:value-of select="." />
                        <xsl:if test="position() != last()">
                            <xsl:text>,</xsl:text>
                            <xsl:value-of select="$SPACE" />
                        </xsl:if>
                    </xsl:for-each>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template name="dateRow" match="cpp:dateCompleted">
        <fo:table-row keep-together.within-page="always">
            <fo:table-cell>
                <xsl:call-template name="cellAttrs" />
                <fo:block font-weight="bold">Date of edition completed</fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <xsl:call-template name="cellAttrs" />
                <fo:block>
                    <xsl:value-of select="." />
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template name="historyRows" match="cpp:history">
        <fo:table-row keep-together.within-page="always">
            <fo:table-cell>
                <xsl:call-template name="headerCellAttrs" />
                <fo:block>Change history</fo:block>
            </fo:table-cell>
            <fo:table-cell>
                <xsl:call-template name="headerCellAttrs" />
                <fo:block>Comments</fo:block>
            </fo:table-cell>
        </fo:table-row>
        <xsl:for-each select="cpp:version">
            <xsl:variable name="VERSION_MAJOR" select="cpp:versionNumber/cpp:majorVersion"></xsl:variable>
            <xsl:variable name="VERSION_MINOR" select="cpp:versionNumber/cpp:minorVersion"></xsl:variable>
            <xsl:variable name="VERSION_PATCH" select="cpp:versionNumber/cpp:patchVersion"></xsl:variable>
            <xsl:variable name="VERSION_DATE" select="cpp:versionDate"></xsl:variable>
            <fo:table-row keep-together.within-page="always">
                <fo:table-cell>
                    <xsl:call-template name="cellAttrs" />
                    <fo:block>
                        <xsl:text>Version </xsl:text>
                        <xsl:value-of select="$VERSION_MAJOR" />
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="$VERSION_MINOR" />
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="$VERSION_PATCH" />
                        <xsl:text> - </xsl:text>
                        <xsl:value-of select="$VERSION_DATE" />
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                    <xsl:call-template name="cellAttrs" />
                    <fo:block>
                        <xsl:value-of select="cpp:versionNotes" />
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:for-each>
    </xsl:template>

    <!-- Description section templates -->

    <xsl:template name="descriptionSectionIntro" match="cpp:cpp">

        <fo:block font-size="{$h1-font-size}" font-weight="{$h1-font-weight}" font-style="{$h1-font-style}" space-before="{$h1-space-before}" space-after="{$h1-space-after}" break-before="page">1. Description of the CPP</fo:block>

        <fo:block font-weight="{$body-font-weight}" font-style="{$body-font-style}" space-before="{$body-space-before}" space-after="{$body-space-after}">
            <xsl:value-of select="cpp:shortDefinition" />
        </fo:block>

        <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Inputs and outputs</fo:block>

        <xsl:call-template name="inoutTable">
            <xsl:with-param name="inputs" select="cpp:process/cpp:inputs" />
            <xsl:with-param name="outputs" select="cpp:process/cpp:outputs" />
        </xsl:call-template>

        <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Definition and scope</fo:block>

        <xsl:call-template name="copyContentFO">
            <xsl:with-param name="data" select="cpp:descriptionAndScope" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="descriptionSectionProcess" match="cpp:cpp">

        <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Process description</fo:block>

        <fo:block font-size="{$h3-font-size}" font-weight="{$h3-font-weight}" font-style="{$h3-font-style}" space-before="{$h3-space-before}" space-after="{$h3-space-after}">Trigger event&#40;s&#41;</fo:block>

        <xsl:call-template name="triggerEvents">
            <xsl:with-param name="data" select="cpp:process/cpp:triggerEvents" />
        </xsl:call-template>

        <fo:block font-size="{$h3-font-size}" font-weight="{$h3-font-weight}" font-style="{$h3-font-style}" space-before="{$h3-space-before}" space-after="{$h3-space-after}">Step-by-step description</fo:block>

        <xsl:call-template name="stepTable">
            <xsl:with-param name="data" select="cpp:process/cpp:stepByStepDescription" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="descriptionSectionRationale" match="cpp:cpp">

        <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Rationale&#40;s&#41; and worst case&#40;s&#41;</fo:block>

        <xsl:call-template name="rationaleTable">
            <xsl:with-param name="data" select="cpp:rationaleWorstCase" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="dependenciesSection" match="cpp:cpp">

        <fo:block font-size="{$h1-font-size}" font-weight="{$h1-font-weight}" font-style="{$h1-font-style}" space-before="{$h1-space-before}" space-after="{$h1-space-after}" break-before="page">2. Dependencies and relationships with other CPPs</fo:block>

        <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Dependencies</fo:block>

        <xsl:call-template name="dependencyTable">
            <xsl:with-param name="data" select="cpp:cppRelationships/cpp:relationship[cpp:relationshipType='Requires']" />
        </xsl:call-template>

        <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Other relations</fo:block>

        <xsl:call-template name="relationTable">
            <xsl:with-param name="data" select="cpp:cppRelationships/cpp:relationship[cpp:relationshipType!='Requires']" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="linksSection" match="cpp:cpp">

        <fo:block font-size="{$h1-font-size}" font-weight="{$h1-font-weight}" font-style="{$h1-font-style}" space-before="{$h1-space-before}" space-after="{$h1-space-after}" break-before="page">3. Links to frameworks</fo:block>

        <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Certification</fo:block>

        <xsl:call-template name="certificationTable">
            <xsl:with-param name="data" select="cpp:frameworkMappings" />
        </xsl:call-template>

        <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Other frameworks and reference documents</fo:block>

        <xsl:call-template name="frameworkTable">
            <xsl:with-param name="data" select="cpp:frameworkMappings" />
        </xsl:call-template>

    </xsl:template>

    <xsl:template name="referencesSection">

        <fo:block font-size="{$h1-font-size}" font-weight="{$h1-font-weight}" font-style="{$h1-font-style}" space-before="{$h1-space-before}" space-after="{$h1-space-after}" break-before="page">4. Reference implementations</fo:block>

        <xsl:if test="count(cpp:referenceImplementations/cpp:useCases/cpp:useCase) &gt; 0">


            <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Use cases</fo:block>

            <xsl:call-template name="useCases">
                <xsl:with-param name="data" select="cpp:referenceImplementations/cpp:useCases" />
            </xsl:call-template>

        </xsl:if>

        <xsl:if test="count(cpp:referenceImplementations/cpp:publicDocumentation) &gt; 0">

            <fo:block font-size="{$h2-font-size}" font-weight="{$h2-font-weight}" font-style="{$h2-font-style}" space-before="{$h2-space-before}" space-after="{$h2-space-after}">Publicly available documentation</fo:block>

            <xsl:call-template name="publicDocumentationTable">
                <xsl:with-param name="data" select="cpp:referenceImplementations" />
            </xsl:call-template>

        </xsl:if>

    </xsl:template>

    <!-- Inputs/outputs table -->

    <xsl:template name="inoutTable">
        <xsl:param name="inputs" />
        <xsl:param name="outputs" />

        <fo:block space-after="4pt">
            <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
                <fo:table-column column-width="proportional-column-width(2)" />
                <fo:table-column column-width="proportional-column-width(1)" />
                <fo:table-column column-width="proportional-column-width(8)" />
                <fo:table-body>
                    <xsl:apply-templates select="$inputs" mode="inout_table" />
                    <xsl:apply-templates select="$outputs" mode="inout_table" />
                </fo:table-body>
            </fo:table>
        </fo:block>

    </xsl:template>

    <xsl:template match="cpp:inputs" mode="inout_table">
        <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
            <fo:table-cell number-columns-spanned="3">
                <xsl:call-template name="headerCellAttrs" />
                <fo:block>Input&#40;s&#41;</fo:block>
            </fo:table-cell>
        </fo:table-row>

        <xsl:call-template name="inoutTableElements">
            <xsl:with-param name="inout_data" select="." />
        </xsl:call-template>

    </xsl:template>

    <xsl:template match="cpp:outputs" mode="inout_table">
        <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
            <fo:table-cell number-columns-spanned="3">
                <xsl:call-template name="headerCellAttrs" />
                <fo:block>Output&#40;s&#41;</fo:block>
            </fo:table-cell>
        </fo:table-row>

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

    <!-- Generic template for multi-row headers, one row per data element -->
    <xsl:template name="multiRowHeader">
        <xsl:param name="data" />
        <xsl:param name="header" />

        <xsl:variable name="requiredData" select="$data[@optional!='true' or not(@optional)]" />
        <xsl:variable name="optionalData" select="$data[@optional='true']" />
        <xsl:variable name="totalRowsRequired" select="count($requiredData)" />
        <xsl:variable name="totalRowsOptional" select="count($optionalData)" />
        <xsl:variable name="totalRows" select="$totalRowsRequired + $totalRowsOptional"></xsl:variable>

        <xsl:for-each select="$requiredData">
            <fo:table-row keep-together.within-page="always">
                <!-- First column cell spanning all rows -->
                <xsl:if test="position() = 1">
                    <fo:table-cell number-rows-spanned="{$totalRows}">
                        <xsl:call-template name="cellAttrs" />
                        <fo:block font-weight="bold">
                            <xsl:value-of select="$header" />
                        </fo:block>
                    </fo:table-cell>
                </xsl:if>

                <!--- the data cell for the required data element, spanning two columns -->
                <fo:table-cell number-columns-spanned="2">
                    <xsl:call-template name="cellAttrs" />
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:for-each>

        <xsl:for-each select="$optionalData">
            <fo:table-row keep-together.within-page="always">
                <!-- First column cell spanning all rows -->
                <xsl:if test="position() = 1 and $totalRowsRequired=0">
                    <fo:table-cell number-rows-spanned="{$totalRows}">
                        <xsl:call-template name="cellAttrs" />
                        <fo:block font-weight="bold">
                            <xsl:value-of select="$header" />
                        </fo:block>
                    </fo:table-cell>
                </xsl:if>

                <!-- The fixed Optional text column -->
                <xsl:if test="position() = 1">
                    <fo:table-cell number-rows-spanned="{$totalRowsOptional}" font-style="italic">
                        <xsl:call-template name="cellAttrs" />
                        <fo:block>Optional</fo:block>
                    </fo:table-cell>
                </xsl:if>

                <!-- The data cell for the optional data element -->
                <fo:table-cell>
                    <xsl:call-template name="cellAttrs" />
                    <fo:block>
                        <xsl:value-of select="." />
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:for-each>

    </xsl:template>

    <!-- Trigger events table -->

    <xsl:template name="triggerEvents">
        <xsl:param name="data" />

        <fo:block space-after="4pt">
            <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
                <fo:table-column column-width="proportional-column-width(3)" />
                <fo:table-column column-width="proportional-column-width(2)" />
                <fo:table-header>
                    <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                        <fo:table-cell>
                            <xsl:call-template name="headerCellAttrs" />
                            <fo:block>Trigger Event</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="headerCellAttrs" />
                            <fo:block>CPP-identifier</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>

                <fo:table-body>
                    <xsl:for-each select="$data/cpp:triggerEvent">
                        <fo:table-row keep-together.within-page="always">
                            <fo:table-cell>
                                <xsl:call-template name="cellAttrs" />
                                <xsl:call-template name="copyContentFO">
                                    <xsl:with-param name="data" select="./cpp:description" />
                                </xsl:call-template>
                            </fo:table-cell>
                            <fo:table-cell>
                                <xsl:call-template name="cellAttrs" />
                                <fo:block>
                                    <xsl:call-template name="cppIdLabel">
                                        <xsl:with-param name="cpp_identifier" select="./cpp:correspondingCPP" />
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>

    </xsl:template>

    <!-- Step-by-step description table -->
    <xsl:template name="stepTable">
        <xsl:param name="data" />

        <fo:table width="100%" table-layout="fixed" table-omit-header-at-break="false" space-after="8pt" font-size="{$table-font-size}" keep-with-previous="always">
            <xsl:call-template name="stepTableColumns" />
            <fo:table-header>
                <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                    <fo:table-cell number-columns-spanned="{$maxStepDepth}">
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>No</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Supplier</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Input</fo:block>
                    </fo:table-cell>
                    <fo:table-cell background-color="#f9cb9c">
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Steps</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Output</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Customer</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>

                <xsl:for-each select="$data/cpp:stepGroup">
                    <xsl:apply-templates select="." mode="group" />
                </xsl:for-each>

            </fo:table-body>
        </fo:table>

    </xsl:template>

    <!-- Fixed set of table columns: maxStepDepth narrow number columns + 5 data columns -->
    <xsl:template name="stepTableColumns">
        <xsl:call-template name="stepNumberColumns">
            <xsl:with-param name="count" select="$maxStepDepth" />
        </xsl:call-template>
        <fo:table-column column-width="15%" />
        <fo:table-column column-width="18%" />
        <fo:table-column column-width="proportional-column-width(100)"/>
        <fo:table-column column-width="18%" />
        <fo:table-column column-width="15%" />
    </xsl:template>

    <xsl:template name="stepNumberColumns">
        <xsl:param name="count" />
        <xsl:if test="$count &gt; 0">
            <fo:table-column>
                <xsl:attribute name="column-width">
                    <xsl:value-of select="10 +($maxStepDepth - $count)*3"/>
                    <xsl:text>mm</xsl:text>
                </xsl:attribute>
            </fo:table-column>

            <xsl:call-template name="stepNumberColumns">
                <xsl:with-param name="count" select="$count - 1" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <!-- Rationale and worst case table -->

    <xsl:template name="rationaleTable">
        <xsl:param name="data" />

        <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
            <fo:table-column column-width="proportional-column-width(3)" />
            <fo:table-column column-width="proportional-column-width(2)" />
            <fo:table-header>
                <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Rationale</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Impact of inaction or failure of the process</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>

                <xsl:for-each select="$data/cpp:purpose">
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <xsl:call-template name="copyContentFO">
                                <xsl:with-param name="data" select="./cpp:purposeDescription" />
                            </xsl:call-template>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <xsl:call-template name="copyContentFO">
                                <xsl:with-param name="data" select="./cpp:worstCase" />
                            </xsl:call-template>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>

            </fo:table-body>
        </fo:table>

    </xsl:template>

    <!-- dependencies table -->

    <xsl:template name="dependencyTable">
        <xsl:param name="data" />

        <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
            <fo:table-column column-width="proportional-column-width(2)" />
            <fo:table-column column-width="proportional-column-width(3)" />
            <fo:table-column column-width="proportional-column-width(10)" />
            <fo:table-header>
                <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>CPP-ID</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>CPP-Title</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Relationship description</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>

                <xsl:if test="not($data)">
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>/</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>/</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>/</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

                <xsl:for-each select="$data">
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:value-of select="cpp:relatedCPP" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:call-template name="cppLabelFromId">
                                    <xsl:with-param name="cpp_identifier" select="cpp:relatedCPP" />
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <xsl:call-template name="copyContentFO">
                                <xsl:with-param name="data" select="cpp:relationshipDescription" />
                            </xsl:call-template>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>

            </fo:table-body>
        </fo:table>

    </xsl:template>

    <!-- relations table -->

    <xsl:template name="relationTable">
        <xsl:param name="data" />

        <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
            <fo:table-column column-width="proportional-column-width(3)" />
            <fo:table-column column-width="proportional-column-width(2)" />
            <fo:table-column column-width="proportional-column-width(3)" />
            <fo:table-column column-width="proportional-column-width(7)" />

            <fo:table-header>
                <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Relation</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>CPP-ID</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>CPP-Title</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Relationship description</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>

                <xsl:for-each select="$data">
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:value-of select="cpp:relationshipType" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:value-of select="cpp:relatedCPP" />
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:call-template name="cppLabelFromId">
                                    <xsl:with-param name="cpp_identifier" select="cpp:relatedCPP" />
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <xsl:call-template name="copyContentFO">
                                <xsl:with-param name="data" select="cpp:relationshipDescription" />
                            </xsl:call-template>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:for-each>

            </fo:table-body>
        </fo:table>
    </xsl:template>

    <!-- certification table -->

    <xsl:template name="certificationTable">
        <xsl:param name="data" />

        <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
            <fo:table-column column-width="proportional-column-width(2)" />
            <fo:table-column column-width="proportional-column-width(4)" />
            <fo:table-column column-width="proportional-column-width(6)" />

            <fo:table-header>
                <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Certification framework</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Term used in framework to refer to the CPP</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Section</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>

                <xsl:for-each select="$frameworks//framework[@type='certification']">
                    <xsl:variable name="certData" select="$data/cpp:mapping[cpp:frameworkName = current()/@code]" />
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:call-template name="hyperlinkFO">
                                    <xsl:with-param name="href" select="link" />
                                    <xsl:with-param name="text" select="name" />
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <xsl:choose>
                            <xsl:when test="not($certData)">
                                <fo:table-cell>
                                    <xsl:call-template name="cellAttrs" />
                                    <fo:block>/</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <xsl:call-template name="cellAttrs" />
                                    <fo:block>/</fo:block>
                                </fo:table-cell>
                            </xsl:when>
                            <xsl:otherwise>
                                <fo:table-cell>
                                    <xsl:call-template name="cellAttrs" />
                                    <xsl:call-template name="copyContentFO">
                                        <xsl:with-param name="data" select="$certData/cpp:correspondingTerm" />
                                    </xsl:call-template>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <xsl:call-template name="cellAttrs" />
                                    <xsl:call-template name="copyContentFO">
                                        <xsl:with-param name="data" select="$certData/cpp:correspondingSection" />
                                    </xsl:call-template>
                                </fo:table-cell>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:table-row>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>

    </xsl:template>

    <!-- framework table -->

    <xsl:template name="frameworkTable">
        <xsl:param name="data" />

        <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
            <fo:table-column column-width="proportional-column-width(2)" />
            <fo:table-column column-width="proportional-column-width(4)" />
            <fo:table-column column-width="proportional-column-width(6)" />

            <fo:table-header>
                <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Reference Document</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Term used in framework to refer to the process</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Section</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>

                <xsl:for-each select="$frameworks//framework[@type='other']">
                    <xsl:variable name="frameworkData" select="$data/cpp:mapping[cpp:frameworkName = current()/@code]" />
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>
                                <xsl:call-template name="hyperlinkFO">
                                    <xsl:with-param name="href" select="link" />
                                    <xsl:with-param name="text" select="name" />
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <xsl:choose>
                            <xsl:when test="not($frameworkData)">
                                <fo:table-cell>
                                    <xsl:call-template name="cellAttrs" />
                                    <fo:block>/</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <xsl:call-template name="cellAttrs" />
                                    <fo:block>/</fo:block>
                                </fo:table-cell>
                            </xsl:when>
                            <xsl:otherwise>
                                <fo:table-cell>
                                    <xsl:call-template name="cellAttrs" />
                                    <xsl:call-template name="copyContentFO">
                                        <xsl:with-param name="data" select="$frameworkData/cpp:correspondingTerm" />
                                    </xsl:call-template>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <xsl:call-template name="cellAttrs" />
                                    <xsl:call-template name="copyContentFO">
                                        <xsl:with-param name="data" select="$frameworkData/cpp:correspondingSection" />
                                    </xsl:call-template>
                                </fo:table-cell>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:table-row>
                </xsl:for-each>

            </fo:table-body>
        </fo:table>

    </xsl:template>

    <!-- Use case section -->

    <xsl:template name="useCases">
        <xsl:param name="data" />

        <xsl:for-each select="$data/cpp:useCase">

            <fo:block font-weight="bold" space-before="8pt" space-after="4pt">
                <xsl:value-of select="cpp:useCasetitle" />
            </fo:block>

            <xsl:call-template name="useCaseTable">
                <xsl:with-param name="data" select="." />
            </xsl:call-template>
        </xsl:for-each>

    </xsl:template>

    <!-- Use case table -->

    <xsl:template name="useCaseTable">
        <xsl:param name="data" />

        <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
            <fo:table-column column-width="proportional-column-width(2)" />
            <fo:table-column column-width="proportional-column-width(10)" />
            <fo:table-header>
                <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                    <fo:table-cell number-columns-spanned="2">
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Institutional background</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>

                <fo:table-row keep-together.within-page="always">
                    <fo:table-cell>
                        <xsl:call-template name="cellAttrs" />
                        <fo:block>Institution</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="cellAttrs" />
                        <fo:block>
                            <xsl:value-of select="$data/cpp:institution/cpp:institutionLabel" />
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="$data/cpp:institution/cpp:institutionCountry" />
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>

                <xsl:if test="$data/cpp:linkToDocumentation">
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>Hyperlink</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <xsl:for-each select="$data/cpp:linkToDocumentation">
                                <fo:block>
                                    <xsl:if test="cpp:comment">
                                        <xsl:value-of select="cpp:comment" />
                                        <xsl:value-of select="$SPACE" />
                                    </xsl:if>
                                    <xsl:call-template name="hyperlinkFO">
                                        <xsl:with-param name="href" select="cpp:hyperlink" />
                                        <xsl:with-param name="text" select="cpp:hyperlink" />
                                    </xsl:call-template>
                                </fo:block>
                            </xsl:for-each>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

                <fo:table-row keep-together.within-page="always">
                    <fo:table-cell number-columns-spanned="2">
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Description</fo:block>
                    </fo:table-cell>
                </fo:table-row>

                <xsl:if test="$data/cpp:triggerEvent">
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>Trigger event</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <xsl:call-template name="copyContentFO">
                                <xsl:with-param name="data" select="$data/cpp:triggerEvent" />
                            </xsl:call-template>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

                <xsl:if test="$data/cpp:problemStatement">
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>Problem statement</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <xsl:call-template name="copyContentFO">
                                <xsl:with-param name="data" select="$data/cpp:problemStatement" />
                            </xsl:call-template>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

                <xsl:if test="$data/cpp:proposedSolution">
                    <fo:table-row keep-together.within-page="always">
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <fo:block>Proposed solution</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <xsl:call-template name="cellAttrs" />
                            <xsl:call-template name="copyContentFO">
                                <xsl:with-param name="data" select="$data/cpp:proposedSolution" />
                            </xsl:call-template>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

            </fo:table-body>
        </fo:table>

    </xsl:template>

    <!-- Public documentation template -->

    <xsl:template name="publicDocumentationTable">
        <xsl:param name="data" />

        <fo:table width="100%" table-layout="fixed" space-after="8pt" keep-with-previous="always" font-size="{$table-font-size}">
            <fo:table-column column-width="proportional-column-width(2)" />
            <fo:table-column column-width="proportional-column-width(2)" />
            <fo:table-column column-width="proportional-column-width(1)" />
            <fo:table-column column-width="proportional-column-width(7)" />

            <fo:table-header>
                <fo:table-row keep-together.within-page="always" keep-with-previous="always" keep-with-next="always">
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Institution</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Organisation type</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Language</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:call-template name="headerCellAttrs" />
                        <fo:block>Hyperlink</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>

                <xsl:for-each select="$data/cpp:publicDocumentation">
                    <xsl:apply-templates select="." />
                </xsl:for-each>

            </fo:table-body>
        </fo:table>

    </xsl:template>

    <xsl:template match="cpp:publicDocumentation">

        <xsl:variable name="cnt" select="count(cpp:linkToDocumentation)"></xsl:variable>
        <xsl:variable name="institution">
            <xsl:value-of select="cpp:institution/cpp:institutionLabel" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="cpp:institution/cpp:institutionCountry" />
        </xsl:variable>
        <xsl:variable name="institutionTypes" select="cpp:institution/cpp:institutionType/text()" />

        <xsl:for-each select="cpp:linkToDocumentation">
            <xsl:variable name="langcode" select="./@xml:lang" />

            <fo:table-row keep-together.within-page="always">
                <xsl:if test="position()>1">
                    <xsl:attribute name="keep-with-previous">always</xsl:attribute>
                </xsl:if>
                <xsl:if test="position()=1">
                    <fo:table-cell number-rows-spanned="{$cnt}">
                        <xsl:call-template name="cellAttrs" />
                        <fo:block>
                            <xsl:value-of select="$institution" />
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-rows-spanned="{$cnt}">
                        <xsl:call-template name="cellAttrs" />
                        <fo:block>
                            <xsl:for-each select="$institutionTypes">
                                <xsl:value-of select="." />
                                <xsl:if test="position() != last()">
                                    <xsl:text>; </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </fo:block>
                    </fo:table-cell>
                </xsl:if>

                <fo:table-cell>
                    <xsl:call-template name="cellAttrs" />
                    <fo:block>
                        <xsl:value-of select="$languages//language[@code=$langcode]/label" />
                    </fo:block>
                </fo:table-cell>

                <fo:table-cell>
                    <xsl:call-template name="cellAttrs" />
                    <fo:block>
                        <xsl:call-template name="hyperlinkFO">
                            <xsl:with-param name="href" select="./cpp:hyperlink" />
                            <xsl:with-param name="text" select="./cpp:hyperlink" />
                        </xsl:call-template>
                        <xsl:if test="./cpp:comment">
                            <xsl:text> &#40;</xsl:text>
                            <xsl:value-of select="./cpp:comment" />
                            <xsl:text>&#41;</xsl:text>
                        </xsl:if>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:for-each>
    </xsl:template>

    <!-- Precomputed hsl(210|150|330, 70%, 95%-depth*5%) colors as hex, since FOP has no hsl() support -->
    <xsl:template name="stepGroupColor">
        <xsl:param name="type" />
        <xsl:param name="depth" />

        <xsl:variable name="colors">
            <c type="sequence" depth="0">#E9F2FB</c>
            <c type="sequence" depth="1">#D4E5F7</c>
            <c type="sequence" depth="2">#BED9F4</c>
            <c type="sequence" depth="3">#A8CCF0</c>
            <c type="sequence" depth="4">#93BFEC</c>
            <c type="sequence" depth="5">#7DB2E8</c>
            <c type="alternative" depth="0">#E9FBF2</c>
            <c type="alternative" depth="1">#D4F7E6</c>
            <c type="alternative" depth="2">#BEF4D9</c>
            <c type="alternative" depth="3">#A8F0CC</c>
            <c type="alternative" depth="4">#93ECBF</c>
            <c type="alternative" depth="5">#7DE8B3</c>
            <c type="parallel" depth="0">#FBE9F2</c>
            <c type="parallel" depth="1">#F7D4E6</c>
            <c type="parallel" depth="2">#F4BED9</c>
            <c type="parallel" depth="3">#F0A8CC</c>
            <c type="parallel" depth="4">#EC93BF</c>
            <c type="parallel" depth="5">#E87DB3</c>
        </xsl:variable>
        <xsl:value-of select="exslt:node-set($colors)/c[@type=$type and @depth=$depth]" />
    </xsl:template>

    <!-- Generic template for a step group -->
    <xsl:template match="cpp:stepGroup" mode="group">
        <xsl:param name="depth" select="0" />
        <xsl:param name="parent-color" />

        <!-- FOP does not support the CSS hsl() function, so colors are looked up from
             a precomputed table (hsl(210|150|330, 70%, 95%-depth*5%) converted to hex) -->
        <xsl:variable name="clampedDepth">
            <xsl:choose>
                <xsl:when test="$depth &gt; 5">5</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$depth" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="my-color">
            <xsl:call-template name="stepGroupColor">
                <xsl:with-param name="type" select="@type" />
                <xsl:with-param name="depth" select="$clampedDepth" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="stepRows" select="number(cpp:stepRowCount(.))" />

        <!-- Group label row: a 1-column indent cell (in the parent's color, spanning
             every row of this nested group) precedes the label for depth > 0, so
             ancestor colors keep showing next to their descendants -->
        <fo:table-row keep-together.within-page="always">
            <xsl:if test="$depth &gt; 0">
                <fo:table-cell background-color="{$parent-color}">
                    <xsl:call-template name="cellAttrs" />
                    <xsl:attribute name="number-rows-spanned">
                        <xsl:value-of select="$stepRows" />
                    </xsl:attribute>
                    <fo:block>
                        <xsl:value-of select="@stepGroupNumber" />
                    </fo:block>
                </fo:table-cell>
            </xsl:if>
            <fo:table-cell background-color="{$my-color}">
                <xsl:call-template name="cellAttrs" />
                <xsl:attribute name="number-columns-spanned">
                    <xsl:value-of select="$totalColumnCount - $depth" />
                </xsl:attribute>
                <fo:block>
                    <xsl:call-template name="stepGroupLabel">
                        <xsl:with-param name="type" select="@type" />
                        <xsl:with-param name="label" select="@label" />
                    </xsl:call-template>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>

        <!-- Process children in document order: steps and nested stepGroup -->
        <xsl:for-each select="node()[self::cpp:step or self::cpp:stepGroup]">
            <xsl:choose>
                <xsl:when test="self::cpp:step">
                    <xsl:apply-templates select="." mode="step">
                        <xsl:with-param name="my-color" select="$my-color" />
                        <xsl:with-param name="depth" select="$depth" />
                    </xsl:apply-templates>
                </xsl:when>

                <xsl:when test="self::cpp:stepGroup">
                    <xsl:apply-templates select="." mode="group">
                        <xsl:with-param name="depth" select="$depth + 1" />
                        <xsl:with-param name="parent-color" select="$my-color" />
                    </xsl:apply-templates>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>

    </xsl:template>

    <!-- Generic template for a single step -->
    <xsl:template match="cpp:step" mode="step">
        <xsl:param name="my-color" />
        <xsl:param name="depth" select="0" />

        <xsl:variable name="stepColumns" select="$maxStepDepth - $depth" />

        <xsl:variable name="rowCount">
            <xsl:value-of select="number(cpp:stepRowCount(.))" />
        </xsl:variable>

        <xsl:variable name="cntInput" select="count(cpp:input)" />
        <xsl:variable name="cntOutput" select="count(cpp:output)" />

        <xsl:apply-templates select="." mode="data">
            <xsl:with-param name="my-color" select="$my-color" />
            <xsl:with-param name="stepColumns" select="$stepColumns" />
            <xsl:with-param name="counter" select="1" />
            <xsl:with-param name="max" select="$rowCount" />
            <xsl:with-param name="maxInput" select="$cntInput" />
            <xsl:with-param name="maxOutput" select="$cntOutput" />
        </xsl:apply-templates>

    </xsl:template>

    <!-- Generic template for single data in step row -->
    <xsl:template match="cpp:step" mode="data">
        <xsl:param name="my-color" />
        <xsl:param name="stepColumns" />
        <xsl:param name="counter" />
        <xsl:param name="max" />
        <xsl:param name="maxInput" />
        <xsl:param name="maxOutput" />

        <fo:table-row keep-together.within-page="always">
            <xsl:choose>
                <xsl:when test="$counter = 1">

                    <!-- step number -->
                    <fo:table-cell background-color="{$my-color}">
                        <xsl:call-template name="cellAttrs" />
                        <xsl:attribute name="number-rows-spanned">
                            <xsl:value-of select="$max" />
                        </xsl:attribute>
                        <xsl:attribute name="number-columns-spanned">
                            <xsl:value-of select="$stepColumns" />
                        </xsl:attribute>
                        <fo:block>
                            <xsl:value-of select="@stepNumber"></xsl:value-of>
                        </fo:block>
                    </fo:table-cell>

                    <!-- input columns -->
                    <xsl:call-template name="stepInput">
                        <xsl:with-param name="data" select="cpp:input[$counter]" />
                        <xsl:with-param name="counter" select="$counter" />
                        <xsl:with-param name="max" select="$maxInput" />
                        <xsl:with-param name="total" select="$max" />
                    </xsl:call-template>

                    <!-- step description -->
                    <fo:table-cell background-color="#fce5cd">
                        <xsl:call-template name="cellAttrs" />
                        <xsl:attribute name="number-rows-spanned">
                            <xsl:value-of select="$max" />
                        </xsl:attribute>
                        <fo:block>
                            <xsl:if test="./@optional='true'">
                                <fo:inline font-style="italic">Optional: </fo:inline>
                            </xsl:if>
                        </fo:block>
                        <xsl:call-template name="copyContentFO">
                            <xsl:with-param name="data" select="cpp:stepDescription" />
                        </xsl:call-template>
                    </fo:table-cell>

                    <!-- output columns -->
                    <xsl:call-template name="stepOutput">
                        <xsl:with-param name="data" select="cpp:output[$counter]" />
                        <xsl:with-param name="counter" select="$counter" />
                        <xsl:with-param name="max" select="$maxOutput" />
                        <xsl:with-param name="total" select="$max" />
                    </xsl:call-template>

                </xsl:when>
                <xsl:otherwise>

                    <xsl:if test="$counter &lt;= $maxInput">
                        <xsl:call-template name="stepInput">
                            <xsl:with-param name="data" select="cpp:input[$counter]" />
                            <xsl:with-param name="counter" select="$counter" />
                            <xsl:with-param name="max" select="$maxInput" />
                            <xsl:with-param name="total" select="$max" />
                        </xsl:call-template>
                    </xsl:if>

                    <xsl:if test="$counter &lt;= $maxOutput">
                        <xsl:call-template name="stepOutput">
                            <xsl:with-param name="data" select="cpp:output[$counter]" />
                            <xsl:with-param name="counter" select="$counter" />
                            <xsl:with-param name="max" select="$maxOutput" />
                            <xsl:with-param name="total" select="$max" />
                        </xsl:call-template>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </fo:table-row>

        <xsl:if test="$counter &lt; $max">
            <xsl:apply-templates select="." mode="data">
                <xsl:with-param name="my-color" select="$my-color" />
                <xsl:with-param name="stepColumns" select="$stepColumns" />
                <xsl:with-param name="counter" select="$counter + 1" />
                <xsl:with-param name="max" select="$max" />
                <xsl:with-param name="maxInput" select="$maxInput" />
                <xsl:with-param name="maxOutput" select="$maxOutput" />
            </xsl:apply-templates>
        </xsl:if>

    </xsl:template>

    <xsl:template name="stepGroupLabel">
        <xsl:param name="type" />
        <xsl:param name="label" />

        <fo:instream-foreign-object content-width="1em" content-height="1em">
            <xsl:choose>
                <xsl:when test="$type='sequence'">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <!--! Font Awesome Free 7.3.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2026 Fonticons, Inc. -->
                        <path fill="currentColor" d="M418.7 38c8.3 6 13.3 15.7 13.3 26l0 96 16 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-96 0c-17.7 0-32-14.3-32-32s14.3-32 32-32l16 0 0-51.6-5.9 2c-16.8 5.6-34.9-3.5-40.5-20.2s3.5-34.9 20.2-40.5l48-16c9.8-3.3 20.5-1.6 28.8 4.4zM365.1 430.6l11.7-18c-32.9-9.9-56.8-40.5-56.8-76.6 0-44.2 35.8-80 80-80s80 35.8 80 80c0 22.9-6.6 45.3-19.1 64.5l-42.1 64.9c-9.6 14.8-29.4 19.1-44.3 9.4s-19.1-29.4-9.4-44.3zM424 336a24 24 0 1 0 -48 0 24 24 0 1 0 48 0zM150.6 470.6c-12.5 12.5-32.8 12.5-45.3 0l-96-96c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L96 370.7 96 64c0-17.7 14.3-32 32-32s32 14.3 32 32l0 306.7 41.4-41.4c12.5-12.5 32.8-12.5 45.3 0s12.5 32.8 0 45.3l-96 96z"/>
                    </svg>
                </xsl:when>
                <xsl:when test="$type='alternative'">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <!--! Font Awesome Free 7.3.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2026 Fonticons, Inc. -->
                        <path fill="currentColor" d="M342.6-22.6c-12.5-12.5-32.8-12.5-45.3 0l-96 96c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l41.4-41.4 0 195.9c-18.8-10.9-40.7-17.1-64-17.1l-114.7 0 41.4-41.4c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-96 96c-12.5 12.5-12.5 32.8 0 45.3l96 96c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.3 320 224 320c35.3 0 64 28.7 64 64 0 70.7 57.3 128 128 128l32 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-32 0c-35.3 0-64-28.7-64-64l0-306.7 41.4 41.4c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3l-96-96z"/>
                    </svg>
                </xsl:when>
                <xsl:when test="$type='parallel'">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <!--! Font Awesome Free 7.3.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free (Icons: CC BY 4.0, Fonts: SIL OFL 1.1, Code: MIT License) Copyright 2026 Fonticons, Inc. -->
                        <path fill="currentColor" d="M214.6 310.6l-64 64c-12.5 12.5-32.8 12.5-45.3 0l-64-64c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0L96 274.7 96 32c0-17.7 14.3-32 32-32s32 14.3 32 32l0 242.7 9.4-9.4c12.5-12.5 32.8-12.5 45.3 0s12.5 32.8 0 45.3zm256 0l-64 64c-12.5 12.5-32.8 12.5-45.3 0l-64-64c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l9.4 9.4 0-242.7c0-17.7 14.3-32 32-32s32 14.3 32 32l0 242.7 9.4-9.4c12.5-12.5 32.8-12.5 45.3 0s12.5 32.8 0 45.3zM32 512c-17.7 0-32-14.3-32-32s14.3-32 32-32l448 0c17.7 0 32 14.3 32 32s-14.3 32-32 32L32 512z"/>
                    </svg>
                </xsl:when>
            </xsl:choose>
        </fo:instream-foreign-object>

        <xsl:text>&#160;</xsl:text>

        <fo:inline font-style="italic">
            <xsl:value-of select="$type" />
        </fo:inline>
        <xsl:if test="$label">
            <xsl:text> - </xsl:text>
            <xsl:value-of select="$label" />
        </xsl:if>
    </xsl:template>

    <!-- print input columns -->
    <xsl:template name="stepInput">
        <xsl:param name="data" />
        <xsl:param name="counter" />
        <xsl:param name="max" />
        <xsl:param name="total" />

        <xsl:variable name="rowspan">
            <xsl:choose>
                <xsl:when test="$max = 0">
                    <xsl:value-of select="$total" />
                </xsl:when>
                <xsl:when test="$counter = $max">
                    <xsl:value-of select="$total - $counter + 1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:table-cell>
            <xsl:call-template name="cellAttrs" />
            <xsl:attribute name="number-rows-spanned">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:if test="count($data/cpp:supplier)=0">
                <fo:block/>
            </xsl:if>
            <xsl:for-each select="$data/cpp:supplier">
                <fo:block margin="0" padding="1mm">
                    <xsl:if test="position()!=1">
                        <xsl:call-template name="cell2Attrs"></xsl:call-template>
                    </xsl:if>
                    <xsl:call-template name="cppIdLabel">
                        <xsl:with-param name="cpp_identifier" select="." />
                    </xsl:call-template>
                </fo:block>
            </xsl:for-each>
        </fo:table-cell>
        <fo:table-cell>
            <xsl:call-template name="cellAttrs" />
            <xsl:attribute name="number-rows-spanned">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:call-template name="copyContentFO">
                <xsl:with-param name="data" select="$data/cpp:inputElement" />
            </xsl:call-template>
        </fo:table-cell>

    </xsl:template>

    <!-- print output columns -->
    <xsl:template name="stepOutput">
        <xsl:param name="data" />
        <xsl:param name="counter" />
        <xsl:param name="max" />
        <xsl:param name="total" />

        <xsl:variable name="rowspan">
            <xsl:choose>
                <xsl:when test="$max = 0">
                    <xsl:value-of select="$total" />
                </xsl:when>
                <xsl:when test="$counter = $max">
                    <xsl:value-of select="$total - $counter + 1" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="1" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:table-cell>
            <xsl:call-template name="cellAttrs" />
            <xsl:attribute name="number-rows-spanned">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:call-template name="copyContentFO">
                <xsl:with-param name="data" select="$data/cpp:outputElement" />
            </xsl:call-template>
        </fo:table-cell>
        <fo:table-cell>
            <xsl:call-template name="cellAttrs" />
            <xsl:attribute name="number-rows-spanned">
                <xsl:value-of select="$rowspan" />
            </xsl:attribute>
            <xsl:if test="count($data/cpp:supplier)=0">
                <fo:block/>
            </xsl:if>
            <xsl:for-each select="$data/cpp:customer">
                <fo:block margin="0" padding="1mm">
                    <xsl:if test="position()!=1">
                        <xsl:call-template name="cell2Attrs"></xsl:call-template>
                    </xsl:if>
                    <xsl:call-template name="cppIdLabel">
                        <xsl:with-param name="cpp_identifier" select="." />
                    </xsl:call-template>
                </fo:block>
            </xsl:for-each>
        </fo:table-cell>
    </xsl:template>

    <!-- Renders textSection/tableCellContent (xhtml:p, xhtml:span, xhtml:ul, xhtml:ol) as FO blocks -->
    <xsl:template name="copyContentFO">
        <xsl:param name="data" />

        <xsl:if test="$data/@optional='true'">
            <fo:block font-style="italic">Optional:</fo:block>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="not($data/*)">
                <!-- fo:table-cell requires at least one block-level child -->
                <fo:block />
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$data/*" mode="fo-block" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Renders textSection/tableCellContent (xhtml:p, xhtml:span, xhtml:ul, xhtml:ol) as FO blocks -->
    <xsl:template match="xhtml:p | xhtml:span" mode="fo-block">
        <fo:block space-after="12pt">
            <xsl:apply-templates mode="fo-inline" />
        </fo:block>
    </xsl:template>

    <xsl:template match="xhtml:ul" mode="fo-block">
        <fo:list-block provisional-distance-between-starts="12pt" provisional-label-separation="4pt" space-after="4pt">
            <xsl:for-each select="xhtml:li">
                <fo:list-item>
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>&#8226;</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates mode="fo-inline" />
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="xhtml:ol" mode="fo-block">
        <fo:list-block provisional-distance-between-starts="16pt" provisional-label-separation="4pt" space-after="4pt">
            <xsl:for-each select="xhtml:li">
                <fo:list-item>
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>
                            <xsl:value-of select="position()" />
                            <xsl:text>.</xsl:text>
                        </fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates mode="fo-inline" />
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="text()" mode="fo-inline">
        <xsl:value-of select="." />
    </xsl:template>

    <!-- Renders a hyperlink, falling back to plain text if no href is available -->
    <xsl:template name="hyperlinkFO">
        <xsl:param name="href" />
        <xsl:param name="text" />
        <xsl:choose>
            <xsl:when test="string-length($href) &gt; 0">
                <fo:basic-link color="blue" external-destination="{$href}">
                    <xsl:value-of select="$text" />
                </fo:basic-link>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="xhtml:em" mode="fo-inline">
        <fo:inline font-style="italic">
            <xsl:apply-templates mode="fo-inline" />
        </fo:inline>
    </xsl:template>

    <xsl:template match="xhtml:strong" mode="fo-inline">
        <fo:inline font-weight="bold">
            <xsl:apply-templates mode="fo-inline" />
        </fo:inline>
    </xsl:template>

    <xsl:template match="xhtml:br" mode="fo-inline">
        <fo:block />
    </xsl:template>

    <xsl:template match="xhtml:a" mode="fo-inline">
        <xsl:call-template name="hyperlinkFO">
            <xsl:with-param name="href" select="@href" />
            <xsl:with-param name="text">
                <xsl:apply-templates mode="fo-inline" />
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="*" mode="fo-inline">
        <xsl:apply-templates mode="fo-inline" />
    </xsl:template>

    <!-- CPP label from identifier -->

    <xsl:template name="cppLabelFromId">
        <xsl:param name="cpp_identifier" />

        <xsl:choose>
            <xsl:when test="string-length($cpp_identifier)=0">
            </xsl:when>
            <xsl:when test="not($cpps//cpp[@identifier=$cpp_identifier])">
                <xsl:text>UNKNOWN CPP IDENTIFIER: </xsl:text>
                <xsl:value-of select="$cpp_identifier" />
                <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="cpp_label" select="$cpps//cpp[@identifier=$cpp_identifier]/label" />
                <xsl:value-of select="$cpp_label" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- CPP identifier and label between brackets -->

    <xsl:template name="cppIdLabel">
        <xsl:param name="cpp_identifier" />

        <xsl:for-each select="$cpp_identifier">
            <xsl:if test="position() &gt; 1">
                <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:variable name="identifier" select="." />
            <xsl:choose>
                <xsl:when test="string-length($identifier)=0">
                </xsl:when>
                <xsl:when test="not($cpps//cpp[@identifier=$identifier])">
                    <xsl:text>UNKNOWN CPP IDENTIFIER: </xsl:text>
                    <xsl:value-of select="$identifier" />
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="cpp_label">
                        <xsl:call-template name="cppLabelFromId">
                            <xsl:with-param name="cpp_identifier" select="$identifier" />
                        </xsl:call-template>
                    </xsl:variable>

                    <xsl:value-of select="$identifier" />
                    <xsl:text> &#40;</xsl:text>
                    <xsl:value-of select="$cpp_label" />
                    <xsl:text>&#41;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <!-- counts the deepest stepGroup nesting reachable from $node (0 = no nested stepGroup) -->
    <func:function name="cpp:maxGroupDepth">
        <xsl:param name="node" />
        <func:result>
            <xsl:variable name="childGroups" select="$node/cpp:stepGroup" />
            <xsl:choose>
                <xsl:when test="not($childGroups)">
                    <xsl:value-of select="0" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="deepestChild">
                        <xsl:call-template name="max-child-group-depth">
                            <xsl:with-param name="nodes" select="$childGroups" />
                            <xsl:with-param name="currentMax" select="0" />
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:value-of select="1 + number($deepestChild)" />
                </xsl:otherwise>
            </xsl:choose>
        </func:result>
    </func:function>

    <!-- helper template: keeps the largest maxGroupDepth found across a set of stepGroup nodes -->
    <xsl:template name="max-child-group-depth">
        <xsl:param name="nodes" />
        <xsl:param name="currentMax" select="0" />

        <xsl:choose>
            <xsl:when test="not($nodes)">
                <xsl:value-of select="$currentMax" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="first" select="$nodes[1]" />
                <xsl:variable name="rest" select="$nodes[position() &gt; 1]" />
                <xsl:variable name="depth" select="number(cpp:maxGroupDepth($first))" />
                <xsl:variable name="newMax">
                    <xsl:choose>
                        <xsl:when test="$depth &gt; $currentMax">
                            <xsl:value-of select="$depth" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$currentMax" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:call-template name="max-child-group-depth">
                    <xsl:with-param name="nodes" select="$rest" />
                    <xsl:with-param name="currentMax" select="$newMax" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- counts number of rows needed for a given step or stepGroup element -->
    <func:function name="cpp:stepRowCount">
        <xsl:param name="node" />
        <func:result>
            <xsl:choose>
                <xsl:when test="local-name($node) = 'step'">
                    <xsl:variable name="nInput">
                        <xsl:value-of select="count($node/cpp:input)" />
                    </xsl:variable>
                    <xsl:variable name="nOutput">
                        <xsl:value-of select="count($node/cpp:output)" />
                    </xsl:variable>
                    <xsl:variable name="nDesc">
                        <xsl:value-of select="count($node/cpp:stepDescription)" />
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$nInput &gt;= $nOutput and $nInput &gt;= $nDesc">
                            <xsl:value-of select="$nInput" />
                        </xsl:when>
                        <xsl:when test="$nOutput &gt;= $nInput and $nOutput &gt;= $nDesc">
                            <xsl:value-of select="$nOutput" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$nDesc" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="children" select="$node/*[self::cpp:step | self::cpp:stepGroup]" />

                    <xsl:variable name="total">
                        <xsl:call-template name="count-children-rows">
                            <xsl:with-param name="nodes" select="$children" />
                            <xsl:with-param name="currentTotal" select="1" />
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:value-of select="$total" />
                </xsl:otherwise>
            </xsl:choose>
        </func:result>
    </func:function>

    <!-- helper template: sums rows for a set of children -->
    <xsl:template name="count-children-rows">
        <xsl:param name="nodes" />
        <xsl:param name="currentTotal" select="0" />

        <xsl:choose>
            <xsl:when test="not($nodes)">
                <xsl:value-of select="$currentTotal" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="first" select="$nodes[1]" />
                <xsl:variable name="rest" select="$nodes[position() &gt; 1]" />

                <xsl:choose>
                    <xsl:when test="name($first) = 'cpp:step'">
                        <xsl:variable name="r">
                            <xsl:value-of select="number(cpp:stepRowCount($first))" />
                        </xsl:variable>
                        <xsl:call-template name="count-children-rows">
                            <xsl:with-param name="nodes" select="$rest" />
                            <xsl:with-param name="currentTotal" select="$currentTotal + number($r)" />
                        </xsl:call-template>
                    </xsl:when>

                    <xsl:when test="name($first) = 'cpp:stepGroup'">
                        <xsl:variable name="r">
                            <xsl:value-of select="number(cpp:stepRowCount($first))" />
                        </xsl:variable>
                        <xsl:call-template name="count-children-rows">
                            <xsl:with-param name="nodes" select="$rest" />
                            <xsl:with-param name="currentTotal" select="$currentTotal + number($r)" />
                        </xsl:call-template>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:call-template name="count-children-rows">
                            <xsl:with-param name="nodes" select="$rest" />
                            <xsl:with-param name="currentTotal" select="$currentTotal" />
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
