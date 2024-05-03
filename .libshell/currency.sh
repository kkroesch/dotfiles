euimport () {
	# Convert DE shopping prices from € to equivalent swiss prices in SFr.
	eu_brutto=$1 
	chf_kurs=$(http GET https://api.fixer.io/latest\?symbols\=CHF,USD | jq .rates.CHF) 
	de_mwst=1.19 
	ch_mwst=1.08 
	echo "${eu_brutto} / ${de_mwst} * ${chf_kurs} * ${ch_mwst}" | bc
}
