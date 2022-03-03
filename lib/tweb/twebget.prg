//	-------------------------------------------------------------

CLASS TWebGet FROM TWebControl

	DATA cType		 				INIT 'text'
	DATA cPlaceHolder 				INIT ''
	DATA aBtnLabel 					INIT {}
	DATA aBtnAction 				INIT {}
	DATA aBtnId 					INIT {}
	DATA uSource 					INIT ''
	DATA cSelect 					INIT ''
	DATA cLink 						INIT ''
	DATA aSpan						INIT {}
	DATA aSpanId 					INIT {}


	METHOD New() 					CONSTRUCTOR
	METHOD Activate()


ENDCLASS 

METHOD New( oParent, cId, uValue, nGrid, cLabel, cAlign, lReadOnly, cType, cPlaceHolder, aBtnLabel, aBtnAction, aBtnId, lRequired, uSource, cSelect, cChange, cClass, cFont, cFontLabel, cLink, cGroup, cDefault, aSpan, aSpanId ) CLASS TWebGet

	DEFAULT cId TO ''
	DEFAULT uValue TO ''
	DEFAULT nGrid TO 4
	DEFAULT cLabel TO ''
	DEFAULT cAlign TO ''
	DEFAULT lReadOnly TO .F.
	DEFAULT cType TO 'text'
	DEFAULT cPlaceHolder TO ''
	DEFAULT aBtnLabel TO {}
	DEFAULT aBtnAction TO {}
	DEFAULT aBtnId 		TO {}
	DEFAULT lRequired TO .F.	
	DEFAULT uSource TO ''
	DEFAULT cSelect TO ''
	DEFAULT cChange TO ''
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''
	DEFAULT cFontLabel TO ''
	DEFAULT cLink TO ''
	DEFAULT cGroup TO ''
	DEFAULT cDefault TO ''	
	DEFAULT aSpan TO {}
	DEFAULT aSpanId TO {}
	
	::oParent 		:= oParent
	::cId			:= cId
	::uValue		:= uValue
	::nGrid			:= nGrid
	::cLabel 		:= cLabel
	::cAlign 		:= cAlign
	::lReadOnly		:= lReadOnly
	::cType			:= cType
	::cPlaceHolder := cPlaceHolder
	::aBtnLabel		:= aBtnLabel
	::aBtnAction	:= aBtnAction	
	::aBtnId		:= aBtnId
	::lRequired		:= lRequired
	::uSource 		:= uSource
	::cSelect 		:= cSelect
	::cChange 		:= cChange
	::cClass 		:= cClass
	::cFont 		:= cFont
	::cFontLabel	:= cFontLabel
	::cLink 		:= cLink
	::cGroup		:= cGroup
	::cDefault		:= cDefault
	::aSpan			:= aSpan
	::aSpanId		:= aSpanId

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )			
	ENDIF

RETU SELF

