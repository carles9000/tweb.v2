//	{% mh_LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}


function Main()

	local cHtml := ''

	//	Autentication ----------

		if ! mh_SessionActive()
		
			mh_Redirect( mh_GetUri() + 'app_login.prg')
			
			retu nil	
			
		endif 
		
		mh_SessionInit()			
	//	------------------------
		
		
	DEFINE WEB oWeb TITLE 'App' INIT

    DEFINE FORM o ACTION 'app_srv_login'

	INIT FORM o  

		HTML o INLINE '<h3>Dummy Screen</h3><hr>'
		
		
	//	Podemos recuperar variables que tenemos almacenadas en la session	
 
		ROW o
			SAY LABEL 'User: ' + mh_Session( 'user' ) GRID 5 OF o
			SAY LABEL 'Entrada a las ' + mh_Session( 'in' ) GRID 7 OF o
		ENDROW o 
		
    END FORM o			
	
retu nil 