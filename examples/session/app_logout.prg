//	{% mh_LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}

function main()

	if ! mh_SessionActive()
	
		mh_Redirect( mh_GetUri() + 'app.prg')
		
		retu nil	
		
	endif 

	mh_SessionEnd()
	
	mh_Redirect( mh_GetUri() + 'app.prg')		

retu nil