//	{% mh_LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}

function main()

	local hParam 	:= AP_PostPairs()
	local cUrl 		:= mh_GetUri() 
	
	if !empty( hParam[ 'user' ] ) .and. hParam[ 'psw' ] == '1234' 
	
		mh_SessionInit()
		
		mh_Session( 'user', lower( hParam[ 'user' ] ) )			
		mh_Session( 'in', time() )			
		
		cUrl += 'app_menu.prg'
	
	else 
	
		cUrl += 'app_login.prg'
	
	endif 
	
	mh_Redirect( cUrl )	

retu nil