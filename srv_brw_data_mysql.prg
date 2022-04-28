//	{% mh_LoadHrb( 'lib/tweb/tweb.hrb' ) %}					//	Loading TWeb 
//	{% mh_LoadHRB( 'lib/wdo/wdo.hrb' ) %}						//	Loading WDO lib
//	{% HB_SetEnv( 'WDO_PATH_MYSQL', "c:/xampp/htdocs/" ) %}	//	Usuarios Xampp



function main()

	local hParam := GetMsgServer()	

	do case
	
		case hParam[ 'action' ] == 'load' 
		
			LoadData()
			
		case hParam[ 'action' ] == 'save'

			SaveData( hParam[ 'data' ] )
			
	endcase
	
retu NIL


function LoadData() 

	local o 		:= WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )		
	local aRows 	:= {}
	local cError 	:= ''	
		
	IF ! o:lConnect
	
		cError :=  o:cError

	ELSE
		
		IF !empty( hRes := o:Query( 'select * from customer limit 100' ) )
		
			aRows := o:FetchAll( hRes, .t. )						
			
			o:Free_Result( hRes )
			
		ELSE 
		
			cError := o:cError
		
		ENDIF	
		
	ENDIF 
	
	o:mysql_Close()
	
	//	Response...
	
		AP_SetContentType( "application/json" )
		
		hResponse := { 'success' => empty(cError), 'rows' => aRows, 'error' => cError }
		
		?? hb_jsonEncode( hResponse ) 

retu nil 

function SaveData( aData ) 

	local o 		:= WDO():Rdbms( 'MYSQL', "localhost", "harbour", "hb1234", "dbHarbour", 3306 )	
	local cSql 	:= '' 
	local cError 	:= '' 
	local hRow
	local nUpdated := 0
	
	//	This is the main concept. You can optimzed it of 1000 different way...
	
	//	Process data...	
	
		for n := 1 to len(aData)

			hRow := aData[n][ 'row' ]
			
			cMarried := mh_valtochar( hRow[ 'married'] )
			
			if cMarried == '.T.'
				hRow[ 'married'] := '1'
			elseif cMarried == '.F.'
				hRow[ 'married'] := '0'
			endif			
			
			cSql := ''			

			do case
				case aData[n][ 'action' ] == 'A'		//	Add, new record								
					
					cSql += "INSERT INTO `customer` (`id`, `first`, `last`, `street`, `city`, `state`, `married`, `age`) " 
					cSql += " VALUES ( "
					cSql += " NULL, " 
					cSql += " '" + hRow[ 'first'] + "', "
					cSql += " '" + hRow[ 'last'] + "', "
					cSql += " '" + hRow[ 'street'] + "', "
					cSql += " '" + hRow[ 'city'] + "', "
					cSql += " '" + hRow[ 'state'] + "', "
					cSql += " '" + hRow[ 'married'] + "', "
					cSql += " '" + hRow[ 'age'] + "' "					
					cSql += " ); "
					
				case aData[n][ 'action' ] == 'U'		//	Update
				
					//	UPDATE `customer` SET `first` = 'Condorit' WHERE `customer`.`id` = 2;
					
					cSql += "UPDATE `customer` SET "
					cSql += "first = '" + hRow[ 'first']  + "', "
					cSql += "last  = '" + hRow[ 'last']  + "', "
					cSql += "street = '" + hRow[ 'street']  + "', "
					cSql += "city   = '" + hRow[ 'city']  + "', "
					cSql += "state  = '" + hRow[ 'state']  + "', "
					cSql += "married = '" + hRow[ 'married']  + "', "
					cSql += "age    = '" + hRow[ 'age']  + "' "
					cSql += "WHERE `customer`.`id` = '" + aData[n]['id'] + "' ; " 															
					
				
				case aData[n][ 'action' ] == 'D'		//	Delete				
					
					cSql += "DELETE FROM `customer` WHERE `customer`.`id` = '" + aData[n]['id']  + "' ; "
					
					
			endcase 

			
			o:Query( cSql )
			
			if o:Row_Count() > 0
				nUpdated++ 
			else
				cError += o:mysql_error() + '<br>'
			endif 			
		
		next 	

		o:mysql_Close()		
	
	//	Response...	

		AP_SetContentType( "application/json" )			

		hResponse := { 'debug_data' => aData, 'updated' => nUpdated, 'error' => cError }
		
		?? hb_jsonEncode( hResponse ) 	

retu nil
