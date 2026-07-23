<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cpp="https://eden-fidelis.eu/cpp/cpp/"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    exclude-result-prefixes="fn">
    <xsl:output method="text" encoding="utf-8" indent="no" omit-xml-declaration="yes" />

    <xsl:variable name="classifications" select="document('classifications.xml')" />

    <xsl:template match="/cpps">
        <xsl:value-of select="'['" />
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates select="cpp" />
        <xsl:value-of select="']'" />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

    <xsl:template match="/cpps/cpp">
        <xsl:value-of select="'  {'" />
        <xsl:text>&#xa;</xsl:text>
        <xsl:variable name="identifier" select="@identifier" />
        <xsl:variable name="lowerCaseIdentifier" select="translate($identifier, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
        <xsl:variable name="label" select="./label" />
        <xsl:call-template name="parse-doc">
            <xsl:with-param name="fname" select="concat('./', $identifier, '/', $lowerCaseIdentifier, '.xml')" />
            <xsl:with-param name="identifier" select="$identifier" />
            <xsl:with-param name="label" select="$label" />
        </xsl:call-template>
        <xsl:value-of select="'  }'" />
        <xsl:if test="position() != last()">
            <xsl:value-of select="','" />
        </xsl:if>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

    <xsl:template name="parse-doc">
        <xsl:param name="fname"/>
        <xsl:param name="identifier"/>
        <xsl:param name="label"/>
        <xsl:apply-templates select="document($fname)" mode="parse-cpp-doc">
            <xsl:with-param name="identifier" select="$identifier" />
            <xsl:with-param name="label" select="$label" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="cpp:cpp" mode="parse-cpp-doc">
        <xsl:param name="identifier"/>
        <xsl:param name="label"/>

        <xsl:value-of select="concat('    &quot;id&quot;: &quot;', $identifier, '&quot;,')" />
        <xsl:text>&#xa;</xsl:text>

        <xsl:value-of select="concat('    &quot;label&quot;: &quot;', $identifier, '&quot;,')" />
        <xsl:text>&#xa;</xsl:text>

        <xsl:value-of select="concat('    &quot;sub&quot;: &quot;', $label, '&quot;,')" />
        <xsl:text>&#xa;</xsl:text>

        <xsl:value-of select="'    &quot;logical_cluster&quot;: &quot;'" />
        <xsl:value-of select="$classifications//classification[@cluster='logical' and ./label/text()=current()/cpp:classification/cpp:logicalClassification/text()]/@identifier" />
        <xsl:value-of select="'&quot;,'" />
        <xsl:text>&#xa;</xsl:text>

        <xsl:value-of select="'    &quot;oais_cluster&quot;: &quot;'" />
        <xsl:value-of select="$classifications//classification[@cluster='oais' and ./label/text()=current()/cpp:classification/cpp:oaisClassification/text()]/@identifier" />
        <xsl:value-of select="'&quot;'" />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
