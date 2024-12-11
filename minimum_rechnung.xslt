<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:rsm="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100"
	xmlns:ram="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100"
	xmlns:udt="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100"
	id="minimum_rechnung"
>

<!--	<xsl:output
		method="xml" indent="yes"
		doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
		doctype-public="-//W3C//DTD XHTML 1.1//EN"
		encoding="UTF-8"
	/>-->

	<xsl:output
		method="xml" indent="yes"
		encoding="UTF-8"
	/>

	<!-- IMPORTANT: params shall comply with those given in calling script -->
	<xsl:param name="SellerTradeParty_Name" select="'NO_VALUE'"/>
	<xsl:param name="PostalTradeAddress_CountryID" select="'NO_VALUE'"/>
	<xsl:param name="BuyerTradeParty_Name" select="'NO_VALUE'"/>
	<xsl:param name="TaxBasisTotalAmount" select="'NO_VALUE'"/>
	<xsl:param name="TaxTotalAmount" select="'NO_VALUE'"/>
	<xsl:param name="GrandTotalAmount" select="'NO_VALUE'"/>
	<xsl:param name="DuePayableAmount" select="'NO_VALUE'"/>

	<xsl:template match="/rsm:CrossIndustryInvoice">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

    <xsl:template match="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:Name">
		<xsl:copy>
			<xsl:value-of select="$SellerTradeParty_Name"/>
		</xsl:copy>
	</xsl:template>

    <xsl:template match="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:SellerTradeParty/ram:PostalTradeAddress/ram:CountryID">
		<xsl:copy>
			<xsl:value-of select="$PostalTradeAddress_CountryID"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="rsm:SupplyChainTradeTransaction/ram:ApplicableHeaderTradeAgreement/ram:BuyerTradeParty/ram:Name">
		<xsl:copy>
			<xsl:value-of select="$BuyerTradeParty_Name"/>
		</xsl:copy>
	</xsl:template>

    <xsl:template match="ram:TaxBasisTotalAmount">
		<xsl:copy>
			<xsl:value-of select="$TaxBasisTotalAmount"/>
		</xsl:copy>
	</xsl:template>

    <xsl:template match="ram:TaxTotalAmount">
		<xsl:copy>
			<xsl:value-of select="$TaxTotalAmount"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ram:GrandTotalAmount">
		<xsl:copy>
			<xsl:value-of select="$GrandTotalAmount"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ram:DuePayableAmount">
		<xsl:copy>
			<xsl:value-of select="$DuePayableAmount"/>
		</xsl:copy>
	</xsl:template>

<!-- template
	<xsl:template match="ram:">
		<xsl:copy>
			<xsl:value-of select="$"/>
		</xsl:copy>
	</xsl:template>
-->

	<xsl:template match="*">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
