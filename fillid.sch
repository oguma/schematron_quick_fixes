<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:uuid="java:java.util.UUID">
    
    <!-- https://www.oxygenxml.com/demo/Schematron_Quick_Fixes.html -->
    <!-- To fix the “cannot find 0-augment function static UUID” error in Oxygen XML Editor, copy the "fillid.sch" file into "~/Oxygen XML Editor 22/frameworks/". -->
    
    <xsl:template name="uuid">
        <xsl:value-of select="uuid:randomUUID()"/>
    </xsl:template>
    
    <sch:pattern>
        <sch:rule context="*/@id">
            <sch:assert test="not(.='')" sqf:fix="fillid" role="warn">@id must be filled.</sch:assert>
            <sqf:fix id="fillid">
                <sqf:description>
                    <sqf:title>Fill the @id</sqf:title>
                    <sqf:p>element name + uuid first 8 characters</sqf:p>
                </sqf:description>
                <sqf:replace node-type="attribute" target="id">
                    <xsl:variable name="uuid">
                        <xsl:call-template name="uuid"/>
                    </xsl:variable>
                    <xsl:value-of select="concat(../local-name(), '-', substring-before($uuid, '-'))"/>
                </sqf:replace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
