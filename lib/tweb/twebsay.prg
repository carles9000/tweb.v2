//	-------------------------------------------------------------

CLASS TWebSay FROM TWebControl

	DATA cLink 						INIT '' 

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, cCaption, nGrid, cAlign, cClass, cFont, cLink ) CLASS TWebSay

	DEFAULT cId TO ''
	DEFAULT cCaption TO ''
	DEFAULT nGrid TO 4
	DEFAULT cAlign TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''
	DEFAULT cLink TO ''
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue		:= cCaption
	::nGrid			:= nGrid
	::cAlign 		:= lower( cAlign )
	::cClass 		:= cClass
	::cFont 		:= cFont
	::cLink 		:= cLink

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebSay

	LOCAL cHtml, hSource
	LOCAL cSize 	:= ''
	
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' ;	cSize 		:= 'form-control-sm'			
		CASE upper(::oParent:cSizing) == 'LG' ;	cSize 		:= 'form-control-lg'			
	ENDCASE	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) 
	
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 
	cHtml += ' tweb_say' 
	
	do case
		case ::cAlign == 'center' ; cHtml += ' text-center'
		case ::cAlign == 'right'  ; cHtml += ' text-right'
	endcase

	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif	
	
	
	cHtml += '" '
	cHtml += IF( ::oParent:lDessign, 'style="border:1px solid brown;"', '' ) 		
	cHtml += ' >'
	
	if !empty( ::cLink )
		cHtml += '<a href="' + ::cLink + '">'
	endif

	
	cHtml += '<span id="' + ::cId + '">' + ::uValue + '</span>'
	
	if !empty( ::cLink )
		cHtml += '</a>'
	endif	

	cHtml += '</div>'

RETU cHtml