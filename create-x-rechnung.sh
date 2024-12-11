#!/bin/bash

export LANG=C

typeset -l profile=${1:-'MINIMUM_Rechnung'} # e.g. 'minimum_rechnung'

# TODO with or without underscores?

# into +rc...
vat_percentage=19
SellerTradeParty_Name="Christian Hartmann"
PostalTradeAddress_CountryID="DE" # default in Beispiel, but used
InvoiceCurrencyCode='EUR' # not used in stylesheet (coz default)


# from command line
BuyerTradeParty_Name="seacamper"
TaxBasisTotalAmount="11.99"

# calculated if not given on command line
TaxTotalAmount="${GrandTotalAmount:-$(echo "scale=2; ${TaxBasisTotalAmount} * ${vat_percentage} / 100" | bc)}"
GrandTotalAmount=${GrandTotalAmount:-$(echo "scale=2; ${TaxBasisTotalAmount} * ( ${vat_percentage} + 100 ) / 100" | bc)}
DuePayableAmount="${GrandTotalAmount}"



# check stylesheet
test -f "$profile.xslt" || error_exit "stylesheet not found for profile: $profile" 1

# template for string params
# 	--stringparam ''       "$" \

xsltproc \
	\
	--stringparam 'SellerTradeParty_Name'           "$SellerTradeParty_Name" \
	--stringparam 'PostalTradeAddress_CountryID'    "$PostalTradeAddress_CountryID" \
	--stringparam 'BuyerTradeParty_Name'            "$BuyerTradeParty_Name" \
	--stringparam 'TaxBasisTotalAmount'             "$TaxBasisTotalAmount" \
	--stringparam 'TaxTotalAmount'                  "$TaxTotalAmount" \
	--stringparam 'GrandTotalAmount'                "$GrandTotalAmount" \
	--stringparam 'DuePayableAmount'                "$DuePayableAmount" \
	\
"$profile.xslt" "Beispiele/0. MINIMUM/MINIMUM_Rechnung/factur-x.xml"
