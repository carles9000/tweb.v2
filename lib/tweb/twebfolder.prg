//	-------------------------------------------------------------

CLASS TWebFolder FROM TWebForm
	
	//DATA oParent
	DATA aTabs	 					INIT {}
	DATA aPrompts 					INIT {}
	DATA aTabs 						INIT {=>}
	DATA cInitTab 					INIT ''
	DATA lAdjust 					INIT .F.

	METHOD New() 					CONSTRUCTOR
	METHOD Activate()
	
		
	METHOD AddTab( cId, cHtml )
	METHOD EndTab()					INLINE ::Html( '</div>' )
	METHOD EndFolder()				INLINE ::Html( '</div></div>' )

ENDCLASS 

METHOD New( oParent, cId, aTabs, aPrompts, nGrid, cInitTab, lAdjust, cClass, cFont  ) CLASS TWebFolder

	DEFAULT cId 			TO ''
	DEFAULT nGrid 			TO 12
	DEFAULT aPrompts 		TO { { "One", "Two", "Three" } }
	//DEFAULT cClass 		TO ''
	DEFAULT cInitTab 		TO ''
	DEFAULT lAdjust 		TO .F.
	DEFAULT cClass TO ''
	DEFAULT cFont TO ''	
		
	::oParent 		:= oParent
	::cId			:= cId
	::nGrid			:= nGrid
	::aTabs 		:= aTabs
	::aPrompts 		:= aPrompts
	//::cClass		:= cClass
	::cInitTab 		:= cInitTab
	::lAdjust		:= lAdjust
	::cClass 		:= cClass
	::cFont 		:= cFont	

	IF Valtype( oParent ) == 'O'	
		oParent:AddControl( SELF )	
		
		::lDessign := oParent:lDessign
		::cSizing  := oParent:cSizing
		::cType    := oParent:cType
		
	ENDIF

RETU SELF



METHOD AddTab( cId , lFocus, cClassTab ) CLASS TWebFolder

	LOCAL cHtml := ''
	LOCAL cClass := IF( ::oParent:lFluid, 'container-fluid', 'container' )
	
	DEFAULT cClassTab TO ''
	
	IF ::lAdjust
		cClass += ' tweb_folder '
	ENDIF

	DEFAULT lFocus TO .F.
	

	//cHtml := '<div class="tab-pane ' + cClass + ' '  + IF( lFocus, 'active', 'fade' )

	// fade no es amigo de active...
	
	cHtml := '<div class="tab-pane  ' + cClassTab + ' ' +  cClass + ' ' 
	
	if cId == ::cInitTab
		cHtml += ' active '
	endif
	
	if ( ::lBorder ) 
		cHtml += ' h-100 border border-primary border-bottom-0 '
	endif	
	
	
	cHtml += '" '
	cHtml += ' id="' +  cId + '">'
	
	::Html( cHtml )	

RETU NIL

METHOD Activate() CLASS TWebFolder

	LOCAL cHtml := ''
	LOCAL nI, aPairs, cCode, cKey

	//retu mh_valtochar( ::APrompts )
	
	
	cHtml += '<div class="col-' + ltrim(str(::nGrid)) + ' tweb_folder" >'	
	
		cHtml += '<ul id="' + ::cId + '" class="nav nav-tabs border-0">'	
		
			FOR nI := 1 To len( ::aPrompts )
			
				 cHtml += '<li class="nav-item ' 
								 
				 if ::cInitTab == ::aTabs[nI] 
				 	cHtml += ' active'				 
				 endif
				 
				 cHtml += '">'
				 
					cHtml += '<a class="nav-link '	

						 if ::cInitTab == ::aTabs[nI] 
							cHtml += ' active'				 
						 endif					
						 
						if ( ::lBorder ) 
							cHtml += ' border border-primary border-bottom-0 '
						endif
	
						if !empty( ::cClass )	
							cHtml += ' ' + ::cClass
						endif
						
						if !empty( ::cFont )	
							cHtml += ' ' + ::cFont
						endif																
					
					cHtml += '" data-toggle="tab" href="#' + ::aTabs[nI] + '">' + ::aPrompts[nI] + '</a>'			 
				 
				 cHtml += '</li>'				
			NEXT		
		
		cHtml += '</ul>'	

	
		cHtml += '<div class="tab-content"' + IF( ::lDessign, 'style="border:1px solid blue;"', '' )   + ' >'


		//	EndFolder() cierra los 2 divs abiertos...
	

		
	FOR nI := 1 To len( ::aControls )
	
		IF Valtype( ::aControls[nI] ) == 'O'			
			cHtml += ::aControls[nI]:Activate()			
		ELSE		
			cHtml += ::aControls[nI]
		ENDIF
	
	NEXT		

	

RETU cHtml