//	{% mh_LoadHrb( 'lib/tweb/tweb.hrb' ) %}

function main()

	local uValue := GetMsgServer()
	
	?? 'Type: ' + valtype( uValue )
	? mh_valtochar(uValue)
	
retu nil