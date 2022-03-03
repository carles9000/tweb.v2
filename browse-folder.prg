//	{% mh_LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
	local aRows := LoadData()	

	DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT
	
	DEFINE FORM o ID 'demo'	
		//o:lFluid := .t.
		
		HTML o INLINE '<h3>View Customer</h3><small>Smartphone version</small><hr>'
		
	INIT FORM o 
	
		ROWGROUP o
	
			FOLDER oFld ID 'fld' TABS 'list', 'user' PROMPT '<i class="fas fa-th-list"></i> List', '<i class="far fa-user"></i> User' ADJUST OF o		
			
				DEFINE TAB 'list' OF oFld
				
					DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 ONCHANGE 'SelData' OF oFld

						ADD oCol TO oBrw ID 'first' 	HEADER 'First' 	ALIGN 'right'
						ADD oCol TO oBrw ID 'last'		HEADER 'Last'  	SORT			
						ADD oCol TO oBrw ID 'age'		HEADER 'Age' 	WIDTH 70 

					INIT BROWSE oBrw DATA aRows		
					
				ENDTAB oFld
				
				DEFINE TAB 'user' OF oFld
				
				    HTML oFld
						<div class="alert alert-dark form_title" role="alert">
							<h5 id="name" style="margin:0px;"></h5>
						</div>
					ENDTEXT
				
					ROWGROUP oFld
						GET ID 'city' VALUE '' GRID 9 LABEL 'City' OF oFld
						GET ID 'st'   VALUE '' GRID 3 LABEL 'State' OF oFld
					ENDROW oFld
					
					ROWGROUP oFld
						GET ID 'zip'  		VALUE '' GRID 6 LABEL 'Zip'   OF oFld
						GET ID 'hiredate' 	VALUE '' GRID 6 LABEL 'Hiredate' OF oFld
					ENDROW oFld
					
					ROWGROUP oFld
						CHECKBOX ID 'married' LABEL 'Married' GRID 6 OF oFld
					ENDROW oFld
						
					ROWGROUP oFld
						GET ID 'notes' VALUE '' GRID 12 LABEL 'Notes' OF oFld
					ENDROW oFld
				
				ENDTAB oFld
			
			ENDFOLDER oFld
		
		ENDROW o 

		HTML o 
		
			<script>				
				
				function SelData( e, row ) {
					$('#city').val( row.city )
					$('#st').val( row.state )
					$('#zip').val( row.zip )
					$('#hiredate').val( row.hiredate )
					$('#married').prop('checked', row.married );
					$('#notes').val( row.notes )
					$('#married').prop('checked', row.married );

					$('#name').html( '<b><i>' + row.first + ' ' + row.last + '</i></b>' );
					
					$('.nav-tabs a[href="#user"]').tab('show');
				}					
				
			</script>
			
		ENDTEXT

	END FORM o	
	
retu nil

{% LoadFile( 'loaddata.prg' ) %} 




