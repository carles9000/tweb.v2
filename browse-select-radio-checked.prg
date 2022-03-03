//	{% mh_LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	
	local aChecked := { 4 }

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o
		
		HTML o INLINE '<h3>Test Browse - radio - Checked</h3><hr>'
		
	INIT FORM o 
	
		ROW o 
		
			COL o GRID 6	

				ROWGROUP o
				
					COL o GRID 12

						DEFINE BROWSE oBrw ID 'brw_A' HEIGHT 300 SELECT RADIO CLICKSELECT OF o	

							ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
							ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
							ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

						INIT BROWSE oBrw DATA aRows	
				
					ENDCOL o	
					
				ENDROW o
				
				ROWGROUP o
					BUTTON LABEL 'Get' ACTION 'Get_A()' OF o
					BUTTON LABEL 'Set' ACTION 'Set_A()' OF o
				ENDROW o
			
			ENDCOL o
			
			COL o GRID 6	

				ROWGROUP o
				
					COL o GRID 12

						DEFINE BROWSE oBrw ID 'brw_B' HEIGHT 300 SELECT RADIO CLICKSELECT OF o	

							ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'

						INIT BROWSE oBrw DATA aRows	
				
					ENDCOL o	
					
				ENDROW o
				
				ROWGROUP o
					BUTTON LABEL 'Get' ACTION 'Get_B()' OF o
					BUTTON LABEL 'Set' ACTION 'Set_B()' OF o
				ENDROW o
			
			ENDCOL o
		ENDROW o 		
		

		HTML o 
		
			<script>				
			
				var oBrw_A 	= new TWebBrowse( 'brw_A' )
				var oBrw_B 	= new TWebBrowse( 'brw_B' )
				
				function Get_A() {				
			
					var aSelect = oBrw_A.Select()
										
					MsgInfo( 'Rows Selected: ' + aSelect.length, 'View console...' )
					console.log( 'Select', aSelect )				
				}	

				function Set_A() {
				
					oBrw_A.UnCheckAll()		
					oBrw_A.SetChecked( [ 2 ], 'id')			
				}	

				function Get_B() {				
			
					var aSelect = oBrw_B.Select()
										
					MsgInfo( 'Rows Selected: ' + aSelect.length, 'View console...' )
					console.log( 'Select', aSelect )				
				}	

				function Set_B() {
				
					oBrw_B.UnCheckAll()		
					oBrw_B.SetChecked( [ 7 ], 'id')			
				}				
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 
