//	-------------------------------------------------------------

CLASS TWebSelect FROM TWebControl

	
	DATA aItems						INIT {}
	DATA aValues					INIT {}
	DATA lParKeyValue				INIT .F. 

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, aItems, aValues, aKeyValue, nGrid, cAction, cLabel, cClass, cFont, cGroup ) CLASS TWebSelect

	DEFAULT cId TO ''
	DEFAULT aItems TO {}
	DEFAULT aValues TO {}
	DEFAULT aKeyValue TO NIL
	DEFAULT nGrid TO 4
	DEFAULT cAction TO ''
	DEFAULT cLabel TO ''
	DEFAULT uValue TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''	
	DEFAULT cGroup TO ''	

	::oParent 		:= oParent	
	::cId			:= cId
	
	::aValues		:= aValues 	//	IF( valtype( aValues ) == 'A' .AND. len( aValues ) == len( aItems ), aValues, aItems )
	::nGrid			:= nGrid
	::cAction		:= cAction
	::cLabel		:= cLabel
	::uValue		:= uValue
	::cClass 		:= cClass
	::cFont 		:= cFont	
	::cGroup 		:= cGroup

	
	if valtype( aKeyValue ) == 'H' 
		::lParKeyValue 	:= .t.
		::aValues 		:= aKeyValue		
		
	else	
	
		if valtype( aItems ) == 'A' .and. len( aItems ) > 0

			if valtype( aItems[1] ) == 'A'
				::aItems := aItems[1]		
			else
				::aItems := aItems		
			endif
		
		else
				
			::aItems := {}
		endif
		
		if valtype( aValues ) == 'A' .and. len( aValues ) > 0

			if valtype( aValues[1] ) == 'A'					
				::aValues := aValues[1]	
			else
				::aValues := aValues
			endif
		
		else
			::aValues := {}
		endif		
		
		if len( ::aItems ) <> len( ::aValues )
			::aValues := ::aItems
		endif
	
	endif

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebSelect

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	LOCAL nI
	LOCAL cSize := ''
	local aPar
	local lArrayPar := .f.
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ; cSize := 'form-control-sm'
		CASE upper(::oParent:cSizing) == 'LG' ; cSize := 'form-control-lg'
	ENDCASE		

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + IF( ::oParent:lDessign, ' tweb_dessign', '') + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' )   + ' >'

	IF !empty( ::cLabel )
	
		cHtml += '<label for="' + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF	
	
	cHtml += '<div class="input-group">'	
	
	//cHtml += '<select class="col-' + ltrim(str(::nGrid)) + ' custom-select form-control ' + cSize + '" id="' + ::cId + '" onchange="' + ::cAction + '" >'
	//cHtml += '<select class="col-' + ltrim(str(::nGrid)) + ' form-control ' + cSize + IF( ::oParent:lDessign, ' tweb_dessign', '')  + '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) + ' id="' + ::cId + '" onchange="' + ::cAction + '" >'
	cHtml += '<select data-control="tcombobox" '
	
	if !empty( ::cGroup )
		cHtml += 'data-group="' + ::cGroup + '" '
	endif
		
		
	cHtml += 'class="col-12 form-control ' + cSize + IF( ::oParent:lDessign, ' tweb_dessign', '') 

	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif	

	
	cHtml += '" ' + IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) + ' id="' + ::cId + '" name="' + ::cId + '" onchange="' + ::cAction + '" >'


	FOR nI := 1 TO len( ::aValues )
	
		if ::lParKeyValue 
			aPar := HB_HPairAt( ::aValues, nI ) 
		else
			aPar := { ::aValues[nI], ::aItems[nI] }

		endif

		cHtml += '<option value="' + aPar[1] + '" ' 			
		
		IF ::uValue == aPar[1]
			cHtml += ' selected '					
		ENDIF
		
		cHtml += '>' + aPar[2]		
		cHtml += '</option>'			
		
	NEXT	

	cHtml += '</select>' 
	
	cHtml += '	</div>'
	cHtml += '</div>'	

RETU cHtml