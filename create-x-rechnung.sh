#!/bin/bash

export LANG=C

typeset -l profile=${1:-'MINIMUM_Rechnung'} # e.g. 'minimum_rechnung'

# TODO with or without underscores?

# into +rc...
vat_percentage=19
vat_percentage_multiplier=119
SellerTradeParty_Name="Christian Hartmann"
PostalTradeAddress_CountryID="DEUTSCHLAND" # is 'DE' only! ;)
InvoiceCurrencyCode='EUR' # not used in stylesheet (as default)


# from command line
BuyerTradeParty_Name="seacamper"
TaxBasisTotalAmount="11.99"

# calculated if not given on command line
TaxTotalAmount="${GrandTotalAmount:-$(echo "scale=2; ${TaxBasisTotalAmount} * ${vat_percentage} / 100" | bc)}"
GrandTotalAmount=${GrandTotalAmount:-$(echo "scale=2; ${TaxBasisTotalAmount} * ( ${vat_percentage} + 100 ) / 100" | bc)}
DuePayableAmount="${GrandTotalAmount}"


# echo $GrandTotalAmount; exit

# xsltproc "$xslt" "$template"

# check stylesheet
test -f "$profile.xslt" || error_exit "stylesheet not found for profile: $profile" 1

# 	--stringparam '' "$" \

xsltproc \
	\
	--stringparam 'SellerTradeParty_Name'			"$SellerTradeParty_Name" \
 	--stringparam 'PostalTradeAddress_CountryID' 	"$PostalTradeAddress_CountryID" \
	--stringparam 'BuyerTradeParty_Name'			"$BuyerTradeParty_Name" \
	--stringparam 'TaxBasisTotalAmount' "$TaxBasisTotalAmount" \
	--stringparam 'TaxTotalAmount' "$TaxTotalAmount" \
	--stringparam 'GrandTotalAmount' "$GrandTotalAmount" \
	--stringparam 'DuePayableAmount' "$DuePayableAmount" \
	\
"$profile.xslt" "Beispiele/0. MINIMUM/MINIMUM_Rechnung/factur-x.xml"
