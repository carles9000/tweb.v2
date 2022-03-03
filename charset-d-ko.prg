//	{% mh_LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

#define PATH_DATA 		HB_GetEnv( "PRGPATH" ) + '/data/'

function main()

    LOCAL o, oWeb
	
	//	Remember, by default charset = ISO-8859-1

	DEFINE WEB oWeb TITLE 'Test CharSet - UTF8 / Dbf' INIT
	
	DEFINE FORM o 
		
	INIT FORM o  	
	
		HTML o PARAMS oWeb 
			
			<h3>
				Demo: Uso de dbf </br>
				Source Format: UTF-8 w/o BOM </br>
				Charset: <$ oWeb:cCharset $>
			</h3><hr>	
			
		ENDTEXT				
	
	END FORM o
	
	//	This dbf is coded with utf-8
	
	USE ( PATH_DATA + 'utf8.dbf' ) SHARED NEW VIA 'DBFCDX'
	
	for nI := 1 TO 5
	
		? FIELD->english  + ' ' + FIELD->hindi + ' ' + FIELD->telugu
		
		dbskip() 
	next					
	
retu nil