//	{% mh_LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oCol, oBrw

	DEFINE WEB oWeb TITLE 'CRUD Browse - Edit Dbf Lite' TABLES INIT
	
	DEFINE FORM o
	
		//o:lDessign := .t.

		HTML o INLINE '<h3>CRUD Browse (MySql)</h3><hr>'
		
		HTML o
		
			<style>
				.mybtnbar {
					border-radius:0px;
				}										
			</style>
		
		ENDTEXT 
		
		
	INIT FORM o 

		ROWGROUP o		
			BUTTON LABEL ' Load Data' ICON '<i class="far fa-save"></i>' ACTION 'Load()' CLASS 'btn-secondary mybtnbar' GRID 12 OF o		
		ENDROW o

		DIV o ID 'bar' CLASS 'btn-group'
			BUTTON LABEL ' New' 	ACTION 'Add()' 		CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Edit' 	ACTION 'Edit()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Delete' 	ACTION 'Delete()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Save' 	ACTION 'Save()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
			BUTTON LABEL ' Test' 	ACTION 'Test()' 	CLASS 'btn-secondary mybtnbar' GRID 0 OF o
		ENDDIV o 

		DEFINE BROWSE oBrw ID 'ringo' MULTISELECT CLICKSELECT HEIGHT 400 ;
			EDIT UNIQUEID 'id';
			TOOLBAR "bar" ;
			SEARCH TOOLS EXPORT PRINT  ;
			OF o	

			//oBrw:cLocale := 'es-ES'
			oBrw:cLocale := 'EN'

			ADD oCol TO oBrw ID 'id'			HEADER 'Id' 		EDIT TYPE 'V' ALIGN 'center' SORT WIDTH 80 
			ADD oCol TO oBrw ID 'first'	    HEADER 'First' 	EDIT SORT
			ADD oCol TO oBrw ID 'last'		HEADER 'Last' 		EDIT SORT
			ADD oCol TO oBrw ID 'street'		HEADER 'Street'		EDIT TYPE 'V'		// VIEW
			ADD oCol TO oBrw ID 'married'		HEADER 'Married'	EDIT TYPE "L"
			ADD oCol TO oBrw ID 'age'			HEADER 'Age'		EDIT TYPE 'N'				

		INIT BROWSE oBrw 
		
		HTML o 
		
			<script>

				var oBrw = new TWebBrowse( 'ringo' )				
				
				//	Load data records from server...	-------------------------
					
					function Load() {						
						
						oBrw.Loading( true )					

						var oParam = new Object()
							oParam[ 'action' ] = 'load'
						
						MsgServer( 'srv_brw_data_mysql.prg', oParam, Post_Load )
					}
					
					function Post_Load( dat ){					
	
						oBrw.Loading( false )				

						oBrw.SetData( dat.rows ) 						
					}
				
				//	Save data records to server... -----------------------------

					function Save() 	{ 								
					
						var oParam = new Object()
							oParam[ 'action' ] = 'save'
							oParam[ 'data'   ] = oBrw.GetDataChanges()							
							
							if ( oParam[ 'data' ].length == 0 )
								return null 
	
						MsgServer( 'srv_brw_data_mysql.prg', oParam, Post_Save )				
					}				
					
					function Post_Save( dat ) {
		
						var cTxt = '<b>Rows updated:</b> ' + dat.updated + '<br>'						
						
						if ( dat.error.length > 0 ) {
					
							cTxt += '<b><u>Error</u></b><br>'
							cTxt += dat.errortxt 				

						} else {
							
							oBrw.ResetChanges( dat.rows_updated )						
						}
						
						MsgInfo( cTxt )					
					}
				
				//	Default public method ------------------------------------
				
					function Edit() 	{ oBrw.Edit() }	
					function Add()  	{ oBrw.AddRow() }	
					function Delete() { oBrw.DeleteRow() }
					function Reset() 	{ oBrw.Reset() }
					
					function Test() 	{ oBrw.Test() }
		
			</script>
		
		ENDTEXT
	
	END FORM o	
	
retu nil