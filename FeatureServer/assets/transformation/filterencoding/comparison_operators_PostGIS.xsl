<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:regexp="http://exslt.org/regular-expressions" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
    <xsl:param name="version" />
	
	<xsl:template match="/">
		<Statements>
			<xsl:apply-templates>
				<xsl:with-param name="version" select="$version" />
            </xsl:apply-templates>
		</Statements>
	</xsl:template>
	
	<xsl:template match="*[local-name(.)='PropertyIsEqualTo']">
		<xsl:param name="version" />

		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" = '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" = '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.)='PropertyIsNotEqualTo']">
		<xsl:param name="version" />
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" != '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" != '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.)='PropertyIsLessThan']">
		<xsl:param name="version" />
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" &lt; '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" &lt; '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.)='PropertyIsGreaterThan']">
		<xsl:param name="version" />
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" &gt; '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" &gt; '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.)='PropertyIsLessThanOrEqualTo']">
		<xsl:param name="version" />
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" &lt;= '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" &lt;= '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.)='PropertyIsGreaterThanOrEqualTo']">
		<xsl:param name="version" />
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" &gt;= '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" &gt;= '<xsl:value-of select="//*[local-name() = 'Literal']" />'</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.)='PropertyIsLike']">
		<xsl:param name="version" />
        
		<xsl:variable name="literal" select="//*[local-name() = 'Literal']"/>
		<xsl:variable name="wildcard" select="@wildCard"/>
		<xsl:variable name="singlechar" select="@singleChar"/>
        
        <xsl:variable name="like1" select="regexp:replace(string($literal), string($wildcard), 'g', '%%')"/>
        <xsl:variable name="like2" select="regexp:replace(string($like1), string($singlechar), 'g', '_')"/>
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" LIKE '<xsl:value-of select="$like2" />'</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" LIKE '<xsl:value-of select="$like2" />'</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.)='PropertyIsBetween']">
		<xsl:param name="version" />
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" BETWEEN '<xsl:value-of select="//*[local-name() = 'LowerBoundary']" />' AND '<xsl:value-of select="//*[local-name() = 'UpperBoundary']" />'</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" BETWEEN '<xsl:value-of select="//*[local-name() = 'LowerBoundary']" />' AND '<xsl:value-of select="//*[local-name() = 'UpperBoundary']" />'</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>
	
	<xsl:template match="*[local-name(.)='PropertyIsNil']">
		<xsl:param name="version" />
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" = ''</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" = ''</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name(.)='PropertyIsNull']">
		<xsl:param name="version" />
        
		<xsl:choose>
			<xsl:when test="$version = '2.0.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'ValueReference']" />" = NULL</Statement>
            </xsl:when>
            <xsl:when test="$version = '1.1.0'">
                <Statement>"<xsl:value-of select="//*[local-name() = 'PropertyName']" />" = NULL</Statement>
            </xsl:when>
        </xsl:choose>
	</xsl:template>

</xsl:stylesheet>