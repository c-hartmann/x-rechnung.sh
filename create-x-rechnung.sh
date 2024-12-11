#!/bin/bash

export LANG=C

# seller and other mostly ixed data go into a rc file
x_rechnung_rc="$HOME/.config/x-rechnung.d/x-rechnung.rc"

# find stylesheets and samples by a profile name
typeset -l profile=${1:-'MINIMUM_Rechnung'} # e.g. 'minimum_rechnung'

# always / often reused customer fixed data might go into a rc file
customer_key="$2:-'sample_customer'"
customer_rc="$HOME/.config/x-rechnung.d/${customer_key}.rc"


# TODO my names with or without underscores?
# TODO use a csv for multiple products?

# into +rc...
vat_percentage=19
SellerTradeParty_Name="Christian Hartmann"
PostalTradeAddress_CountryID='DE' # default in Beispiel, but used
InvoiceCurrencyCode='EUR' # not used in stylesheet (coz default)


# from command line or customer rc
BuyerTradeParty_Name="seacamper"
TaxBasisTotalAmount="11.99"

# calculated if not given on command line
TaxTotalAmount="${TaxTotalAmount:-$(echo "scale=2; ${TaxBasisTotalAmount} * ${vat_percentage} / 100" | bc)}"
# GrandTotalAmount=${GrandTotalAmount:-$(echo "scale=2; ${TaxBasisTotalAmount} * ( ${vat_percentage} + 100 ) / 100" | bc)}
GrandTotalAmount="${GrandTotalAmount:-$(echo "scale=2; ${TaxBasisTotalAmount} + ${TaxTotalAmount}" | bc)}"
DuePayableAmount="${GrandTotalAmount}" # TODO whats the diff to GrandTotalAmount?



# check stylesheet
test -f "$profile.xslt" || error_exit "stylesheet not found for profile: $profile" 1

# template for string params to add
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
