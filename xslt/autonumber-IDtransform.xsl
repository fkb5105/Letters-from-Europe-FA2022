<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <!--ebb: This is an identity transformation stylesheet just designed to 
    correct the values of @n attributes numbering the <l> elements in your collection. -->
  
  <xsl:variable name="lettersColl" as="document-node()+" select="collection('../XML-RNG/?select=*.xml')[base-uri()[contains(., 'page')]]"/>
  <!--ebb: The variable establishes the collection of XML files as the ones in the XML-RNG directory whose filenames contain the word page, 
    as in page11.xml -->
 
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!--ebb: We have to process the collection files one at a time. We'll do that with this next template on any single document node and set up an 
    <xsl:for-each> to process each file in the collection one at a time.
    -->
  <xsl:template match="/">
    <xsl:for-each select="$lettersColl">
   <!-- ebb: The following variable captures the filename of the original source XML file currently being processed: -->
      <xsl:variable name="filename" as="xs:string" select="base-uri() ! tokenize(., '/')[last()]"/>
      
      <xsl:result-document method="xml" indent="yes" href="../xml-rng-revised/{$filename}">
        <!--ebb: I'm creating a new directory for the output before copying it back into the original folder. 
      Use <xsl:result-document> to set up the output and where it gets saved:
      -->
        <xsl:apply-templates/>

      </xsl:result-document>

    </xsl:for-each>
  </xsl:template>
      
    
    <xsl:template match="l">
     
          <l n="{count(preceding::l) + 1}"/>  
      <!--ebb: No need to use xsl:apply-templates since l is a self-closing element (nothing to process from here).  -->
        
    </xsl:template>
    
    
</xsl:stylesheet>