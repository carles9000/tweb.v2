//	{% mh_LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'App' INIT

    DEFINE FORM o ACTION 'app_srv_login'

	INIT FORM o  

		HTML o INLINE '<h3>Autenticate</h3><hr>'
	   
		ROWGROUP o	HALIGN 'center'		
			GET ID 'user' 	VALUE 'demo' GRID 4 LABEL 'User'  	OF o
			GET ID 'psw'	VALUE '1234' GRID 4 LABEL 'Password' TYPE 'password'	OF o			
		ENDROW o		
		
		ROWGROUP o HALIGN 'center'	
			BUTTON LABEL 'Enviar' ALIGN 'center' GRID 8 SUBMIT OF o      
		ENDROW o					
		
    END FORM o	
	
retu nil