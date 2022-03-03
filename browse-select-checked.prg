//	{% mh_LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	
	local aChecked := { 1,2,4 }

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o
		
		HTML o INLINE '<h3>Test Browse - multiselect - Checked</h3><hr>'
		
	INIT FORM o 

		ROWGROUP o
		
			COL o GRID 12
			
				//	3 Options
				//	SELECT 				= Select only one
				//	MULTISELECT 			= MultiSelect Ctrl+Click or Shift+Click
				//	SELECT MULTISELECT 	= Multiselect toglee

				DEFINE BROWSE oBrw ID 'ringo' SELECT MULTISELECT HEIGHT 300   CLICKSELECT OF o	//	SELECT
				
					oBrw:cUniqueId := 'id'

					ADD oCol TO oBrw ID 'id' 		HEADER 'Id' 	ALIGN 'center'
					ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
					ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
					ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

				INIT BROWSE oBrw DATA aRows CHECKED aChecked 
		
			ENDCOL o	
			
		ENDROW o
		
		ROWGROUP o
			BUTTON LABEL 'Get' ACTION 'Get()' OF o
			BUTTON LABEL 'Set' ACTION 'Set()' OF o
		ENDROW o
		

		HTML o 
		
			<script>				
			
				var oBrw 	= new TWebBrowse( 'ringo' )
				
				function Get() {				
			
					var aSelect = oBrw.Select()
										
					MsgInfo( 'Rows Selected: ' + aSelect.length, 'View console...' )
					console.log( 'Select', aSelect )				
				}	

				function Set() {
				
					oBrw.UnCheckAll()		
					oBrw.SetChecked( [ 2, 3, 7, 9 ], 'id')			
				}					
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 
