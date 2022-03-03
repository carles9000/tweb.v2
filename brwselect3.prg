//	{% mh_LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    LOCAL o, oWeb

	DEFINE WEB oWeb TITLE 'Browse Select' TABLES INIT


    DEFINE FORM o 

	INIT FORM o  	

		HTML o INLINE '<h3>Test BrwSelect() 3</h3><hr>'	
			
		ROWGROUP o
			BUTTON LABEL 'Test TWebBrwSelect()' GRID 6 ACTION 'Test()' OF o      			
		ENDROW o
		
		DIV o ID 'log' 
		ENDDIV o
		
		HTML o
		
			<style>
				.myid {
					color:red;
					font-weight:bold;
				}
			</style>
		
			<script>			
				
				function Test() {

					
					var headers 	= { 'id' : 'Id.' , 'name': 'Item Name', 'price': 'Precio' } 
					var aFormatter = { 'id' : 'formatId' }
					
					var rows = [{ 'id' :1, 'name' : 'Pepi', 'price' : 123  , 'dummy' : 1 } ,
								{ 'id' :2 , 'name' : 'Mari', 'price' : 345  , 'dummy' : 2 } ,
								{ 'id' :3 , 'name' : 'Runa', 'price' : 757  , 'dummy' : 3 } ,
								{ 'id' :4 , 'name' : 'Site', 'price' : 111  , 'dummy' : 4 } , 
								{ 'id' :5 , 'name' : 'Boyi', 'price' : 222  , 'dummy' : 5 } ,
								{ 'id' :6 , 'name' : 'John', 'price' : 757  , 'dummy' : 6 } ,
								{ 'id' :7 , 'name' : 'John', 'price' : 888  , 'dummy' : 7 }, 
								{ 'id' :8 , 'name' : 'John', 'price' : 777  , 'dummy' : 8 }, 
								{ 'id' :9 , 'name' : 'John', 'price' : 666  , 'dummy' : 9 }, 
								{ 'id' :10, 'name' : 'John', 'price' : 555  , 'dummy' : 6 } 
								]	

					var oOptions = new Object()
						oOptions[ 'search' ] = true
						oOptions[ 'height' ] = 400 
						//oOptions[ 'select' ] = false
						
					$('#log').html('')
					
					TWebBrwSelect( headers, rows, myfunc, '<i class="fas fa-user-friends"></i> My Customers', oOptions, aFormatter )
				}
		
				function myfunc( row ) {

					if ( row ) {													
						$('#log').html( '<b>Name: </b>' + row.name + '<br>' + 
										'<b>Price: </b>' + row.price + '<br>' +
										'<b>Dummy: </b>' + row.dummy )
					}						
				}
				
				function formatId( value ) {
			
					if ( value > 2 && value < 8 )
						return '<span class="myid">' + value + '</span>'
					else
						return value 				
				}
			
			</script>			
		
		ENDTEXT
			
		
    END FORM o	
	
retu nil