METHOD Activate() CLASS TWebGet

	LOCAL cHtml, hSource
	LOCAL cSize 	 := ''
	LOCAL cAlign 	 := ''
	LOCAL cSizeLabel := 'col-form-label'
	LOCAL cBtnSize 	 := ''
	local nI, nBtn, cLabel, cAction, cBtnId, nSpan
	
	DO CASE
		CASE ::cAlign == 'center' ; cAlign := 'text-center'
		CASE ::cAlign == 'right'  ; cAlign := 'text-right'
	ENDCASE
	
	DO CASE
		CASE upper(::oParent:cSizing) == 'SM' 
			cSize 		:= 'form-control-sm'
			cSizeLabel	:= 'col-form-label-sm'
			cBtnSize 	:= 'btn-sm'
		CASE upper(::oParent:cSizing) == 'LG' 
			cSize 		:= 'form-control-lg'
			cSizeLabel	:= 'col-form-label-lg'
			cBtnSize 	:= 'btn-lg'
	ENDCASE	

	cHtml := '<div class="col-' + ltrim(str(::nGrid)) 
	//cHtml += ' col-form-label ' 
	cHtml += IF( ::oParent:lDessign, ' tweb_dessign', '') 		
	cHtml += '" '
	chtml += IF( ::oParent:lDessign, 'style="border:1px solid blue;"', '' ) 
	cHtml += ' >'
	
	IF !empty( ::cLabel )

		cHtml += '<label class="' + cSizeLabel + ' ' + ::cFontLabel + ' " for="' + ::cId + '">' + ::cLabel + '</label>'
	
	ENDIF
	
	cHtml += '<div class="input-group">'
	
	cHtml += '<input data-control="tget" '
	
	if !empty( ::cGroup )
		cHtml += 'data-group="' + ::cGroup + '" '
	endif
	
	if !empty( ::cDefault )
		cHtml += 'data-default="' + ::cDefault + '" '
	endif	
	
	cHtml += ' type="' + ::cType + '" class="form-control ' + cSize + ' ' + cAlign
	
	if !empty( ::cClass )	
		cHtml += ' ' + ::cClass
	endif
	
	if !empty( ::cFont )	
		cHtml += ' ' + ::cFont
	endif						
	
	cHtml += '" '
	cHtml += 'id="' + ::cId + '"	 name="' + ::cId + '" ' 
	cHtml += 'placeholder="' + ::cPlaceHolder + '" ' 
	
	IF ::lReadOnly
		cHtml += ' readonly '
	ENDIF
	
	IF ::lRequired
		cHtml += ' required '
	ENDIF	
	
	IF !empty( ::cChange )
		cHtml += ' onchange="' + ::cChange + '" '
		//cHtml += ' onfocusout="' + ::cChange + '" '
	ENDIF
	
	cHtml += ' value="' + ::uValue + '">'

	
	nSpan := len( ::aSpan )
	
	if nSpan > 0 
	
		cHtml += '<div class="input-group-append">'	
		
		for nI := 1 to nSpan 
		
			cHtml += '<span'
			
			if Len( ::aSpanId ) == len( ::aSpan )			
				cHtml += ' id="' + ::aSpanId[ nI ] + '" ' 
			endif
				
			cHtml += ' class="input-group-text" >' + ::aSpan[nI] + '</span>'
			
		next
		
		cHtml += '</div>'	
		
	endif
	
	
	nBtn := len( ::aBtnLabel )

	
	if nBtn > 0 
	
		cHtml += '<div class="input-group-append">'
	
		for nI := 1 to nBtn 
		
			cLabel  := ::aBtnLabel[nI]
			
			if len( ::aBtnId ) == nBtn 
				cBtnId := ::aBtnId[nI] 
			else
				cBtnId := 'btn_' + ::cId + '_' + ltrim(str(nI))
			endif

			cHtml += '<button id="' + cBtnId + '" class="btn btn-outline-secondary ' + cBtnSize + '" type="button" '
			
			if empty( ::cLink )
				cAction := ::aBtnAction[nI]
				cHtml += 'onclick="' + cAction + '" '
			else	
				cHtml += 'style="border-radius: 0px 5px 5px 0px;" '												
			endif
			
			cHtml += ' >'
			
			if !empty( ::cLink )
				cHtml += '<a href="' + ::cLink + '" >'
			endif	
			
			cHtml += cLabel								
			
			if !empty( ::cLink )
				cHtml += '</a>'
			endif
			
			cHtml += '</button>'	
		
		next
		
		cHtml += '</div>'	
		
	endif
	
	
	
	
	
	cHtml += '	</div>'
	cHtml += '</div>'

	
	
/*	
	DO CASE
		CASE hCtrl[ 'align' ] == 'center' ; cHtml += ' text-center '
		CASE hCtrl[ 'align' ] == 'right'  ; cHtml += ' text-right '						
	ENDCASE	
*/	

	IF !Empty( ::uSource )
	
		cHtml += '<script>'
		cHtml += "$(document).ready( function() {"
	
		DO CASE 
		
			CASE Valtype( ::uSource ) == 'A'	//	Tabla Array
			
				hSource := hb_jsonencode( ::uSource )	
			
				cHtml += "  var _uSource = JSON.parse( '" + hSource + "' );"						
			
			CASE Valtype( ::uSource ) == 'C'	//	Url
			
				cHtml += "  var _uSource = '" + ::uSource + "';"						
				
		ENDCASE
		
		IF empty( ::cSelect )
			::cSelect := 'null'
		ENDIF
		
		cHtml += "   TWebGetAutocomplete( '" + ::cId + "', _uSource, '" + ::cSelect + "' ); "	

		cHtml += '})'
		cHtml += '</script>'
	
	ENDIF	

	
	//Aadd( ::aHtml, cHtml )		


RETU cHtml