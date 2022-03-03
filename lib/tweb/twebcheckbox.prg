//	-------------------------------------------------------------

CLASS TWebCheckbox FROM TWebControl

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()

ENDCLASS 

METHOD New(  oParent, cId, lValue, cLabel, nGrid, cAction, cClass, cFont     ) CLASS TWebCheckbox

	DEFAULT cId TO ''
	DEFAULT lValue TO .F.
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAction TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''
	
	::cId			:= cId
	::uValue 		:= lValue
	::cLabel 		:= cLabel
	::nGrid			:= nGrid
	::cAction		:= cAction
	::cClass 		:= cClass
	::cFont 		:= cFont	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF


METHOD Activate() CLASS TWebCheckbox

	LOCAL cHtml 	:= ''
	LOCAL cChecked	:= ''
	
	IF ::uValue
		cChecked := 'checked="checked"'
	ENDIF	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) + ' custom-control custom-checkbox tweb_checkbox" ' + IF( ::lDessign, 'style="border:1px solid blue;"', '' )   + ' >'
	cHtml += '<input type="checkbox" class="custom-control-input tweb_pointer" id="' + ::cId + '" ' 
	cHtml += ' onchange="' + ::cAction + '" '  + cChecked
	cHtml += '> '
	
	IF !empty( ::cLabel )
	
		cHtml += '<label class="custom-control-label tweb_pointer '
		
		if !empty( ::cClass )	
			cHtml += ' ' + ::cClass
		endif
		
		if !empty( ::cFont )	
			cHtml += ' ' + ::cFont
		endif

		cHtml += '" '

		
		cHtml += 'for="' + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF	

	cHtml += '</div>'

RETU cHtml