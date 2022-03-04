//	{% mh_LoadHrb( '../../lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude( '../../lib/tweb/' ) %}


function Main()

	local cHtml := ''
	local x := ''

	//	Autentication ----------

		if ! mh_SessionActive()
		
			mh_Redirect( mh_GetUri() + 'app_login.prg')
			
			retu nil	
			
		endif 
		
		mh_SessionInit()			
	//	------------------------	

	DEFINE WEB oWeb TITLE 'App' INIT

    DEFINE FORM o

	INIT FORM o  		
		
		HTML o 
		
			<h3>Menu principal</h3><hr>			

			<ul>
			  <li><a href="app_consulta.prg">Consulta</a></li>
			  <li><a href="app_dummy.prg">Dummy...</a></li>
			  <li><a href="app_logout.prg">Logout</a></li>
			</ul>

			<hr>
		
		ENDTEXT		
		
		
	//	Podemos recuperar variables que tenemos almacenadas en la session	
 
		ROW o
			SAY LABEL 'User: ' + mh_Session( 'user' ) GRID 5 OF o
			SAY LABEL 'Entrada a las ' + mh_Session( 'in' ) GRID 7 OF o
		ENDROW o 

	END FORM o		
		
retu nil 