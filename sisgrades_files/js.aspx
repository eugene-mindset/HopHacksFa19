function isDirty()
{
	var oElem, oForm = window.top.frames["applicationFrame"].window.document.forms[0];
	var nCounter, nElementsLength = oForm.elements.length;

		
	for ( nCounter=0; nCounter<nElementsLength; ++nCounter )
	{
		if (oForm.elements[nCounter].name )
		{
			oElem = oForm.elements[nCounter];
	
		
			if( "_" == oElem.name.substr( 0, 1 ) )
				continue;

			if( isItemDirty( oElem ) )
			{		
				return true;
			}	
		}		
	}	
	return false;
}

function unDirty()
{
	var oElem, oForm = window.top.frames["applicationFrame"].window.document.forms[0];
	var nCounter, nElementsLength = oForm.elements.length;
	
	for ( nCounter=0; nCounter<nElementsLength; ++nCounter )
	{
		if (oForm.elements[nCounter].name )
		{

			oElem = oForm.elements[nCounter];

			if( "_" == oElem.name.substr( 0, 1 ) )
				continue;
	
			unDirtyItem( oElem );
		}
	}
		
	return true;
}

function makeDirty()
{
	var oElem, oForm = window.top.frames["applicationFrame"].window.document.forms[0];
	var nCounter, nElementsLength = oForm.elements.length;
	
	for ( nCounter=0; nCounter<nElementsLength; ++nCounter )
	{
		if (oForm.elements[nCounter].name )
		{
			oElem = oForm.elements[nCounter];
	
			if( "_" == oElem.name.substr( 0, 1 ) )
				continue;
	
			makeItemDirty( oElem );
		}
	}
		
	return true;
}

function isItemDirty( oItem )
{
	var oOptions, oOption;
	var nLength, nCounter;
	
	switch( oItem.type.toLowerCase() )
	{
	case "text" :
	case "hidden" :
	case "password" :
		return ( oItem.defaultValue != oItem.value );

	case "checkbox" :
	case "radio" :
		//if( "Y" == oItem.getAttribute( "itemDirty" ) )
		//	return true;
		return ( oItem.defaultChecked != oItem.checked );
		
	case "select-multiple":
	case "select-one":
		oOptions = oItem.options;
		nLength = oOptions.length;

		if( 0 == nLength ) 
			return false;

		for( nCounter = 0; nCounter < nLength; ++nCounter )
		{
			oOption = oOptions[nCounter];
			if( oOption.defaultSelected != oOption.selected ) 
				return true;
		}
		return false;
		
	case "textarea" :
		return ( oItem.defaultValue != oItem.value );
		
	case "button":
	case "submit":
	case "reset":
		return false;

	default :
		return ( oItem.defaultValue != oItem.value );
		break;
	} //-- end of switch ( type )
	
	return false;
}


function unDirtyItem( oItem )
{
	var oOptions, oOption;
	var nLength, nCounter;

	switch( oItem.type.toLowerCase() )
	{
	case "text" :
	case "hidden" :
	case "password" :
		oItem.defaultValue = oItem.value ;
		break;

	case "checkbox" :
	case "radio" :
		//oItem.setAttribute( "itemDirty", "N" );
		oItem.defaultChecked = oItem.checked;
		break;

	case "select-multiple":
	case "select-one":
		oOptions = oItem.options;
		nLength = oOptions.length;
		
		if( 0 == nLength ) 
			return true;
			
		for( nCounter = 0; nCounter < nLength; ++nCounter )
		{
			oOption = oOptions[nCounter];
			oOption.defaultSelected = oOption.selected; 
		}
		break;

	case "textarea" :
		oItem.defaultValue = oItem.value;
		break;

	case "button":
	case "submit":
	case "reset":
		break;

	default :
		oItem.defaultValue = oItem.value;
		break;
	} //-- end of switch ( type )

	return true;
}

function makeItemDirty( oItem )
{
	var oOptions, oOption;
	var nLength, nCounter;

	switch( oItem.type.toLowerCase() )
	{
	case "text" :
	case "hidden" :
	case "password" :
		oItem.defaultValue = null;
		break;

	case "checkbox" :
	case "radio" :
		//oItem.setAttribute( "itemDirty", "Y" );
//		oItem.defaultChecked = null;
		break;

	case "select-multiple":
	case "select-one":
		oOptions = oItem.options;
		nLength = oOptions.length;
		
		if( 0 == nLength ) 
			return true;
			
		for( nCounter = 0; nCounter < nLength; ++nCounter )
		{
			oOption = oOptions[nCounter];
			oOption.defaultSelected = false; 
		}
		break;

	case "textarea" :
		oItem.defaultValue = null;
		break;

	case "button":
	case "submit":
	case "reset":
		break;

	default :
		oItem.defaultValue = null;
		break;
	} //-- end of switch ( type )

	return true;
}

function invokeHelp( Event )
{
//-- Netscape and Safari browsers pass the parameter Event when calling the keyboard event handler
//-- IE doesn't do so and excepts to pick up the event object from window level
	var objEvent = Event;
	
	if (navigator.appName != 'Netscape') 
	{
		if( window.event )
			objEvent = window.event;
	}
		
	try
	{
		//-- check for Ctrl + Shift + H combination to display Screen Help
		if( ( objEvent.keyCode == 72 ) && ( objEvent.ctrlKey ) && ( objEvent.shiftKey ) ) 
			showHelpOnEvent( objEvent );
	}
	catch( ex )
	{}
}


function showHelp()
{
	if(event)
	{
		if( window.top.frames["leftFrame"] )
		{
			var strScreenName = window.top.frames["leftFrame"].window.gCurrentFunction;
			event.cancelBubble = true;
			getMenuHelpPage(strScreenName);
			return false;		
		}
		else
		{
			var strScreenName = window.top.gCurrentFunction;
			event.cancelBubble = true;
			getMenuHelpPage(strScreenName);
			return false;		
		}
	}
	else
		return true;		
}


function getMenuHelpPage(strScreenName)
{
	var strURL = "../../Framework/Help/ShowHelp.aspx?ScreenName=" + strScreenName;			
	var SWSHelp=window.open(strURL,'SWSHelp','left=0,top=0,height=680,width=1000,status=no,toolbar=yes,menubar=no,resizable=1,location=no');	 
}

function showHelpOnEvent( objEvent )
{
	if( window.top.frames["leftFrame"] )
	{
		var strScreenName = window.top.frames["leftFrame"].window.gCurrentFunction;
		objEvent.cancelBubble = true;
		getMenuHelpPage(strScreenName);
		return false;		
	}
	else
	{
		var strScreenName = window.top.gCurrentFunction;
		objEvent.cancelBubble = true;
		getMenuHelpPage(strScreenName);
		return false;		
	}
}

//-- BEGIN Set Help Keyboard handlers

//-- Netscape and Safari browsers indicates the appName as Netscape
//-- Both the browsers requires call to captureEvents 
//-- in order to fire keyboard events
if (navigator.appName == 'Netscape') 
{
    window.captureEvents(Event.KEYDOWN);
    window.onkeydown = invokeHelp;
}
else
{
//-- The check will make sure that the document is ready to get keydown event assigned in IE
	if( window.document )
		window.document.onkeydown = invokeHelp;
}

//-- Standard F1 handler in IE
window.onhelp=showHelp;

//-- END Set Help Keyboard handlers

var IISTimeout;
var timeLag;
var TimeToRefresh;
var timeID;
var strLOVTextOriginalValue;

//-- CMN 2611: Function to capture the value present in control when onfocus event is fired
//-- This is to replace the inconsistent behaviour of OnChange event (it is not fired when the same value entered again in textbox)
function setLOVTextOriginalValue(controlIDCol)
{
	var oForm = document.forms[0];
	var arrLocalControlID = controlIDCol.split("^");
	//-- Read the current value store it in a global variable
	strLOVTextOriginalValue = trim(oForm.elements[arrLocalControlID[1]].value)
}

//-- AshwaniK : March 17, 2004 : Begins the implementing LOV for validation changes.
function CallLOVForValidation (strLOVName, controlIDCol, returnIDCol, strNextNavigableControlID, windowFeatures)
{
	var strblnValidation = "Yes"
	var oForm = document.forms[0];
	arrcontrolID = controlIDCol.split("^");	
	setLOVTextCurrentValue = trim(oForm.elements[arrcontrolID[1]].value);
	
	//-- CMN 2611: Don't invoke the LOV, if the value present in text box has not changed
	if(strLOVTextOriginalValue == setLOVTextCurrentValue)
	{
		return;
	}
				
	if ( setLOVTextCurrentValue != "" )
	{
		if ( windowFeatures == undefined )
			windowFeatures = ""

		CallLOV(strLOVName, controlIDCol, returnIDCol, strNextNavigableControlID, windowFeatures, strblnValidation)
	}
	else
	{
		//-- Clear the dependent values when the user clears the value present in text box and tabs out
		arrReturnIDCol = returnIDCol.split("^");

		for (i=0;i < arrReturnIDCol.length; i++)
			oForm.elements[arrReturnIDCol[i]].value = "";		

		return;
	}
}

			
function trim( strValue, strTrim )
{
	var strReturn;
	if( !strTrim ) strTrim = " ";

	strReturn = ltrim( strValue, strTrim );
	strReturn = rtrim( strReturn, strTrim );

	if( !strReturn ) return "";
			
	return strReturn;
}

function rtrim( strValue, strTrim )
{
	if( !strTrim ) 	strTrim = " ";

	while( !( "" == strValue ) )
	{ 
		if( ( strValue.length - 1 ) == strValue.lastIndexOf(strTrim) ) 
			strValue = strValue.substring(0,strValue.length - 1 ); 
		else 
			return strValue; 
	}

	if( !strValue )	return "";
}


function ltrim( strValue, strTrim )
{
	if( !strTrim ) strTrim = " ";

	while( !( "" == strValue ) )
	{ 
		if( 0 == strValue.indexOf(strTrim) ) 
			strValue = strValue.substr(1); 
		else 
			return strValue; 
	}

	if( !strValue )	return "";
}

//-- AshwaniK : March 17, 2004 : Ends the implementing LOV for validation changes.


function ConfirmDelete() 
{ 
	return confirm("Are you sure you want to delete this record?");
}

function setLOVFocus(obj,strItemName)
{
		//Browser is Netscape
		if (navigator.appName.indexOf("Netscape") > -1)
		{
			obj.blur();
		}
		else
			document.getElementById(strItemName).focus();

}


function setFocus(strFormName, strItemName)
{
	//-- Set the focus to the element that has been passed.
	document.forms[strFormName].elements[strItemName].focus();
}

//This function compares a start and end date
function validDateRange(strStartDate,strEndDate)
{	
	var strRegExp = /-/g;

	strStartDate = strStartDate.replace( strRegExp, "/" ) ;
	strEndDate = strEndDate.replace( strRegExp, "/" ) ;

	var dtStart = new Date(strStartDate);
	var dtEnd = new Date(strEndDate);

	if(dtStart > dtEnd)
		return false;
	else
		return true;									

}

function enableDisableForm(oForm, bEnabled)
{
//-- This function can be used to enable/disable all the elements within 
//-- the form. This includes all the input elements and buttons but not the links.

	var oElements;
	var nLength;
	var count;
	oElements = oForm.elements;
	nLength = oElements.length;
	for (count=0;count < nLength; count++)
	{
		enableDisableItem(oElements[count],bEnabled);
	}
}

function messageBox( strMessageName, strType )
{
	if( "YesNo" == strType )
	{
		return confirm( eval(strMessageName) );
	}
	else
	{
		alert( eval(strMessageName) );
		return true;
	}
}

function isStringEmpty( strValue )
{
	var strTemp;

	if( null == strValue )
		return true;

	strTemp = strValue;

	do
	{
		strValue = strTemp;
		strTemp = strTemp.replace( " ", "" );
	}while( strValue != strTemp );

	if( 0 == strValue.length )
		return true;
	else
	{
		if( 1 == strValue.length && 32 == strValue.charCodeAt(0) )
			return true;
	}

	return false;
}

function StartTimer()
{
	var nTime;
	nTime = TimeToRefresh * 60000;
	timeID = window.setTimeout ("EndTime()", nTime);
}

function EndTime()
{
	ClearSessionIdleTime();
	
	var myDate;
	var myMin;
	var myHour;
	var myTime;
	var myMessage;

	myDate = new Date();
	myMin = parseInt(myDate.getMinutes()) + parseInt(timeLag);
	myHour = myDate.getHours();

	if (myMin > 59)
	{
		myMin = parseInt(myMin) - 60
		myHour = parseInt(myHour) + 1
	}

	if (myMin < 10)
		myMin = '0' + myMin

	if (myHour < 10)
		myHour = '0' + myHour

	if (myHour > 23)
		myHour = '00'

	myTime = myHour + ':' + myMin

	var myDate1 = new Date();
	var a = myDate1.getTime();

	myMessage = 'Your Session will timeout at ' + myTime + '. Click OK to refresh it'
	alert(myMessage);

	var myDate2 = new Date();
	var b = myDate2.getTime();
	var c = b - a;
	
	if(c >= (timeLag * 60000))
	{
		alert('Your session has timed out. Log in again to proceed.');
		//window.top.location.replace("Logout.aspx");
		window.top.location.replace("../../Framework/Menu/Logout.aspx");
	}
	else
	{
		var oForm = parent.frames[0].window;
		oForm.__doPostBack('txtTimerControl','');

		var oForm1 = parent.frames[0].window.document.forms[0];
		oForm1.elements["txtProfileSettings"].value = timeLag;
		oForm1.elements["txtServerSettings"].value = IISTimeout;

		StartSessionIdleTime();
	}
}

function StartSessionIdleTime()
{
	try
	{
		var oForm = parent.frames[0].window.document.forms[0];

		timeLag =  oForm.elements["txtProfileSettings"].value;
		IISTimeout = oForm.elements["txtServerSettings"].value;

		TimeToRefresh = parseInt(IISTimeout) - parseInt(timeLag);
		//TimeToRefresh = ( 6000 * parseInt(IISTimeout)) - parseInt(timeLag)

		if (TimeToRefresh > 0 && TimeToRefresh < parseInt(IISTimeout))
		{
			StartTimer();
		}
	} catch(e){;}
}

function ClearSessionIdleTime()
{
	clearTimeout(timeID);
}

//-- Global variable to determine whether the user has navigated to page exisiting in an external domain.
//-- External domain means accessing a website that is out of the current web server's context.

//-- Jana 27-Mar-06
//-- var gExternalDomain = "N";
//-- The variable had been moved to cache window as the variable gets reset each time the left menu is refreshed.
//-- The value is required after the left menu refresh when the application Frame is actually refreshed.

function MenuItem_Click( selectedItem, itemType )
{
	//-- If the user is clicking on the menu item from an external domain don't do a dirty.
	//-- This is because of the inherent behaviour of IE security settings that doesn't allow to access an external window.
	//-- Refer to http://msdn.microsoft.com/library/default.asp?url=/workshop/author/om/xframe_scripting_security.asp
	
	var appFrame = window.top.frames["applicationFrame"];
	
	setExternalWindow( null );
	
	var oFormElement = document.forms[0].elements;
	//var cacheWindow = getCacheWindow();
	
	//if( cacheWindow.gExternalDomain == "Y")
	//{		
	//	oFormElement["SelectedItem"].value = selectedItem;
	//	oFormElement["ItemType"].value = itemType;
	//	oFormElement["ClearPageSessionVariables"].value = "Y";
	//	oFormElement["PostPageChange"].value = "N";
	//	oFormElement["AdditionalInfo"].value = "";
	//	oFormElement["IsPageRefreshed"].value = "N";	
	//	document.forms[0].submit();
	//}
	//else
	//{
	   
	   oFormElement["SelectedItemIdentifier"].value = "";
	   
	   if ( selectedItem.indexOf("MenuGroupLink_") == -1 )
	   {
		if ( window.top.frames["applicationFrame"].document.forms[0] )
		{
			if ( window.top.frames["applicationFrame"].document.forms[0].elements["AllowNavigation"] )
			{
				if (window.top.frames["applicationFrame"].document.forms[0].elements["AllowNavigation"].value = "Yes")
				{
					if ( confirmSaveChanges() )
					{
						oFormElement["SelectedItem"].value = selectedItem;
						oFormElement["ItemType"].value = itemType;
						oFormElement["ClearPageSessionVariables"].value = "Y";
						oFormElement["PostPageChange"].value = "N";
						oFormElement["AdditionalInfo"].value = "";
						oFormElement["IsPageRefreshed"].value = "N";
						document.forms[0].submit();
					}
				}
			}
		}
	   //}

	   if ( selectedItem.indexOf("MenuGroupLink_") == 0 )
	   {
		if ( confirmSaveChanges() )
		{
			oFormElement["SelectedItem"].value = selectedItem;
			oFormElement["ItemType"].value = itemType;
			oFormElement["ClearPageSessionVariables"].value = "Y";
			oFormElement["PostPageChange"].value = "N";
			oFormElement["AdditionalInfo"].value = "";
			oFormElement["IsPageRefreshed"].value = "N";
			document.forms[0].submit();
		}
	   }
	   else
	   {
	      if ( gCurrentFunction == "SMSWEB_AppAccountInfo")
		   {
		    try {
				if ( window.top.frames["applicationFrame"].document.forms[0].elements["txtSMS_OnlineAppsID"] )
				{
					if ( window.top.frames["applicationFrame"].document.forms[0].elements["txtSMS_OnlineAppsID"].value == "" )
					{
						var oForm = window.top.frames["applicationFrame"].document.forms[0];
						oForm.__EVENTTARGET.value = "ImgNextScreen"
						oForm.__EVENTARGUMENT.value = "";
						oForm.submit();
						//** 2621 - SMS -OLA- Personal Info specific change 26-Apr-2006 - start
						//** From OLA-Personal Info screen (Add mode), if the user clicks on Application Summary, Do NOT do the Validation.
						//** If it is any other menu link (apart from Application Summary) within the Domain [My Applications], then only run through the validations.
						if (selectedItem.indexOf("_0") == -1 )
						{
							if ( window.top.frames["applicationFrame"].Page_IsValid && window.top.frames["applicationFrame"].document.forms[0].elements["txtSMS_OnlineAppsID"].value != "" )
							{
								oFormElement["SelectedItem"].value = selectedItem;
								oFormElement["ItemType"].value = itemType;
								oFormElement["ClearPageSessionVariables"].value = "Y";
								oFormElement["PostPageChange"].value = "N";
								oFormElement["AdditionalInfo"].value = "";
								oFormElement["IsPageRefreshed"].value = "N";
								document.forms[0].submit();
							}
							else if ( oForm.elements["TermsID"].value !== "" && oForm.elements["TypesSubtypesMapID"].value != "")
							{
								alert ("Before you navigate to another page, you must save the information on the current page.");
							}
						}
						else
						{
							if ( confirmSaveChanges() )
							{
								oFormElement["SelectedItem"].value = selectedItem;
								oFormElement["ItemType"].value = itemType;
								oFormElement["ClearPageSessionVariables"].value = "Y";
								oFormElement["PostPageChange"].value = "N";
								oFormElement["AdditionalInfo"].value = "";
								oFormElement["IsPageRefreshed"].value = "N";
								document.forms[0].submit();
							}
						}
						//** 2621 - SMS -OLA- Personal Info specific change 26-Apr-2006 - end
					}
					else
					{
						if ( confirmSaveChanges() )
						{
							oFormElement["SelectedItem"].value = selectedItem;
							oFormElement["ItemType"].value = itemType;
							oFormElement["ClearPageSessionVariables"].value = "Y";
							oFormElement["PostPageChange"].value = "N";
							oFormElement["AdditionalInfo"].value = "";
							oFormElement["IsPageRefreshed"].value = "N";
							document.forms[0].submit();
						}
					}
				}
			 }
			 catch(e){;}	
		   }
		   else
		   {
				if ( confirmSaveChanges() )
				{
					oFormElement["SelectedItem"].value = selectedItem;
					oFormElement["ItemType"].value = itemType;
					oFormElement["ClearPageSessionVariables"].value = "Y";
					oFormElement["PostPageChange"].value = "N";
					oFormElement["AdditionalInfo"].value = "";
					oFormElement["IsPageRefreshed"].value = "N";
					document.forms[0].submit();
				}
		   }	
		}
	}
}

function syncMenuItem( identifier, additionalInfo, doConfirmSave, postPageChange )
{
	//if( true == doConfirmSave )
	//{
	//	if( !confirmSaveChanges() )
	//		return false;
	//}
	
	//var oFormElement = document.forms[0].elements;

	//oFormElement["SelectedItem"].value = "";
	//oFormElement["ItemType"].value = "";
	//oFormElement["SelectedItemIdentifier"].value = identifier;
	//oFormElement["AdditionalInfo"].value = additionalInfo;
	//oFormElement["IsPageRefreshed"].value = "N";


	//if( true != postPageChange )
	//{
	//	oFormElement["ClearPageSessionVariables"].value = "Y";
	//	oFormElement["PostPageChange"].value = "N";
	//}
	//else
	//{
	//	oFormElement["ClearPageSessionVariables"].value = "N";
	//	oFormElement["PostPageChange"].value = "Y";
	//}
	
	//setExternalWindow( null );

 	//document.forms[0].submit();
}

function loadPageInApplicationFrame( URL )
{
	//-- Check whether the user is navigating to an external domain.
	//-- If yes, keep track of it in a global variable and do not try accessing 
	//-- the external window ( where ever applicable ).
	
	//var cacheWindow = getCacheWindow();
	
	//var bIsExternalDomain = cacheWindow.gExternalDomain;
	var appFrame = window.top.frames["applicationFrame"];
	//var bPreviousURLFromExternal = bIsExternalDomain;
	
	//if 
	//(
	//	URL.indexOf("../CMN/") != -1 || URL.indexOf("../SYS/") != -1 ||	URL.indexOf("../SMS/") != -1 || 
	//	URL.indexOf("../SAS/") != -1 ||	URL.indexOf("../SBS/") != -1 || URL.indexOf("../SSS/") != -1 ||
	//	URL.indexOf("../ARM/") != -1
	//)
	//{
	//	cacheWindow.gExternalDomain = "N";
	//}
	//else
	//{
	//	cacheWindow.gExternalDomain = "Y";
		URL = URL.split("?MyIndex=")[0];
	//}
	
	//if( "Y" == bPreviousURLFromExternal )
	//	appFrame.location.href = URL;

	//else
		appFrame.location.replace(URL);
		
	setExternalWindow( null );
}

function loadHomePage( URL )
{
	window.top.location.replace(URL);
}

function setPageTitle( menuGroup, menuItem )
{
	var titleWindowFrame;
	
	titleWindowFrame = window.top.frames["titleFrame"].window;
	
	//-- Title window may not yet have rendered. Just leave it for now
	//-- 666
	if( 0 < titleWindowFrame.document.forms.length )
	{
		if( '' == menuGroup )
		{
			titleWindowFrame.document.forms[0].elements["ChildLink"].value = menuItem;
		}
		else
		{
			titleWindowFrame.document.forms[0].elements["MenuGroup"].value = menuGroup;
			titleWindowFrame.document.forms[0].elements["MenuItem"].value = menuItem;
		}
		titleWindowFrame.document.forms[0].submit();
	}
}

function setPageTitleinTitleFrame( strTitle )
{
	//-- var titleWindowFrame;
	//-- titleWindowFrame = window.top.frames["titleFrame"].window;
	//-- Title window may not yet have rendered. Just leave it for now
	//-- 666
	//-- if( 0 < titleWindowFrame.document.forms.length )
	//-- {
	//-- 	var oSpan = parent.frames[3].window.document.getElementsByTagName("SPAN");
	//-- 	oSpan[0].innerHTML = strTitle;
	//-- }
}

function SessionTimeOut()
{
	alert('Your session has timed out. Log in again to proceed.');
}



function setExternalWindow( oWindow )
{
//-- K. Janardanan 20-Mar-06
//-- This function is called to set the currently opened external window into Cache
//-- The function takes care of closing the previously opened external window (if any)
//-- It will check if the previously opened external window is same as the current one
//-- using window.name. 
//-- NOTE: It is advised that all the external window opened be given a name.

	var strWindowName;
	var cacheWindow, oExtWindow;
	
	if( oWindow )
		strWindowName = oWindow.name;
	else
		strWindowName = "matrixdummywindowname";

	//cacheWindow = getCacheWindow();
	
	//oExtWindow = cacheWindow.oExternalWindow;
	
	//if( null != oExtWindow )
	//{
	//	if( ( !oExtWindow.closed ) && oExtWindow.name != strWindowName )
	//		oExtWindow.close();
	//}
	
	//cacheWindow.oExternalWindow = oWindow
}

function getCacheWindow()
{
	//return window.top.frames["messagesFrame"].window;
}

function ShowProgressBar(visibilityState)
{
		if(document.getElementById('ProgressIndicator') != null) {
			document.getElementById('ProgressIndicator').style.visibility = visibilityState;
		}
}
//-- BEGIN: Top Menu Tab Functions
function selectMenu( selectedTab )
{
	//-- variable to determine whether to do dirty check or not
	var bIsScreenDirty;

	//-- If the user is accessing an external domain, just transfer the control to new tab
	//-- Jana 31-Mar-06
	//-- Accessing the variable by piping the function call (getCacheWindow) is not working in
	//-- Netscape browser in Mac (panther as well as tiger)
	var cacheWindow = window.top.frames["leftFrame"].window.getCacheWindow();
	if (cacheWindow.gExternalDomain == "Y")
	{
		bIsScreenDirty = true;
	}
	//-- Incase of regular screen present on the same web server, do the dirty check before moving out
	else
	{
		bIsScreenDirty = confirmSaveChanges();
	}

	if ( bIsScreenDirty )
	{
		var leftMenuFrame;
		leftMenuFrame = window.top.frames["leftFrame"].window;
		leftMenuFrame.document.forms[0].elements["SelectedTab"].value = selectedTab;
		leftMenuFrame.document.forms[0].elements["IsPageRefreshed"].value = "N";
		leftMenuFrame.document.forms[0].submit();
		document.forms[0].elements["SelectedTab"].value = selectedTab;
		document.forms[0].submit();
	}
}
//-- END: Top Menu Tab Functions

function showHelp( strHelpURL )
{
  if ( strHelpURL != "" )
  {
   	//var lookupWin = window.open(strHelpURL,'lookUpWin','scrollbars=yes,location=no,toolbar=yes,modal=yes,status=yes,resizable=yes,width=780,height=425,screenX=0,screenY=0,top=165,left=150');
   	var lookupWin = window.open(strHelpURL,'lookUpWin');
  }
  else
  {
	alert("Help is not available for the current screen.")
  }
}

window.onhelp = getHelp;

function printPage()
{
	//-- If the user is accessing an external domain, throw up the message indicating the non-availbility of print feature
	//var cacheWindow = window.top.frames["leftFrame"].window.getCacheWindow();
	//if (cacheWindow.gExternalDomain == "Y")
	//{
	//	alert('The Print feature is not available for this Web page.');		
	//	return;
	//}

	//if( confirmSaveChanges() )
	//{
		//var strPageName = window.top.frames["applicationFrame"].window.location.href;
		var strPageName = window.location.href;
		
		if (strPageName.lastIndexOf("?") > 0)
			strPageName = strPageName + "&ForPrint=true";
		else
			strPageName = strPageName + "?ForPrint=true";

		  
		var retval=window.open( strPageName ,'PrintWin','scrollbars=yes, menubar=no, location=no,toolbar=no, modal=no, status=no, resizable=yes, width=900, height=550, top=100, left=100, screenX=100,screenY=100');
	//}
}

function switchRole()
{
	var bIsScreenDirty;

	//-- If the user is accessing an external domain, just transfer the control to switch role screen
	var cacheWindow = window.top.frames["leftFrame"].window.getCacheWindow();
	if (cacheWindow.gExternalDomain == "Y")
	{
		bIsScreenDirty = true;
	}
	//-- Incase of regular screen present on the same web server, do the dirty check before moving out
	else
	{
		bIsScreenDirty = confirmSaveChanges();
	}

	if ( bIsScreenDirty )
	{
		window.top.location.replace("SwitchRole.aspx");
	}
}

function getHelp()
{
	//-- If the user is accessing an external domain, throw up the message indicating the non-availbility of help.
	//var cacheWindow = window.top.frames["leftFrame"].window.getCacheWindow();
	//if (cacheWindow.gExternalDomain == "Y")
	//{
	//	alert('Help is not available for this Web page.');		
	//	return;
	//}	

	//getMenuHelpPage( window.top.frames["leftFrame"].window.gCurrentFunction );
	getMenuHelpPage( window.gCurrentFunction );
}

function signOut()
{
	//var bIsScreenDirty;

	//-- If the user is accessing an external domain, just log out.
	//var cacheWindow = window.top.frames["leftFrame"].window.getCacheWindow();
	//if (cacheWindow.gExternalDomain == "Y")
	//{
	//	bIsScreenDirty = true;
	//}
	//-- Incase of regular screen present on the same web server, do the dirty check before moving out.
	//else
	//{
	//	bIsScreenDirty = confirmSaveChanges();
	//}

	//if( bIsScreenDirty )
	window.top.location.replace("../../Framework/Menu/Logout.aspx");
}
//-- END: Toolbar Functions

function SessionTimeOut()
{	
	alert('Your session has timed out. Log in to proceed.');
}
function confirmSaveChanges()
{
	var bConfirmChange, bDirty;
	
	bDirty = isPageDirty();
	
	if( bDirty )
		bConfirmChange = confirm( "Are you sure you want to navigate away from this page? \n\n You have unsaved changes. Click Cancel to stay on current page to save your changes. \n\n Click OK to discard unsaved changes and continue to next page.");
	else
		bConfirmChange = true;
	
	return bConfirmChange;	
}

function isPageDirty()
{
	var bDirty;
	
	var oWindow;


	oWindow = window.top.frames["applicationFrame"];	
	
	if( null == oWindow.isDirty )
		bDirty = false;
	else
		bDirty = oWindow.isDirty();


	return bDirty;
}
function multipleInstancesPopupSet(value){
	var onsuccess = function(text) { };
	var onfailure = function() { };
	var returnval = new jhu.DownloadAsync("../../Framework/JHU_Framework/multipleinstancespopupset.aspx?value=" + value,onsuccess,onfailure,"",false);
}		

function handleCheck(checked)
{
	if (checked == true) 
	{
		multipleInstancesPopupSet("true");
		return;
	}
	else
	{
		deleteCookie(cookieName);
		multipleInstancesPopupSet("false");
		return;
	}
}

function showMultipleInstancesWindow(checked){
    
    var message = "<p>You have multiple student records. Please use the drop-down list to select the student record that you wish to review. Common reasons for multiple student records include:</p><ul><li>Enrollments as both an undergraduate and a graduate student</li><li>Taking courses as a special/non-degree student and later enrolling in a degree program</li><li>Taking courses at multiple divisions across the Johns Hopkins institution</li></ul><input type=checkbox id=\"showMessageAgain\" value=\"N\" onclick=\"handleCheck(showMessageAgain.checked)\"" + (checked ? "checked" : "") + " />&nbsp;Don\'t show this message again<a href=\"javascript:Windows.closeAll();\"><img border=0 style=margin-left:120px; src=../../Images/cmdOK.gif /></a>";
    showWin({
	    title: "Multiple Records",
	    content: message,
	    width: 500,
	    top: 125,
	    left:-525,
	    offsetElement: $("multirecords"),
	    offsetCorner: { x: "left", y: "top" }
    });
	if (getCookie(cookieName) != null) $("showMessageAgain").checked = true;

}

function checkCookie(cookieName, bPrefHide) 
{ 
	var bShow = true;
	if (bPrefHide || getCookie(cookieName) == "True") bShow = false;
	
	if (bShow)
	{  
	    window.setTimeout(showMultipleInstancesWindow,100,false);
	}   
	//cookie does not exist, so show message
		//if the object exists, then we dont need to create it with creatInlineMessage
/*		if (document.getElementById('divGenMsg')) 
		{
				document.getElementById('divGenMsg').style.visibility = 'visible';
				return;
		} 
		//if the object does not exist, then we need to create it with creatInlineMessage
		else
		{	
			var multi = document.getElementById('multirecords');
			
			if (multi)
			{
				if (multi.style.visibility == 'visible')
					new_createInlineMsg(document.getElementById('multi'),'divGenMsg','<p>You have multiple student records. Please use the drop-down list to select the student record that you wish to review. Common reasons for multiple student records include:</p><ul><li>Enrollments as both an undergraduate and a graduate student</li><li>Taking courses as a special/non-degree student and later enrolling in a degree program</li><li>Taking courses at multiple divisions across the Johns Hopkins institution</li></ul><input type=checkbox id=showMessageAgain value=N onclick=handleCheck(showMessageAgain.checked) />&nbsp;Don\'t show this message again<a href=javascript:close();><img border=0 style=margin-left:120px; src=../../Images/cmdOK.gif /></a>',12,0, 500);
					return;
			}
		} 
	} 
	else
	{
		//cookie exists, so dont show message
		if (document.getElementById('divGenMsg')) 
		{
				document.getElementById('divGenMsg').style.visibility = 'hidden';
				return;
		} 
	}*/
 } 
 
 
function setCookie(c_name,value,expiredays) {
 var exdate=new Date();
 //expiredays = expiredays * 1000 * 60 * 60 * 24;
 //var domain = "development.isis.jhu.edu";
 exdate.setDate(exdate.getDate()+expiredays)
 document.cookie = c_name + "=" + escape(value)+
 ((expiredays==null) ? "" : ";expires="+exdate.toGMTString() +
 "; path=/"); //; domain=" + domain)
}
 

/*
  name - name of the desired cookie
  return string containing value of specified cookie or null
  if cookie does not exist
*/
 
function getCookie(name) {
  var dc = document.cookie;
  var prefix = name + "=";
  var begin = dc.indexOf("; " + prefix);
  if (begin == -1) {
    begin = dc.indexOf(prefix);
    if (begin != 0) return null;
  } else
    begin += 2;
  var end = document.cookie.indexOf(";", begin);
  if (end == -1)
    end = dc.length;
  return unescape(dc.substring(begin + prefix.length, end));
}
 

/*
   name - name of the cookie
   [path] - path of the cookie (must be same as path used to create cookie)
   [domain] - domain of the cookie (must be same as domain used to
     create cookie)
   path and domain default if assigned null or omitted if no explicit
     argument proceeds
*/
 
function deleteCookie(name) 
{
	setCookie(name, "", 0); 
}

function showAlerts( strAlertsExist ){
	var url = "../../CMN/AlertsNotification/CMN_AlertsNotification.aspx";
			var myup = $("alertsSpan");
			var mycn = myup.className;
			//SNL: TODO: myup.className = "icon-spinner";
			new Ajax.Request(url, {
				method: "get",
				requestHeaders: ["If-Modified-Since", "Thu, 1 Jan 1970 00:00:00 GMT"],
				onSuccess: function(transport) {
					showWin({
						title: "My Alerts",
						content: transport.responseText,
						width: 800,
						top: 50,
						left:-500,
						offsetElement: myup,
						offsetCorner: { x: "left", y: "top" }
					});
				},
				onComplete: function(transport) {
					myup.className = mycn;
				}
			});
}
function new_wrapper(cdiv, width, controlNameToCalcRelativePos, shiftByY, shiftByX, includeCloseButton, includeSaveButton, includeRemoveButton, includeTitle, titleText) {
	cdiv.style.width = width || "auto";
	
	if(!controlNameToCalcRelativePos) {
		cdiv.className += " ajaxDivNotificationRelative";
	} else {
		cdiv.className += " ajaxDivNotification";
		var controlToCalcRelativePos = document.getElementById(controlNameToCalcRelativePos);
		if(!controlToCalcRelativePos) {
			alert('Control Name supplied to calculate relative position of the Wrapper does not exist in DOM.');
		} else {
			var elPosition = findPos(controlToCalcRelativePos);
			shiftByX = shiftByX || 0;
			shiftByY = shiftByY || 0;
			cdiv.style.left = elPosition[0] + shiftByX; 
			cdiv.style.top = elPosition[1] + shiftByY;
		}
	}
	
	var classTree = ["north","east","south","west","ne","se","sw","nw"];
	var tempdivs = [];
	var tempinner = cdiv.innerHTML;
	cdiv.innerHTML = "";
	prevdiv = cdiv;
	for(var a = 0; a < classTree.length; a++) {
		tempdivs[a] = document.createElement('DIV');
		tempdivs[a].className = classTree[a];
		prevdiv.appendChild(tempdivs[a]);
		prevdiv = tempdivs[a];
	}
	
	if(includeCloseButton && includeCloseButton == true) {
		var myCloseButtonDiv = document.createElement("DIV");
		myCloseButtonDiv.id = "closeButton" + cdiv.id;
		myCloseButtonDiv.className = "ajaxDivNotificationCloseButton";
		new_myCloseButtonDivEvents(myCloseButtonDiv, cdiv);
	
		var myMoveButtonDiv = document.createElement("DIV");
		myMoveButtonDiv.id = "moveButton" + cdiv.id;
		myMoveButtonDiv.className = "ajaxDivNotificationMoveButton";
		myMoveButtonDivEvents(myMoveButtonDiv, cdiv);
		
		myMoveButtonDiv.appendChild(myCloseButtonDiv);

		var header     = document.createElement("table");
		var headerBody = document.createElement("tbody");
		var headerRow = document.createElement("tr");
		var headerCell1 = document.createElement("td");
		headerCell1.appendChild(myMoveButtonDiv);
		headerRow.appendChild(headerCell1);
		var headerCell2 = document.createElement("td");
		headerCell2.appendChild(myCloseButtonDiv);
		headerRow.appendChild(headerCell2);
		headerCell2.setAttribute("align","right");
		headerBody.appendChild(headerRow);
		header.appendChild(headerBody);
		header.className = "ajaxDivTablePlain"
		header.style.width = (width==null) ? "auto" : parseInt(width) - 50;
		prevdiv.appendChild(header);
	}

	if(includeTitle && includeTitle == true) {
		var titleContainer = document.createElement("DIV");
		titleContainer.className = "sectionHeader";
		var title = createSpanElement("title" + cdiv.id, (titleText) ? titleText : "", "sectionHeader")
		titleContainer.appendChild(title);
		prevdiv.appendChild(titleContainer)
	}
	
	var newDiv = document.createElement('DIV');
	newDiv.id = "contentContainer" + cdiv.id
	//newDiv.id = "feedback" + controlNameToCalcRelativePos;
	
	newDiv.innerHTML += tempinner;
	prevdiv.appendChild(newDiv);
	noteDiv = document.createElement('DIV');
	noteDiv.id = "feedback" + controlNameToCalcRelativePos;
	newDiv.appendChild(noteDiv);

	if(includeSaveButton && includeSaveButton == true) {
		var saveLink = document.createElement('A');
		saveLink.id = "save" + controlNameToCalcRelativePos;
		saveLink.setAttribute("href","javascript:;");
		saveLink.innerHTML = "<BR>Save";
		newDiv.appendChild(saveLink);
		
		newDiv.innerHTML += "&nbsp&nbsp&nbsp";
		
		var cancelLink = document.createElement('A');
		cancelLink.id = "cancel" + controlNameToCalcRelativePos;
		cancelLink.setAttribute("href","javascript:;");  
		cancelLink.innerHTML = "Cancel";
		newDiv.appendChild(cancelLink);

		if(includeRemoveButton && includeRemoveButton == true) {
			newDiv.innerHTML += "&nbsp&nbsp&nbsp";
			var removeLink = document.createElement('A');
			removeLink.id = "remove" + controlNameToCalcRelativePos;
			removeLink.setAttribute("href","javascript:;");  
			removeLink.innerHTML = "Remove";
			newDiv.appendChild(removeLink);
		}

		newDiv.innerHTML += "&nbsp&nbsp&nbsp";
		newDiv.innerHTML += "<img id='progressIndicator" +  controlNameToCalcRelativePos + "' width='15px' height='15px' class='AjaxHidden' src='/SSWF/Images/ProgressIndicator_medium.gif'>"

		myCancelButtonEvent(cancelLink, cdiv);
	}
	
	return prevdiv;
}

function collapser(XXX, cdiv) {
	XXX.onclick = function() {
			var obj = document.getElementById("contentContainer" + cdiv.id); 
			obj.className = (obj.className == 'AjaxVisible') ? 'AjaxHidden' : 'AjaxVisible';
			
			var divobj = document.getElementById("BiographicalInfo"); 
			cdiv.className = (divobj.className == 'AjaxSectionNormal') ? 'AjaxSectionShrinksed' : 'AjaxSectionNormal';
		};
}

function myMoveButtonDivEvents(myMoveButtonDiv, targetControl) {
	myMoveButtonDiv.onmousedown = function() {
		var myNonElements = [ ];
		document.onmousemove = function(e) { getMoving(e, targetControl); return false; };
	};
	myMoveButtonDiv.onmouseup = function() {
		document.onmousemove = function(e) { return true; };
	};
	myMoveButtonDiv.onmouseover = function() {
		this.className = "ajaxDivNotificationMoveButtonMouseOver";
	};
	myMoveButtonDiv.onmouseout = function() {
		this.className = "ajaxDivNotificationMoveButton";
	};
}

function new_myCloseButtonDivEvents(myCloseButtonDiv, targetControl){
	myCloseButtonDiv.onclick = function(){ new_closeControl(targetControl.id); };
	myCloseButtonDiv.onmouseover = function() { this.className = "ajaxDivNotificationCloseButtonMouseOver" };
	myCloseButtonDiv.onmouseout = function() { this.className = "ajaxDivNotificationCloseButton" };
	myCloseButtonDiv.onmousedown = function() { this.className = "ajaxDivNotificationCloseButtonPressed" };
	myCloseButtonDiv.onmouseup = function() { this.className = "ajaxDivNotificationCloseButton" };
}

function myCancelButtonEvent(myCancelButton, targetControl){
	myCancelButton.onclick = function() {new_closeControl(targetControl.id); };
}

function new_closeControl(controlName) {

	var agt=navigator.userAgent.toLowerCase();

	var myBody = document.getElementsByTagName("body")[0];
	var myDiv = document.getElementById(controlName);
	var iframe = document.getElementById("jhu_HoverPanel[" + controlName + "].Iframe");
	if(myDiv) 
	{
		if ((agt.indexOf("msie") != -1) && (agt.indexOf("opera") == -1))
		{
			document.getElementsByTagName('form')[0].removeChild(myDiv);
			//myBody.children[0].removeChild(myDiv);
		}
		else if (agt.indexOf('gecko') != -1)
		{
			myBody.childNodes[1].removeChild(myDiv);
		}
	}
	if(iframe) 
	{
		if ((agt.indexOf("msie") != -1) && (agt.indexOf("opera") == -1))
		{
			document.getElementsByTagName('form')[0].removeChild(iframe);
			//myBody.children[0].removeChild(iframe);
		}
		else if (agt.indexOf('gecko') != -1)
		{
			myBody.childNodes[1].removeChild(iframe);
		}
	}
}

function progressIndicator(popupName, IsVisible) {
	var pi = document.getElementById("progressIndicator" + popupName);
	if (pi == null) { //alert('ProgressBar control not found'); 
						return; }
	
	if (IsVisible == true) { pi.className = ""; }
	else				   { pi.className = "AjaxHidden"; }
	
}

function writeFeedback(popupName, feedbackSpanName, msg, msgCssName){
	// Find Feedback container DIV
	var name = popupName.split("_");
	var popupName = name[0].replace("temp","").replace("hidden","");
	
	var pl = document.getElementById("feedback" + popupName);
	if(pl) {
		if(document.getElementById(feedbackSpanName) == null) {
			var val = createSpanElement(feedbackSpanName, "<BR>" + msg, msgCssName);
			pl.appendChild(val);
			val.focus();
			return true;
		} else {
			//Remove if message exists - to support easy msg replacement
			removeFeedback(popupName, feedbackSpanName);
			writeFeedback(popupName, feedbackSpanName, msg, msgCssName); // round trip
		}
	}
	
	return false;
}

function removeFeedback(popupName, feedbackSpanName){
	// Find Feedback container DIV
	var name = popupName.split("_");
	var popupName = name[0].replace("temp","").replace("hidden","");

	var pl = document.getElementById("feedback" + popupName);
	if(pl) {
		if(document.getElementById(feedbackSpanName) != null) {
			var val = document.getElementById(feedbackSpanName);
			pl.removeChild(val);
			return true;
		}
	}
	
	return false;
}



function getMoving(e, el) {
	e = e || window.event;
	var cursor = {x:0, y:0};
	if(e.pageX || e.pageY) {
		cursor.x = e.pageX;
		cursor.y = e.pageY;
	} else {
		var de = document.documentElement;
		var b = document.body;
		cursor.x = e.clientX + 
			(de.scrollLeft || b.scrollLeft) - (de.clientLeft || 0);
		cursor.y = e.clientY + 
			(de.scrollTop || b.scrollTop) - (de.clientTop || 0);
	}
	
	//statusDiv = document.getElementById("Status")
	//statusDiv.innerHTML = "Cursor position: " + cursor.x + ":" + cursor.y
	
	el.style.top = cursor.y - 35;
	el.style.left = cursor.x - 32;
	
	var iframe = document.getElementById("jhu_HoverPanel[" + el.id + "].Iframe");
	if(iframe) {
		iframe.style.top = el.style.top;
		iframe.style.left = el.style.left;
	}
	
	return cursor;
}

function findPos(obj) {
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft
		curtop = obj.offsetTop
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft
			curtop += obj.offsetTop
		}
	}
	return [curleft,curtop];
}
	
	
function new_createInlineMsg(selfControl,controlName, value, shiftByY, shiftByX, divWidth){
	
//	try { closeAllMessages(); } // the function doesn't exist!
//	catch(err) {};
	
	var myBody = document.getElementsByTagName("body")[0];
	
	var agt=navigator.userAgent.toLowerCase();
	
//	if (typeof(messages) != "undefined") {
//		messages[messages.length] = controlName;
//	}
	
	if (document.getElementById(controlName) == null) {
		var myDiv = document.createElement("DIV");
		myDiv.id = controlName;
		myDiv.className = "ajaxDivNotification";
		
		var myLabel = document.createElement("DIV");
		myLabel.className = "ajaxDivNotificationText";
		myLabel.innerHTML = "<a ID=" + controlName + "note href='#' alt='Note:'></a>" + value;
		myDiv.appendChild(myLabel);
		
		//SNL allow width to be specified, or use orig value of 300
		divWidth = divWidth || 300;
		new_wrapper(myDiv, divWidth, selfControl.id, shiftByY, shiftByX,true);
		//SNL END REPLACED -- wrapper(myDiv, 300, selfControl.id, shiftByY, shiftByX,true);
		
		if ((agt.indexOf("msie") != -1) && (agt.indexOf("opera") == -1))
		{
			document.getElementsByTagName('form')[0].appendChild(myDiv);
			//myBody.children[0].appendChild(myDiv);
		}
		else if (agt.indexOf('gecko') != -1)
		{
			myBody.childNodes[1].appendChild(myDiv);
		}

		//myBody.appendChild(myDiv);
		
		var iframe = document.createElement("iframe");
		iframe.id = "jhu_HoverPanel[" + controlName + "].Iframe";
		iframe.src = "javascript:false";
		iframe.style.position = "absolute";
		iframe.style.top = myDiv.style.top;
		iframe.style.left = myDiv.style.left;
		iframe.style.width = myDiv.clientWidth;
		iframe.style.height = myDiv.clientHeight;
		iframe.style.padding = "0px";
		iframe.style.margin = "0px";
		iframe.style.border = "0px";
		iframe.style.filter = "alpha(opacity = 0)";
		iframe.scrolling = "no";
		
		myDiv.onresize = function() {
			iframe.style.width = myDiv.clientWidth;
			iframe.style.height = myDiv.clientHeight;
		};

		if ((agt.indexOf("msie") != -1) && (agt.indexOf("opera") == -1))
		{
			document.getElementsByTagName('form')[0].insertBefore(iframe,myDiv);
			//myBody.children[0].insertBefore(iframe,myDiv);
		}
		else if (agt.indexOf('gecko') != -1)
		{
			myBody.childNodes[1].insertBefore(iframe,myDiv);
		}
		
		//myBody.insertBefore(iframe, myDiv);
		
		//related to accessibility - screen readers, in particular
		var focusOnControl = document.getElementById(controlName + "note");
		if(focusOnControl) {
			focusOnControl.focus();
		}
	}
	else {
		new_closeControl(controlName);
	}
}

			
// Generic - extending javascript Array object to include indexOf method
Array.prototype.indexOf=function(obj){
	for (ArrayItem=0; ArrayItem<this.length; ArrayItem++){	
		if (this[ArrayItem]==obj ) {
			return ArrayItem;
		}
	}
	return -1;
};

function createSpanElement(spanControlName, spanControlText, spanClass) {
	newSpan = document.createElement('span');
	newSpan.id = spanControlName;
	newSpan.className = spanClass;
	newSpan.innerHTML = spanControlText;
	
	return newSpan;
}

function createTextBoxElement(textControlName, textControlValue, sizePx, maxLength){
	newTextBox = document.createElement('input');
	newTextBox.setAttribute('type', 'text');
	newTextBox.setAttribute('id',textControlName);
	newTextBox.setAttribute('name',textControlName);
	newTextBox.setAttribute('value', textControlValue);
	newTextBox.setAttribute('size', sizePx);
	newTextBox.setAttribute('maxLength', maxLength);
	
	return newTextBox;
}

function createCheckBox(checkControlName, checkControlValue){
	checkBox = document.createElement("input"); 
	checkBox.setAttribute('type', 'checkbox');
	checkBox.setAttribute('id',checkControlName);
	checkBox.setAttribute('name',checkControlName);
	checkBox.checked = checkControlValue;                 
	//checkBox.checked = true make it checked; checkBox.defaultChecked by default

	return checkBox;
}

function createDropDownElement(controlName, arr, selectedValue) {
	myselect = document.createElement("SELECT");
	myselect.id=controlName;
	
	for (i=0;i<arr.length;i++) {
		theOption=document.createElement("OPTION");
		theText=document.createTextNode(arr[i]);
		theOption.appendChild(theText);
		theOption.setAttribute("value",arr[i]);
		if (arr[i] == selectedValue) {			// Does not work in Firefox, expects elent to be attached to Body, 
			theOption.selected = true;			// before it accepts value
		}
		myselect.appendChild(theOption);
	}
	
	return myselect;
}

function createTableElement(twoDimensionalControlArray) {
	var rowCount = twoDimensionalControlArray.length;
	var columnCount = twoDimensionalControlArray[0].length;
	
	mytable     = document.createElement("table");
	mytablebody = document.createElement("tbody");

	for(var j = 0; j < rowCount; j++) {
		mycurrent_row = document.createElement("tr");
		for(var i = 0; i < columnCount; i++) {
			mycurrent_cell = document.createElement("td");
			mycurrent_cell.className = "label";
			mycurrent_cell.appendChild(twoDimensionalControlArray[j][i]);
			mycurrent_row.appendChild(mycurrent_cell);
		}
		mytablebody.appendChild(mycurrent_row);
	}
	
	mytable.appendChild(mytablebody);
	mytable.setAttribute("border", "0");
	return mytable;
}

function compareValues(value1, value2){
	if (value1 != value2) {	return false;} 
	else {return true;}
}

function jhuRegularExpressionValidatorEvaluateIsValid(value, expression) {
    if (jhuValidatorTrim(value).length == 0)
        return true;        
    var rx = new RegExp(expression);
    var matches = rx.exec(value);
    return (matches != null && value == matches[0]);
}
function jhuValidatorTrim(s) {
    var m = s.match(/^\s*(\S+(\s+\S+)*)\s*$/);
    return (m == null) ? "" : m[1];
}

function trimAll(sString)
{
	while (sString.substring(0,1) == ' ')
	{
		sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' ')
	{
		sString = sString.substring(0,sString.length-1);
	}
	return sString;
}
/*  Prototype JavaScript framework, version 1.5.1
 *  (c) 2005-2007 Sam Stephenson
 *
 *  Prototype is freely distributable under the terms of an MIT-style license.
 *  For details, see the Prototype web site: http://www.prototypejs.org/
 *
/*--------------------------------------------------------------------------*/

var Prototype = {
  Version: '1.5.1',

  Browser: {
    IE:     !!(window.attachEvent && !window.opera),
    Opera:  !!window.opera,
    WebKit: navigator.userAgent.indexOf('AppleWebKit/') > -1,
    Gecko:  navigator.userAgent.indexOf('Gecko') > -1 && navigator.userAgent.indexOf('KHTML') == -1
  },

  BrowserFeatures: {
    XPath: !!document.evaluate,
    ElementExtensions: !!window.HTMLElement,
    SpecificElementExtensions:
      (document.createElement('div').__proto__ !==
       document.createElement('form').__proto__)
  },

  ScriptFragment: '<script[^>]*>([\u0001-\uFFFF]*?)</script>',
  JSONFilter: /^\/\*-secure-\s*(.*)\s*\*\/\s*$/,

  emptyFunction: function() { },
  K: function(x) { return x }
}

var Class = {
  create: function() {
    return function() {
      this.initialize.apply(this, arguments);
    }
  }
}

var Abstract = new Object();

Object.extend = function(destination, source) {
  for (var property in source) {
    destination[property] = source[property];
  }
  return destination;
}

Object.extend(Object, {
  inspect: function(object) {
    try {
      if (object === undefined) return 'undefined';
      if (object === null) return 'null';
      return object.inspect ? object.inspect() : object.toString();
    } catch (e) {
      if (e instanceof RangeError) return '...';
      throw e;
    }
  },

  toJSON: function(object) {
    var type = typeof object;
    switch(type) {
      case 'undefined':
      case 'function':
      case 'unknown': return;
      case 'boolean': return object.toString();
    }
    if (object === null) return 'null';
    if (object.toJSON) return object.toJSON();
    if (object.ownerDocument === document) return;
    var results = [];
    for (var property in object) {
      var value = Object.toJSON(object[property]);
      if (value !== undefined)
        results.push(property.toJSON() + ': ' + value);
    }
    return '{' + results.join(', ') + '}';
  },

  keys: function(object) {
    var keys = [];
    for (var property in object)
      keys.push(property);
    return keys;
  },

  values: function(object) {
    var values = [];
    for (var property in object)
      values.push(object[property]);
    return values;
  },

  clone: function(object) {
    return Object.extend({}, object);
  }
});

Function.prototype.bind = function() {
  var __method = this, args = $A(arguments), object = args.shift();
  return function() {
    return __method.apply(object, args.concat($A(arguments)));
  }
}

Function.prototype.bindAsEventListener = function(object) {
  var __method = this, args = $A(arguments), object = args.shift();
  return function(event) {
    return __method.apply(object, [event || window.event].concat(args));
  }
}

Object.extend(Number.prototype, {
  toColorPart: function() {
    return this.toPaddedString(2, 16);
  },

  succ: function() {
    return this + 1;
  },

  times: function(iterator) {
    $R(0, this, true).each(iterator);
    return this;
  },

  toPaddedString: function(length, radix) {
    var string = this.toString(radix || 10);
    return '0'.times(length - string.length) + string;
  },

  toJSON: function() {
    return isFinite(this) ? this.toString() : 'null';
  }
});

Date.prototype.toJSON = function() {
  return '"' + this.getFullYear() + '-' +
    (this.getMonth() + 1).toPaddedString(2) + '-' +
    this.getDate().toPaddedString(2) + 'T' +
    this.getHours().toPaddedString(2) + ':' +
    this.getMinutes().toPaddedString(2) + ':' +
    this.getSeconds().toPaddedString(2) + '"';
};

var Try = {
  these: function() {
    var returnValue;

    for (var i = 0, length = arguments.length; i < length; i++) {
      var lambda = arguments[i];
      try {
        returnValue = lambda();
        break;
      } catch (e) {}
    }

    return returnValue;
  }
}

/*--------------------------------------------------------------------------*/

var PeriodicalExecuter = Class.create();
PeriodicalExecuter.prototype = {
  initialize: function(callback, frequency) {
    this.callback = callback;
    this.frequency = frequency;
    this.currentlyExecuting = false;

    this.registerCallback();
  },

  registerCallback: function() {
    this.timer = setInterval(this.onTimerEvent.bind(this), this.frequency * 1000);
  },

  stop: function() {
    if (!this.timer) return;
    clearInterval(this.timer);
    this.timer = null;
  },

  onTimerEvent: function() {
    if (!this.currentlyExecuting) {
      try {
        this.currentlyExecuting = true;
        this.callback(this);
      } finally {
        this.currentlyExecuting = false;
      }
    }
  }
}
Object.extend(String, {
  interpret: function(value) {
    return value == null ? '' : String(value);
  },
  specialChar: {
    '\b': '\\b',
    '\t': '\\t',
    '\n': '\\n',
    '\f': '\\f',
    '\r': '\\r',
    '\\': '\\\\'
  }
});

Object.extend(String.prototype, {
  gsub: function(pattern, replacement) {
    var result = '', source = this, match;
    replacement = arguments.callee.prepareReplacement(replacement);

    while (source.length > 0) {
      if (match = source.match(pattern)) {
        result += source.slice(0, match.index);
        result += String.interpret(replacement(match));
        source  = source.slice(match.index + match[0].length);
      } else {
        result += source, source = '';
      }
    }
    return result;
  },

  sub: function(pattern, replacement, count) {
    replacement = this.gsub.prepareReplacement(replacement);
    count = count === undefined ? 1 : count;

    return this.gsub(pattern, function(match) {
      if (--count < 0) return match[0];
      return replacement(match);
    });
  },

  scan: function(pattern, iterator) {
    this.gsub(pattern, iterator);
    return this;
  },

  truncate: function(length, truncation) {
    length = length || 30;
    truncation = truncation === undefined ? '...' : truncation;
    return this.length > length ?
      this.slice(0, length - truncation.length) + truncation : this;
  },

  strip: function() {
    return this.replace(/^\s+/, '').replace(/\s+$/, '');
  },

  stripTags: function() {
    return this.replace(/<\/?[^>]+>/gi, '');
  },

  stripScripts: function() {
    return this.replace(new RegExp(Prototype.ScriptFragment, 'img'), '');
  },

  extractScripts: function() {
    var matchAll = new RegExp(Prototype.ScriptFragment, 'img');
    var matchOne = new RegExp(Prototype.ScriptFragment, 'im');
    return (this.match(matchAll) || []).map(function(scriptTag) {
      return (scriptTag.match(matchOne) || ['', ''])[1];
    });
  },

  evalScripts: function() {
    return this.extractScripts().map(function(script) { return eval(script) });
  },

  escapeHTML: function() {
    var self = arguments.callee;
    self.text.data = this;
    return self.div.innerHTML;
  },

  unescapeHTML: function() {
    var div = document.createElement('div');
    div.innerHTML = this.stripTags();
    return div.childNodes[0] ? (div.childNodes.length > 1 ?
      $A(div.childNodes).inject('', function(memo, node) { return memo+node.nodeValue }) :
      div.childNodes[0].nodeValue) : '';
  },

  toQueryParams: function(separator) {
    var match = this.strip().match(/([^?#]*)(#.*)?$/);
    if (!match) return {};

    return match[1].split(separator || '&').inject({}, function(hash, pair) {
      if ((pair = pair.split('='))[0]) {
        var key = decodeURIComponent(pair.shift());
        var value = pair.length > 1 ? pair.join('=') : pair[0];
        if (value != undefined) value = decodeURIComponent(value);

        if (key in hash) {
          if (hash[key].constructor != Array) hash[key] = [hash[key]];
          hash[key].push(value);
        }
        else hash[key] = value;
      }
      return hash;
    });
  },

  toArray: function() {
    return this.split('');
  },

  succ: function() {
    return this.slice(0, this.length - 1) +
      String.fromCharCode(this.charCodeAt(this.length - 1) + 1);
  },

  times: function(count) {
    var result = '';
    for (var i = 0; i < count; i++) result += this;
    return result;
  },

  camelize: function() {
    var parts = this.split('-'), len = parts.length;
    if (len == 1) return parts[0];

    var camelized = this.charAt(0) == '-'
      ? parts[0].charAt(0).toUpperCase() + parts[0].substring(1)
      : parts[0];

    for (var i = 1; i < len; i++)
      camelized += parts[i].charAt(0).toUpperCase() + parts[i].substring(1);

    return camelized;
  },

  capitalize: function() {
    return this.charAt(0).toUpperCase() + this.substring(1).toLowerCase();
  },

  underscore: function() {
    return this.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'#{1}_#{2}').gsub(/([a-z\d])([A-Z])/,'#{1}_#{2}').gsub(/-/,'_').toLowerCase();
  },

  dasherize: function() {
    return this.gsub(/_/,'-');
  },

  inspect: function(useDoubleQuotes) {
    var escapedString = this.gsub(/[\x00-\x1f\\]/, function(match) {
      var character = String.specialChar[match[0]];
      return character ? character : '\\u00' + match[0].charCodeAt().toPaddedString(2, 16);
    });
    if (useDoubleQuotes) return '"' + escapedString.replace(/"/g, '\\"') + '"';
    return "'" + escapedString.replace(/'/g, '\\\'') + "'";
  },

  toJSON: function() {
    return this.inspect(true);
  },

  unfilterJSON: function(filter) {
    return this.sub(filter || Prototype.JSONFilter, '#{1}');
  },

  evalJSON: function(sanitize) {
    var json = this.unfilterJSON();
    try {
      if (!sanitize || (/^("(\\.|[^"\\\n\r])*?"|[,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t])+?$/.test(json)))
        return eval('(' + json + ')');
    } catch (e) { }
    throw new SyntaxError('Badly formed JSON string: ' + this.inspect());
  },

  include: function(pattern) {
    return this.indexOf(pattern) > -1;
  },

  startsWith: function(pattern) {
    return this.indexOf(pattern) === 0;
  },

  endsWith: function(pattern) {
    var d = this.length - pattern.length;
    return d >= 0 && this.lastIndexOf(pattern) === d;
  },

  empty: function() {
    return this == '';
  },

  blank: function() {
    return /^\s*$/.test(this);
  }
});

if (Prototype.Browser.WebKit || Prototype.Browser.IE) Object.extend(String.prototype, {
  escapeHTML: function() {
    return this.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
  },
  unescapeHTML: function() {
    return this.replace(/&amp;/g,'&').replace(/&lt;/g,'<').replace(/&gt;/g,'>');
  }
});

String.prototype.gsub.prepareReplacement = function(replacement) {
  if (typeof replacement == 'function') return replacement;
  var template = new Template(replacement);
  return function(match) { return template.evaluate(match) };
}

String.prototype.parseQuery = String.prototype.toQueryParams;

Object.extend(String.prototype.escapeHTML, {
  div:  document.createElement('div'),
  text: document.createTextNode('')
});

with (String.prototype.escapeHTML) div.appendChild(text);

var Template = Class.create();
Template.Pattern = /(^|.|\r|\n)(#\{(.*?)\})/;
Template.prototype = {
  initialize: function(template, pattern) {
    this.template = template.toString();
    this.pattern  = pattern || Template.Pattern;
  },

  evaluate: function(object) {
    return this.template.gsub(this.pattern, function(match) {
      var before = match[1];
      if (before == '\\') return match[2];
      return before + String.interpret(object[match[3]]);
    });
  }
}

var $break = {}, $continue = new Error('"throw $continue" is deprecated, use "return" instead');

var Enumerable = {
  each: function(iterator) {
    var index = 0;
    try {
      this._each(function(value) {
        iterator(value, index++);
      });
    } catch (e) {
      if (e != $break) throw e;
    }
    return this;
  },

  eachSlice: function(number, iterator) {
    var index = -number, slices = [], array = this.toArray();
    while ((index += number) < array.length)
      slices.push(array.slice(index, index+number));
    return slices.map(iterator);
  },

  all: function(iterator) {
    var result = true;
    this.each(function(value, index) {
      result = result && !!(iterator || Prototype.K)(value, index);
      if (!result) throw $break;
    });
    return result;
  },

  any: function(iterator) {
    var result = false;
    this.each(function(value, index) {
      if (result = !!(iterator || Prototype.K)(value, index))
        throw $break;
    });
    return result;
  },

  collect: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      results.push((iterator || Prototype.K)(value, index));
    });
    return results;
  },

  detect: function(iterator) {
    var result;
    this.each(function(value, index) {
      if (iterator(value, index)) {
        result = value;
        throw $break;
      }
    });
    return result;
  },

  findAll: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      if (iterator(value, index))
        results.push(value);
    });
    return results;
  },

  grep: function(pattern, iterator) {
    var results = [];
    this.each(function(value, index) {
      var stringValue = value.toString();
      if (stringValue.match(pattern))
        results.push((iterator || Prototype.K)(value, index));
    })
    return results;
  },

  include: function(object) {
    var found = false;
    this.each(function(value) {
      if (value == object) {
        found = true;
        throw $break;
      }
    });
    return found;
  },

  inGroupsOf: function(number, fillWith) {
    fillWith = fillWith === undefined ? null : fillWith;
    return this.eachSlice(number, function(slice) {
      while(slice.length < number) slice.push(fillWith);
      return slice;
    });
  },

  inject: function(memo, iterator) {
    this.each(function(value, index) {
      memo = iterator(memo, value, index);
    });
    return memo;
  },

  invoke: function(method) {
    var args = $A(arguments).slice(1);
    return this.map(function(value) {
      return value[method].apply(value, args);
    });
  },

  max: function(iterator) {
    var result;
    this.each(function(value, index) {
      value = (iterator || Prototype.K)(value, index);
      if (result == undefined || value >= result)
        result = value;
    });
    return result;
  },

  min: function(iterator) {
    var result;
    this.each(function(value, index) {
      value = (iterator || Prototype.K)(value, index);
      if (result == undefined || value < result)
        result = value;
    });
    return result;
  },

  partition: function(iterator) {
    var trues = [], falses = [];
    this.each(function(value, index) {
      ((iterator || Prototype.K)(value, index) ?
        trues : falses).push(value);
    });
    return [trues, falses];
  },

  pluck: function(property) {
    var results = [];
    this.each(function(value, index) {
      results.push(value[property]);
    });
    return results;
  },

  reject: function(iterator) {
    var results = [];
    this.each(function(value, index) {
      if (!iterator(value, index))
        results.push(value);
    });
    return results;
  },

  sortBy: function(iterator) {
    return this.map(function(value, index) {
      return {value: value, criteria: iterator(value, index)};
    }).sort(function(left, right) {
      var a = left.criteria, b = right.criteria;
      return a < b ? -1 : a > b ? 1 : 0;
    }).pluck('value');
  },

  toArray: function() {
    return this.map();
  },

  zip: function() {
    var iterator = Prototype.K, args = $A(arguments);
    if (typeof args.last() == 'function')
      iterator = args.pop();

    var collections = [this].concat(args).map($A);
    return this.map(function(value, index) {
      return iterator(collections.pluck(index));
    });
  },

  size: function() {
    return this.toArray().length;
  },

  inspect: function() {
    return '#<Enumerable:' + this.toArray().inspect() + '>';
  }
}

Object.extend(Enumerable, {
  map:     Enumerable.collect,
  find:    Enumerable.detect,
  select:  Enumerable.findAll,
  member:  Enumerable.include,
  entries: Enumerable.toArray
});
var $A = Array.from = function(iterable) {
  if (!iterable) return [];
  if (iterable.toArray) {
    return iterable.toArray();
  } else {
    var results = [];
    for (var i = 0, length = iterable.length; i < length; i++)
      results.push(iterable[i]);
    return results;
  }
}

if (Prototype.Browser.WebKit) {
  $A = Array.from = function(iterable) {
    if (!iterable) return [];
    if (!(typeof iterable == 'function' && iterable == '[object NodeList]') &&
      iterable.toArray) {
      return iterable.toArray();
    } else {
      var results = [];
      for (var i = 0, length = iterable.length; i < length; i++)
        results.push(iterable[i]);
      return results;
    }
  }
}

Object.extend(Array.prototype, Enumerable);

if (!Array.prototype._reverse)
  Array.prototype._reverse = Array.prototype.reverse;

Object.extend(Array.prototype, {
  _each: function(iterator) {
    for (var i = 0, length = this.length; i < length; i++)
      iterator(this[i]);
  },

  clear: function() {
    this.length = 0;
    return this;
  },

  first: function() {
    return this[0];
  },

  last: function() {
    return this[this.length - 1];
  },

  compact: function() {
    return this.select(function(value) {
      return value != null;
    });
  },

  flatten: function() {
    return this.inject([], function(array, value) {
      return array.concat(value && value.constructor == Array ?
        value.flatten() : [value]);
    });
  },

  without: function() {
    var values = $A(arguments);
    return this.select(function(value) {
      return !values.include(value);
    });
  },

  indexOf: function(object) {
    for (var i = 0, length = this.length; i < length; i++)
      if (this[i] == object) return i;
    return -1;
  },

  reverse: function(inline) {
    return (inline !== false ? this : this.toArray())._reverse();
  },

  reduce: function() {
    return this.length > 1 ? this : this[0];
  },

  uniq: function(sorted) {
    return this.inject([], function(array, value, index) {
      if (0 == index || (sorted ? array.last() != value : !array.include(value)))
        array.push(value);
      return array;
    });
  },

  clone: function() {
    return [].concat(this);
  },

  size: function() {
    return this.length;
  },

  inspect: function() {
    return '[' + this.map(Object.inspect).join(', ') + ']';
  },

  toJSON: function() {
    var results = [];
    this.each(function(object) {
      var value = Object.toJSON(object);
      if (value !== undefined) results.push(value);
    });
    return '[' + results.join(', ') + ']';
  }
});

Array.prototype.toArray = Array.prototype.clone;

function $w(string) {
  string = string.strip();
  return string ? string.split(/\s+/) : [];
}

if (Prototype.Browser.Opera){
  Array.prototype.concat = function() {
    var array = [];
    for (var i = 0, length = this.length; i < length; i++) array.push(this[i]);
    for (var i = 0, length = arguments.length; i < length; i++) {
      if (arguments[i].constructor == Array) {
        for (var j = 0, arrayLength = arguments[i].length; j < arrayLength; j++)
          array.push(arguments[i][j]);
      } else {
        array.push(arguments[i]);
      }
    }
    return array;
  }
}
var Hash = function(object) {
  if (object instanceof Hash) this.merge(object);
  else Object.extend(this, object || {});
};

Object.extend(Hash, {
  toQueryString: function(obj) {
    var parts = [];
    parts.add = arguments.callee.addPair;

    this.prototype._each.call(obj, function(pair) {
      if (!pair.key) return;
      var value = pair.value;

      if (value && typeof value == 'object') {
        if (value.constructor == Array) value.each(function(value) {
          parts.add(pair.key, value);
        });
        return;
      }
      parts.add(pair.key, value);
    });

    return parts.join('&');
  },

  toJSON: function(object) {
    var results = [];
    this.prototype._each.call(object, function(pair) {
      var value = Object.toJSON(pair.value);
      if (value !== undefined) results.push(pair.key.toJSON() + ': ' + value);
    });
    return '{' + results.join(', ') + '}';
  }
});

Hash.toQueryString.addPair = function(key, value, prefix) {
  key = encodeURIComponent(key);
  if (value === undefined) this.push(key);
  else this.push(key + '=' + (value == null ? '' : encodeURIComponent(value)));
}

Object.extend(Hash.prototype, Enumerable);
Object.extend(Hash.prototype, {
  _each: function(iterator) {
    for (var key in this) {
      var value = this[key];
      if (value && value == Hash.prototype[key]) continue;

      var pair = [key, value];
      pair.key = key;
      pair.value = value;
      iterator(pair);
    }
  },

  keys: function() {
    return this.pluck('key');
  },

  values: function() {
    return this.pluck('value');
  },

  merge: function(hash) {
    return $H(hash).inject(this, function(mergedHash, pair) {
      mergedHash[pair.key] = pair.value;
      return mergedHash;
    });
  },

  remove: function() {
    var result;
    for(var i = 0, length = arguments.length; i < length; i++) {
      var value = this[arguments[i]];
      if (value !== undefined){
        if (result === undefined) result = value;
        else {
          if (result.constructor != Array) result = [result];
          result.push(value)
        }
      }
      delete this[arguments[i]];
    }
    return result;
  },

  toQueryString: function() {
    return Hash.toQueryString(this);
  },

  inspect: function() {
    return '#<Hash:{' + this.map(function(pair) {
      return pair.map(Object.inspect).join(': ');
    }).join(', ') + '}>';
  },

  toJSON: function() {
    return Hash.toJSON(this);
  }
});

function $H(object) {
  if (object instanceof Hash) return object;
  return new Hash(object);
};

// Safari iterates over shadowed properties
if (function() {
  var i = 0, Test = function(value) { this.key = value };
  Test.prototype.key = 'foo';
  for (var property in new Test('bar')) i++;
  return i > 1;
}()) Hash.prototype._each = function(iterator) {
  var cache = [];
  for (var key in this) {
    var value = this[key];
    if ((value && value == Hash.prototype[key]) || cache.include(key)) continue;
    cache.push(key);
    var pair = [key, value];
    pair.key = key;
    pair.value = value;
    iterator(pair);
  }
};
ObjectRange = Class.create();
Object.extend(ObjectRange.prototype, Enumerable);
Object.extend(ObjectRange.prototype, {
  initialize: function(start, end, exclusive) {
    this.start = start;
    this.end = end;
    this.exclusive = exclusive;
  },

  _each: function(iterator) {
    var value = this.start;
    while (this.include(value)) {
      iterator(value);
      value = value.succ();
    }
  },

  include: function(value) {
    if (value < this.start)
      return false;
    if (this.exclusive)
      return value < this.end;
    return value <= this.end;
  }
});

var $R = function(start, end, exclusive) {
  return new ObjectRange(start, end, exclusive);
}

var Ajax = {
  getTransport: function() {
    return Try.these(
      function() {return new XMLHttpRequest()},
      function() {return new ActiveXObject('Msxml2.XMLHTTP')},
      function() {return new ActiveXObject('Microsoft.XMLHTTP')}
    ) || false;
  },

  activeRequestCount: 0
}

Ajax.Responders = {
  responders: [],

  _each: function(iterator) {
    this.responders._each(iterator);
  },

  register: function(responder) {
    if (!this.include(responder))
      this.responders.push(responder);
  },

  unregister: function(responder) {
    this.responders = this.responders.without(responder);
  },

  dispatch: function(callback, request, transport, json) {
    this.each(function(responder) {
      if (typeof responder[callback] == 'function') {
        try {
          responder[callback].apply(responder, [request, transport, json]);
        } catch (e) {}
      }
    });
  }
};

Object.extend(Ajax.Responders, Enumerable);

Ajax.Responders.register({
  onCreate: function() {
    Ajax.activeRequestCount++;
  },
  onComplete: function() {
    Ajax.activeRequestCount--;
  }
});

Ajax.Base = function() {};
Ajax.Base.prototype = {
  setOptions: function(options) {
    this.options = {
      method:       'post',
      asynchronous: true,
      contentType:  'application/x-www-form-urlencoded',
      encoding:     'UTF-8',
      parameters:   ''
    }
    Object.extend(this.options, options || {});

    this.options.method = this.options.method.toLowerCase();
    if (typeof this.options.parameters == 'string')
      this.options.parameters = this.options.parameters.toQueryParams();
  }
}

Ajax.Request = Class.create();
Ajax.Request.Events =
  ['Uninitialized', 'Loading', 'Loaded', 'Interactive', 'Complete'];

Ajax.Request.prototype = Object.extend(new Ajax.Base(), {
  _complete: false,

  initialize: function(url, options) {
    this.transport = Ajax.getTransport();
    this.setOptions(options);
    this.request(url);
  },

  request: function(url) {
    this.url = url;
    this.method = this.options.method;
    var params = Object.clone(this.options.parameters);

    if (!['get', 'post'].include(this.method)) {
      // simulate other verbs over post
      params['_method'] = this.method;
      this.method = 'post';
    }

    this.parameters = params;

    if (params = Hash.toQueryString(params)) {
      // when GET, append parameters to URL
      if (this.method == 'get')
        this.url += (this.url.include('?') ? '&' : '?') + params;
      else if (/Konqueror|Safari|KHTML/.test(navigator.userAgent))
        params += '&_=';
    }

    try {
      if (this.options.onCreate) this.options.onCreate(this.transport);
      Ajax.Responders.dispatch('onCreate', this, this.transport);

      this.transport.open(this.method.toUpperCase(), this.url,
        this.options.asynchronous);

      if (this.options.asynchronous)
        setTimeout(function() { this.respondToReadyState(1) }.bind(this), 10);

      this.transport.onreadystatechange = this.onStateChange.bind(this);
      this.setRequestHeaders();

      this.body = this.method == 'post' ? (this.options.postBody || params) : null;
      this.transport.send(this.body);

      /* Force Firefox to handle ready state 4 for synchronous requests */
      if (!this.options.asynchronous && this.transport.overrideMimeType)
        this.onStateChange();

    }
    catch (e) {
      this.dispatchException(e);
    }
  },

  onStateChange: function() {
    var readyState = this.transport.readyState;
    if (readyState > 1 && !((readyState == 4) && this._complete))
      this.respondToReadyState(this.transport.readyState);
  },

  setRequestHeaders: function() {
    var headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-Prototype-Version': Prototype.Version,
      'Accept': 'text/javascript, text/html, application/xml, text/xml, */*'
    };

    if (this.method == 'post') {
      headers['Content-type'] = this.options.contentType +
        (this.options.encoding ? '; charset=' + this.options.encoding : '');

      /* Force "Connection: close" for older Mozilla browsers to work
       * around a bug where XMLHttpRequest sends an incorrect
       * Content-length header. See Mozilla Bugzilla #246651.
       */
      if (this.transport.overrideMimeType &&
          (navigator.userAgent.match(/Gecko\/(\d{4})/) || [0,2005])[1] < 2005)
            headers['Connection'] = 'close';
    }

    // user-defined headers
    if (typeof this.options.requestHeaders == 'object') {
      var extras = this.options.requestHeaders;

      if (typeof extras.push == 'function')
        for (var i = 0, length = extras.length; i < length; i += 2)
          headers[extras[i]] = extras[i+1];
      else
        $H(extras).each(function(pair) { headers[pair.key] = pair.value });
    }

    for (var name in headers)
      this.transport.setRequestHeader(name, headers[name]);
  },

  success: function() {
    return !this.transport.status
        || (this.transport.status >= 200 && this.transport.status < 300);
  },

  respondToReadyState: function(readyState) {
    var state = Ajax.Request.Events[readyState];
    var transport = this.transport, json = this.evalJSON();

    if (state == 'Complete') {
      try {
        this._complete = true;
        (this.options['on' + this.transport.status]
         || this.options['on' + (this.success() ? 'Success' : 'Failure')]
         || Prototype.emptyFunction)(transport, json);
      } catch (e) {
        this.dispatchException(e);
      }

      var contentType = this.getHeader('Content-type');
      if (contentType && contentType.strip().
        match(/^(text|application)\/(x-)?(java|ecma)script(;.*)?$/i))
          this.evalResponse();
    }

    try {
      (this.options['on' + state] || Prototype.emptyFunction)(transport, json);
      Ajax.Responders.dispatch('on' + state, this, transport, json);
    } catch (e) {
      this.dispatchException(e);
    }

    if (state == 'Complete') {
      // avoid memory leak in MSIE: clean up
      this.transport.onreadystatechange = Prototype.emptyFunction;
    }
  },

  getHeader: function(name) {
    try {
      return this.transport.getResponseHeader(name);
    } catch (e) { return null }
  },

  evalJSON: function() {
    try {
      var json = this.getHeader('X-JSON');
      return json ? json.evalJSON() : null;
    } catch (e) { return null }
  },

  evalResponse: function() {
    try {
      return eval((this.transport.responseText || '').unfilterJSON());
    } catch (e) {
      this.dispatchException(e);
    }
  },

  dispatchException: function(exception) {
    (this.options.onException || Prototype.emptyFunction)(this, exception);
    Ajax.Responders.dispatch('onException', this, exception);
  }
});

Ajax.Updater = Class.create();

Object.extend(Object.extend(Ajax.Updater.prototype, Ajax.Request.prototype), {
  initialize: function(container, url, options) {
    this.container = {
      success: (container.success || container),
      failure: (container.failure || (container.success ? null : container))
    }

    this.transport = Ajax.getTransport();
    this.setOptions(options);

    var onComplete = this.options.onComplete || Prototype.emptyFunction;
    this.options.onComplete = (function(transport, param) {
      this.updateContent();
      onComplete(transport, param);
    }).bind(this);

    this.request(url);
  },

  updateContent: function() {
    var receiver = this.container[this.success() ? 'success' : 'failure'];
    var response = this.transport.responseText;

    if (!this.options.evalScripts) response = response.stripScripts();

    if (receiver = $(receiver)) {
      if (this.options.insertion)
        new this.options.insertion(receiver, response);
      else
        receiver.update(response);
    }

    if (this.success()) {
      if (this.onComplete)
        setTimeout(this.onComplete.bind(this), 10);
    }
  }
});

Ajax.PeriodicalUpdater = Class.create();
Ajax.PeriodicalUpdater.prototype = Object.extend(new Ajax.Base(), {
  initialize: function(container, url, options) {
    this.setOptions(options);
    this.onComplete = this.options.onComplete;

    this.frequency = (this.options.frequency || 2);
    this.decay = (this.options.decay || 1);

    this.updater = {};
    this.container = container;
    this.url = url;

    this.start();
  },

  start: function() {
    this.options.onComplete = this.updateComplete.bind(this);
    this.onTimerEvent();
  },

  stop: function() {
    this.updater.options.onComplete = undefined;
    clearTimeout(this.timer);
    (this.onComplete || Prototype.emptyFunction).apply(this, arguments);
  },

  updateComplete: function(request) {
    if (this.options.decay) {
      this.decay = (request.responseText == this.lastText ?
        this.decay * this.options.decay : 1);

      this.lastText = request.responseText;
    }
    this.timer = setTimeout(this.onTimerEvent.bind(this),
      this.decay * this.frequency * 1000);
  },

  onTimerEvent: function() {
    this.updater = new Ajax.Updater(this.container, this.url, this.options);
  }
});
function $(element) {
  if (arguments.length > 1) {
    for (var i = 0, elements = [], length = arguments.length; i < length; i++)
      elements.push($(arguments[i]));
    return elements;
  }
  if (typeof element == 'string')
    element = document.getElementById(element);
  return Element.extend(element);
}

if (Prototype.BrowserFeatures.XPath) {
  document._getElementsByXPath = function(expression, parentElement) {
    var results = [];
    var query = document.evaluate(expression, $(parentElement) || document,
      null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
    for (var i = 0, length = query.snapshotLength; i < length; i++)
      results.push(query.snapshotItem(i));
    return results;
  };

  document.getElementsByClassName = function(className, parentElement) {
    var q = ".//*[contains(concat(' ', @class, ' '), ' " + className + " ')]";
    return document._getElementsByXPath(q, parentElement);
  }

} else document.getElementsByClassName = function(className, parentElement) {
  var children = ($(parentElement) || document.body).getElementsByTagName('*');
  var elements = [], child;
  for (var i = 0, length = children.length; i < length; i++) {
    child = children[i];
    if (Element.hasClassName(child, className))
      elements.push(Element.extend(child));
  }
  return elements;
};

/*--------------------------------------------------------------------------*/

if (!window.Element) var Element = {};

Element.extend = function(element) {
  var F = Prototype.BrowserFeatures;
  if (!element || !element.tagName || element.nodeType == 3 ||
   element._extended || F.SpecificElementExtensions || element == window)
    return element;

  var methods = {}, tagName = element.tagName, cache = Element.extend.cache,
   T = Element.Methods.ByTag;

  // extend methods for all tags (Safari doesn't need this)
  if (!F.ElementExtensions) {
    Object.extend(methods, Element.Methods),
    Object.extend(methods, Element.Methods.Simulated);
  }

  // extend methods for specific tags
  if (T[tagName]) Object.extend(methods, T[tagName]);

  for (var property in methods) {
    var value = methods[property];
    if (typeof value == 'function' && !(property in element))
      element[property] = cache.findOrStore(value);
  }

  element._extended = Prototype.emptyFunction;
  return element;
};

Element.extend.cache = {
  findOrStore: function(value) {
    return this[value] = this[value] || function() {
      return value.apply(null, [this].concat($A(arguments)));
    }
  }
};

Element.Methods = {
  visible: function(element) {
    return $(element).style.display != 'none';
  },

  toggle: function(element) {
    element = $(element);
    Element[Element.visible(element) ? 'hide' : 'show'](element);
    return element;
  },

  hide: function(element) {
    $(element).style.display = 'none';
    return element;
  },

  show: function(element) {
    $(element).style.display = '';
    return element;
  },

  remove: function(element) {
    element = $(element);
    element.parentNode.removeChild(element);
    return element;
  },

  update: function(element, html) {
    html = typeof html == 'undefined' ? '' : html.toString();
    $(element).innerHTML = html.stripScripts();
    setTimeout(function() {html.evalScripts()}, 10);
    return element;
  },

  replace: function(element, html) {
    element = $(element);
    html = typeof html == 'undefined' ? '' : html.toString();
    if (element.outerHTML) {
      element.outerHTML = html.stripScripts();
    } else {
      var range = element.ownerDocument.createRange();
      range.selectNodeContents(element);
      element.parentNode.replaceChild(
        range.createContextualFragment(html.stripScripts()), element);
    }
    setTimeout(function() {html.evalScripts()}, 10);
    return element;
  },

  inspect: function(element) {
    element = $(element);
    var result = '<' + element.tagName.toLowerCase();
    $H({'id': 'id', 'className': 'class'}).each(function(pair) {
      var property = pair.first(), attribute = pair.last();
      var value = (element[property] || '').toString();
      if (value) result += ' ' + attribute + '=' + value.inspect(true);
    });
    return result + '>';
  },

  recursivelyCollect: function(element, property) {
    element = $(element);
    var elements = [];
    while (element = element[property])
      if (element.nodeType == 1)
        elements.push(Element.extend(element));
    return elements;
  },

  ancestors: function(element) {
    return $(element).recursivelyCollect('parentNode');
  },

  descendants: function(element) {
    return $A($(element).getElementsByTagName('*')).each(Element.extend);
  },

  firstDescendant: function(element) {
    element = $(element).firstChild;
    while (element && element.nodeType != 1) element = element.nextSibling;
    return $(element);
  },

  immediateDescendants: function(element) {
    if (!(element = $(element).firstChild)) return [];
    while (element && element.nodeType != 1) element = element.nextSibling;
    if (element) return [element].concat($(element).nextSiblings());
    return [];
  },

  previousSiblings: function(element) {
    return $(element).recursivelyCollect('previousSibling');
  },

  nextSiblings: function(element) {
    return $(element).recursivelyCollect('nextSibling');
  },

  siblings: function(element) {
    element = $(element);
    return element.previousSiblings().reverse().concat(element.nextSiblings());
  },

  match: function(element, selector) {
    if (typeof selector == 'string')
      selector = new Selector(selector);
    return selector.match($(element));
  },

  up: function(element, expression, index) {
    element = $(element);
    if (arguments.length == 1) return $(element.parentNode);
    var ancestors = element.ancestors();
    return expression ? Selector.findElement(ancestors, expression, index) :
      ancestors[index || 0];
  },

  down: function(element, expression, index) {
    element = $(element);
    if (arguments.length == 1) return element.firstDescendant();
    var descendants = element.descendants();
    return expression ? Selector.findElement(descendants, expression, index) :
      descendants[index || 0];
  },

  previous: function(element, expression, index) {
    element = $(element);
    if (arguments.length == 1) return $(Selector.handlers.previousElementSibling(element));
    var previousSiblings = element.previousSiblings();
    return expression ? Selector.findElement(previousSiblings, expression, index) :
      previousSiblings[index || 0];
  },

  next: function(element, expression, index) {
    element = $(element);
    if (arguments.length == 1) return $(Selector.handlers.nextElementSibling(element));
    var nextSiblings = element.nextSiblings();
    return expression ? Selector.findElement(nextSiblings, expression, index) :
      nextSiblings[index || 0];
  },

  getElementsBySelector: function() {
    var args = $A(arguments), element = $(args.shift());
    return Selector.findChildElements(element, args);
  },

  getElementsByClassName: function(element, className) {
    return document.getElementsByClassName(className, element);
  },

  readAttribute: function(element, name) {
    element = $(element);
    if (Prototype.Browser.IE) {
      if (!element.attributes) return null;
      var t = Element._attributeTranslations;
      if (t.values[name]) return t.values[name](element, name);
      if (t.names[name])  name = t.names[name];
      var attribute = element.attributes[name];
      return attribute ? attribute.nodeValue : null;
    }
    return element.getAttribute(name);
  },

  getHeight: function(element) {
    return $(element).getDimensions().height;
  },

  getWidth: function(element) {
    return $(element).getDimensions().width;
  },

  classNames: function(element) {
    return new Element.ClassNames(element);
  },

  hasClassName: function(element, className) {
    if (!(element = $(element))) return;
    var elementClassName = element.className;
    if (elementClassName.length == 0) return false;
    if (elementClassName == className ||
        elementClassName.match(new RegExp("(^|\\s)" + className + "(\\s|$)")))
      return true;
    return false;
  },

  addClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element).add(className);
    return element;
  },

  removeClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element).remove(className);
    return element;
  },

  toggleClassName: function(element, className) {
    if (!(element = $(element))) return;
    Element.classNames(element)[element.hasClassName(className) ? 'remove' : 'add'](className);
    return element;
  },

  observe: function() {
    Event.observe.apply(Event, arguments);
    return $A(arguments).first();
  },

  stopObserving: function() {
    Event.stopObserving.apply(Event, arguments);
    return $A(arguments).first();
  },

  // removes whitespace-only text node children
  cleanWhitespace: function(element) {
    element = $(element);
    var node = element.firstChild;
    while (node) {
      var nextNode = node.nextSibling;
      if (node.nodeType == 3 && !/\S/.test(node.nodeValue))
        element.removeChild(node);
      node = nextNode;
    }
    return element;
  },

  empty: function(element) {
    return $(element).innerHTML.blank();
  },

  descendantOf: function(element, ancestor) {
    element = $(element), ancestor = $(ancestor);
    while (element = element.parentNode)
      if (element == ancestor) return true;
    return false;
  },

  scrollTo: function(element) {
    element = $(element);
    var pos = Position.cumulativeOffset(element);
    window.scrollTo(pos[0], pos[1]);
    return element;
  },

  getStyle: function(element, style) {
    element = $(element);
    style = style == 'float' ? 'cssFloat' : style.camelize();
    var value = element.style[style];
    if (!value) {
      var css = document.defaultView.getComputedStyle(element, null);
      value = css ? css[style] : null;
    }
    if (style == 'opacity') return value ? parseFloat(value) : 1.0;
    return value == 'auto' ? null : value;
  },

  getOpacity: function(element) {
    return $(element).getStyle('opacity');
  },

  setStyle: function(element, styles, camelized) {
    element = $(element);
    var elementStyle = element.style;

    for (var property in styles)
      if (property == 'opacity') element.setOpacity(styles[property])
      else
        elementStyle[(property == 'float' || property == 'cssFloat') ?
          (elementStyle.styleFloat === undefined ? 'cssFloat' : 'styleFloat') :
          (camelized ? property : property.camelize())] = styles[property];

    return element;
  },

  setOpacity: function(element, value) {
    element = $(element);
    element.style.opacity = (value == 1 || value === '') ? '' :
      (value < 0.00001) ? 0 : value;
    return element;
  },

  getDimensions: function(element) {
    element = $(element);
    var display = $(element).getStyle('display');
    if (display != 'none' && display != null) // Safari bug
      return {width: element.offsetWidth, height: element.offsetHeight};

    // All *Width and *Height properties give 0 on elements with display none,
    // so enable the element temporarily
    var els = element.style;
    var originalVisibility = els.visibility;
    var originalPosition = els.position;
    var originalDisplay = els.display;
    els.visibility = 'hidden';
    els.position = 'absolute';
    els.display = 'block';
    var originalWidth = element.clientWidth;
    var originalHeight = element.clientHeight;
    els.display = originalDisplay;
    els.position = originalPosition;
    els.visibility = originalVisibility;
    return {width: originalWidth, height: originalHeight};
  },

  makePositioned: function(element) {
    element = $(element);
    var pos = Element.getStyle(element, 'position');
    if (pos == 'static' || !pos) {
      element._madePositioned = true;
      element.style.position = 'relative';
      // Opera returns the offset relative to the positioning context, when an
      // element is position relative but top and left have not been defined
      if (window.opera) {
        element.style.top = 0;
        element.style.left = 0;
      }
    }
    return element;
  },

  undoPositioned: function(element) {
    element = $(element);
    if (element._madePositioned) {
      element._madePositioned = undefined;
      element.style.position =
        element.style.top =
        element.style.left =
        element.style.bottom =
        element.style.right = '';
    }
    return element;
  },

  makeClipping: function(element) {
    element = $(element);
    if (element._overflow) return element;
    element._overflow = element.style.overflow || 'auto';
    if ((Element.getStyle(element, 'overflow') || 'visible') != 'hidden')
      element.style.overflow = 'hidden';
    return element;
  },

  undoClipping: function(element) {
    element = $(element);
    if (!element._overflow) return element;
    element.style.overflow = element._overflow == 'auto' ? '' : element._overflow;
    element._overflow = null;
    return element;
  }
};

Object.extend(Element.Methods, {
  childOf: Element.Methods.descendantOf,
  childElements: Element.Methods.immediateDescendants
});

if (Prototype.Browser.Opera) {
  Element.Methods._getStyle = Element.Methods.getStyle;
  Element.Methods.getStyle = function(element, style) {
    switch(style) {
      case 'left':
      case 'top':
      case 'right':
      case 'bottom':
        if (Element._getStyle(element, 'position') == 'static') return null;
      default: return Element._getStyle(element, style);
    }
  };
}
else if (Prototype.Browser.IE) {
  Element.Methods.getStyle = function(element, style) {
    element = $(element);
    style = (style == 'float' || style == 'cssFloat') ? 'styleFloat' : style.camelize();
    var value = element.style[style];
    if (!value && element.currentStyle) value = element.currentStyle[style];

    if (style == 'opacity') {
      if (value = (element.getStyle('filter') || '').match(/alpha\(opacity=(.*)\)/))
        if (value[1]) return parseFloat(value[1]) / 100;
      return 1.0;
    }

    if (value == 'auto') {
      if ((style == 'width' || style == 'height') && (element.getStyle('display') != 'none'))
        return element['offset'+style.capitalize()] + 'px';
      return null;
    }
    return value;
  };

  Element.Methods.setOpacity = function(element, value) {
    element = $(element);
    var filter = element.getStyle('filter'), style = element.style;
    if (value == 1 || value === '') {
      style.filter = filter.replace(/alpha\([^\)]*\)/gi,'');
      return element;
    } else if (value < 0.00001) value = 0;
    style.filter = filter.replace(/alpha\([^\)]*\)/gi, '') +
      'alpha(opacity=' + (value * 100) + ')';
    return element;
  };

  // IE is missing .innerHTML support for TABLE-related elements
  Element.Methods.update = function(element, html) {
    element = $(element);
    html = typeof html == 'undefined' ? '' : html.toString();
    var tagName = element.tagName.toUpperCase();
    if (['THEAD','TBODY','TR','TD'].include(tagName)) {
      var div = document.createElement('div');
      switch (tagName) {
        case 'THEAD':
        case 'TBODY':
          div.innerHTML = '<table><tbody>' +  html.stripScripts() + '</tbody></table>';
          depth = 2;
          break;
        case 'TR':
          div.innerHTML = '<table><tbody><tr>' +  html.stripScripts() + '</tr></tbody></table>';
          depth = 3;
          break;
        case 'TD':
          div.innerHTML = '<table><tbody><tr><td>' +  html.stripScripts() + '</td></tr></tbody></table>';
          depth = 4;
      }
      $A(element.childNodes).each(function(node) { element.removeChild(node) });
      depth.times(function() { div = div.firstChild });
      $A(div.childNodes).each(function(node) { element.appendChild(node) });
    } else {
      element.innerHTML = html.stripScripts();
    }
    setTimeout(function() { html.evalScripts() }, 10);
    return element;
  }
}
else if (Prototype.Browser.Gecko) {
  Element.Methods.setOpacity = function(element, value) {
    element = $(element);
    element.style.opacity = (value == 1) ? 0.999999 :
      (value === '') ? '' : (value < 0.00001) ? 0 : value;
    return element;
  };
}

Element._attributeTranslations = {
  names: {
    colspan:   "colSpan",
    rowspan:   "rowSpan",
    valign:    "vAlign",
    datetime:  "dateTime",
    accesskey: "accessKey",
    tabindex:  "tabIndex",
    enctype:   "encType",
    maxlength: "maxLength",
    readonly:  "readOnly",
    longdesc:  "longDesc"
  },
  values: {
    _getAttr: function(element, attribute) {
      return element.getAttribute(attribute, 2);
    },
    _flag: function(element, attribute) {
      return $(element).hasAttribute(attribute) ? attribute : null;
    },
    style: function(element) {
      return element.style.cssText.toLowerCase();
    },
    title: function(element) {
      var node = element.getAttributeNode('title');
      return node.specified ? node.nodeValue : null;
    }
  }
};

(function() {
  Object.extend(this, {
    href: this._getAttr,
    src:  this._getAttr,
    type: this._getAttr,
    disabled: this._flag,
    checked:  this._flag,
    readonly: this._flag,
    multiple: this._flag
  });
}).call(Element._attributeTranslations.values);

Element.Methods.Simulated = {
  hasAttribute: function(element, attribute) {
    var t = Element._attributeTranslations, node;
    attribute = t.names[attribute] || attribute;
    node = $(element).getAttributeNode(attribute);
    return node && node.specified;
  }
};

Element.Methods.ByTag = {};

Object.extend(Element, Element.Methods);

if (!Prototype.BrowserFeatures.ElementExtensions &&
 document.createElement('div').__proto__) {
  window.HTMLElement = {};
  window.HTMLElement.prototype = document.createElement('div').__proto__;
  Prototype.BrowserFeatures.ElementExtensions = true;
}

Element.hasAttribute = function(element, attribute) {
  if (element.hasAttribute) return element.hasAttribute(attribute);
  return Element.Methods.Simulated.hasAttribute(element, attribute);
};

Element.addMethods = function(methods) {
  var F = Prototype.BrowserFeatures, T = Element.Methods.ByTag;

  if (!methods) {
    Object.extend(Form, Form.Methods);
    Object.extend(Form.Element, Form.Element.Methods);
    Object.extend(Element.Methods.ByTag, {
      "FORM":     Object.clone(Form.Methods),
      "INPUT":    Object.clone(Form.Element.Methods),
      "SELECT":   Object.clone(Form.Element.Methods),
      "TEXTAREA": Object.clone(Form.Element.Methods)
    });
  }

  if (arguments.length == 2) {
    var tagName = methods;
    methods = arguments[1];
  }

  if (!tagName) Object.extend(Element.Methods, methods || {});
  else {
    if (tagName.constructor == Array) tagName.each(extend);
    else extend(tagName);
  }

  function extend(tagName) {
    tagName = tagName.toUpperCase();
    if (!Element.Methods.ByTag[tagName])
      Element.Methods.ByTag[tagName] = {};
    Object.extend(Element.Methods.ByTag[tagName], methods);
  }

  function copy(methods, destination, onlyIfAbsent) {
    onlyIfAbsent = onlyIfAbsent || false;
    var cache = Element.extend.cache;
    for (var property in methods) {
      var value = methods[property];
      if (!onlyIfAbsent || !(property in destination))
        destination[property] = cache.findOrStore(value);
    }
  }

  function findDOMClass(tagName) {
    var klass;
    var trans = {
      "OPTGROUP": "OptGroup", "TEXTAREA": "TextArea", "P": "Paragraph",
      "FIELDSET": "FieldSet", "UL": "UList", "OL": "OList", "DL": "DList",
      "DIR": "Directory", "H1": "Heading", "H2": "Heading", "H3": "Heading",
      "H4": "Heading", "H5": "Heading", "H6": "Heading", "Q": "Quote",
      "INS": "Mod", "DEL": "Mod", "A": "Anchor", "IMG": "Image", "CAPTION":
      "TableCaption", "COL": "TableCol", "COLGROUP": "TableCol", "THEAD":
      "TableSection", "TFOOT": "TableSection", "TBODY": "TableSection", "TR":
      "TableRow", "TH": "TableCell", "TD": "TableCell", "FRAMESET":
      "FrameSet", "IFRAME": "IFrame"
    };
    if (trans[tagName]) klass = 'HTML' + trans[tagName] + 'Element';
    if (window[klass]) return window[klass];
    klass = 'HTML' + tagName + 'Element';
    if (window[klass]) return window[klass];
    klass = 'HTML' + tagName.capitalize() + 'Element';
    if (window[klass]) return window[klass];

    window[klass] = {};
    window[klass].prototype = document.createElement(tagName).__proto__;
    return window[klass];
  }

  if (F.ElementExtensions) {
    copy(Element.Methods, HTMLElement.prototype);
    copy(Element.Methods.Simulated, HTMLElement.prototype, true);
  }

  if (F.SpecificElementExtensions) {
    for (var tag in Element.Methods.ByTag) {
      var klass = findDOMClass(tag);
      if (typeof klass == "undefined") continue;
      copy(T[tag], klass.prototype);
    }
  }

  Object.extend(Element, Element.Methods);
  delete Element.ByTag;
};

var Toggle = { display: Element.toggle };

/*--------------------------------------------------------------------------*/

Abstract.Insertion = function(adjacency) {
  this.adjacency = adjacency;
}

Abstract.Insertion.prototype = {
  initialize: function(element, content) {
    this.element = $(element);
    this.content = content.stripScripts();

    if (this.adjacency && this.element.insertAdjacentHTML) {
      try {
        this.element.insertAdjacentHTML(this.adjacency, this.content);
      } catch (e) {
        var tagName = this.element.tagName.toUpperCase();
        if (['TBODY', 'TR'].include(tagName)) {
          this.insertContent(this.contentFromAnonymousTable());
        } else {
          throw e;
        }
      }
    } else {
      this.range = this.element.ownerDocument.createRange();
      if (this.initializeRange) this.initializeRange();
      this.insertContent([this.range.createContextualFragment(this.content)]);
    }

    setTimeout(function() {content.evalScripts()}, 10);
  },

  contentFromAnonymousTable: function() {
    var div = document.createElement('div');
    div.innerHTML = '<table><tbody>' + this.content + '</tbody></table>';
    return $A(div.childNodes[0].childNodes[0].childNodes);
  }
}

var Insertion = new Object();

Insertion.Before = Class.create();
Insertion.Before.prototype = Object.extend(new Abstract.Insertion('beforeBegin'), {
  initializeRange: function() {
    this.range.setStartBefore(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.parentNode.insertBefore(fragment, this.element);
    }).bind(this));
  }
});

Insertion.Top = Class.create();
Insertion.Top.prototype = Object.extend(new Abstract.Insertion('afterBegin'), {
  initializeRange: function() {
    this.range.selectNodeContents(this.element);
    this.range.collapse(true);
  },

  insertContent: function(fragments) {
    fragments.reverse(false).each((function(fragment) {
      this.element.insertBefore(fragment, this.element.firstChild);
    }).bind(this));
  }
});

Insertion.Bottom = Class.create();
Insertion.Bottom.prototype = Object.extend(new Abstract.Insertion('beforeEnd'), {
  initializeRange: function() {
    this.range.selectNodeContents(this.element);
    this.range.collapse(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.appendChild(fragment);
    }).bind(this));
  }
});

Insertion.After = Class.create();
Insertion.After.prototype = Object.extend(new Abstract.Insertion('afterEnd'), {
  initializeRange: function() {
    this.range.setStartAfter(this.element);
  },

  insertContent: function(fragments) {
    fragments.each((function(fragment) {
      this.element.parentNode.insertBefore(fragment,
        this.element.nextSibling);
    }).bind(this));
  }
});

/*--------------------------------------------------------------------------*/

Element.ClassNames = Class.create();
Element.ClassNames.prototype = {
  initialize: function(element) {
    this.element = $(element);
  },

  _each: function(iterator) {
    this.element.className.split(/\s+/).select(function(name) {
      return name.length > 0;
    })._each(iterator);
  },

  set: function(className) {
    this.element.className = className;
  },

  add: function(classNameToAdd) {
    if (this.include(classNameToAdd)) return;
    this.set($A(this).concat(classNameToAdd).join(' '));
  },

  remove: function(classNameToRemove) {
    if (!this.include(classNameToRemove)) return;
    this.set($A(this).without(classNameToRemove).join(' '));
  },

  toString: function() {
    return $A(this).join(' ');
  }
};

Object.extend(Element.ClassNames.prototype, Enumerable);
/* Portions of the Selector class are derived from Jack Slocum’s DomQuery,
 * part of YUI-Ext version 0.40, distributed under the terms of an MIT-style
 * license.  Please see http://www.yui-ext.com/ for more information. */

var Selector = Class.create();

Selector.prototype = {
  initialize: function(expression) {
    this.expression = expression.strip();
    this.compileMatcher();
  },

  compileMatcher: function() {
    // Selectors with namespaced attributes can't use the XPath version
    if (Prototype.BrowserFeatures.XPath && !(/\[[\w-]*?:/).test(this.expression))
      return this.compileXPathMatcher();

    var e = this.expression, ps = Selector.patterns, h = Selector.handlers,
        c = Selector.criteria, le, p, m;

    if (Selector._cache[e]) {
      this.matcher = Selector._cache[e]; return;
    }
    this.matcher = ["this.matcher = function(root) {",
                    "var r = root, h = Selector.handlers, c = false, n;"];

    while (e && le != e && (/\S/).test(e)) {
      le = e;
      for (var i in ps) {
        p = ps[i];
        if (m = e.match(p)) {
          this.matcher.push(typeof c[i] == 'function' ? c[i](m) :
    	      new Template(c[i]).evaluate(m));
          e = e.replace(m[0], '');
          break;
        }
      }
    }

    this.matcher.push("return h.unique(n);\n}");
    eval(this.matcher.join('\n'));
    Selector._cache[this.expression] = this.matcher;
  },

  compileXPathMatcher: function() {
    var e = this.expression, ps = Selector.patterns,
        x = Selector.xpath, le,  m;

    if (Selector._cache[e]) {
      this.xpath = Selector._cache[e]; return;
    }

    this.matcher = ['.//*'];
    while (e && le != e && (/\S/).test(e)) {
      le = e;
      for (var i in ps) {
        if (m = e.match(ps[i])) {
          this.matcher.push(typeof x[i] == 'function' ? x[i](m) :
            new Template(x[i]).evaluate(m));
          e = e.replace(m[0], '');
          break;
        }
      }
    }

    this.xpath = this.matcher.join('');
    Selector._cache[this.expression] = this.xpath;
  },

  findElements: function(root) {
    root = root || document;
    if (this.xpath) return document._getElementsByXPath(this.xpath, root);
    return this.matcher(root);
  },

  match: function(element) {
    return this.findElements(document).include(element);
  },

  toString: function() {
    return this.expression;
  },

  inspect: function() {
    return "#<Selector:" + this.expression.inspect() + ">";
  }
};

Object.extend(Selector, {
  _cache: {},

  xpath: {
    descendant:   "//*",
    child:        "/*",
    adjacent:     "/following-sibling::*[1]",
    laterSibling: '/following-sibling::*',
    tagName:      function(m) {
      if (m[1] == '*') return '';
      return "[local-name()='" + m[1].toLowerCase() +
             "' or local-name()='" + m[1].toUpperCase() + "']";
    },
    className:    "[contains(concat(' ', @class, ' '), ' #{1} ')]",
    id:           "[@id='#{1}']",
    attrPresence: "[@#{1}]",
    attr: function(m) {
      m[3] = m[5] || m[6];
      return new Template(Selector.xpath.operators[m[2]]).evaluate(m);
    },
    pseudo: function(m) {
      var h = Selector.xpath.pseudos[m[1]];
      if (!h) return '';
      if (typeof h === 'function') return h(m);
      return new Template(Selector.xpath.pseudos[m[1]]).evaluate(m);
    },
    operators: {
      '=':  "[@#{1}='#{3}']",
      '!=': "[@#{1}!='#{3}']",
      '^=': "[starts-with(@#{1}, '#{3}')]",
      '$=': "[substring(@#{1}, (string-length(@#{1}) - string-length('#{3}') + 1))='#{3}']",
      '*=': "[contains(@#{1}, '#{3}')]",
      '~=': "[contains(concat(' ', @#{1}, ' '), ' #{3} ')]",
      '|=': "[contains(concat('-', @#{1}, '-'), '-#{3}-')]"
    },
    pseudos: {
      'first-child': '[not(preceding-sibling::*)]',
      'last-child':  '[not(following-sibling::*)]',
      'only-child':  '[not(preceding-sibling::* or following-sibling::*)]',
      'empty':       "[count(*) = 0 and (count(text()) = 0 or translate(text(), ' \t\r\n', '') = '')]",
      'checked':     "[@checked]",
      'disabled':    "[@disabled]",
      'enabled':     "[not(@disabled)]",
      'not': function(m) {
        var e = m[6], p = Selector.patterns,
            x = Selector.xpath, le, m, v;

        var exclusion = [];
        while (e && le != e && (/\S/).test(e)) {
          le = e;
          for (var i in p) {
            if (m = e.match(p[i])) {
              v = typeof x[i] == 'function' ? x[i](m) : new Template(x[i]).evaluate(m);
              exclusion.push("(" + v.substring(1, v.length - 1) + ")");
              e = e.replace(m[0], '');
              break;
            }
          }
        }
        return "[not(" + exclusion.join(" and ") + ")]";
      },
      'nth-child':      function(m) {
        return Selector.xpath.pseudos.nth("(count(./preceding-sibling::*) + 1) ", m);
      },
      'nth-last-child': function(m) {
        return Selector.xpath.pseudos.nth("(count(./following-sibling::*) + 1) ", m);
      },
      'nth-of-type':    function(m) {
        return Selector.xpath.pseudos.nth("position() ", m);
      },
      'nth-last-of-type': function(m) {
        return Selector.xpath.pseudos.nth("(last() + 1 - position()) ", m);
      },
      'first-of-type':  function(m) {
        m[6] = "1"; return Selector.xpath.pseudos['nth-of-type'](m);
      },
      'last-of-type':   function(m) {
        m[6] = "1"; return Selector.xpath.pseudos['nth-last-of-type'](m);
      },
      'only-of-type':   function(m) {
        var p = Selector.xpath.pseudos; return p['first-of-type'](m) + p['last-of-type'](m);
      },
      nth: function(fragment, m) {
        var mm, formula = m[6], predicate;
        if (formula == 'even') formula = '2n+0';
        if (formula == 'odd')  formula = '2n+1';
        if (mm = formula.match(/^(\d+)$/)) // digit only
          return '[' + fragment + "= " + mm[1] + ']';
        if (mm = formula.match(/^(-?\d*)?n(([+-])(\d+))?/)) { // an+b
          if (mm[1] == "-") mm[1] = -1;
          var a = mm[1] ? Number(mm[1]) : 1;
          var b = mm[2] ? Number(mm[2]) : 0;
          predicate = "[((#{fragment} - #{b}) mod #{a} = 0) and " +
          "((#{fragment} - #{b}) div #{a} >= 0)]";
          return new Template(predicate).evaluate({
            fragment: fragment, a: a, b: b });
        }
      }
    }
  },

  criteria: {
    tagName:      'n = h.tagName(n, r, "#{1}", c);   c = false;',
    className:    'n = h.className(n, r, "#{1}", c); c = false;',
    id:           'n = h.id(n, r, "#{1}", c);        c = false;',
    attrPresence: 'n = h.attrPresence(n, r, "#{1}"); c = false;',
    attr: function(m) {
      m[3] = (m[5] || m[6]);
      return new Template('n = h.attr(n, r, "#{1}", "#{3}", "#{2}"); c = false;').evaluate(m);
    },
    pseudo:       function(m) {
      if (m[6]) m[6] = m[6].replace(/"/g, '\\"');
      return new Template('n = h.pseudo(n, "#{1}", "#{6}", r, c); c = false;').evaluate(m);
    },
    descendant:   'c = "descendant";',
    child:        'c = "child";',
    adjacent:     'c = "adjacent";',
    laterSibling: 'c = "laterSibling";'
  },

  patterns: {
    // combinators must be listed first
    // (and descendant needs to be last combinator)
    laterSibling: /^\s*~\s*/,
    child:        /^\s*>\s*/,
    adjacent:     /^\s*\+\s*/,
    descendant:   /^\s/,

    // selectors follow
    tagName:      /^\s*(\*|[\w\-]+)(\b|$)?/,
    id:           /^#([\w\-\*]+)(\b|$)/,
    className:    /^\.([\w\-\*]+)(\b|$)/,
    pseudo:       /^:((first|last|nth|nth-last|only)(-child|-of-type)|empty|checked|(en|dis)abled|not)(\((.*?)\))?(\b|$|\s|(?=:))/,
    attrPresence: /^\[([\w]+)\]/,
    attr:         /\[((?:[\w-]*:)?[\w-]+)\s*(?:([!^$*~|]?=)\s*((['"])([^\]]*?)\4|([^'"][^\]]*?)))?\]/
  },

  handlers: {
    // UTILITY FUNCTIONS
    // joins two collections
    concat: function(a, b) {
      for (var i = 0, node; node = b[i]; i++)
        a.push(node);
      return a;
    },

    // marks an array of nodes for counting
    mark: function(nodes) {
      for (var i = 0, node; node = nodes[i]; i++)
        node._counted = true;
      return nodes;
    },

    unmark: function(nodes) {
      for (var i = 0, node; node = nodes[i]; i++)
        node._counted = undefined;
      return nodes;
    },

    // mark each child node with its position (for nth calls)
    // "ofType" flag indicates whether we're indexing for nth-of-type
    // rather than nth-child
    index: function(parentNode, reverse, ofType) {
      parentNode._counted = true;
      if (reverse) {
        for (var nodes = parentNode.childNodes, i = nodes.length - 1, j = 1; i >= 0; i--) {
          node = nodes[i];
          if (node.nodeType == 1 && (!ofType || node._counted)) node.nodeIndex = j++;
        }
      } else {
        for (var i = 0, j = 1, nodes = parentNode.childNodes; node = nodes[i]; i++)
          if (node.nodeType == 1 && (!ofType || node._counted)) node.nodeIndex = j++;
      }
    },

    // filters out duplicates and extends all nodes
    unique: function(nodes) {
      if (nodes.length == 0) return nodes;
      var results = [], n;
      for (var i = 0, l = nodes.length; i < l; i++)
        if (!(n = nodes[i])._counted) {
          n._counted = true;
          results.push(Element.extend(n));
        }
      return Selector.handlers.unmark(results);
    },

    // COMBINATOR FUNCTIONS
    descendant: function(nodes) {
      var h = Selector.handlers;
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        h.concat(results, node.getElementsByTagName('*'));
      return results;
    },

    child: function(nodes) {
      var h = Selector.handlers;
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        for (var j = 0, children = [], child; child = node.childNodes[j]; j++)
          if (child.nodeType == 1 && child.tagName != '!') results.push(child);
      }
      return results;
    },

    adjacent: function(nodes) {
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        var next = this.nextElementSibling(node);
        if (next) results.push(next);
      }
      return results;
    },

    laterSibling: function(nodes) {
      var h = Selector.handlers;
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        h.concat(results, Element.nextSiblings(node));
      return results;
    },

    nextElementSibling: function(node) {
      while (node = node.nextSibling)
	      if (node.nodeType == 1) return node;
      return null;
    },

    previousElementSibling: function(node) {
      while (node = node.previousSibling)
        if (node.nodeType == 1) return node;
      return null;
    },

    // TOKEN FUNCTIONS
    tagName: function(nodes, root, tagName, combinator) {
      tagName = tagName.toUpperCase();
      var results = [], h = Selector.handlers;
      if (nodes) {
        if (combinator) {
          // fastlane for ordinary descendant combinators
          if (combinator == "descendant") {
            for (var i = 0, node; node = nodes[i]; i++)
              h.concat(results, node.getElementsByTagName(tagName));
            return results;
          } else nodes = this[combinator](nodes);
          if (tagName == "*") return nodes;
        }
        for (var i = 0, node; node = nodes[i]; i++)
          if (node.tagName.toUpperCase() == tagName) results.push(node);
        return results;
      } else return root.getElementsByTagName(tagName);
    },

    id: function(nodes, root, id, combinator) {
      var targetNode = $(id), h = Selector.handlers;
      if (!nodes && root == document) return targetNode ? [targetNode] : [];
      if (nodes) {
        if (combinator) {
          if (combinator == 'child') {
            for (var i = 0, node; node = nodes[i]; i++)
              if (targetNode.parentNode == node) return [targetNode];
          } else if (combinator == 'descendant') {
            for (var i = 0, node; node = nodes[i]; i++)
              if (Element.descendantOf(targetNode, node)) return [targetNode];
          } else if (combinator == 'adjacent') {
            for (var i = 0, node; node = nodes[i]; i++)
              if (Selector.handlers.previousElementSibling(targetNode) == node)
                return [targetNode];
          } else nodes = h[combinator](nodes);
        }
        for (var i = 0, node; node = nodes[i]; i++)
          if (node == targetNode) return [targetNode];
        return [];
      }
      return (targetNode && Element.descendantOf(targetNode, root)) ? [targetNode] : [];
    },

    className: function(nodes, root, className, combinator) {
      if (nodes && combinator) nodes = this[combinator](nodes);
      return Selector.handlers.byClassName(nodes, root, className);
    },

    byClassName: function(nodes, root, className) {
      if (!nodes) nodes = Selector.handlers.descendant([root]);
      var needle = ' ' + className + ' ';
      for (var i = 0, results = [], node, nodeClassName; node = nodes[i]; i++) {
        nodeClassName = node.className;
        if (nodeClassName.length == 0) continue;
        if (nodeClassName == className || (' ' + nodeClassName + ' ').include(needle))
          results.push(node);
      }
      return results;
    },

    attrPresence: function(nodes, root, attr) {
      var results = [];
      for (var i = 0, node; node = nodes[i]; i++)
        if (Element.hasAttribute(node, attr)) results.push(node);
      return results;
    },

    attr: function(nodes, root, attr, value, operator) {
      if (!nodes) nodes = root.getElementsByTagName("*");
      var handler = Selector.operators[operator], results = [];
      for (var i = 0, node; node = nodes[i]; i++) {
        var nodeValue = Element.readAttribute(node, attr);
        if (nodeValue === null) continue;
        if (handler(nodeValue, value)) results.push(node);
      }
      return results;
    },

    pseudo: function(nodes, name, value, root, combinator) {
      if (nodes && combinator) nodes = this[combinator](nodes);
      if (!nodes) nodes = root.getElementsByTagName("*");
      return Selector.pseudos[name](nodes, value, root);
    }
  },

  pseudos: {
    'first-child': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        if (Selector.handlers.previousElementSibling(node)) continue;
          results.push(node);
      }
      return results;
    },
    'last-child': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        if (Selector.handlers.nextElementSibling(node)) continue;
          results.push(node);
      }
      return results;
    },
    'only-child': function(nodes, value, root) {
      var h = Selector.handlers;
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (!h.previousElementSibling(node) && !h.nextElementSibling(node))
          results.push(node);
      return results;
    },
    'nth-child':        function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, formula, root);
    },
    'nth-last-child':   function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, formula, root, true);
    },
    'nth-of-type':      function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, formula, root, false, true);
    },
    'nth-last-of-type': function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, formula, root, true, true);
    },
    'first-of-type':    function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, "1", root, false, true);
    },
    'last-of-type':     function(nodes, formula, root) {
      return Selector.pseudos.nth(nodes, "1", root, true, true);
    },
    'only-of-type':     function(nodes, formula, root) {
      var p = Selector.pseudos;
      return p['last-of-type'](p['first-of-type'](nodes, formula, root), formula, root);
    },

    // handles the an+b logic
    getIndices: function(a, b, total) {
      if (a == 0) return b > 0 ? [b] : [];
      return $R(1, total).inject([], function(memo, i) {
        if (0 == (i - b) % a && (i - b) / a >= 0) memo.push(i);
        return memo;
      });
    },

    // handles nth(-last)-child, nth(-last)-of-type, and (first|last)-of-type
    nth: function(nodes, formula, root, reverse, ofType) {
      if (nodes.length == 0) return [];
      if (formula == 'even') formula = '2n+0';
      if (formula == 'odd')  formula = '2n+1';
      var h = Selector.handlers, results = [], indexed = [], m;
      h.mark(nodes);
      for (var i = 0, node; node = nodes[i]; i++) {
        if (!node.parentNode._counted) {
          h.index(node.parentNode, reverse, ofType);
          indexed.push(node.parentNode);
        }
      }
      if (formula.match(/^\d+$/)) { // just a number
        formula = Number(formula);
        for (var i = 0, node; node = nodes[i]; i++)
          if (node.nodeIndex == formula) results.push(node);
      } else if (m = formula.match(/^(-?\d*)?n(([+-])(\d+))?/)) { // an+b
        if (m[1] == "-") m[1] = -1;
        var a = m[1] ? Number(m[1]) : 1;
        var b = m[2] ? Number(m[2]) : 0;
        var indices = Selector.pseudos.getIndices(a, b, nodes.length);
        for (var i = 0, node, l = indices.length; node = nodes[i]; i++) {
          for (var j = 0; j < l; j++)
            if (node.nodeIndex == indices[j]) results.push(node);
        }
      }
      h.unmark(nodes);
      h.unmark(indexed);
      return results;
    },

    'empty': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++) {
        // IE treats comments as element nodes
        if (node.tagName == '!' || (node.firstChild && !node.innerHTML.match(/^\s*$/))) continue;
        results.push(node);
      }
      return results;
    },

    'not': function(nodes, selector, root) {
      var h = Selector.handlers, selectorType, m;
      var exclusions = new Selector(selector).findElements(root);
      h.mark(exclusions);
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (!node._counted) results.push(node);
      h.unmark(exclusions);
      return results;
    },

    'enabled': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (!node.disabled) results.push(node);
      return results;
    },

    'disabled': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (node.disabled) results.push(node);
      return results;
    },

    'checked': function(nodes, value, root) {
      for (var i = 0, results = [], node; node = nodes[i]; i++)
        if (node.checked) results.push(node);
      return results;
    }
  },

  operators: {
    '=':  function(nv, v) { return nv == v; },
    '!=': function(nv, v) { return nv != v; },
    '^=': function(nv, v) { return nv.startsWith(v); },
    '$=': function(nv, v) { return nv.endsWith(v); },
    '*=': function(nv, v) { return nv.include(v); },
    '~=': function(nv, v) { return (' ' + nv + ' ').include(' ' + v + ' '); },
    '|=': function(nv, v) { return ('-' + nv.toUpperCase() + '-').include('-' + v.toUpperCase() + '-'); }
  },

  matchElements: function(elements, expression) {
    var matches = new Selector(expression).findElements(), h = Selector.handlers;
    h.mark(matches);
    for (var i = 0, results = [], element; element = elements[i]; i++)
      if (element._counted) results.push(element);
    h.unmark(matches);
    return results;
  },

  findElement: function(elements, expression, index) {
    if (typeof expression == 'number') {
      index = expression; expression = false;
    }
    return Selector.matchElements(elements, expression || '*')[index || 0];
  },

  findChildElements: function(element, expressions) {
    var exprs = expressions.join(','), expressions = [];
    exprs.scan(/(([\w#:.~>+()\s-]+|\*|\[.*?\])+)\s*(,|$)/, function(m) {
      expressions.push(m[1].strip());
    });
    var results = [], h = Selector.handlers;
    for (var i = 0, l = expressions.length, selector; i < l; i++) {
      selector = new Selector(expressions[i].strip());
      h.concat(results, selector.findElements(element));
    }
    return (l > 1) ? h.unique(results) : results;
  }
});

function $$() {
  return Selector.findChildElements(document, $A(arguments));
}
var Form = {
  reset: function(form) {
    $(form).reset();
    return form;
  },

  serializeElements: function(elements, getHash) {
    var data = elements.inject({}, function(result, element) {
      if (!element.disabled && element.name) {
        var key = element.name, value = $(element).getValue();
        if (value != null) {
         	if (key in result) {
            if (result[key].constructor != Array) result[key] = [result[key]];
            result[key].push(value);
          }
          else result[key] = value;
        }
      }
      return result;
    });

    return getHash ? data : Hash.toQueryString(data);
  }
};

Form.Methods = {
  serialize: function(form, getHash) {
    return Form.serializeElements(Form.getElements(form), getHash);
  },

  getElements: function(form) {
    return $A($(form).getElementsByTagName('*')).inject([],
      function(elements, child) {
        if (Form.Element.Serializers[child.tagName.toLowerCase()])
          elements.push(Element.extend(child));
        return elements;
      }
    );
  },

  getInputs: function(form, typeName, name) {
    form = $(form);
    var inputs = form.getElementsByTagName('input');

    if (!typeName && !name) return $A(inputs).map(Element.extend);

    for (var i = 0, matchingInputs = [], length = inputs.length; i < length; i++) {
      var input = inputs[i];
      if ((typeName && input.type != typeName) || (name && input.name != name))
        continue;
      matchingInputs.push(Element.extend(input));
    }

    return matchingInputs;
  },

  disable: function(form) {
    form = $(form);
    Form.getElements(form).invoke('disable');
    return form;
  },

  enable: function(form) {
    form = $(form);
    Form.getElements(form).invoke('enable');
    return form;
  },

  findFirstElement: function(form) {
    return $(form).getElements().find(function(element) {
      return element.type != 'hidden' && !element.disabled &&
        ['input', 'select', 'textarea'].include(element.tagName.toLowerCase());
    });
  },

  focusFirstElement: function(form) {
    form = $(form);
    form.findFirstElement().activate();
    return form;
  },

  request: function(form, options) {
    form = $(form), options = Object.clone(options || {});

    var params = options.parameters;
    options.parameters = form.serialize(true);

    if (params) {
      if (typeof params == 'string') params = params.toQueryParams();
      Object.extend(options.parameters, params);
    }

    if (form.hasAttribute('method') && !options.method)
      options.method = form.method;

    return new Ajax.Request(form.readAttribute('action'), options);
  }
}

/*--------------------------------------------------------------------------*/

Form.Element = {
  focus: function(element) {
    $(element).focus();
    return element;
  },

  select: function(element) {
    $(element).select();
    return element;
  }
}

Form.Element.Methods = {
  serialize: function(element) {
    element = $(element);
    if (!element.disabled && element.name) {
      var value = element.getValue();
      if (value != undefined) {
        var pair = {};
        pair[element.name] = value;
        return Hash.toQueryString(pair);
      }
    }
    return '';
  },

  getValue: function(element) {
    element = $(element);
    var method = element.tagName.toLowerCase();
    return Form.Element.Serializers[method](element);
  },

  clear: function(element) {
    $(element).value = '';
    return element;
  },

  present: function(element) {
    return $(element).value != '';
  },

  activate: function(element) {
    element = $(element);
    try {
      element.focus();
      if (element.select && (element.tagName.toLowerCase() != 'input' ||
        !['button', 'reset', 'submit'].include(element.type)))
        element.select();
    } catch (e) {}
    return element;
  },

  disable: function(element) {
    element = $(element);
    element.blur();
    element.disabled = true;
    return element;
  },

  enable: function(element) {
    element = $(element);
    element.disabled = false;
    return element;
  }
}

/*--------------------------------------------------------------------------*/

var Field = Form.Element;
var $F = Form.Element.Methods.getValue;

/*--------------------------------------------------------------------------*/

Form.Element.Serializers = {
  input: function(element) {
    switch (element.type.toLowerCase()) {
      case 'checkbox':
      case 'radio':
        return Form.Element.Serializers.inputSelector(element);
      default:
        return Form.Element.Serializers.textarea(element);
    }
  },

  inputSelector: function(element) {
    return element.checked ? element.value : null;
  },

  textarea: function(element) {
    return element.value;
  },

  select: function(element) {
    return this[element.type == 'select-one' ?
      'selectOne' : 'selectMany'](element);
  },

  selectOne: function(element) {
    var index = element.selectedIndex;
    return index >= 0 ? this.optionValue(element.options[index]) : null;
  },

  selectMany: function(element) {
    var values, length = element.length;
    if (!length) return null;

    for (var i = 0, values = []; i < length; i++) {
      var opt = element.options[i];
      if (opt.selected) values.push(this.optionValue(opt));
    }
    return values;
  },

  optionValue: function(opt) {
    // extend element because hasAttribute may not be native
    return Element.extend(opt).hasAttribute('value') ? opt.value : opt.text;
  }
}

/*--------------------------------------------------------------------------*/

Abstract.TimedObserver = function() {}
Abstract.TimedObserver.prototype = {
  initialize: function(element, frequency, callback) {
    this.frequency = frequency;
    this.element   = $(element);
    this.callback  = callback;

    this.lastValue = this.getValue();
    this.registerCallback();
  },

  registerCallback: function() {
    setInterval(this.onTimerEvent.bind(this), this.frequency * 1000);
  },

  onTimerEvent: function() {
    var value = this.getValue();
    var changed = ('string' == typeof this.lastValue && 'string' == typeof value
      ? this.lastValue != value : String(this.lastValue) != String(value));
    if (changed) {
      this.callback(this.element, value);
      this.lastValue = value;
    }
  }
}

Form.Element.Observer = Class.create();
Form.Element.Observer.prototype = Object.extend(new Abstract.TimedObserver(), {
  getValue: function() {
    return Form.Element.getValue(this.element);
  }
});

Form.Observer = Class.create();
Form.Observer.prototype = Object.extend(new Abstract.TimedObserver(), {
  getValue: function() {
    return Form.serialize(this.element);
  }
});

/*--------------------------------------------------------------------------*/

Abstract.EventObserver = function() {}
Abstract.EventObserver.prototype = {
  initialize: function(element, callback) {
    this.element  = $(element);
    this.callback = callback;

    this.lastValue = this.getValue();
    if (this.element.tagName.toLowerCase() == 'form')
      this.registerFormCallbacks();
    else
      this.registerCallback(this.element);
  },

  onElementEvent: function() {
    var value = this.getValue();
    if (this.lastValue != value) {
      this.callback(this.element, value);
      this.lastValue = value;
    }
  },

  registerFormCallbacks: function() {
    Form.getElements(this.element).each(this.registerCallback.bind(this));
  },

  registerCallback: function(element) {
    if (element.type) {
      switch (element.type.toLowerCase()) {
        case 'checkbox':
        case 'radio':
          Event.observe(element, 'click', this.onElementEvent.bind(this));
          break;
        default:
          Event.observe(element, 'change', this.onElementEvent.bind(this));
          break;
      }
    }
  }
}

Form.Element.EventObserver = Class.create();
Form.Element.EventObserver.prototype = Object.extend(new Abstract.EventObserver(), {
  getValue: function() {
    return Form.Element.getValue(this.element);
  }
});

Form.EventObserver = Class.create();
Form.EventObserver.prototype = Object.extend(new Abstract.EventObserver(), {
  getValue: function() {
    return Form.serialize(this.element);
  }
});
if (!window.Event) {
  var Event = new Object();
}

Object.extend(Event, {
  KEY_BACKSPACE: 8,
  KEY_TAB:       9,
  KEY_RETURN:   13,
  KEY_ESC:      27,
  KEY_LEFT:     37,
  KEY_UP:       38,
  KEY_RIGHT:    39,
  KEY_DOWN:     40,
  KEY_DELETE:   46,
  KEY_HOME:     36,
  KEY_END:      35,
  KEY_PAGEUP:   33,
  KEY_PAGEDOWN: 34,

  element: function(event) {
    return $(event.target || event.srcElement);
  },

  isLeftClick: function(event) {
    return (((event.which) && (event.which == 1)) ||
            ((event.button) && (event.button == 1)));
  },

  pointerX: function(event) {
    return event.pageX || (event.clientX +
      (document.documentElement.scrollLeft || document.body.scrollLeft));
  },

  pointerY: function(event) {
    return event.pageY || (event.clientY +
      (document.documentElement.scrollTop || document.body.scrollTop));
  },

  stop: function(event) {
    if (event.preventDefault) {
      event.preventDefault();
      event.stopPropagation();
    } else {
      event.returnValue = false;
      event.cancelBubble = true;
    }
  },

  // find the first node with the given tagName, starting from the
  // node the event was triggered on; traverses the DOM upwards
  findElement: function(event, tagName) {
    var element = Event.element(event);
    while (element.parentNode && (!element.tagName ||
        (element.tagName.toUpperCase() != tagName.toUpperCase())))
      element = element.parentNode;
    return element;
  },

  observers: false,

  _observeAndCache: function(element, name, observer, useCapture) {
    if (!this.observers) this.observers = [];
    if (element.addEventListener) {
      this.observers.push([element, name, observer, useCapture]);
      element.addEventListener(name, observer, useCapture);
    } else if (element.attachEvent) {
      this.observers.push([element, name, observer, useCapture]);
      element.attachEvent('on' + name, observer);
    }
  },

  unloadCache: function() {
    if (!Event.observers) return;
    for (var i = 0, length = Event.observers.length; i < length; i++) {
      Event.stopObserving.apply(this, Event.observers[i]);
      Event.observers[i][0] = null;
    }
    Event.observers = false;
  },

  observe: function(element, name, observer, useCapture) {
    element = $(element);
    useCapture = useCapture || false;

    if (name == 'keypress' &&
      (Prototype.Browser.WebKit || element.attachEvent))
      name = 'keydown';

    Event._observeAndCache(element, name, observer, useCapture);
  },

  stopObserving: function(element, name, observer, useCapture) {
    element = $(element);
    useCapture = useCapture || false;

    if (name == 'keypress' &&
        (Prototype.Browser.WebKit || element.attachEvent))
      name = 'keydown';

    if (element.removeEventListener) {
      element.removeEventListener(name, observer, useCapture);
    } else if (element.detachEvent) {
      try {
        element.detachEvent('on' + name, observer);
      } catch (e) {}
    }
  }
});

/* prevent memory leaks in IE */
if (Prototype.Browser.IE)
  Event.observe(window, 'unload', Event.unloadCache, false);
var Position = {
  // set to true if needed, warning: firefox performance problems
  // NOT neeeded for page scrolling, only if draggable contained in
  // scrollable elements
  includeScrollOffsets: false,

  // must be called before calling withinIncludingScrolloffset, every time the
  // page is scrolled
  prepare: function() {
    this.deltaX =  window.pageXOffset
                || document.documentElement.scrollLeft
                || document.body.scrollLeft
                || 0;
    this.deltaY =  window.pageYOffset
                || document.documentElement.scrollTop
                || document.body.scrollTop
                || 0;
  },

  realOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.scrollTop  || 0;
      valueL += element.scrollLeft || 0;
      element = element.parentNode;
    } while (element);
    return [valueL, valueT];
  },

  cumulativeOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      element = element.offsetParent;
    } while (element);
    return [valueL, valueT];
  },

  positionedOffset: function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      element = element.offsetParent;
      if (element) {
        if(element.tagName=='BODY') break;
        var p = Element.getStyle(element, 'position');
        if (p == 'relative' || p == 'absolute') break;
      }
    } while (element);
    return [valueL, valueT];
  },

  offsetParent: function(element) {
    if (element.offsetParent) return element.offsetParent;
    if (element == document.body) return element;

    while ((element = element.parentNode) && element != document.body)
      if (Element.getStyle(element, 'position') != 'static')
        return element;

    return document.body;
  },

  // caches x/y coordinate pair to use with overlap
  within: function(element, x, y) {
    if (this.includeScrollOffsets)
      return this.withinIncludingScrolloffsets(element, x, y);
    this.xcomp = x;
    this.ycomp = y;
    this.offset = this.cumulativeOffset(element);

    return (y >= this.offset[1] &&
            y <  this.offset[1] + element.offsetHeight &&
            x >= this.offset[0] &&
            x <  this.offset[0] + element.offsetWidth);
  },

  withinIncludingScrolloffsets: function(element, x, y) {
    var offsetcache = this.realOffset(element);

    this.xcomp = x + offsetcache[0] - this.deltaX;
    this.ycomp = y + offsetcache[1] - this.deltaY;
    this.offset = this.cumulativeOffset(element);

    return (this.ycomp >= this.offset[1] &&
            this.ycomp <  this.offset[1] + element.offsetHeight &&
            this.xcomp >= this.offset[0] &&
            this.xcomp <  this.offset[0] + element.offsetWidth);
  },

  // within must be called directly before
  overlap: function(mode, element) {
    if (!mode) return 0;
    if (mode == 'vertical')
      return ((this.offset[1] + element.offsetHeight) - this.ycomp) /
        element.offsetHeight;
    if (mode == 'horizontal')
      return ((this.offset[0] + element.offsetWidth) - this.xcomp) /
        element.offsetWidth;
  },

  page: function(forElement) {
    var valueT = 0, valueL = 0;

    var element = forElement;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;

      // Safari fix
      if (element.offsetParent == document.body)
        if (Element.getStyle(element,'position')=='absolute') break;

    } while (element = element.offsetParent);

    element = forElement;
    do {
      if (!window.opera || element.tagName=='BODY') {
        valueT -= element.scrollTop  || 0;
        valueL -= element.scrollLeft || 0;
      }
    } while (element = element.parentNode);

    return [valueL, valueT];
  },

  clone: function(source, target) {
    var options = Object.extend({
      setLeft:    true,
      setTop:     true,
      setWidth:   true,
      setHeight:  true,
      offsetTop:  0,
      offsetLeft: 0
    }, arguments[2] || {})

    // find page position of source
    source = $(source);
    var p = Position.page(source);

    // find coordinate system to use
    target = $(target);
    var delta = [0, 0];
    var parent = null;
    // delta [0,0] will do fine with position: fixed elements,
    // position:absolute needs offsetParent deltas
    if (Element.getStyle(target,'position') == 'absolute') {
      parent = Position.offsetParent(target);
      delta = Position.page(parent);
    }

    // correct by body offsets (fixes Safari)
    if (parent == document.body) {
      delta[0] -= document.body.offsetLeft;
      delta[1] -= document.body.offsetTop;
    }

    // set position
    if(options.setLeft)   target.style.left  = (p[0] - delta[0] + options.offsetLeft) + 'px';
    if(options.setTop)    target.style.top   = (p[1] - delta[1] + options.offsetTop) + 'px';
    if(options.setWidth)  target.style.width = source.offsetWidth + 'px';
    if(options.setHeight) target.style.height = source.offsetHeight + 'px';
  },

  absolutize: function(element) {
    element = $(element);
    if (element.style.position == 'absolute') return;
    Position.prepare();

    var offsets = Position.positionedOffset(element);
    var top     = offsets[1];
    var left    = offsets[0];
    var width   = element.clientWidth;
    var height  = element.clientHeight;

    element._originalLeft   = left - parseFloat(element.style.left  || 0);
    element._originalTop    = top  - parseFloat(element.style.top || 0);
    element._originalWidth  = element.style.width;
    element._originalHeight = element.style.height;

    element.style.position = 'absolute';
    element.style.top    = top + 'px';
    element.style.left   = left + 'px';
    element.style.width  = width + 'px';
    element.style.height = height + 'px';
  },

  relativize: function(element) {
    element = $(element);
    if (element.style.position == 'relative') return;
    Position.prepare();

    element.style.position = 'relative';
    var top  = parseFloat(element.style.top  || 0) - (element._originalTop || 0);
    var left = parseFloat(element.style.left || 0) - (element._originalLeft || 0);

    element.style.top    = top + 'px';
    element.style.left   = left + 'px';
    element.style.height = element._originalHeight;
    element.style.width  = element._originalWidth;
  }
}

// Safari returns margins on body which is incorrect if the child is absolutely
// positioned.  For performance reasons, redefine Position.cumulativeOffset for
// KHTML/WebKit only.
if (Prototype.Browser.WebKit) {
  Position.cumulativeOffset = function(element) {
    var valueT = 0, valueL = 0;
    do {
      valueT += element.offsetTop  || 0;
      valueL += element.offsetLeft || 0;
      if (element.offsetParent == document.body)
        if (Element.getStyle(element, 'position') == 'absolute') break;

      element = element.offsetParent;
    } while (element);

    return [valueL, valueT];
  }
}

Element.addMethods();
// script.aculo.us effects.js v1.7.1_beta3, Fri May 25 17:19:41 +0200 2007

// Copyright (c) 2005-2007 Thomas Fuchs (http://script.aculo.us, http://mir.aculo.us)
// Contributors:
//  Justin Palmer (http://encytemedia.com/)
//  Mark Pilgrim (http://diveintomark.org/)
//  Martin Bialasinki
// 
// script.aculo.us is freely distributable under the terms of an MIT-style license.
// For details, see the script.aculo.us web site: http://script.aculo.us/ 

// converts rgb() and #xxx to #xxxxxx format,  
// returns self (or first argument) if not convertable  
String.prototype.parseColor = function() {  
  var color = '#';
  if(this.slice(0,4) == 'rgb(') {  
    var cols = this.slice(4,this.length-1).split(',');  
    var i=0; do { color += parseInt(cols[i]).toColorPart() } while (++i<3);  
  } else {  
    if(this.slice(0,1) == '#') {  
      if(this.length==4) for(var i=1;i<4;i++) color += (this.charAt(i) + this.charAt(i)).toLowerCase();  
      if(this.length==7) color = this.toLowerCase();  
    }  
  }  
  return(color.length==7 ? color : (arguments[0] || this));  
}

/*--------------------------------------------------------------------------*/

Element.collectTextNodes = function(element) {  
  return $A($(element).childNodes).collect( function(node) {
    return (node.nodeType==3 ? node.nodeValue : 
      (node.hasChildNodes() ? Element.collectTextNodes(node) : ''));
  }).flatten().join('');
}

Element.collectTextNodesIgnoreClass = function(element, className) {  
  return $A($(element).childNodes).collect( function(node) {
    return (node.nodeType==3 ? node.nodeValue : 
      ((node.hasChildNodes() && !Element.hasClassName(node,className)) ? 
        Element.collectTextNodesIgnoreClass(node, className) : ''));
  }).flatten().join('');
}

Element.setContentZoom = function(element, percent) {
  element = $(element);  
  element.setStyle({fontSize: (percent/100) + 'em'});   
  if(Prototype.Browser.WebKit) window.scrollBy(0,0);
  return element;
}

Element.getInlineOpacity = function(element){
  return $(element).style.opacity || '';
}

Element.forceRerendering = function(element) {
  try {
    element = $(element);
    var n = document.createTextNode(' ');
    element.appendChild(n);
    element.removeChild(n);
  } catch(e) { }
};

/*--------------------------------------------------------------------------*/

Array.prototype.call = function() {
  var args = arguments;
  this.each(function(f){ f.apply(this, args) });
}

/*--------------------------------------------------------------------------*/

var Effect = {
  _elementDoesNotExistError: {
    name: 'ElementDoesNotExistError',
    message: 'The specified DOM element does not exist, but is required for this effect to operate'
  },
  tagifyText: function(element) {
    if(typeof Builder == 'undefined')
      throw("Effect.tagifyText requires including script.aculo.us' builder.js library");
      
    var tagifyStyle = 'position:relative';
    if(Prototype.Browser.IE) tagifyStyle += ';zoom:1';
    
    element = $(element);
    $A(element.childNodes).each( function(child) {
      if(child.nodeType==3) {
        child.nodeValue.toArray().each( function(character) {
          element.insertBefore(
            Builder.node('span',{style: tagifyStyle},
              character == ' ' ? String.fromCharCode(160) : character), 
              child);
        });
        Element.remove(child);
      }
    });
  },
  multiple: function(element, effect) {
    var elements;
    if(((typeof element == 'object') || 
        (typeof element == 'function')) && 
       (element.length))
      elements = element;
    else
      elements = $(element).childNodes;
      
    var options = Object.extend({
      speed: 0.1,
      delay: 0.0
    }, arguments[2] || {});
    var masterDelay = options.delay;

    $A(elements).each( function(element, index) {
      new effect(element, Object.extend(options, { delay: index * options.speed + masterDelay }));
    });
  },
  PAIRS: {
    'slide':  ['SlideDown','SlideUp'],
    'blind':  ['BlindDown','BlindUp'],
    'appear': ['Appear','Fade']
  },
  toggle: function(element, effect) {
    element = $(element);
    effect = (effect || 'appear').toLowerCase();
    var options = Object.extend({
      queue: { position:'end', scope:(element.id || 'global'), limit: 1 }
    }, arguments[2] || {});
    Effect[element.visible() ? 
      Effect.PAIRS[effect][1] : Effect.PAIRS[effect][0]](element, options);
  }
};

var Effect2 = Effect; // deprecated

/* ------------- transitions ------------- */

Effect.Transitions = {
  linear: Prototype.K,
  sinoidal: function(pos) {
    return (-Math.cos(pos*Math.PI)/2) + 0.5;
  },
  reverse: function(pos) {
    return 1-pos;
  },
  flicker: function(pos) {
    var pos = ((-Math.cos(pos*Math.PI)/4) + 0.75) + Math.random()/4;
    return (pos > 1 ? 1 : pos);
  },
  wobble: function(pos) {
    return (-Math.cos(pos*Math.PI*(9*pos))/2) + 0.5;
  },
  pulse: function(pos, pulses) { 
    pulses = pulses || 5; 
    return (
      Math.round((pos % (1/pulses)) * pulses) == 0 ? 
            ((pos * pulses * 2) - Math.floor(pos * pulses * 2)) : 
        1 - ((pos * pulses * 2) - Math.floor(pos * pulses * 2))
      );
  },
  none: function(pos) {
    return 0;
  },
  full: function(pos) {
    return 1;
  }
};

/* ------------- core effects ------------- */

Effect.ScopedQueue = Class.create();
Object.extend(Object.extend(Effect.ScopedQueue.prototype, Enumerable), {
  initialize: function() {
    this.effects  = [];
    this.interval = null;    
  },
  _each: function(iterator) {
    this.effects._each(iterator);
  },
  add: function(effect) {
    var timestamp = new Date().getTime();
    
    var position = (typeof effect.options.queue == 'string') ? 
      effect.options.queue : effect.options.queue.position;
    
    switch(position) {
      case 'front':
        // move unstarted effects after this effect  
        this.effects.findAll(function(e){ return e.state=='idle' }).each( function(e) {
            e.startOn  += effect.finishOn;
            e.finishOn += effect.finishOn;
          });
        break;
      case 'with-last':
        timestamp = this.effects.pluck('startOn').max() || timestamp;
        break;
      case 'end':
        // start effect after last queued effect has finished
        timestamp = this.effects.pluck('finishOn').max() || timestamp;
        break;
    }
    
    effect.startOn  += timestamp;
    effect.finishOn += timestamp;

    if(!effect.options.queue.limit || (this.effects.length < effect.options.queue.limit))
      this.effects.push(effect);
    
    if(!this.interval)
      this.interval = setInterval(this.loop.bind(this), 15);
  },
  remove: function(effect) {
    this.effects = this.effects.reject(function(e) { return e==effect });
    if(this.effects.length == 0) {
      clearInterval(this.interval);
      this.interval = null;
    }
  },
  loop: function() {
    var timePos = new Date().getTime();
    for(var i=0, len=this.effects.length;i<len;i++) 
      this.effects[i] && this.effects[i].loop(timePos);
  }
});

Effect.Queues = {
  instances: $H(),
  get: function(queueName) {
    if(typeof queueName != 'string') return queueName;
    
    if(!this.instances[queueName])
      this.instances[queueName] = new Effect.ScopedQueue();
      
    return this.instances[queueName];
  }
}
Effect.Queue = Effect.Queues.get('global');

Effect.DefaultOptions = {
  transition: Effect.Transitions.sinoidal,
  duration:   1.0,   // seconds
  fps:        100,   // 100= assume 66fps max.
  sync:       false, // true for combining
  from:       0.0,
  to:         1.0,
  delay:      0.0,
  queue:      'parallel'
}

Effect.Base = function() {};
Effect.Base.prototype = {
  position: null,
  start: function(options) {
    function codeForEvent(options,eventName){
      return (
        (options[eventName+'Internal'] ? 'this.options.'+eventName+'Internal(this);' : '') +
        (options[eventName] ? 'this.options.'+eventName+'(this);' : '')
      );
    }
    if(options.transition === false) options.transition = Effect.Transitions.linear;
    this.options      = Object.extend(Object.extend({},Effect.DefaultOptions), options || {});
    this.currentFrame = 0;
    this.state        = 'idle';
    this.startOn      = this.options.delay*1000;
    this.finishOn     = this.startOn+(this.options.duration*1000);
    this.fromToDelta  = this.options.to-this.options.from;
    this.totalTime    = this.finishOn-this.startOn;
    this.totalFrames  = this.options.fps*this.options.duration;
    
    eval('this.render = function(pos){ '+
      'if(this.state=="idle"){this.state="running";'+
      codeForEvent(options,'beforeSetup')+
      (this.setup ? 'this.setup();':'')+ 
      codeForEvent(options,'afterSetup')+
      '};if(this.state=="running"){'+
      'pos=this.options.transition(pos)*'+this.fromToDelta+'+'+this.options.from+';'+
      'this.position=pos;'+
      codeForEvent(options,'beforeUpdate')+
      (this.update ? 'this.update(pos);':'')+
      codeForEvent(options,'afterUpdate')+
      '}}');
    
    this.event('beforeStart');
    if(!this.options.sync)
      Effect.Queues.get(typeof this.options.queue == 'string' ? 
        'global' : this.options.queue.scope).add(this);
  },
  loop: function(timePos) {
    if(timePos >= this.startOn) {
      if(timePos >= this.finishOn) {
        this.render(1.0);
        this.cancel();
        this.event('beforeFinish');
        if(this.finish) this.finish(); 
        this.event('afterFinish');
        return;  
      }
      var pos   = (timePos - this.startOn) / this.totalTime,
          frame = Math.round(pos * this.totalFrames);
      if(frame > this.currentFrame) {
        this.render(pos);
        this.currentFrame = frame;
      }
    }
  },
  cancel: function() {
    if(!this.options.sync)
      Effect.Queues.get(typeof this.options.queue == 'string' ? 
        'global' : this.options.queue.scope).remove(this);
    this.state = 'finished';
  },
  event: function(eventName) {
    if(this.options[eventName + 'Internal']) this.options[eventName + 'Internal'](this);
    if(this.options[eventName]) this.options[eventName](this);
  },
  inspect: function() {
    var data = $H();
    for(property in this)
      if(typeof this[property] != 'function') data[property] = this[property];
    return '#<Effect:' + data.inspect() + ',options:' + $H(this.options).inspect() + '>';
  }
}

Effect.Parallel = Class.create();
Object.extend(Object.extend(Effect.Parallel.prototype, Effect.Base.prototype), {
  initialize: function(effects) {
    this.effects = effects || [];
    this.start(arguments[1]);
  },
  update: function(position) {
    this.effects.invoke('render', position);
  },
  finish: function(position) {
    this.effects.each( function(effect) {
      effect.render(1.0);
      effect.cancel();
      effect.event('beforeFinish');
      if(effect.finish) effect.finish(position);
      effect.event('afterFinish');
    });
  }
});

Effect.Event = Class.create();
Object.extend(Object.extend(Effect.Event.prototype, Effect.Base.prototype), {
  initialize: function() {
    var options = Object.extend({
      duration: 0
    }, arguments[0] || {});
    this.start(options);
  },
  update: Prototype.emptyFunction
});

Effect.Opacity = Class.create();
Object.extend(Object.extend(Effect.Opacity.prototype, Effect.Base.prototype), {
  initialize: function(element) {
    this.element = $(element);
    if(!this.element) throw(Effect._elementDoesNotExistError);
    // make this work on IE on elements without 'layout'
    if(Prototype.Browser.IE && (!this.element.currentStyle.hasLayout))
      this.element.setStyle({zoom: 1});
    var options = Object.extend({
      from: this.element.getOpacity() || 0.0,
      to:   1.0
    }, arguments[1] || {});
    this.start(options);
  },
  update: function(position) {
    this.element.setOpacity(position);
  }
});

Effect.Move = Class.create();
Object.extend(Object.extend(Effect.Move.prototype, Effect.Base.prototype), {
  initialize: function(element) {
    this.element = $(element);
    if(!this.element) throw(Effect._elementDoesNotExistError);
    var options = Object.extend({
      x:    0,
      y:    0,
      mode: 'relative'
    }, arguments[1] || {});
    this.start(options);
  },
  setup: function() {
    // Bug in Opera: Opera returns the "real" position of a static element or
    // relative element that does not have top/left explicitly set.
    // ==> Always set top and left for position relative elements in your stylesheets 
    // (to 0 if you do not need them) 
    this.element.makePositioned();
    this.originalLeft = parseFloat(this.element.getStyle('left') || '0');
    this.originalTop  = parseFloat(this.element.getStyle('top')  || '0');
    if(this.options.mode == 'absolute') {
      // absolute movement, so we need to calc deltaX and deltaY
      this.options.x = this.options.x - this.originalLeft;
      this.options.y = this.options.y - this.originalTop;
    }
  },
  update: function(position) {
    this.element.setStyle({
      left: Math.round(this.options.x  * position + this.originalLeft) + 'px',
      top:  Math.round(this.options.y  * position + this.originalTop)  + 'px'
    });
  }
});

// for backwards compatibility
Effect.MoveBy = function(element, toTop, toLeft) {
  return new Effect.Move(element, 
    Object.extend({ x: toLeft, y: toTop }, arguments[3] || {}));
};

Effect.Scale = Class.create();
Object.extend(Object.extend(Effect.Scale.prototype, Effect.Base.prototype), {
  initialize: function(element, percent) {
    this.element = $(element);
    if(!this.element) throw(Effect._elementDoesNotExistError);
    var options = Object.extend({
      scaleX: true,
      scaleY: true,
      scaleContent: true,
      scaleFromCenter: false,
      scaleMode: 'box',        // 'box' or 'contents' or {} with provided values
      scaleFrom: 100.0,
      scaleTo:   percent
    }, arguments[2] || {});
    this.start(options);
  },
  setup: function() {
    this.restoreAfterFinish = this.options.restoreAfterFinish || false;
    this.elementPositioning = this.element.getStyle('position');
    
    this.originalStyle = {};
    ['top','left','width','height','fontSize'].each( function(k) {
      this.originalStyle[k] = this.element.style[k];
    }.bind(this));
      
    this.originalTop  = this.element.offsetTop;
    this.originalLeft = this.element.offsetLeft;
    
    var fontSize = this.element.getStyle('font-size') || '100%';
    ['em','px','%','pt'].each( function(fontSizeType) {
      if(fontSize.indexOf(fontSizeType)>0) {
        this.fontSize     = parseFloat(fontSize);
        this.fontSizeType = fontSizeType;
      }
    }.bind(this));
    
    this.factor = (this.options.scaleTo - this.options.scaleFrom)/100;
    
    this.dims = null;
    if(this.options.scaleMode=='box')
      this.dims = [this.element.offsetHeight, this.element.offsetWidth];
    if(/^content/.test(this.options.scaleMode))
      this.dims = [this.element.scrollHeight, this.element.scrollWidth];
    if(!this.dims)
      this.dims = [this.options.scaleMode.originalHeight,
                   this.options.scaleMode.originalWidth];
  },
  update: function(position) {
    var currentScale = (this.options.scaleFrom/100.0) + (this.factor * position);
    if(this.options.scaleContent && this.fontSize)
      this.element.setStyle({fontSize: this.fontSize * currentScale + this.fontSizeType });
    this.setDimensions(this.dims[0] * currentScale, this.dims[1] * currentScale);
  },
  finish: function(position) {
    if(this.restoreAfterFinish) this.element.setStyle(this.originalStyle);
  },
  setDimensions: function(height, width) {
    var d = {};
    if(this.options.scaleX) d.width = Math.round(width) + 'px';
    if(this.options.scaleY) d.height = Math.round(height) + 'px';
    if(this.options.scaleFromCenter) {
      var topd  = (height - this.dims[0])/2;
      var leftd = (width  - this.dims[1])/2;
      if(this.elementPositioning == 'absolute') {
        if(this.options.scaleY) d.top = this.originalTop-topd + 'px';
        if(this.options.scaleX) d.left = this.originalLeft-leftd + 'px';
      } else {
        if(this.options.scaleY) d.top = -topd + 'px';
        if(this.options.scaleX) d.left = -leftd + 'px';
      }
    }
    this.element.setStyle(d);
  }
});

Effect.Highlight = Class.create();
Object.extend(Object.extend(Effect.Highlight.prototype, Effect.Base.prototype), {
  initialize: function(element) {
    this.element = $(element);
    if(!this.element) throw(Effect._elementDoesNotExistError);
    var options = Object.extend({ startcolor: '#ffff99' }, arguments[1] || {});
    this.start(options);
  },
  setup: function() {
    // Prevent executing on elements not in the layout flow
    if(this.element.getStyle('display')=='none') { this.cancel(); return; }
    // Disable background image during the effect
    this.oldStyle = {};
    if (!this.options.keepBackgroundImage) {
      this.oldStyle.backgroundImage = this.element.getStyle('background-image');
      this.element.setStyle({backgroundImage: 'none'});
    }
    if(!this.options.endcolor)
      this.options.endcolor = this.element.getStyle('background-color').parseColor('#ffffff');
    if(!this.options.restorecolor)
      this.options.restorecolor = this.element.getStyle('background-color');
    // init color calculations
    this._base  = $R(0,2).map(function(i){ return parseInt(this.options.startcolor.slice(i*2+1,i*2+3),16) }.bind(this));
    this._delta = $R(0,2).map(function(i){ return parseInt(this.options.endcolor.slice(i*2+1,i*2+3),16)-this._base[i] }.bind(this));
  },
  update: function(position) {
    this.element.setStyle({backgroundColor: $R(0,2).inject('#',function(m,v,i){
      return m+(Math.round(this._base[i]+(this._delta[i]*position)).toColorPart()); }.bind(this)) });
  },
  finish: function() {
    this.element.setStyle(Object.extend(this.oldStyle, {
      backgroundColor: this.options.restorecolor
    }));
  }
});

Effect.ScrollTo = Class.create();
Object.extend(Object.extend(Effect.ScrollTo.prototype, Effect.Base.prototype), {
  initialize: function(element) {
    this.element = $(element);
    this.start(arguments[1] || {});
  },
  setup: function() {
    Position.prepare();
    var offsets = Position.cumulativeOffset(this.element);
    if(this.options.offset) offsets[1] += this.options.offset;
    var max = window.innerHeight ? 
      window.height - window.innerHeight :
      document.body.scrollHeight - 
        (document.documentElement.clientHeight ? 
          document.documentElement.clientHeight : document.body.clientHeight);
    this.scrollStart = Position.deltaY;
    this.delta = (offsets[1] > max ? max : offsets[1]) - this.scrollStart;
  },
  update: function(position) {
    Position.prepare();
    window.scrollTo(Position.deltaX, 
      this.scrollStart + (position*this.delta));
  }
});

/* ------------- combination effects ------------- */

Effect.Fade = function(element) {
  element = $(element);
  var oldOpacity = element.getInlineOpacity();
  var options = Object.extend({
  from: element.getOpacity() || 1.0,
  to:   0.0,
  afterFinishInternal: function(effect) { 
    if(effect.options.to!=0) return;
    effect.element.hide().setStyle({opacity: oldOpacity}); 
  }}, arguments[1] || {});
  return new Effect.Opacity(element,options);
}

Effect.Appear = function(element) {
  element = $(element);
  var options = Object.extend({
  from: (element.getStyle('display') == 'none' ? 0.0 : element.getOpacity() || 0.0),
  to:   1.0,
  // force Safari to render floated elements properly
  afterFinishInternal: function(effect) {
    effect.element.forceRerendering();
  },
  beforeSetup: function(effect) {
    effect.element.setOpacity(effect.options.from).show(); 
  }}, arguments[1] || {});
  return new Effect.Opacity(element,options);
}

Effect.Puff = function(element) {
  element = $(element);
  var oldStyle = { 
    opacity: element.getInlineOpacity(), 
    position: element.getStyle('position'),
    top:  element.style.top,
    left: element.style.left,
    width: element.style.width,
    height: element.style.height
  };
  return new Effect.Parallel(
   [ new Effect.Scale(element, 200, 
      { sync: true, scaleFromCenter: true, scaleContent: true, restoreAfterFinish: true }), 
     new Effect.Opacity(element, { sync: true, to: 0.0 } ) ], 
     Object.extend({ duration: 1.0, 
      beforeSetupInternal: function(effect) {
        Position.absolutize(effect.effects[0].element)
      },
      afterFinishInternal: function(effect) {
         effect.effects[0].element.hide().setStyle(oldStyle); }
     }, arguments[1] || {})
   );
}

Effect.BlindUp = function(element) {
  element = $(element);
  element.makeClipping();
  return new Effect.Scale(element, 0,
    Object.extend({ scaleContent: false, 
      scaleX: false, 
      restoreAfterFinish: true,
      afterFinishInternal: function(effect) {
        effect.element.hide().undoClipping();
      } 
    }, arguments[1] || {})
  );
}

Effect.BlindDown = function(element) {
  element = $(element);
  var elementDimensions = element.getDimensions();
  return new Effect.Scale(element, 100, Object.extend({ 
    scaleContent: false, 
    scaleX: false,
    scaleFrom: 0,
    scaleMode: {originalHeight: elementDimensions.height, originalWidth: elementDimensions.width},
    restoreAfterFinish: true,
    afterSetup: function(effect) {
      effect.element.makeClipping().setStyle({height: '0px'}).show(); 
    },  
    afterFinishInternal: function(effect) {
      effect.element.undoClipping();
    }
  }, arguments[1] || {}));
}

Effect.SwitchOff = function(element) {
  element = $(element);
  var oldOpacity = element.getInlineOpacity();
  return new Effect.Appear(element, Object.extend({
    duration: 0.4,
    from: 0,
    transition: Effect.Transitions.flicker,
    afterFinishInternal: function(effect) {
      new Effect.Scale(effect.element, 1, { 
        duration: 0.3, scaleFromCenter: true,
        scaleX: false, scaleContent: false, restoreAfterFinish: true,
        beforeSetup: function(effect) { 
          effect.element.makePositioned().makeClipping();
        },
        afterFinishInternal: function(effect) {
          effect.element.hide().undoClipping().undoPositioned().setStyle({opacity: oldOpacity});
        }
      })
    }
  }, arguments[1] || {}));
}

Effect.DropOut = function(element) {
  element = $(element);
  var oldStyle = {
    top: element.getStyle('top'),
    left: element.getStyle('left'),
    opacity: element.getInlineOpacity() };
  return new Effect.Parallel(
    [ new Effect.Move(element, {x: 0, y: 100, sync: true }), 
      new Effect.Opacity(element, { sync: true, to: 0.0 }) ],
    Object.extend(
      { duration: 0.5,
        beforeSetup: function(effect) {
          effect.effects[0].element.makePositioned(); 
        },
        afterFinishInternal: function(effect) {
          effect.effects[0].element.hide().undoPositioned().setStyle(oldStyle);
        } 
      }, arguments[1] || {}));
}

Effect.Shake = function(element) {
  element = $(element);
  var oldStyle = {
    top: element.getStyle('top'),
    left: element.getStyle('left') };
    return new Effect.Move(element, 
      { x:  20, y: 0, duration: 0.05, afterFinishInternal: function(effect) {
    new Effect.Move(effect.element,
      { x: -40, y: 0, duration: 0.1,  afterFinishInternal: function(effect) {
    new Effect.Move(effect.element,
      { x:  40, y: 0, duration: 0.1,  afterFinishInternal: function(effect) {
    new Effect.Move(effect.element,
      { x: -40, y: 0, duration: 0.1,  afterFinishInternal: function(effect) {
    new Effect.Move(effect.element,
      { x:  40, y: 0, duration: 0.1,  afterFinishInternal: function(effect) {
    new Effect.Move(effect.element,
      { x: -20, y: 0, duration: 0.05, afterFinishInternal: function(effect) {
        effect.element.undoPositioned().setStyle(oldStyle);
  }}) }}) }}) }}) }}) }});
}

Effect.SlideDown = function(element) {
  element = $(element).cleanWhitespace();
  // SlideDown need to have the content of the element wrapped in a container element with fixed height!
  var oldInnerBottom = element.down().getStyle('bottom');
  var elementDimensions = element.getDimensions();
  return new Effect.Scale(element, 100, Object.extend({ 
    scaleContent: false, 
    scaleX: false, 
    scaleFrom: window.opera ? 0 : 1,
    scaleMode: {originalHeight: elementDimensions.height, originalWidth: elementDimensions.width},
    restoreAfterFinish: true,
    afterSetup: function(effect) {
      effect.element.makePositioned();
      effect.element.down().makePositioned();
      if(window.opera) effect.element.setStyle({top: ''});
      effect.element.makeClipping().setStyle({height: '0px'}).show(); 
    },
    afterUpdateInternal: function(effect) {
      effect.element.down().setStyle({bottom:
        (effect.dims[0] - effect.element.clientHeight) + 'px' }); 
    },
    afterFinishInternal: function(effect) {
      effect.element.undoClipping().undoPositioned();
      effect.element.down().undoPositioned().setStyle({bottom: oldInnerBottom}); }
    }, arguments[1] || {})
  );
}

Effect.SlideUp = function(element) {
  element = $(element).cleanWhitespace();
  var oldInnerBottom = element.down().getStyle('bottom');
  return new Effect.Scale(element, window.opera ? 0 : 1,
   Object.extend({ scaleContent: false, 
    scaleX: false, 
    scaleMode: 'box',
    scaleFrom: 100,
    restoreAfterFinish: true,
    beforeStartInternal: function(effect) {
      effect.element.makePositioned();
      effect.element.down().makePositioned();
      if(window.opera) effect.element.setStyle({top: ''});
      effect.element.makeClipping().show();
    },  
    afterUpdateInternal: function(effect) {
      effect.element.down().setStyle({bottom:
        (effect.dims[0] - effect.element.clientHeight) + 'px' });
    },
    afterFinishInternal: function(effect) {
      effect.element.hide().undoClipping().undoPositioned().setStyle({bottom: oldInnerBottom});
      effect.element.down().undoPositioned();
    }
   }, arguments[1] || {})
  );
}

// Bug in opera makes the TD containing this element expand for a instance after finish 
Effect.Squish = function(element) {
  return new Effect.Scale(element, window.opera ? 1 : 0, { 
    restoreAfterFinish: true,
    beforeSetup: function(effect) {
      effect.element.makeClipping(); 
    },  
    afterFinishInternal: function(effect) {
      effect.element.hide().undoClipping(); 
    }
  });
}

Effect.Grow = function(element) {
  element = $(element);
  var options = Object.extend({
    direction: 'center',
    moveTransition: Effect.Transitions.sinoidal,
    scaleTransition: Effect.Transitions.sinoidal,
    opacityTransition: Effect.Transitions.full
  }, arguments[1] || {});
  var oldStyle = {
    top: element.style.top,
    left: element.style.left,
    height: element.style.height,
    width: element.style.width,
    opacity: element.getInlineOpacity() };

  var dims = element.getDimensions();    
  var initialMoveX, initialMoveY;
  var moveX, moveY;
  
  switch (options.direction) {
    case 'top-left':
      initialMoveX = initialMoveY = moveX = moveY = 0; 
      break;
    case 'top-right':
      initialMoveX = dims.width;
      initialMoveY = moveY = 0;
      moveX = -dims.width;
      break;
    case 'bottom-left':
      initialMoveX = moveX = 0;
      initialMoveY = dims.height;
      moveY = -dims.height;
      break;
    case 'bottom-right':
      initialMoveX = dims.width;
      initialMoveY = dims.height;
      moveX = -dims.width;
      moveY = -dims.height;
      break;
    case 'center':
      initialMoveX = dims.width / 2;
      initialMoveY = dims.height / 2;
      moveX = -dims.width / 2;
      moveY = -dims.height / 2;
      break;
  }
  
  return new Effect.Move(element, {
    x: initialMoveX,
    y: initialMoveY,
    duration: 0.01, 
    beforeSetup: function(effect) {
      effect.element.hide().makeClipping().makePositioned();
    },
    afterFinishInternal: function(effect) {
      new Effect.Parallel(
        [ new Effect.Opacity(effect.element, { sync: true, to: 1.0, from: 0.0, transition: options.opacityTransition }),
          new Effect.Move(effect.element, { x: moveX, y: moveY, sync: true, transition: options.moveTransition }),
          new Effect.Scale(effect.element, 100, {
            scaleMode: { originalHeight: dims.height, originalWidth: dims.width }, 
            sync: true, scaleFrom: window.opera ? 1 : 0, transition: options.scaleTransition, restoreAfterFinish: true})
        ], Object.extend({
             beforeSetup: function(effect) {
               effect.effects[0].element.setStyle({height: '0px'}).show(); 
             },
             afterFinishInternal: function(effect) {
               effect.effects[0].element.undoClipping().undoPositioned().setStyle(oldStyle); 
             }
           }, options)
      )
    }
  });
}

Effect.Shrink = function(element) {
  element = $(element);
  var options = Object.extend({
    direction: 'center',
    moveTransition: Effect.Transitions.sinoidal,
    scaleTransition: Effect.Transitions.sinoidal,
    opacityTransition: Effect.Transitions.none
  }, arguments[1] || {});
  var oldStyle = {
    top: element.style.top,
    left: element.style.left,
    height: element.style.height,
    width: element.style.width,
    opacity: element.getInlineOpacity() };

  var dims = element.getDimensions();
  var moveX, moveY;
  
  switch (options.direction) {
    case 'top-left':
      moveX = moveY = 0;
      break;
    case 'top-right':
      moveX = dims.width;
      moveY = 0;
      break;
    case 'bottom-left':
      moveX = 0;
      moveY = dims.height;
      break;
    case 'bottom-right':
      moveX = dims.width;
      moveY = dims.height;
      break;
    case 'center':  
      moveX = dims.width / 2;
      moveY = dims.height / 2;
      break;
  }
  
  return new Effect.Parallel(
    [ new Effect.Opacity(element, { sync: true, to: 0.0, from: 1.0, transition: options.opacityTransition }),
      new Effect.Scale(element, window.opera ? 1 : 0, { sync: true, transition: options.scaleTransition, restoreAfterFinish: true}),
      new Effect.Move(element, { x: moveX, y: moveY, sync: true, transition: options.moveTransition })
    ], Object.extend({            
         beforeStartInternal: function(effect) {
           effect.effects[0].element.makePositioned().makeClipping(); 
         },
         afterFinishInternal: function(effect) {
           effect.effects[0].element.hide().undoClipping().undoPositioned().setStyle(oldStyle); }
       }, options)
  );
}

Effect.Pulsate = function(element) {
  element = $(element);
  var options    = arguments[1] || {};
  var oldOpacity = element.getInlineOpacity();
  var transition = options.transition || Effect.Transitions.sinoidal;
  var reverser   = function(pos){ return transition(1-Effect.Transitions.pulse(pos, options.pulses)) };
  reverser.bind(transition);
  return new Effect.Opacity(element, 
    Object.extend(Object.extend({  duration: 2.0, from: 0,
      afterFinishInternal: function(effect) { effect.element.setStyle({opacity: oldOpacity}); }
    }, options), {transition: reverser}));
}

Effect.Fold = function(element) {
  element = $(element);
  var oldStyle = {
    top: element.style.top,
    left: element.style.left,
    width: element.style.width,
    height: element.style.height };
  element.makeClipping();
  return new Effect.Scale(element, 5, Object.extend({   
    scaleContent: false,
    scaleX: false,
    afterFinishInternal: function(effect) {
    new Effect.Scale(element, 1, { 
      scaleContent: false, 
      scaleY: false,
      afterFinishInternal: function(effect) {
        effect.element.hide().undoClipping().setStyle(oldStyle);
      } });
  }}, arguments[1] || {}));
};

Effect.Morph = Class.create();
Object.extend(Object.extend(Effect.Morph.prototype, Effect.Base.prototype), {
  initialize: function(element) {
    this.element = $(element);
    if(!this.element) throw(Effect._elementDoesNotExistError);
    var options = Object.extend({
      style: {}
    }, arguments[1] || {});
    if (typeof options.style == 'string') {
      if(options.style.indexOf(':') == -1) {
        var cssText = '', selector = '.' + options.style;
        $A(document.styleSheets).reverse().each(function(styleSheet) {
          if (styleSheet.cssRules) cssRules = styleSheet.cssRules;
          else if (styleSheet.rules) cssRules = styleSheet.rules;
          $A(cssRules).reverse().each(function(rule) {
            if (selector == rule.selectorText) {
              cssText = rule.style.cssText;
              throw $break;
            }
          });
          if (cssText) throw $break;
        });
        this.style = cssText.parseStyle();
        options.afterFinishInternal = function(effect){
          effect.element.addClassName(effect.options.style);
          effect.transforms.each(function(transform) {
            if(transform.style != 'opacity')
              effect.element.style[transform.style] = '';
          });
        }
      } else this.style = options.style.parseStyle();
    } else this.style = $H(options.style)
    this.start(options);
  },
  setup: function(){
    function parseColor(color){
      if(!color || ['rgba(0, 0, 0, 0)','transparent'].include(color)) color = '#ffffff';
      color = color.parseColor();
      return $R(0,2).map(function(i){
        return parseInt( color.slice(i*2+1,i*2+3), 16 ) 
      });
    }
    this.transforms = this.style.map(function(pair){
      var property = pair[0], value = pair[1], unit = null;

      if(value.parseColor('#zzzzzz') != '#zzzzzz') {
        value = value.parseColor();
        unit  = 'color';
      } else if(property == 'opacity') {
        value = parseFloat(value);
        if(Prototype.Browser.IE && (!this.element.currentStyle.hasLayout))
          this.element.setStyle({zoom: 1});
      } else if(Element.CSS_LENGTH.test(value)) {
          var components = value.match(/^([\+\-]?[0-9\.]+)(.*)$/);
          value = parseFloat(components[1]);
          unit = (components.length == 3) ? components[2] : null;
      }

      var originalValue = this.element.getStyle(property);
      return { 
        style: property.camelize(), 
        originalValue: unit=='color' ? parseColor(originalValue) : parseFloat(originalValue || 0), 
        targetValue: unit=='color' ? parseColor(value) : value,
        unit: unit
      };
    }.bind(this)).reject(function(transform){
      return (
        (transform.originalValue == transform.targetValue) ||
        (
          transform.unit != 'color' &&
          (isNaN(transform.originalValue) || isNaN(transform.targetValue))
        )
      )
    });
  },
  update: function(position) {
    var style = {}, transform, i = this.transforms.length;
    while(i--)
      style[(transform = this.transforms[i]).style] = 
        transform.unit=='color' ? '#'+
          (Math.round(transform.originalValue[0]+
            (transform.targetValue[0]-transform.originalValue[0])*position)).toColorPart() +
          (Math.round(transform.originalValue[1]+
            (transform.targetValue[1]-transform.originalValue[1])*position)).toColorPart() +
          (Math.round(transform.originalValue[2]+
            (transform.targetValue[2]-transform.originalValue[2])*position)).toColorPart() :
        transform.originalValue + Math.round(
          ((transform.targetValue - transform.originalValue) * position) * 1000)/1000 + transform.unit;
    this.element.setStyle(style, true);
  }
});

Effect.Transform = Class.create();
Object.extend(Effect.Transform.prototype, {
  initialize: function(tracks){
    this.tracks  = [];
    this.options = arguments[1] || {};
    this.addTracks(tracks);
  },
  addTracks: function(tracks){
    tracks.each(function(track){
      var data = $H(track).values().first();
      this.tracks.push($H({
        ids:     $H(track).keys().first(),
        effect:  Effect.Morph,
        options: { style: data }
      }));
    }.bind(this));
    return this;
  },
  play: function(){
    return new Effect.Parallel(
      this.tracks.map(function(track){
        var elements = [$(track.ids) || $$(track.ids)].flatten();
        return elements.map(function(e){ return new track.effect(e, Object.extend({ sync:true }, track.options)) });
      }).flatten(),
      this.options
    );
  }
});

Element.CSS_PROPERTIES = $w(
  'backgroundColor backgroundPosition borderBottomColor borderBottomStyle ' + 
  'borderBottomWidth borderLeftColor borderLeftStyle borderLeftWidth ' +
  'borderRightColor borderRightStyle borderRightWidth borderSpacing ' +
  'borderTopColor borderTopStyle borderTopWidth bottom clip color ' +
  'fontSize fontWeight height left letterSpacing lineHeight ' +
  'marginBottom marginLeft marginRight marginTop markerOffset maxHeight '+
  'maxWidth minHeight minWidth opacity outlineColor outlineOffset ' +
  'outlineWidth paddingBottom paddingLeft paddingRight paddingTop ' +
  'right textIndent top width wordSpacing zIndex');
  
Element.CSS_LENGTH = /^(([\+\-]?[0-9\.]+)(em|ex|px|in|cm|mm|pt|pc|\%))|0$/;

String.prototype.parseStyle = function(){
  var element = document.createElement('div');
  element.innerHTML = '<div style="' + this + '"></div>';
  var style = element.childNodes[0].style, styleRules = $H();
  
  Element.CSS_PROPERTIES.each(function(property){
    if(style[property]) styleRules[property] = style[property]; 
  });
  if(Prototype.Browser.IE && this.indexOf('opacity') > -1) {
    styleRules.opacity = this.match(/opacity:\s*((?:0|1)?(?:\.\d*)?)/)[1];
  }
  return styleRules;
};

Element.morph = function(element, style) {
  new Effect.Morph(element, Object.extend({ style: style }, arguments[2] || {}));
  return element;
};

['getInlineOpacity','forceRerendering','setContentZoom',
 'collectTextNodes','collectTextNodesIgnoreClass','morph'].each( 
  function(f) { Element.Methods[f] = Element[f]; }
);

Element.Methods.visualEffect = function(element, effect, options) {
  s = effect.dasherize().camelize();
  effect_class = s.charAt(0).toUpperCase() + s.substring(1);
  new Effect[effect_class](element, options);
  return $(element);
};

Element.addMethods();
// script.aculo.us scriptaculous.js v1.7.1_beta3, Fri May 25 17:19:41 +0200 2007

// Copyright (c) 2005-2007 Thomas Fuchs (http://script.aculo.us, http://mir.aculo.us)
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// For details, see the script.aculo.us web site: http://script.aculo.us/

var Scriptaculous = {
  Version: '1.7.1_beta3',
  require: function(libraryName) {
    // inserting via DOM fails in Safari 2.0, so brute force approach
    document.write('<script type="text/javascript" src="'+libraryName+'"></script>');
  },
  REQUIRED_PROTOTYPE: '1.5.1',
  load: function() {
    function convertVersionString(versionString){
      var r = versionString.split('.');
      return parseInt(r[0])*100000 + parseInt(r[1])*1000 + parseInt(r[2]);
    }
 
    if((typeof Prototype=='undefined') || 
       (typeof Element == 'undefined') || 
       (typeof Element.Methods=='undefined') ||
       (convertVersionString(Prototype.Version) < 
        convertVersionString(Scriptaculous.REQUIRED_PROTOTYPE)))
       throw("script.aculo.us requires the Prototype JavaScript framework >= " +
        Scriptaculous.REQUIRED_PROTOTYPE);
    
    $A(document.getElementsByTagName("script")).findAll( function(s) {
      return (s.src && s.src.match(/scriptaculous\.js(\?.*)?$/))
    }).each( function(s) {
      var path = s.src.replace(/scriptaculous\.js(\?.*)?$/,'');
      var includes = s.src.match(/\?.*load=([a-z,]*)/);
      (includes ? includes[1] : 'builder,effects,dragdrop,controls,slider,sound').split(',').each(
       function(include) { Scriptaculous.require(path+include+'.js') });
    });
  }
}

Scriptaculous.load();
// Copyright (c) 2006 Sébastien Gruhier (http://xilinus.com, http://itseb.com)
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// VERSION 1.3

var Window = Class.create();

Window.keepMultiModalWindow = false;
Window.hasEffectLib = (typeof Effect != 'undefined');
Window.resizeEffectDuration = 0.4;

Window.prototype = {
  // Constructor
  // Available parameters : className, blurClassName, title, minWidth, minHeight, maxWidth, maxHeight, width, height, top, left, bottom, right, resizable, zIndex, opacity, recenterAuto, wiredDrag
  //                        hideEffect, showEffect, showEffectOptions, hideEffectOptions, effectOptions, url, draggable, closable, minimizable, maximizable, parent, onload
  //                        add all callbacks (if you do not use an observer)
  //                        onDestroy onStartResize onStartMove onResize onMove onEndResize onEndMove onFocus onBlur onBeforeShow onShow onHide onMinimize onMaximize onClose
  
  initialize: function() {
    var id;
    var optionIndex = 0;
    // For backward compatibility like win= new Window("id", {...}) instead of win = new Window({id: "id", ...})
    if (arguments.length > 0) {
      if (typeof arguments[0] == "string" ) {
        id = arguments[0];
        optionIndex = 1;
      }
      else
        id = arguments[0] ? arguments[0].id : null;
    }
    
    // Generate unique ID if not specified
    if (!id)
      id = "window_" + new Date().getTime();
      
    if ($(id))
      alert("Window " + id + " is already registered in the DOM! Make sure you use setDestroyOnClose() or destroyOnClose: true in the constructor");

    this.options = Object.extend({
      className:         "dialog",
      blurClassName:     null,
      minWidth:          100, 
      minHeight:         20,
      resizable:         true,
      closable:          true,
      minimizable:       true,
      maximizable:       true,
      draggable:         true,
      userData:          null,
      showEffect:        (Window.hasEffectLib ? Effect.Appear : Element.show),
      hideEffect:        (Window.hasEffectLib ? Effect.Fade : Element.hide),
      showEffectOptions: {},
      hideEffectOptions: {},
      effectOptions:     null,
      parent:            document.body,
      title:             "&nbsp;",
      url:               null,
      onload:            Prototype.emptyFunction,
      width:             200,
      height:            300,
      opacity:           1,
      recenterAuto:      true,
      wiredDrag:         false,
      closeCallback:     null,
      destroyOnClose:    false,
      gridX:             1, 
      gridY:             1      
    }, arguments[optionIndex] || {});
    if (this.options.blurClassName)
      this.options.focusClassName = this.options.className;
      
    if (typeof this.options.top == "undefined" &&  typeof this.options.bottom ==  "undefined") 
      this.options.top = this._round(Math.random()*500, this.options.gridY);
    if (typeof this.options.left == "undefined" &&  typeof this.options.right ==  "undefined") 
      this.options.left = this._round(Math.random()*500, this.options.gridX);

    if (this.options.effectOptions) {
      Object.extend(this.options.hideEffectOptions, this.options.effectOptions);
      Object.extend(this.options.showEffectOptions, this.options.effectOptions);
      if (this.options.showEffect == Element.Appear)
        this.options.showEffectOptions.to = this.options.opacity;
    }
    if (Window.hasEffectLib) {
      if (this.options.showEffect == Effect.Appear)
        this.options.showEffectOptions.to = this.options.opacity;
    
      if (this.options.hideEffect == Effect.Fade)
        this.options.hideEffectOptions.from = this.options.opacity;
    }
    if (this.options.hideEffect == Element.hide)
      this.options.hideEffect = function(){ Element.hide(this.element); if (this.options.destroyOnClose) this.destroy(); }.bind(this)
    
    if (this.options.parent != document.body)  
      this.options.parent = $(this.options.parent);
      
    this.element = this._createWindow(id);       
    this.element.win = this;
    
    // Bind event listener
    this.eventMouseDown = this._initDrag.bindAsEventListener(this);
    this.eventMouseUp   = this._endDrag.bindAsEventListener(this);
    this.eventMouseMove = this._updateDrag.bindAsEventListener(this);
    this.eventOnLoad    = this._getWindowBorderSize.bindAsEventListener(this);
    this.eventMouseDownContent = this.toFront.bindAsEventListener(this);
    this.eventResize = this._recenter.bindAsEventListener(this);
 
    this.topbar = $(this.element.id + "_top");
    this.bottombar = $(this.element.id + "_bottom");
    this.content = $(this.element.id + "_content");
    
    Event.observe(this.topbar, "mousedown", this.eventMouseDown);
    Event.observe(this.bottombar, "mousedown", this.eventMouseDown);
    Event.observe(this.content, "mousedown", this.eventMouseDownContent);
    Event.observe(window, "load", this.eventOnLoad);
    Event.observe(window, "resize", this.eventResize);
    Event.observe(window, "scroll", this.eventResize);
    Event.observe(this.options.parent, "scroll", this.eventResize);
    
    if (this.options.draggable)  {
      var that = this;
      [this.topbar, this.topbar.up().previous(), this.topbar.up().next()].each(function(element) {
        element.observe("mousedown", that.eventMouseDown);
        element.addClassName("top_draggable");
      });
      [this.bottombar.up(), this.bottombar.up().previous(), this.bottombar.up().next()].each(function(element) {
        element.observe("mousedown", that.eventMouseDown);
        element.addClassName("bottom_draggable");
      });
      
    }    
    
    if (this.options.resizable) {
      this.sizer = $(this.element.id + "_sizer");
      Event.observe(this.sizer, "mousedown", this.eventMouseDown);
    }  
    
    this.useLeft = null;
    this.useTop = null;
    if (typeof this.options.left != "undefined") {
      this.element.setStyle({left: parseFloat(this.options.left) + 'px'});
      this.useLeft = true;
    }
    else {
      this.element.setStyle({right: parseFloat(this.options.right) + 'px'});
      this.useLeft = false;
    }
    
    if (typeof this.options.top != "undefined") {
      this.element.setStyle({top: parseFloat(this.options.top) + 'px'});
      this.useTop = true;
    }
    else {
      this.element.setStyle({bottom: parseFloat(this.options.bottom) + 'px'});      
      this.useTop = false;
    }
      
    this.storedLocation = null;
    
    this.setOpacity(this.options.opacity);
    if (this.options.zIndex)
      this.setZIndex(this.options.zIndex)

    if (this.options.destroyOnClose)
      this.setDestroyOnClose(true);

    this._getWindowBorderSize();
    this.width = this.options.width;
    this.height = this.options.height;
    this.visible = false;
    
    this.constraint = false;
    this.constraintPad = {top: 0, left:0, bottom:0, right:0};
    
    if (this.width && this.height)
      this.setSize(this.options.width, this.options.height);
    this.setTitle(this.options.title)
    Windows.register(this);      
  },
  
  // Destructor
  destroy: function() {
    this._notify("onDestroy");
    Event.stopObserving(this.topbar, "mousedown", this.eventMouseDown);
    Event.stopObserving(this.bottombar, "mousedown", this.eventMouseDown);
    Event.stopObserving(this.content, "mousedown", this.eventMouseDownContent);
    
    Event.stopObserving(window, "load", this.eventOnLoad);
    Event.stopObserving(window, "resize", this.eventResize);
    Event.stopObserving(window, "scroll", this.eventResize);
    
    Event.stopObserving(this.content, "load", this.options.onload);

    if (this._oldParent) {
      var content = this.getContent();
      var originalContent = null;
      for(var i = 0; i < content.childNodes.length; i++) {
        originalContent = content.childNodes[i];
        if (originalContent.nodeType == 1) 
          break;
        originalContent = null;
      }
      if (originalContent)
        this._oldParent.appendChild(originalContent);
      this._oldParent = null;
    }

    if (this.sizer)
        Event.stopObserving(this.sizer, "mousedown", this.eventMouseDown);

    if (this.options.url) 
      this.content.src = null

     if(this.iefix) 
      Element.remove(this.iefix);

    Element.remove(this.element);
    Windows.unregister(this);      
  },
    
  // Sets close callback, if it sets, it should return true to be able to close the window.
  setCloseCallback: function(callback) {
    this.options.closeCallback = callback;
  },
  
  // Gets window content
  getContent: function () {
    return this.content;
  },
  
  // Sets the content with an element id
  setContent: function(id, autoresize, autoposition) {
    var element = $(id);
    if (null == element) throw "Unable to find element '" + id + "' in DOM";
    this._oldParent = element.parentNode;

    var d = null;
    var p = null;

    if (autoresize) 
      d = Element.getDimensions(element);
    if (autoposition) 
      p = Position.cumulativeOffset(element);

    var content = this.getContent();
    // Clear HTML (and even iframe)
    this.setHTMLContent("");
    content = this.getContent();
    
    content.appendChild(element);
    element.show();
    if (autoresize) 
      this.setSize(d.width, d.height);
    if (autoposition) 
      this.setLocation(p[1] - this.heightN, p[0] - this.widthW);    
  },
  
  setHTMLContent: function(html) {
    // It was an url (iframe), recreate a div content instead of iframe content
    if (this.options.url) {
      this.content.src = null;
      this.options.url = null;
      
  	  var content ="<div id=\"" + this.getId() + "_content\" class=\"" + this.options.className + "_content\"> </div>";
      $(this.getId() +"_table_content").innerHTML = content;
      
      this.content = $(this.element.id + "_content");
    }
      
    this.getContent().innerHTML = html;
  },
  
  setAjaxContent: function(url, options, showCentered, showModal) {
    this.showFunction = showCentered ? "showCenter" : "show";
    this.showModal = showModal || false;
  
    options = options || {};

    // Clear HTML (and even iframe)
    this.setHTMLContent("");
 
    this.onComplete = options.onComplete;
    if (! this._onCompleteHandler)
      this._onCompleteHandler = this._setAjaxContent.bind(this);
    options.onComplete = this._onCompleteHandler;

    new Ajax.Request(url, options);    
    options.onComplete = this.onComplete;
  },
  
  _setAjaxContent: function(originalRequest) {
    Element.update(this.getContent(), originalRequest.responseText);
    if (this.onComplete)
      this.onComplete(originalRequest);
    this.onComplete = null;
    this[this.showFunction](this.showModal)
  },
  
  setURL: function(url) {
    // Not an url content, change div to iframe
    if (this.options.url) 
      this.content.src = null;
    this.options.url = url;
    var content= "<iframe frameborder='0' name='" + this.getId() + "_content'  id='" + this.getId() + "_content' src='" + url + "' width='" + this.width + "' height='" + this.height + "'> </iframe>";
    $(this.getId() +"_table_content").innerHTML = content;
    
    this.content = $(this.element.id + "_content");
  },

  getURL: function() {
  	return this.options.url ? this.options.url : null;
  },

  refresh: function() {
    if (this.options.url)
	    $(this.element.getAttribute('id') + '_content').src = this.options.url;
  },
  
  // Stores position/size in a cookie, by default named with window id
  setCookie: function(name, expires, path, domain, secure) {
    name = name || this.element.id;
    this.cookie = [name, expires, path, domain, secure];
    
    // Get cookie
    var value = WindowUtilities.getCookie(name)
    // If exists
    if (value) {
      var values = value.split(',');
      var x = values[0].split(':');
      var y = values[1].split(':');

      var w = parseFloat(values[2]), h = parseFloat(values[3]);
      var mini = values[4];
      var maxi = values[5];

      this.setSize(w, h);
      if (mini == "true")
        this.doMinimize = true; // Minimize will be done at onload window event
      else if (maxi == "true")
        this.doMaximize = true; // Maximize will be done at onload window event

      this.useLeft = x[0] == "l";
      this.useTop = y[0] == "t";

      this.element.setStyle(this.useLeft ? {left: x[1]} : {right: x[1]});
      this.element.setStyle(this.useTop ? {top: y[1]} : {bottom: y[1]});
    }
  },
  
  // Gets window ID
  getId: function() {
    return this.element.id;
  },
  
  // Detroys itself when closing 
  setDestroyOnClose: function() {
    this.options.destroyOnClose = true;
  },
  
  setConstraint: function(bool, padding) {
    this.constraint = bool;
    this.constraintPad = Object.extend(this.constraintPad, padding || {});
    // Reset location to apply constraint
    if (this.useTop && this.useLeft)
      this.setLocation(parseFloat(this.element.style.top), parseFloat(this.element.style.left));
  },
  
  // initDrag event

  _initDrag: function(event) {
    // No resize on minimized window
    if (Event.element(event) == this.sizer && this.isMinimized())
      return;

    // No move on maximzed window
    if (Event.element(event) != this.sizer && this.isMaximized())
      return;
      
    if (Prototype.Browser.IE && this.heightN == 0)
      this._getWindowBorderSize();
    
    // Get pointer X,Y
    this.pointer = [this._round(Event.pointerX(event), this.options.gridX), this._round(Event.pointerY(event), this.options.gridY)];
    if (this.options.wiredDrag) 
      this.currentDrag = this._createWiredElement();
    else
      this.currentDrag = this.element;
      
    // Resize
    if (Event.element(event) == this.sizer) {
      this.doResize = true;
      this.widthOrg = this.width;
      this.heightOrg = this.height;
      this.bottomOrg = parseFloat(this.element.getStyle('bottom'));
      this.rightOrg = parseFloat(this.element.getStyle('right'));
      this._notify("onStartResize");
    }
    else {
      this.doResize = false;

      // Check if click on close button, 
      var closeButton = $(this.getId() + '_close');
      if (closeButton && Position.within(closeButton, this.pointer[0], this.pointer[1])) {
        this.currentDrag = null;
        return;
      }

      this.toFront();

      if (! this.options.draggable) 
        return;
      this._notify("onStartMove");
    }    
    // Register global event to capture mouseUp and mouseMove
    Event.observe(document, "mouseup", this.eventMouseUp, false);
    Event.observe(document, "mousemove", this.eventMouseMove, false);
    
    // Add an invisible div to keep catching mouse event over iframes
    WindowUtilities.disableScreen('__invisible__', '__invisible__', this.overlayOpacity);

    // Stop selection while dragging
    document.body.ondrag = function () { return false; };
    document.body.onselectstart = function () { return false; };
    
    this.currentDrag.show();
    Event.stop(event);
  },
  
  _round: function(val, round) {
    return round == 1 ? val  : val = Math.floor(val / round) * round;
  },

  // updateDrag event
  _updateDrag: function(event) {
    var pointer =  [this._round(Event.pointerX(event), this.options.gridX), this._round(Event.pointerY(event), this.options.gridY)];  
    var dx = pointer[0] - this.pointer[0];
    var dy = pointer[1] - this.pointer[1];
    
    // Resize case, update width/height
    if (this.doResize) {
      var w = this.widthOrg + dx;
      var h = this.heightOrg + dy;
      
      dx = this.width - this.widthOrg
      dy = this.height - this.heightOrg
      
      // Check if it's a right position, update it to keep upper-left corner at the same position
      if (this.useLeft) 
        w = this._updateWidthConstraint(w)
      else 
        this.currentDrag.setStyle({right: (this.rightOrg -dx) + 'px'});
      // Check if it's a bottom position, update it to keep upper-left corner at the same position
      if (this.useTop) 
        h = this._updateHeightConstraint(h)
      else
        this.currentDrag.setStyle({bottom: (this.bottomOrg -dy) + 'px'});
        
      this.setSize(w , h);
      this._notify("onResize");
    }
    // Move case, update top/left
    else {
      this.pointer = pointer;
      
      if (this.useLeft) {
        var left =  parseFloat(this.currentDrag.getStyle('left')) + dx;
        var newLeft = this._updateLeftConstraint(left);
        // Keep mouse pointer correct
        this.pointer[0] += newLeft-left;
        this.currentDrag.setStyle({left: newLeft + 'px'});
      }
      else 
        this.currentDrag.setStyle({right: parseFloat(this.currentDrag.getStyle('right')) - dx + 'px'});
      
      if (this.useTop) {
        var top =  parseFloat(this.currentDrag.getStyle('top')) + dy;
        var newTop = this._updateTopConstraint(top);
        // Keep mouse pointer correct
        this.pointer[1] += newTop - top;
        this.currentDrag.setStyle({top: newTop + 'px'});
      }
      else 
        this.currentDrag.setStyle({bottom: parseFloat(this.currentDrag.getStyle('bottom')) - dy + 'px'});

      this._notify("onMove");
    }
    if (this.iefix) 
      this._fixIEOverlapping(); 
      
    this._removeStoreLocation();
    Event.stop(event);
  },

   // endDrag callback
   _endDrag: function(event) {
    // Remove temporary div over iframes
     WindowUtilities.enableScreen('__invisible__');
    
    if (this.doResize)
      this._notify("onEndResize");
    else
      this._notify("onEndMove");
    
    // Release event observing
    Event.stopObserving(document, "mouseup", this.eventMouseUp,false);
    Event.stopObserving(document, "mousemove", this.eventMouseMove, false);

    Event.stop(event);
    
    this._hideWiredElement();

    // Store new location/size if need be
    this._saveCookie()
      
    // Restore selection
    document.body.ondrag = null;
    document.body.onselectstart = null;
  },

  _updateLeftConstraint: function(left) {
    if (this.constraint && this.useLeft && this.useTop) {
      var width = this.options.parent == document.body ? WindowUtilities.getPageSize().windowWidth : this.options.parent.getDimensions().width;

      if (left < this.constraintPad.left)
        left = this.constraintPad.left;
      if (left + this.width + this.widthE + this.widthW > width - this.constraintPad.right) 
        left = width - this.constraintPad.right - this.width - this.widthE - this.widthW;
    }
    return left;
  },
  
  _updateTopConstraint: function(top) {
    if (this.constraint && this.useLeft && this.useTop) {        
      var height = this.options.parent == document.body ? WindowUtilities.getPageSize().windowHeight : this.options.parent.getDimensions().height;
      
      var h = this.height + this.heightN + this.heightS;

      if (top < this.constraintPad.top)
        top = this.constraintPad.top;
      if (top + h > height - this.constraintPad.bottom) 
        top = height - this.constraintPad.bottom - h;
    }
    return top;
  },
  
  _updateWidthConstraint: function(w) {
    if (this.constraint && this.useLeft && this.useTop) {
      var width = this.options.parent == document.body ? WindowUtilities.getPageSize().windowWidth : this.options.parent.getDimensions().width;
      var left =  parseFloat(this.element.getStyle("left"));

      if (left + w + this.widthE + this.widthW > width - this.constraintPad.right) 
        w = width - this.constraintPad.right - left - this.widthE - this.widthW;
    }
    return w;
  },
  
  _updateHeightConstraint: function(h) {
    if (this.constraint && this.useLeft && this.useTop) {
      var height = this.options.parent == document.body ? WindowUtilities.getPageSize().windowHeight : this.options.parent.getDimensions().height;
      var top =  parseFloat(this.element.getStyle("top"));

      if (top + h + this.heightN + this.heightS > height - this.constraintPad.bottom) 
        h = height - this.constraintPad.bottom - top - this.heightN - this.heightS;
    }
    return h;
  },
  
  
  // Creates HTML window code
  _createWindow: function(id) {
    var className = this.options.className;
    var win = document.createElement("div");
    win.setAttribute('id', id);
    win.className = "dialog";

    var content;
    if (this.options.url)
      content= "<iframe frameborder=\"0\" name=\"" + id + "_content\"  id=\"" + id + "_content\" src=\"" + this.options.url + "\"> </iframe>";
    else
      content ="<div id=\"" + id + "_content\" class=\"" +className + "_content\"> </div>";

    var closeDiv = this.options.closable ? "<div class='"+ className +"_close' id='"+ id +"_close' onclick='Windows.close(\""+ id +"\", event)'> </div>" : "";
    var minDiv = this.options.minimizable ? "<div class='"+ className + "_minimize' id='"+ id +"_minimize' onclick='Windows.minimize(\""+ id +"\", event)'> </div>" : "";
    var maxDiv = this.options.maximizable ? "<div class='"+ className + "_maximize' id='"+ id +"_maximize' onclick='Windows.maximize(\""+ id +"\", event)'> </div>" : "";
    var seAttributes = this.options.resizable ? "class='" + className + "_sizer' id='" + id + "_sizer'" : "class='"  + className + "_se'";
    var blank = "../themes/default/blank.gif";
    
    win.innerHTML = closeDiv + minDiv + maxDiv + "\
      <table id='"+ id +"_row1' class=\"top table_window\">\
        <tr>\
          <td class='"+ className +"_nw'></td>\
          <td class='"+ className +"_n'><div id='"+ id +"_top' class='"+ className +"_title title_window'>"+ this.options.title +"</div></td>\
          <td class='"+ className +"_ne'></td>\
        </tr>\
      </table>\
      <table id='"+ id +"_row2' class=\"mid table_window\">\
        <tr>\
          <td class='"+ className +"_w'></td>\
            <td id='"+ id +"_table_content' class='"+ className +"_content' valign='top'>" + content + "</td>\
          <td class='"+ className +"_e'></td>\
        </tr>\
      </table>\
        <table id='"+ id +"_row3' class=\"bot table_window\">\
        <tr>\
          <td class='"+ className +"_sw'></td>\
            <td class='"+ className +"_s'><div id='"+ id +"_bottom' class='status_bar'><span style='float:left; width:1px; height:1px'></span></div></td>\
            <td " + seAttributes + "></td>\
        </tr>\
      </table>\
    ";
    Element.hide(win);
    this.options.parent.insertBefore(win, this.options.parent.firstChild);
    Event.observe($(id + "_content"), "load", this.options.onload);
    return win;
  },
  
  
  changeClassName: function(newClassName) {    
    var className = this.options.className;
    var id = this.getId();
    $A(["_close", "_minimize", "_maximize", "_sizer", "_content"]).each(function(value) { this._toggleClassName($(id + value), className + value, newClassName + value) }.bind(this));
    this._toggleClassName($(id + "_top"), className + "_title", newClassName + "_title");
    $$("#" + id + " td").each(function(td) {td.className = td.className.sub(className,newClassName); });
    this.options.className = newClassName;
  },
  
  _toggleClassName: function(element, oldClassName, newClassName) { 
    if (element) {
      element.removeClassName(oldClassName);
      element.addClassName(newClassName);
    }
  },
  
  // Sets window location
  setLocation: function(top, left) {
    top = this._updateTopConstraint(top);
    left = this._updateLeftConstraint(left);

    var e = this.currentDrag || this.element;
    e.setStyle({top: top + 'px'});
    e.setStyle({left: left + 'px'});

    this.useLeft = true;
    this.useTop = true;
  },
    
  getLocation: function() {
    var location = {};
    if (this.useTop)
      location = Object.extend(location, {top: this.element.getStyle("top")});
    else
      location = Object.extend(location, {bottom: this.element.getStyle("bottom")});
    if (this.useLeft)
      location = Object.extend(location, {left: this.element.getStyle("left")});
    else
      location = Object.extend(location, {right: this.element.getStyle("right")});
    
    return location;
  },
  
  // Gets window size
  getSize: function() {
    return {width: this.width, height: this.height};
  },
    
  // Sets window size
  setSize: function(width, height, useEffect) {    
    width = parseFloat(width);
    height = parseFloat(height);
    
    // Check min and max size
    if (!this.minimized && width < this.options.minWidth)
      width = this.options.minWidth;

    if (!this.minimized && height < this.options.minHeight)
      height = this.options.minHeight;
      
    if (this.options. maxHeight && height > this.options. maxHeight)
      height = this.options. maxHeight;

    if (this.options. maxWidth && width > this.options. maxWidth)
      width = this.options. maxWidth;

    
    if (this.useTop && this.useLeft && Window.hasEffectLib && Effect.ResizeWindow && useEffect) {
      new Effect.ResizeWindow(this, null, null, width, height, {duration: Window.resizeEffectDuration});
    } else {
      this.width = width;
      this.height = height;
      var e = this.currentDrag ? this.currentDrag : this.element;

      e.setStyle({width: width + this.widthW + this.widthE + "px"})
      e.setStyle({height: height  + this.heightN + this.heightS + "px"})

      // Update content size
      if (!this.currentDrag || this.currentDrag == this.element) {
        var content = $(this.element.id + '_content');
        content.setStyle({height: height  + 'px'});
        content.setStyle({width: width  + 'px'});
      }
    }
  },
  
  updateHeight: function() {
    this.setSize(this.width, this.content.scrollHeight, true);
  },
  
  updateWidth: function() {
    this.setSize(this.content.scrollWidth, this.height, true);
  },
  
  // Brings window to front
  toFront: function() {
    if (this.element.style.zIndex < Windows.maxZIndex)  
      this.setZIndex(Windows.maxZIndex + 1);
    if (this.iefix) 
      this._fixIEOverlapping(); 
  },
   
  getBounds: function(insideOnly) {
    if (! this.width || !this.height || !this.visible)  
      this.computeBounds();
    var w = this.width;
    var h = this.height;

    if (!insideOnly) {
      w += this.widthW + this.widthE;
      h += this.heightN + this.heightS;
    }
    var bounds = Object.extend(this.getLocation(), {width: w + "px", height: h + "px"});
    return bounds;
  },
      
  computeBounds: function() {
     if (! this.width || !this.height) {
      var size = WindowUtilities._computeSize(this.content.innerHTML, this.content.id, this.width, this.height, 0, this.options.className)
      if (this.height)
        this.width = size + 5
      else
        this.height = size + 5
    }

    this.setSize(this.width, this.height);
    if (this.centered)
      this._center(this.centerTop, this.centerLeft);    
  },
  
  // Displays window modal state or not
  show: function(modal) {
    this.visible = true;
    if (modal) {
      // Hack for Safari !!
      if (typeof this.overlayOpacity == "undefined") {
        var that = this;
        setTimeout(function() {that.show(modal)}, 10);
        return;
      }
      Windows.addModalWindow(this);
      
      this.modal = true;      
      this.setZIndex(Windows.maxZIndex + 1);
      Windows.unsetOverflow(this);
    }
    else    
      if (!this.element.style.zIndex) 
        this.setZIndex(Windows.maxZIndex + 1);        
      
    // To restore overflow if need be
    if (this.oldStyle)
      this.getContent().setStyle({overflow: this.oldStyle});
      
    this.computeBounds();
    
    this._notify("onBeforeShow");   
    if (this.options.showEffect != Element.show && this.options.showEffectOptions)
      this.options.showEffect(this.element, this.options.showEffectOptions);  
    else
      this.options.showEffect(this.element);  
      
    this._checkIEOverlapping();
    WindowUtilities.focusedWindow = this
    this._notify("onShow");   
  },
  
  // Displays window modal state or not at the center of the page
  showCenter: function(modal, top, left) {
    this.centered = true;
    this.centerTop = top;
    this.centerLeft = left;

    this.show(modal);
  },
  
  isVisible: function() {
    return this.visible;
  },
  
  _center: function(top, left) {    
    var windowScroll = WindowUtilities.getWindowScroll(this.options.parent);    
    var pageSize = WindowUtilities.getPageSize(this.options.parent);    
    if (typeof top == "undefined")
      top = (pageSize.windowHeight - (this.height + this.heightN + this.heightS))/2;
    top += windowScroll.top
    
    if (typeof left == "undefined")
      left = (pageSize.windowWidth - (this.width + this.widthW + this.widthE))/2;
    left += windowScroll.left      
    this.setLocation(top, left);
    this.toFront();
  },
  
  _recenter: function(event) {     
    if (this.centered) {
      var pageSize = WindowUtilities.getPageSize(this.options.parent);
      var windowScroll = WindowUtilities.getWindowScroll(this.options.parent);    

      // Check for this stupid IE that sends dumb events
      if (this.pageSize && this.pageSize.windowWidth == pageSize.windowWidth && this.pageSize.windowHeight == pageSize.windowHeight && 
          this.windowScroll.left == windowScroll.left && this.windowScroll.top == windowScroll.top) 
        return;
      this.pageSize = pageSize;
      this.windowScroll = windowScroll;
      // set height of Overlay to take up whole page and show
      if ($('overlay_modal')) 
        $('overlay_modal').setStyle({height: (pageSize.pageHeight + 'px')});
      
      if (this.options.recenterAuto)
        this._center(this.centerTop, this.centerLeft);    
    }
  },
  
  // Hides window
  hide: function() {
    this.visible = false;
    if (this.modal) {
      Windows.removeModalWindow(this);
      Windows.resetOverflow();
    }
    // To avoid bug on scrolling bar
    this.oldStyle = this.getContent().getStyle('overflow') || "auto"
    this.getContent().setStyle({overflow: "hidden"});

    this.options.hideEffect(this.element, this.options.hideEffectOptions);  

     if(this.iefix) 
      this.iefix.hide();

    if (!this.doNotNotifyHide)
      this._notify("onHide");
  },

  close: function() {
    // Asks closeCallback if exists
    if (this.visible) {
      if (this.options.closeCallback && ! this.options.closeCallback(this)) 
        return;

      if (this.options.destroyOnClose) {
        var destroyFunc = this.destroy.bind(this);
        if (this.options.hideEffectOptions.afterFinish) {
          var func = this.options.hideEffectOptions.afterFinish;
          this.options.hideEffectOptions.afterFinish = function() {func();destroyFunc() }
        }
        else 
          this.options.hideEffectOptions.afterFinish = function() {destroyFunc() }
      }
      Windows.updateFocusedWindow();
      
      this.doNotNotifyHide = true;
      this.hide();
      this.doNotNotifyHide = false;
      this._notify("onClose");
    }
  },
  
  minimize: function() {
    if (this.resizing)
      return;
    
    var r2 = $(this.getId() + "_row2");
    
    if (!this.minimized) {
      this.minimized = true;

      var dh = r2.getDimensions().height;
      this.r2Height = dh;
      var h  = this.element.getHeight() - dh;

      if (this.useLeft && this.useTop && Window.hasEffectLib && Effect.ResizeWindow) {
        new Effect.ResizeWindow(this, null, null, null, this.height -dh, {duration: Window.resizeEffectDuration});
      } else  {
        this.height -= dh;
        this.element.setStyle({height: h + "px"});
        r2.hide();
      }

      if (! this.useTop) {
        var bottom = parseFloat(this.element.getStyle('bottom'));
        this.element.setStyle({bottom: (bottom + dh) + 'px'});
      }
    } 
    else {      
      this.minimized = false;
      
      var dh = this.r2Height;
      this.r2Height = null;
      if (this.useLeft && this.useTop && Window.hasEffectLib && Effect.ResizeWindow) {
        new Effect.ResizeWindow(this, null, null, null, this.height + dh, {duration: Window.resizeEffectDuration});
      }
      else {
        var h  = this.element.getHeight() + dh;
        this.height += dh;
        this.element.setStyle({height: h + "px"})
        r2.show();
      }
      if (! this.useTop) {
        var bottom = parseFloat(this.element.getStyle('bottom'));
        this.element.setStyle({bottom: (bottom - dh) + 'px'});
      }
      this.toFront();
    }
    this._notify("onMinimize");
    
    // Store new location/size if need be
    this._saveCookie()
  },
  
  maximize: function() {
    if (this.isMinimized() || this.resizing)
      return;
  
    if (Prototype.Browser.IE && this.heightN == 0)
      this._getWindowBorderSize();
      
    if (this.storedLocation != null) {
      this._restoreLocation();
      if(this.iefix) 
        this.iefix.hide();
    }
    else {
      this._storeLocation();
      Windows.unsetOverflow(this);
      
      var windowScroll = WindowUtilities.getWindowScroll(this.options.parent);
      var pageSize = WindowUtilities.getPageSize(this.options.parent);    
      var left = windowScroll.left;
      var top = windowScroll.top;
      
      if (this.options.parent != document.body) {
        windowScroll =  {top:0, left:0, bottom:0, right:0};
        var dim = this.options.parent.getDimensions();
        pageSize.windowWidth = dim.width;
        pageSize.windowHeight = dim.height;
        top = 0; 
        left = 0;
      }
      
      if (this.constraint) {
        pageSize.windowWidth -= Math.max(0, this.constraintPad.left) + Math.max(0, this.constraintPad.right);
        pageSize.windowHeight -= Math.max(0, this.constraintPad.top) + Math.max(0, this.constraintPad.bottom);
        left +=  Math.max(0, this.constraintPad.left);
        top +=  Math.max(0, this.constraintPad.top);
      }
      
      var width = pageSize.windowWidth - this.widthW - this.widthE;
      var height= pageSize.windowHeight - this.heightN - this.heightS;

      if (this.useLeft && this.useTop && Window.hasEffectLib && Effect.ResizeWindow) {
        new Effect.ResizeWindow(this, top, left, width, height, {duration: Window.resizeEffectDuration});
      }
      else {
        this.setSize(width, height);
        this.element.setStyle(this.useLeft ? {left: left} : {right: left});
        this.element.setStyle(this.useTop ? {top: top} : {bottom: top});
      }
        
      this.toFront();
      if (this.iefix) 
        this._fixIEOverlapping(); 
    }
    this._notify("onMaximize");

    // Store new location/size if need be
    this._saveCookie()
  },
  
  isMinimized: function() {
    return this.minimized;
  },
  
  isMaximized: function() {
    return (this.storedLocation != null);
  },
  
  setOpacity: function(opacity) {
    if (Element.setOpacity)
      Element.setOpacity(this.element, opacity);
  },
  
  setZIndex: function(zindex) {
    this.element.setStyle({zIndex: zindex});
    Windows.updateZindex(zindex, this);
  },

  setTitle: function(newTitle) {
    if (!newTitle || newTitle == "") 
      newTitle = "&nbsp;";
      
    Element.update(this.element.id + '_top', newTitle);
  },
   
  getTitle: function() {
    return $(this.element.id + '_top').innerHTML;
  },
  
  setStatusBar: function(element) {
    var statusBar = $(this.getId() + "_bottom");

    if (typeof(element) == "object") {
      if (this.bottombar.firstChild)
        this.bottombar.replaceChild(element, this.bottombar.firstChild);
      else
        this.bottombar.appendChild(element);
    }
    else
      this.bottombar.innerHTML = element;
  },

  _checkIEOverlapping: function() {
    if(!this.iefix && (navigator.appVersion.indexOf('MSIE')>0) && (navigator.userAgent.indexOf('Opera')<0) && (this.element.getStyle('position')=='absolute')) {
        new Insertion.After(this.element.id, '<iframe id="' + this.element.id + '_iefix" '+ 'style="display:none;position:absolute;filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);" ' + 'src="javascript:false;" frameborder="0" scrolling="no"></iframe>');
        this.iefix = $(this.element.id+'_iefix');
    }
    if(this.iefix) 
      setTimeout(this._fixIEOverlapping.bind(this), 50);
  },

  _fixIEOverlapping: function() {
      Position.clone(this.element, this.iefix);
      this.iefix.style.zIndex = this.element.style.zIndex - 1;
      this.iefix.show();
  },
  
  _getWindowBorderSize: function(event) {
    // Hack to get real window border size!!
    var div = this._createHiddenDiv(this.options.className + "_n")
    this.heightN = Element.getDimensions(div).height;    
    div.parentNode.removeChild(div)

    var div = this._createHiddenDiv(this.options.className + "_s")
    this.heightS = Element.getDimensions(div).height;    
    div.parentNode.removeChild(div)

    var div = this._createHiddenDiv(this.options.className + "_e")
    this.widthE = Element.getDimensions(div).width;    
    div.parentNode.removeChild(div)

    var div = this._createHiddenDiv(this.options.className + "_w")
    this.widthW = Element.getDimensions(div).width;
    div.parentNode.removeChild(div);
    
    var div = document.createElement("div");
    div.className = "overlay_" + this.options.className ;
    document.body.appendChild(div);
    //alert("no timeout:\nopacity: " + div.getStyle("opacity") + "\nwidth: " + document.defaultView.getComputedStyle(div, null).width);
    var that = this;
    
    // Workaround for Safari!!
    setTimeout(function() {that.overlayOpacity = ($(div).getStyle("opacity")); div.parentNode.removeChild(div);}, 10);
    
    // Workaround for IE!!
    if (Prototype.Browser.IE) {
      this.heightS = $(this.getId() +"_row3").getDimensions().height;
      this.heightN = $(this.getId() +"_row1").getDimensions().height;
    }

    // Safari size fix
    if (Prototype.Browser.WebKit && Prototype.Browser.WebKitVersion < 420)
      this.setSize(this.width, this.height);
    if (this.doMaximize)
      this.maximize();
    if (this.doMinimize)
      this.minimize();
  },
 
  _createHiddenDiv: function(className) {
    var objBody = document.body;
    var win = document.createElement("div");
    win.setAttribute('id', this.element.id+ "_tmp");
    win.className = className;
    win.style.display = 'none';
    win.innerHTML = '';
    objBody.insertBefore(win, objBody.firstChild);
    return win;
  },
  
  _storeLocation: function() {
    if (this.storedLocation == null) {
      this.storedLocation = {useTop: this.useTop, useLeft: this.useLeft, 
                             top: this.element.getStyle('top'), bottom: this.element.getStyle('bottom'),
                             left: this.element.getStyle('left'), right: this.element.getStyle('right'),
                             width: this.width, height: this.height };
    }
  },
  
  _restoreLocation: function() {
    if (this.storedLocation != null) {
      this.useLeft = this.storedLocation.useLeft;
      this.useTop = this.storedLocation.useTop;
      
      if (this.useLeft && this.useTop && Window.hasEffectLib && Effect.ResizeWindow)
        new Effect.ResizeWindow(this, this.storedLocation.top, this.storedLocation.left, this.storedLocation.width, this.storedLocation.height, {duration: Window.resizeEffectDuration});
      else {
        this.element.setStyle(this.useLeft ? {left: this.storedLocation.left} : {right: this.storedLocation.right});
        this.element.setStyle(this.useTop ? {top: this.storedLocation.top} : {bottom: this.storedLocation.bottom});
        this.setSize(this.storedLocation.width, this.storedLocation.height);
      }
      
      Windows.resetOverflow();
      this._removeStoreLocation();
    }
  },
  
  _removeStoreLocation: function() {
    this.storedLocation = null;
  },
  
  _saveCookie: function() {
    if (this.cookie) {
      var value = "";
      if (this.useLeft)
        value += "l:" +  (this.storedLocation ? this.storedLocation.left : this.element.getStyle('left'))
      else
        value += "r:" + (this.storedLocation ? this.storedLocation.right : this.element.getStyle('right'))
      if (this.useTop)
        value += ",t:" + (this.storedLocation ? this.storedLocation.top : this.element.getStyle('top'))
      else
        value += ",b:" + (this.storedLocation ? this.storedLocation.bottom :this.element.getStyle('bottom'))
        
      value += "," + (this.storedLocation ? this.storedLocation.width : this.width);
      value += "," + (this.storedLocation ? this.storedLocation.height : this.height);
      value += "," + this.isMinimized();
      value += "," + this.isMaximized();
      WindowUtilities.setCookie(value, this.cookie)
    }
  },
  
  _createWiredElement: function() {
    if (! this.wiredElement) {
      if (Prototype.Browser.IE)
        this._getWindowBorderSize();
      var div = document.createElement("div");
      div.className = "wired_frame " + this.options.className + "_wired_frame";
      
      div.style.position = 'absolute';
      this.options.parent.insertBefore(div, this.options.parent.firstChild);
      this.wiredElement = $(div);
    }
    if (this.useLeft) 
      this.wiredElement.setStyle({left: this.element.getStyle('left')});
    else 
      this.wiredElement.setStyle({right: this.element.getStyle('right')});
      
    if (this.useTop) 
      this.wiredElement.setStyle({top: this.element.getStyle('top')});
    else 
      this.wiredElement.setStyle({bottom: this.element.getStyle('bottom')});

    var dim = this.element.getDimensions();
    this.wiredElement.setStyle({width: dim.width + "px", height: dim.height +"px"});

    this.wiredElement.setStyle({zIndex: Windows.maxZIndex+30});
    return this.wiredElement;
  },
  
  _hideWiredElement: function() {
    if (! this.wiredElement || ! this.currentDrag)
      return;
    if (this.currentDrag == this.element) 
      this.currentDrag = null;
    else {
      if (this.useLeft) 
        this.element.setStyle({left: this.currentDrag.getStyle('left')});
      else 
        this.element.setStyle({right: this.currentDrag.getStyle('right')});

      if (this.useTop) 
        this.element.setStyle({top: this.currentDrag.getStyle('top')});
      else 
        this.element.setStyle({bottom: this.currentDrag.getStyle('bottom')});

      this.currentDrag.hide();
      this.currentDrag = null;
      if (this.doResize)
        this.setSize(this.width, this.height);
    } 
  },
  
  _notify: function(eventName) {
    if (this.options[eventName])
      this.options[eventName](this);
    else
      Windows.notify(eventName, this);
  }
};

// Windows containers, register all page windows
var Windows = {
  windows: [],
  modalWindows: [],
  observers: [],
  focusedWindow: null,
  maxZIndex: 0,
  overlayShowEffectOptions: {duration: 0.5},
  overlayHideEffectOptions: {duration: 0.5},

  addObserver: function(observer) {
    this.removeObserver(observer);
    this.observers.push(observer);
  },
  
  removeObserver: function(observer) {  
    this.observers = this.observers.reject( function(o) { return o==observer });
  },
  
  // onDestroy onStartResize onStartMove onResize onMove onEndResize onEndMove onFocus onBlur onBeforeShow onShow onHide onMinimize onMaximize onClose
  notify: function(eventName, win) {  
    this.observers.each( function(o) {if(o[eventName]) o[eventName](eventName, win);});
  },

  // Gets window from its id
  getWindow: function(id) {
    return this.windows.detect(function(d) { return d.getId() ==id });
  },

  // Gets the last focused window
  getFocusedWindow: function() {
    return this.focusedWindow;
  },

  updateFocusedWindow: function() {
    this.focusedWindow = this.windows.length >=2 ? this.windows[this.windows.length-2] : null;    
  },
  
  // Registers a new window (called by Windows constructor)
  register: function(win) {
    this.windows.push(win);
  },
    
  // Add a modal window in the stack
  addModalWindow: function(win) {
    // Disable screen if first modal window
    if (this.modalWindows.length == 0) {
      WindowUtilities.disableScreen(win.options.className, 'overlay_modal', win.overlayOpacity, win.getId(), win.options.parent);
    }
    else {
      // Move overlay over all windows
      if (Window.keepMultiModalWindow) {
        $('overlay_modal').style.zIndex = Windows.maxZIndex + 1;
        Windows.maxZIndex += 1;
        WindowUtilities._hideSelect(this.modalWindows.last().getId());
      }
      // Hide current modal window
      else
        this.modalWindows.last().element.hide();
      // Fucking IE select issue
      WindowUtilities._showSelect(win.getId());
    }      
    this.modalWindows.push(win);    
  },
  
  removeModalWindow: function(win) {
    this.modalWindows.pop();
    
    // No more modal windows
    if (this.modalWindows.length == 0)
      WindowUtilities.enableScreen();     
    else {
      if (Window.keepMultiModalWindow) {
        this.modalWindows.last().toFront();
        WindowUtilities._showSelect(this.modalWindows.last().getId());        
      }
      else
        this.modalWindows.last().element.show();
    }
  },
  
  // Registers a new window (called by Windows constructor)
  register: function(win) {
    this.windows.push(win);
  },
  
  // Unregisters a window (called by Windows destructor)
  unregister: function(win) {
    this.windows = this.windows.reject(function(d) { return d==win });
  }, 
  
  // Closes all windows
  closeAll: function() {  
    this.windows.each( function(w) {Windows.close(w.getId())} );
  },
  
  closeAllModalWindows: function() {
    WindowUtilities.enableScreen();     
    this.modalWindows.each( function(win) {if (win) win.close()});    
  },

  // Minimizes a window with its id
  minimize: function(id, event) {
    var win = this.getWindow(id)
    if (win && win.visible)
      win.minimize();
    Event.stop(event);
  },
  
  // Maximizes a window with its id
  maximize: function(id, event) {
    var win = this.getWindow(id)
    if (win && win.visible)
      win.maximize();
    Event.stop(event);
  },

  // Closes a window with its id
  close: function(id, event) {
    var win = this.getWindow(id);
    if (win) 
      win.close();
    if (event)
      Event.stop(event);
  },
  
  blur: function(id) {
    var win = this.getWindow(id);  
    if (!win)
      return;
    if (win.options.blurClassName)
      win.changeClassName(win.options.blurClassName);
    if (this.focusedWindow == win)  
      this.focusedWindow = null;
    win._notify("onBlur");  
  },
  
  focus: function(id) {
    var win = this.getWindow(id);  
    if (!win)
      return;       
    if (this.focusedWindow)
      this.blur(this.focusedWindow.getId())

    if (win.options.focusClassName)
      win.changeClassName(win.options.focusClassName);  
    this.focusedWindow = win;
    win._notify("onFocus");
  },
  
  unsetOverflow: function(except) {    
    this.windows.each(function(d) { d.oldOverflow = d.getContent().getStyle("overflow") || "auto" ; d.getContent().setStyle({overflow: "hidden"}) });
    if (except && except.oldOverflow)
      except.getContent().setStyle({overflow: except.oldOverflow});
  },

  resetOverflow: function() {
    this.windows.each(function(d) { if (d.oldOverflow) d.getContent().setStyle({overflow: d.oldOverflow}) });
  },

  updateZindex: function(zindex, win) { 
    if (zindex > this.maxZIndex) {   
      this.maxZIndex = zindex;    
      if (this.focusedWindow) 
        this.blur(this.focusedWindow.getId())
    }
    this.focusedWindow = win;
    if (this.focusedWindow) 
      this.focus(this.focusedWindow.getId())
  }
};

var Dialog = {
  dialogId: null,
  onCompleteFunc: null,
  callFunc: null, 
  parameters: null, 
    
  confirm: function(content, parameters) {
    // Get Ajax return before
    if (content && typeof content != "string") {
      Dialog._runAjaxRequest(content, parameters, Dialog.confirm);
      return 
    }
    content = content || "";
    
    parameters = parameters || {};
    var okLabel = parameters.okLabel ? parameters.okLabel : "Ok";
    var cancelLabel = parameters.cancelLabel ? parameters.cancelLabel : "Cancel";

    // Backward compatibility
    parameters = Object.extend(parameters, parameters.windowParameters || {});
    parameters.windowParameters = parameters.windowParameters || {};

    parameters.className = parameters.className || "alert";

    var okButtonClass = "class ='" + (parameters.buttonClass ? parameters.buttonClass + " " : "") + " ok_button'" 
    var cancelButtonClass = "class ='" + (parameters.buttonClass ? parameters.buttonClass + " " : "") + " cancel_button'" 
    var content = "\
      <div class='" + parameters.className + "_message'>" + content  + "</div>\
        <div class='" + parameters.className + "_buttons'>\
          <input type='button' value='" + okLabel + "' onclick='Dialog.okCallback()' " + okButtonClass + "/>\
          <input type='button' value='" + cancelLabel + "' onclick='Dialog.cancelCallback()' " + cancelButtonClass + "/>\
        </div>\
    ";
    return this._openDialog(content, parameters)
  },
  
  alert: function(content, parameters) {
    // Get Ajax return before
    if (content && typeof content != "string") {
      Dialog._runAjaxRequest(content, parameters, Dialog.alert);
      return 
    }
    content = content || "";
    
    parameters = parameters || {};
    var okLabel = parameters.okLabel ? parameters.okLabel : "Ok";

    // Backward compatibility    
    parameters = Object.extend(parameters, parameters.windowParameters || {});
    parameters.windowParameters = parameters.windowParameters || {};
    
    parameters.className = parameters.className || "alert";
    
    var okButtonClass = "class ='" + (parameters.buttonClass ? parameters.buttonClass + " " : "") + " ok_button'" 
    var content = "\
      <div class='" + parameters.className + "_message'>" + content  + "</div>\
        <div class='" + parameters.className + "_buttons'>\
          <input type='button' value='" + okLabel + "' onclick='Dialog.okCallback()' " + okButtonClass + "/>\
        </div>";                  
    return this._openDialog(content, parameters)
  },
  
  info: function(content, parameters) {   
    // Get Ajax return before
    if (content && typeof content != "string") {
      Dialog._runAjaxRequest(content, parameters, Dialog.info);
      return 
    }
    content = content || "";
     
    // Backward compatibility
    parameters = parameters || {};
    parameters = Object.extend(parameters, parameters.windowParameters || {});
    parameters.windowParameters = parameters.windowParameters || {};
    
    parameters.className = parameters.className || "alert";
    
    var content = "<div id='modal_dialog_message' class='" + parameters.className + "_message'>" + content  + "</div>";
    if (parameters.showProgress)
      content += "<div id='modal_dialog_progress' class='" + parameters.className + "_progress'>  </div>";

    parameters.ok = null;
    parameters.cancel = null;
    
    return this._openDialog(content, parameters)
  },
  
  setInfoMessage: function(message) {
    $('modal_dialog_message').update(message);
  },
  
  closeInfo: function() {
    Windows.close(this.dialogId);
  },
  
  _openDialog: function(content, parameters) {
    var className = parameters.className;
    
    if (! parameters.height && ! parameters.width) {
      parameters.width = WindowUtilities.getPageSize(parameters.options.parent || document.body).pageWidth / 2;
    }
    if (parameters.id)
      this.dialogId = parameters.id;
    else { 
      var t = new Date();
      this.dialogId = 'modal_dialog_' + t.getTime();
      parameters.id = this.dialogId;
    }

    // compute height or width if need be
    if (! parameters.height || ! parameters.width) {
      var size = WindowUtilities._computeSize(content, this.dialogId, parameters.width, parameters.height, 5, className)
      if (parameters.height)
        parameters.width = size + 5
      else
        parameters.height = size + 5
    }
    parameters.effectOptions = parameters.effectOptions ;
    parameters.resizable   = parameters.resizable || false;
    parameters.minimizable = parameters.minimizable || false;
    parameters.maximizable = parameters.maximizable ||  false;
    parameters.draggable   = parameters.draggable || false;
    parameters.closable    = parameters.closable || false;
    
    var win = new Window(parameters);
    win.getContent().innerHTML = content;
    
    win.showCenter(true, parameters.top, parameters.left);  
    win.setDestroyOnClose();
    
    win.cancelCallback = parameters.onCancel || parameters.cancel; 
    win.okCallback = parameters.onOk || parameters.ok;
    
    return win;    
  },
  
  _getAjaxContent: function(originalRequest)  {
      Dialog.callFunc(originalRequest.responseText, Dialog.parameters)
  },
  
  _runAjaxRequest: function(message, parameters, callFunc) {
    if (message.options == null)
      message.options = {}  
    Dialog.onCompleteFunc = message.options.onComplete;
    Dialog.parameters = parameters;
    Dialog.callFunc = callFunc;
    
    message.options.onComplete = Dialog._getAjaxContent;
    new Ajax.Request(message.url, message.options);
  },
  
  okCallback: function() {
    var win = Windows.focusedWindow;
    if (!win.okCallback || win.okCallback(win)) {
      // Remove onclick on button
      $$("#" + win.getId()+" input").each(function(element) {element.onclick=null;})
      win.close();
    }
  },

  cancelCallback: function() {
    var win = Windows.focusedWindow;
    // Remove onclick on button
    $$("#" + win.getId()+" input").each(function(element) {element.onclick=null})
    win.close();
    if (win.cancelCallback)
      win.cancelCallback(win);
  }
}
/*
  Based on Lightbox JS: Fullsize Image Overlays 
  by Lokesh Dhakar - http://www.huddletogether.com

  For more information on this script, visit:
  http://huddletogether.com/projects/lightbox/

  Licensed under the Creative Commons Attribution 2.5 License - http://creativecommons.org/licenses/by/2.5/
  (basically, do anything you want, just leave my name and link)
*/

if (Prototype.Browser.WebKit) {
  var array = navigator.userAgent.match(new RegExp(/AppleWebKit\/([\d\.\+]*)/));
  Prototype.Browser.WebKitVersion = parseFloat(array[1]);
}

var WindowUtilities = {  
  // From dragdrop.js
  getWindowScroll: function(parent) {
    var T, L, W, H;
    parent = parent || document.body;              
    if (parent != document.body) {
      T = parent.scrollTop;
      L = parent.scrollLeft;
      W = parent.scrollWidth;
      H = parent.scrollHeight;
    } 
    else {
      var w = window;
      with (w.document) {
        if (w.document.documentElement && documentElement.scrollTop) {
          T = documentElement.scrollTop;
          L = documentElement.scrollLeft;
        } else if (w.document.body) {
          T = body.scrollTop;
          L = body.scrollLeft;
        }
        if (w.innerWidth) {
          W = w.innerWidth;
          H = w.innerHeight;
        } else if (w.document.documentElement && documentElement.clientWidth) {
          W = documentElement.clientWidth;
          H = documentElement.clientHeight;
        } else {
          W = body.offsetWidth;
          H = body.offsetHeight
        }
      }
    }
    return { top: T, left: L, width: W, height: H };
  }, 
  //
  // getPageSize()
  // Returns array with page width, height and window width, height
  // Core code from - quirksmode.org
  // Edit for Firefox by pHaez
  //
  getPageSize: function(parent){
    parent = parent || document.body;              
    var windowWidth, windowHeight;
    var pageHeight, pageWidth;
    if (parent != document.body) {
      windowWidth = parent.getWidth();
      windowHeight = parent.getHeight();                                
      pageWidth = parent.scrollWidth;
      pageHeight = parent.scrollHeight;                                
    } 
    else {
      var xScroll, yScroll;

      if (window.innerHeight && window.scrollMaxY) {  
        xScroll = document.body.scrollWidth;
        yScroll = window.innerHeight + window.scrollMaxY;
      } else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
        xScroll = document.body.scrollWidth;
        yScroll = document.body.scrollHeight;
      } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
        xScroll = document.body.offsetWidth;
        yScroll = document.body.offsetHeight;
      }


      if (self.innerHeight) {  // all except Explorer
        windowWidth = self.innerWidth;
        windowHeight = self.innerHeight;
      } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
        windowWidth = document.documentElement.clientWidth;
        windowHeight = document.documentElement.clientHeight;
      } else if (document.body) { // other Explorers
        windowWidth = document.body.clientWidth;
        windowHeight = document.body.clientHeight;
      }  

      // for small pages with total height less then height of the viewport
      if(yScroll < windowHeight){
        pageHeight = windowHeight;
      } else { 
        pageHeight = yScroll;
      }

      // for small pages with total width less then width of the viewport
      if(xScroll < windowWidth){  
        pageWidth = windowWidth;
      } else {
        pageWidth = xScroll;
      }
    }             
    return {pageWidth: pageWidth ,pageHeight: pageHeight , windowWidth: windowWidth, windowHeight: windowHeight};
  },

  disableScreen: function(className, overlayId, overlayOpacity, contentId, parent) {
    WindowUtilities.initLightbox(overlayId, className, function() {this._disableScreen(className, overlayId, overlayOpacity, contentId)}.bind(this), parent || document.body);
  },

  _disableScreen: function(className, overlayId, overlayOpacity, contentId) {
    // prep objects
    var objOverlay = $(overlayId);

    var pageSize = WindowUtilities.getPageSize(objOverlay.parentNode);

    // Hide select boxes as they will 'peek' through the image in IE, store old value
    if (contentId && Prototype.Browser.IE) {
      WindowUtilities._hideSelect();
      WindowUtilities._showSelect(contentId);
    }  
  
    // set height of Overlay to take up whole page and show
    objOverlay.style.height = (pageSize.pageHeight + 'px');
    objOverlay.style.display = 'none'; 
    if (overlayId == "overlay_modal" && Window.hasEffectLib && Windows.overlayShowEffectOptions) {
      objOverlay.overlayOpacity = overlayOpacity;
      new Effect.Appear(objOverlay, Object.extend({from: 0, to: overlayOpacity}, Windows.overlayShowEffectOptions));
    }
    else
      objOverlay.style.display = "block";
  },
  
  enableScreen: function(id) {
    id = id || 'overlay_modal';
    var objOverlay =  $(id);
    if (objOverlay) {
      // hide lightbox and overlay
      if (id == "overlay_modal" && Window.hasEffectLib && Windows.overlayHideEffectOptions)
        new Effect.Fade(objOverlay, Object.extend({from: objOverlay.overlayOpacity, to:0}, Windows.overlayHideEffectOptions));
      else {
        objOverlay.style.display = 'none';
        objOverlay.parentNode.removeChild(objOverlay);
      }
      
      // make select boxes visible using old value
      if (id != "__invisible__") 
        WindowUtilities._showSelect();
    }
  },

  _hideSelect: function(id) {
    if (Prototype.Browser.IE) {
      id = id ==  null ? "" : "#" + id + " ";
      $$(id + 'select').each(function(element) {
        if (! WindowUtilities.isDefined(element.oldVisibility)) {
          element.oldVisibility = element.style.visibility ? element.style.visibility : "visible";
          element.style.visibility = "hidden";
        }
      });
    }
  },
  
  _showSelect: function(id) {
    if (Prototype.Browser.IE) {
      id = id ==  null ? "" : "#" + id + " ";
      $$(id + 'select').each(function(element) {
        if (WindowUtilities.isDefined(element.oldVisibility)) {
          // Why?? Ask IE
          try {
            element.style.visibility = element.oldVisibility;
          } catch(e) {
            element.style.visibility = "visible";
          }
          element.oldVisibility = null;
        }
        else {
          if (element.style.visibility)
            element.style.visibility = "visible";
        }
      });
    }
  },

  isDefined: function(object) {
    return typeof(object) != "undefined" && object != null;
  },
  
  // initLightbox()
  // Function runs on window load, going through link tags looking for rel="lightbox".
  // These links receive onclick events that enable the lightbox display for their targets.
  // The function also inserts html markup at the top of the page which will be used as a
  // container for the overlay pattern and the inline image.
  initLightbox: function(id, className, doneHandler, parent) {
    // Already done, just update zIndex
    if ($(id)) {
      Element.setStyle(id, {zIndex: Windows.maxZIndex + 1});
      Windows.maxZIndex++;
      doneHandler();
    }
    // create overlay div and hardcode some functional styles (aesthetic styles are in CSS file)
    else {
      var objOverlay = document.createElement("div");
      objOverlay.setAttribute('id', id);
      objOverlay.className = "overlay_" + className
      objOverlay.style.display = 'none';
      objOverlay.style.position = 'absolute';
      objOverlay.style.top = '0';
      objOverlay.style.left = '0';
      objOverlay.style.zIndex = Windows.maxZIndex + 1;
      Windows.maxZIndex++;
      objOverlay.style.width = '100%';
      parent.insertBefore(objOverlay, parent.firstChild);
      if (Prototype.Browser.WebKit && id == "overlay_modal") {
        setTimeout(function() {doneHandler()}, 10);
      }
      else
        doneHandler();
    }    
  },
  
  setCookie: function(value, parameters) {
    document.cookie= parameters[0] + "=" + escape(value) +
      ((parameters[1]) ? "; expires=" + parameters[1].toGMTString() : "") +
      ((parameters[2]) ? "; path=" + parameters[2] : "") +
      ((parameters[3]) ? "; domain=" + parameters[3] : "") +
      ((parameters[4]) ? "; secure" : "");
  },

  getCookie: function(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
      begin = dc.indexOf(prefix);
      if (begin != 0) return null;
    } else {
      begin += 2;
    }
    var end = document.cookie.indexOf(";", begin);
    if (end == -1) {
      end = dc.length;
    }
    return unescape(dc.substring(begin + prefix.length, end));
  },
    
  _computeSize: function(content, id, width, height, margin, className) {
    var objBody = document.body;
    var tmpObj = document.createElement("div");
    tmpObj.setAttribute('id', id);
    tmpObj.className = className + "_content";

    if (height)
      tmpObj.style.height = height + "px"
    else
      tmpObj.style.width = width + "px"
  
    tmpObj.style.position = 'absolute';
    tmpObj.style.top = '0';
    tmpObj.style.left = '0';
    tmpObj.style.display = 'none';

    tmpObj.innerHTML = content;
    objBody.insertBefore(tmpObj, objBody.firstChild);

    var size;
    if (height)
      size = $(tmpObj).getDimensions().width + margin;
    else
      size = $(tmpObj).getDimensions().height + margin;
    objBody.removeChild(tmpObj);
    return size;
  }  
}

function testAlert()
{
	alert("great success");
}

function wrapper(cdiv, width, controlNameToCalcRelativePos, shiftByY, shiftByX, includeCloseButton, includeSaveButton, includeRemoveButton, includeTitle, titleText) {
	cdiv.style.width = width || "auto";
	
	if(!controlNameToCalcRelativePos) {
		cdiv.className += " ajaxDivNotificationRelative";
	} else {
		cdiv.className += " ajaxDivNotification";
		var controlToCalcRelativePos = document.getElementById(controlNameToCalcRelativePos);
		if(!controlToCalcRelativePos) {
			alert('Control Name supplied to calculate relative position of the Wrapper does not exist in DOM.');
		} else {
			var elPosition = findPos(controlToCalcRelativePos);
			shiftByX = shiftByX || 0;
			shiftByY = shiftByY || 0;
			cdiv.style.left = elPosition[0] + shiftByX; 
			cdiv.style.top = elPosition[1] + shiftByY;
		}
	}
	
	var classTree = ["north","east","south","west","ne","se","sw","nw"];
	var tempdivs = [];
	var tempinner = cdiv.innerHTML;
	cdiv.innerHTML = "";
	prevdiv = cdiv;
	for(var a = 0; a < classTree.length; a++) {
		tempdivs[a] = document.createElement('DIV');
		tempdivs[a].className = classTree[a];
		prevdiv.appendChild(tempdivs[a]);
		prevdiv = tempdivs[a];
	}
	
	if(includeCloseButton && includeCloseButton == true) {
		var myCloseButtonDiv = document.createElement("DIV");
		myCloseButtonDiv.id = "closeButton" + cdiv.id;
		myCloseButtonDiv.className = "ajaxDivNotificationCloseButton";
		myCloseButtonDivEvents(myCloseButtonDiv, cdiv);
	
		var myMoveButtonDiv = document.createElement("DIV");
		myMoveButtonDiv.id = "moveButton" + cdiv.id;
		myMoveButtonDiv.className = "ajaxDivNotificationMoveButton";
		myMoveButtonDivEvents(myMoveButtonDiv, cdiv);
		
		myMoveButtonDiv.appendChild(myCloseButtonDiv);

		var header     = document.createElement("table");
		var headerBody = document.createElement("tbody");
		var headerRow = document.createElement("tr");
		var headerCell1 = document.createElement("td");
		headerCell1.appendChild(myMoveButtonDiv);
		headerRow.appendChild(headerCell1);
		var headerCell2 = document.createElement("td");
		headerCell2.appendChild(myCloseButtonDiv);
		headerRow.appendChild(headerCell2);
		headerCell2.setAttribute("align","right");
		headerBody.appendChild(headerRow);
		header.appendChild(headerBody);
		header.className = "ajaxDivTablePlain"
		header.style.width = (width==null) ? "auto" : parseInt(width) - 50;
		prevdiv.appendChild(header);
	}

	if(includeTitle && includeTitle == true) {
		var titleContainer = document.createElement("DIV");
		titleContainer.className = "sectionHeader";
		var title = createSpanElement("title" + cdiv.id, (titleText) ? titleText : "", "sectionHeader")
		titleContainer.appendChild(title);
		prevdiv.appendChild(titleContainer)
	}
	
	var newDiv = document.createElement('DIV');
	newDiv.id = "contentContainer" + cdiv.id
	//newDiv.id = "feedback" + controlNameToCalcRelativePos;
	
	newDiv.innerHTML += tempinner;
	prevdiv.appendChild(newDiv);
	

	if(includeSaveButton && includeSaveButton == true) {
		var saveLink = document.createElement('A');
		saveLink.id = "save" + controlNameToCalcRelativePos;
		saveLink.setAttribute("href","javascript:;");
		saveLink.innerHTML = "<BR>[save]";
		newDiv.appendChild(saveLink);
		
		newDiv.innerHTML += "&nbsp&nbsp&nbsp";
		
		var cancelLink = document.createElement('A');
		cancelLink.id = "cancel" + controlNameToCalcRelativePos;
		cancelLink.setAttribute("href","javascript:;");  
		cancelLink.innerHTML = "[cancel]";
		newDiv.appendChild(cancelLink);

		if(includeRemoveButton && includeRemoveButton == true) {
			newDiv.innerHTML += "&nbsp&nbsp&nbsp";
			var removeLink = document.createElement('A');
			removeLink.id = "remove" + controlNameToCalcRelativePos;
			removeLink.setAttribute("href","javascript:;");  
			removeLink.innerHTML = "[remove]";
			newDiv.appendChild(removeLink);
		}

		newDiv.innerHTML += "&nbsp&nbsp&nbsp";
		newDiv.innerHTML += "<img id='progressIndicator" +  controlNameToCalcRelativePos + "' width='15px' height='15px' class='AjaxHidden' src='/SSWF/Images/ProgressIndicator_medium.gif'>"

		noteDiv = document.createElement('DIV');
	noteDiv.id = "feedback" + controlNameToCalcRelativePos;
	newDiv.appendChild(noteDiv);
	
		myCancelButtonEvent(cancelLink, cdiv);
	}
	
	return prevdiv;
}

function collapser(XXX, cdiv) {
	XXX.onclick = function() {
			var obj = document.getElementById("contentContainer" + cdiv.id); 
			obj.className = (obj.className == 'AjaxVisible') ? 'AjaxHidden' : 'AjaxVisible';
			
			var divobj = document.getElementById("BiographicalInfo"); 
			cdiv.className = (divobj.className == 'AjaxSectionNormal') ? 'AjaxSectionShrinksed' : 'AjaxSectionNormal';
		};
}

function myMoveButtonDivEvents(myMoveButtonDiv, targetControl) {
	myMoveButtonDiv.onmousedown = function() {
		var myNonElements = [ ];
		document.onmousemove = function(e) { getMoving(e, targetControl); return false; };
	};
	myMoveButtonDiv.onmouseup = function() {
		document.onmousemove = function(e) { return true; };
	};
	myMoveButtonDiv.onmouseover = function() {
		this.className = "ajaxDivNotificationMoveButton";
	};
	myMoveButtonDiv.onmouseout = function() {
		this.className = "ajaxDivNotificationMoveButton";
	};
}

function myCloseButtonDivEvents(myCloseButtonDiv, targetControl){
	myCloseButtonDiv.onclick = function(){ closeControl(targetControl.id); };
	myCloseButtonDiv.onmouseover = function() { this.className = "ajaxDivNotificationCloseButtonMouseOver" };
	myCloseButtonDiv.onmouseout = function() { this.className = "ajaxDivNotificationCloseButton" };
	myCloseButtonDiv.onmousedown = function() { this.className = "ajaxDivNotificationCloseButtonPressed" };
	myCloseButtonDiv.onmouseup = function() { this.className = "ajaxDivNotificationCloseButton" };
}

function myCancelButtonEvent(myCancelButton, targetControl){
	myCancelButton.onclick = function() {closeControl(targetControl.id); };
}

function closeControl(controlName) {
	var myBody = document.getElementsByTagName("body")[0];
	var myDiv = document.getElementById(controlName);
	var iframe = document.getElementById("jhu_HoverPanel[" + controlName + "].Iframe");
	if(myDiv) {
		myBody.removeChild(myDiv);
	}
	if(iframe) {
		myBody.removeChild(iframe);
	}
}

function progressIndicator(popupName, IsVisible) {
	var pi = document.getElementById("progressIndicator" + popupName);
	if (pi == null) { //alert('ProgressBar control not found'); 
						return; }
	
	if (IsVisible == true) { pi.className = ""; }
	else				   { pi.className = "AjaxHidden"; }
	
}

function writeFeedback(popupName, feedbackSpanName, msg, msgCssName){
	// Find Feedback container DIV
	var name = popupName.split("_");
	var popupName = name[0].replace("temp","").replace("hidden","");
	
	var pl = document.getElementById("feedback" + popupName);
	if(pl) {
		if(document.getElementById(feedbackSpanName) == null) {
			var val = createSpanElement(feedbackSpanName, "<BR>" + msg, msgCssName);
			pl.appendChild(val);
			try{
			val.focus();
			}catch(e){ }
			return true;
		} else {
			//Remove if message exists - to support easy msg replacement
			removeFeedback(popupName, feedbackSpanName);
			writeFeedback(popupName, feedbackSpanName, msg, msgCssName); // round trip
		}
	}
	
	return false;
}

function removeFeedback(popupName, feedbackSpanName){
	// Find Feedback container DIV
	var name = popupName.split("_");
	var popupName = name[0].replace("temp","").replace("hidden","");

	var pl = document.getElementById("feedback" + popupName);
	if(pl) {
		if(document.getElementById(feedbackSpanName) != null) {
			var val = document.getElementById(feedbackSpanName);
			pl.removeChild(val);
			return true;
		}
	}
	
	return false;
}



function getMoving(e, el) {
	e = e || window.event;
	var cursor = {x:0, y:0};
	if(e.pageX || e.pageY) {
		cursor.x = e.pageX;
		cursor.y = e.pageY;
	} else {
		var de = document.documentElement;
		var b = document.body;
		cursor.x = e.clientX + 
			(de.scrollLeft || b.scrollLeft) - (de.clientLeft || 0);
		cursor.y = e.clientY + 
			(de.scrollTop || b.scrollTop) - (de.clientTop || 0);
	}
	
	//statusDiv = document.getElementById("Status")
	//statusDiv.innerHTML = "Cursor position: " + cursor.x + ":" + cursor.y
	if (jQuery) {
		jQuery(el).css({top:cursor.y - 35, left: cursor.x - 32});
	}
	else {
		el.style.top = cursor.y - 35;
		el.style.left = cursor.x - 32;
	}
	
	var iframe = document.getElementById("jhu_HoverPanel[" + el.id + "].Iframe");
	if(iframe) {
		iframe.style.top = el.style.top;
		iframe.style.left = el.style.left;
	}
	
	return cursor;
}

function findPos(obj) {
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		curleft = obj.offsetLeft
		curtop = obj.offsetTop
		while (obj = obj.offsetParent) {
			curleft += obj.offsetLeft
			curtop += obj.offsetTop
		}
	}
	return [curleft,curtop];
}
	
	
function createInlineMessage(selfControl,controlName, value, shiftByY, shiftByX, divWidth, useiframe){
//	try { closeAllMessages(); } // the function doesn't exist!
//	catch(err) {};
	
	var myBody = document.getElementsByTagName("body")[0]
	
//	if (typeof(messages) != "undefined") {
//		messages[messages.length] = controlName;
//	}
	
	if (document.getElementById(controlName) == null) {
		var myDiv = document.createElement("DIV");
		myDiv.id = controlName;
		myDiv.className = "ajaxDivNotification";
		
		var myLabel = document.createElement("DIV");
		myLabel.className = "ajaxDivNotificationText";
		myLabel.innerHTML = "<a ID=" + controlName + "note href='#' alt='Note:'></a>" + value;
		myDiv.appendChild(myLabel);
		
		//SNL allow width to be specified, or use orig value of 300
		divWidth = divWidth || 300;
		wrapper(myDiv, divWidth, selfControl.id, shiftByY, shiftByX,true);
		//SNL END REPLACED -- wrapper(myDiv, 300, selfControl.id, shiftByY, shiftByX,true);
		myBody.appendChild(myDiv);
		if(useiframe == null || useiframe == true){
			var iframe = document.createElement("iframe");
			iframe.id = "jhu_HoverPanel[" + controlName + "].Iframe";
			iframe.src = "javascript:false";
			iframe.style.position = "absolute";
			iframe.style.top = myDiv.style.top;
			iframe.style.left = myDiv.style.left;
			iframe.style.width = myDiv.clientWidth;
			iframe.style.height = myDiv.clientHeight;
			iframe.style.padding = "0px";
			iframe.style.margin = "0px";
			iframe.style.border = "0px";
			iframe.style.filter = "alpha(opacity = 0)";
			iframe.scrolling = "no";
			
			myDiv.onresize = function() {
				iframe.style.width = myDiv.clientWidth;
				iframe.style.height = myDiv.clientHeight;
			};
	
			myBody.insertBefore(iframe, myDiv);
		}
		
		//related to accessibility - screen readers, in particular
		var focusOnControl = document.getElementById(controlName + "note");
		if(focusOnControl) {
			focusOnControl.focus();
		}
	}
	else {
		closeControl(controlName);
	}
}

			
// Generic - extending javascript Array object to include indexOf method
Array.prototype.indexOf=function(obj){
	for (ArrayItem=0; ArrayItem<this.length; ArrayItem++){	
		if (this[ArrayItem]==obj ) {
			return ArrayItem;
		}
	}
	return -1;
};

function createSpanElement(spanControlName, spanControlText, spanClass) {
	newSpan = document.createElement('span');
	newSpan.id = spanControlName;
	newSpan.className = spanClass;
	newSpan.innerHTML = spanControlText;
	
	return newSpan;
}

function createTextBoxElement(textControlName, textControlValue, sizePx, maxLength){
	newTextBox = document.createElement('input');
	newTextBox.setAttribute('type', 'text');
	newTextBox.setAttribute('id',textControlName);
	newTextBox.setAttribute('name',textControlName);
	newTextBox.setAttribute('value', textControlValue);
	newTextBox.setAttribute('size', sizePx);
	newTextBox.setAttribute('maxLength', maxLength);
	
	return newTextBox;
}

function createCheckBox(checkControlName, checkControlValue){
	checkBox = document.createElement("input"); 
	checkBox.setAttribute('type', 'checkbox');
	checkBox.setAttribute('id',checkControlName);
	checkBox.setAttribute('name',checkControlName);
	checkBox.checked = checkControlValue;                 
	//checkBox.checked = true make it checked; checkBox.defaultChecked by default

	return checkBox;
}

function createDropDownElement(controlName, arr, selectedValue) {
	myselect = document.createElement("SELECT");
	myselect.id=controlName;
	
	for (i=0;i<arr.length;i++) {
		theOption=document.createElement("OPTION");
		theText=document.createTextNode(arr[i]);
		theOption.appendChild(theText);
		theOption.setAttribute("value",arr[i]);
		if (arr[i] == selectedValue) {			// Does not work in Firefox, expects elent to be attached to Body, 
			theOption.selected = true;			// before it accepts value
		}
		myselect.appendChild(theOption);
	}
	
	return myselect;
}

function createTableElement(twoDimensionalControlArray) {
	var rowCount = twoDimensionalControlArray.length;
	var columnCount = twoDimensionalControlArray[0].length;
	
	mytable     = document.createElement("table");
	mytablebody = document.createElement("tbody");

	for(var j = 0; j < rowCount; j++) {
		mycurrent_row = document.createElement("tr");
		for(var i = 0; i < columnCount; i++) {
			mycurrent_cell = document.createElement("td");
			mycurrent_cell.className = "label";
			mycurrent_cell.appendChild(twoDimensionalControlArray[j][i]);
			mycurrent_row.appendChild(mycurrent_cell);
		}
		mytablebody.appendChild(mycurrent_row);
	}
	
	mytable.appendChild(mytablebody);
	mytable.setAttribute("border", "0");
	return mytable;
}

function compareValues(value1, value2){
	if (value1 != value2) {	return false;} 
	else {return true;}
}

function jhuRegularExpressionValidatorEvaluateIsValid(value, expression) {
    if (jhuValidatorTrim(value).length == 0)
        return true;        
    var rx = new RegExp(expression);
    var matches = rx.exec(value);
    return (matches != null && value == matches[0]);
}
function jhuValidatorTrim(s) {
    var m = s.match(/^\s*(\S+(\s+\S+)*)\s*$/);
    return (m == null) ? "" : m[1];
}

function trimAll(sString)
{
	while (sString.substring(0,1) == ' ')
	{
		sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' ')
	{
		sString = sString.substring(0,sString.length-1);
	}
	return sString;
}
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  jhu.DownloadAsync - function(url, onsuccess, onfailure, data, ispost,     //
//                               israwdata, timeout).                         //
//  arguments:                                                                //
//      url - string.                                                         //
//          The url pointing to the content to be downloaded. The url *must*  //
//          be properly url-encoded. It may include query-string parameters,  //
//          which *must* also be properly url-encoded.                        //
//      onsuccess - function(text).                                           //
//          remarks:                                                          //
//              Will be called when the async download is complete, and will  //
//              be passed the content downloaded.                             //
//          arguments:                                                        //
//              text - string.                                                //
//                  The content downloaded.                                   //
//      onfailure - function(error).                                          //
//          remarks:                                                          //
//              A generic error-handler, which will be called when an error   //
//              is detected.                                                  //
//          arguments:                                                        //
//              error - Error.                                                //
//                  An exception Error object containing, generally contain-  //
//                  a 'message' property.                                     //
//      data - israwdata ? string : object (default = null)                   //
//          remarks:                                                          //
//              If 'israwdata' is set to 'true', the type is 'string'; else-  //
//              wise, the type is 'object'.                                   //
//              The object is treated as an associative array. For every      //
//              user-defined property, that property's name and values are    //
//              added as property-value pairs to the query string or, if      //
//              'ispost' is set to 'true', to the content of the http-post    //
//              message.                                                      //
//      ispost - boolean (default = false)                                    //
//          remarks:                                                          //
//              If 'true', the request will be sent via http-post. Otherwise  //
//              the request will be sent via http-get.                        //
//      israwdata - boolean (default = false)                                 //
//          remarks:                                                          //
//              If 'true' (and 'ispost' is 'true'), the value of 'data' will  //
//              be sent unmangled. Otherwise, the 'data' parameter will be    //
//              interpreted as an array of name-value pairs and will be url-  //
//              encoded based on that interpretation.                         //
//      timeout - number (default = 0)                                        //
//          remarks:                                                          //
//              If a number greater than 0, the async download will abort     //
//              after 'timeout' milliseconds has elapsed and the async down-  //
//              load has not yet completed.                                   //
//  returns:                                                                  //
//      { Cancel - function() }                                               //
//          remarks:                                                          //
//              An object containing a function 'Cancel' which the user may   //
//              call at any time to cancel the download.                      //
//                                                                            //
//  jhu.DownloadAsyncEx - function(namedparams).                              //
//  remarks:                                                                  //
//      A wrapper around jhu.DownloadAsync taking an object representing      //
//      a dictionary of named parameters.                                     //
//  arguments:                                                                //
//      namedparams - { url, onsuccess, onfailure, ispost, israwdata,         //
//                      timeout }.                                            //
//          remarks:                                                          //
//              These properties have all the same semantics as the corres-   //
//              pondingly named parameters of 'jhu.DownloadAsync'.            //
//                                                                            //
//  additional notes:                                                         //
//      Parameters such as 'ispost' and 'israwdata' which are marked as of    //
//      type boolean have the following convention: Any value 'v' such that   //
//      '!v' evaluates to 'true' will be considered 'false'; any other value  //
//      'v' will be considered true.                                          //
//                                                                            //
//  example:                                                                  //
//      var url = "/MyPage.aspx";                                             //
//      var onsuccess = function(text) {                                      //
//          document.getElementById("MyPanel").InnerText = text;              //
//      };                                                                    //
//      var onfailure = function() {                                          //
//          alert("Oh no!");                                                  //
//      };                                                                    //
//      var data = { PreliminaryStuff: "Jay Rocks!" };                        //
//      data.ProductId = document.getElementById("Product").Value;            //
//      data.EmployeeName = document.getElementById("Employee").Value;        //
//      jhu.DownloadAsync(url, onsuccess, onfailure, data, true, false);      //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
//  Assure our namespaces exist.
////////////////////////////////////////////////////////////////////////////////

if(typeof jhu == "undefined") jhu = { };



////////////////////////////////////////////////////////////////////////////////
//  Generic higher-order functional-style functions.
////////////////////////////////////////////////////////////////////////////////

//  Aggregates 'func' applied pairwise to the previous partial aggregate (or
//  'initial') and the next element of 'array' or property of 'object'.
//  Aggregation is often considered the basic generic function from which the
//  other functions may be derived. Such is true, and such is illustrated here.
jhu.ArrayReduce = function(func, initial, array, starti, length) {
	starti =
		starti === 0 ? 0 :
		!starti ? 0 :
		starti < 0 ? 0 :
		starti > array.length ? array.length :
		starti;
	length =
		length === 0 ? 0 :
		!length ? array.length - starti :
		length < 0 ? 0 :
		length > array.length - starti ? array.length - starti :
		length;
	for(var i = starti; i < starti + length; i += 1) {
		initial = func(initial, array[i]);
	}
	return initial;
};
jhu.DictionaryReduce = function(func, initial, dictionary) {
	for(var current in dictionary) {
		initial = func(initial, current, dictionary[current]);
	}
	return initial;
};

//  ForEach. Applies 'func' to each element of 'array' or each property of 'dictionary'.
jhu.ArrayForEach = function(func, array, starti, length) {
	jhu.ArrayReduce(
		function(i, c) { func(c); },
		null, array, starti, length);
};
jhu.DictionaryForEach = function(func, dictionary) {
	jhu.DictionaryReduce(
		function(i, key, val) { func(key, val); },
		null, dictionary);
};

//  Filter. Evaluates 'func' on each element of 'array' or each property of 'dictionary',
//  retrieving those elements or properties for which 'func' evaluates to true (or any
//  value convertible to true).
jhu.ArrayFilter = function(func, array, starti, length) {
	return jhu.ArrayReduce(
		function(i, c) { if(func(c)) i.push(c); return i; },
		[ ], array, starti, length);
};
jhu.DictionaryFilter = function(func, dictionary) {
	return jhu.DictionaryReduce(
		function(i, key, val) { if(func(key, val)) i[key] = val; return i; },
		{ }, dictionary);
};

//  Map. Projects the elements of 'array' or the properties of 'dictionary'
//  to new elements of a new array or new properties of a new dictionary.
jhu.ArrayMap = function(func, array, starti, length) {
	return jhu.ArrayReduce(
		function(i, c) { i.push(func(c)); return i; },
		[], array, starti, length);
};
jhu.DictionaryMap = function(func, dictionary) {
	return jhu.DictionaryReduce(
		function(i, key, val) { i[key] = func(key, val); return i; },
		{ }, dictionary);
};

jhu.ArrayTrueForAll = function(func, array, starti, length) {
	return jhu.ArrayReduce(
		function(i, c) { return i && !!func(c); },
		true, array, starti, length);
};
jhu.ArrayTrueForSome = function(func, array, starti, length) {
	return jhu.ArrayReduce(
		function(i, c) { return i || !!func(c); },
		false, array, starti, length);
};
jhu.ArrayFalseForAll = function(func, array, starti, length) {
	return jhu.ArrayReduce(
		function(i, c) { return i && !func(c); },
		true, array, starti, length);
};
jhu.ArrayFalseForSome = function(func, array, starti, length) {
	return jhu.ArrayReduce(
		function(i, c) { return i || !func(c); },
		false, array, starti, length);
};
jhu.DictionaryTrueForAll = function(func, dictionary) {
	return jhu.DictionaryReduce(
		function(i, key, val) { return i && !!func(key, val) },
		true, dictionary);
};
jhu.DictionaryTrueForSome = function(func, dictionary) {
	return jhu.DictionaryReduce(
		function(i, key, val) { return i || !!func(key, val) },
		false, dictionary);
};
jhu.DictionaryFalseForAll = function(func, dictionary) {
	return jhu.DictionaryReduce(
		function(i, key, val) { return i && !func(key, val) },
		true, dictionary);
};
jhu.DictionaryFalseForSome = function(func, dictionary) {
	return jhu.DictionaryReduce(
		function(i, key, val) { return i || !func(key, val) },
		false, dictionary);
};



//  Copy.
jhu.ArrayCopy = function(array, starti, length) {
	return jhu.ArrayMap(
		function(c) { return c; },
		array, starti, length);
};
jhu.DictionaryCopy = function(dictionary) {
	return jhu.DictionaryMap(
		function(key, val) { return val; },
		dictionary);
};

//  Concatenate. Accepts unlimited arguments, each of which is an array or dictionary.
//  ArrayConcatenate will add the elements from each array in the order that the arrays
//  are passed. Elements from later arrays may therefore not keep the same indexes they
//  once had. That is a warning.
//  DictionaryConcatenate will add the properties from each dictionary in the order that
//  the dictionaries are passed. If a later dictionary contains the same key as an earlier
//  dictionary, then only the later dictionary's property is kept. That is a warning.
jhu.ArrayConcatenate = function() {
	return jhu.ArrayReduce(
		function(i, c) {
			return jhu.ArrayReduce(
				function(i, c) { i.push(c); return i; },
				i, c); },
		[], arguments);
};
jhu.DictionaryConcatenate = function() {
	return jhu.ArrayReduce(
		function(i, c) {
			return jhu.DictionaryReduce(
				function(i, key, val) { i[key] = val; return i; },
				i, c); },
		{ }, arguments);
};



jhu.ArrayReverse = function(array, starti, length) {
	return jhu.ArrayReduce(
		function(i, c) { i.unshift(c); return i; },
		[], array, starti, length);
};
jhu.ArrayContains = function(array, value, starti, length) {
	return jhu.ArrayTrueForSome(function(c) { return value == c; }, array, starti, length);
};



//  Invoke.
jhu.Invoke = function(func, args) {
	return func.apply(null, args || []);
};

//  Binding curry (see Prototype).
//  Note: this returns a higher-order currying function *regardless* of the number of formal
//  parameters involved. This *never* evaluates the function. This is what I consider the
//  logical behavior: currying is the explicit delay of both: application of arguments *and*
//  evaluation.
jhu.Bind = function(scope, func) {
	var curriedargs = jhu.ArrayCopy(arguments, 2); // Preserve the outer arguments array.
	return function() {
		var args = jhu.ArrayCopy(arguments);
		return func.apply(scope, curriedargs.concat(args));
	};
};
//  Nonbinding curry.
jhu.Curry = jhu.Bind(null, jhu.Bind, null);

//  Compose. Accepts unlimited arguments, each of which is a function.
//  Returns a function which applies the last of the accepted functions to its arguments,
//  then applies the second-to-last of the accepted functions to the partial result, and
//  so on until it returns the result of the first accepted function.
//  Each funtion except the last must take one argument only (that argument can be an array
//  which the next function returns to it). The last function is passed all the arguments
//  which are passed to the composition itself.
jhu.Compose = function() {
//	var args = arguments.length === 1 && arguments[0] instanceof Array ? arguments[0] : arguments;
	var funcs = jhu.ArrayCopy(arguments).reverse(); // arguments isn't a native array.
	return function() {
		return jhu.ArrayReduce(
			function(i, c) { return [c.apply(null, i)]; },
			arguments, funcs)[0];
	};
};

//  FirstOf. Accepts unlimited arguments, each of which is a function.
//  Begins evaluating each accepted function, returning immediately as soon as an
//  accepted function returns a non-null value or object and returning that value
//  or object.
jhu.FirstOf = function() {
//	var args = arguments.length === 1 && arguments[0] instanceof Array ? arguments[0] : arguments;
	for(var i = 0; i < funcs.length; i++) {
		var t = funcs[i]();
		if(typeof t !== "undefined") return t;
	}
};



////////////////////////////////////////////////////////////////////////////////
//  Other helper functions.
////////////////////////////////////////////////////////////////////////////////

jhu.IsNull = function(object) { return typeof object === "undefined"; };
jhu.Identity = function(object) { return object; }
jhu.Negate = function(object) { return !object; }

//  Serializes and url-encodes the properties of 'object'.
jhu.DictionaryUrlSerialize = function(dictionary) {
	var encode = encodeURIComponent;
	var concat = function(initial, key, val) {
		var current = !val ? encode(key) : encode(key) + "=" + encode(val);
		return !initial ? current : initial + "&" + current;
	};
	return jhu.DictionaryReduce(concat, null, dictionary);
};

//  XMLHttpRequest ... notsoez
//  This is here for reference only. Also as an example of Currying Curry(...), which itself is defined
//  as Binding Bind(...), making this a Curried Curried Curried Curry.
jhu.CreateTransport = function() {
	var names = [ "Msxml2.XMLHTTP.6.0", "Msxml2.XMLHTTP.5.0", "Msxml2.XMLHTTP.4.0", "Msxml2.XMLHTTP.3.0", "Msxml.XMLHTTP", "Microsoft.XMLHTTP" ];
	var tryname = function(name) { try { return new window.ActiveXObject(name); } catch(ex) { } };
	
	return null || // retardo javascript lets "return \n value;" turn into "return; value;" ... not so good ...
		window.XMLHttpRequest && new window.XMLHttpRequest() ||
		window.ActiveXObject  && jhu.FirstOf(jhu.ArrayMap(jhu.Curry(jhu.Curry, tryname), names)) ||
		null;
};



////////////////////////////////////////////////////////////////////////////////
//  DownloadAsync
//      Use DownloadAsyncEx instead.
////////////////////////////////////////////////////////////////////////////////

jhu.DownloadAsync = function(url, onsuccess, onfailure, data, ispost, israwdata, timeout) {
	//  The following enums are *not* complete listings.
	//  They include *only* the values herein used.
	var XhrState = {
		Complete: 4
	};
	var HttpStatus = {
		Ok: 200
	};
	var HttpMethod = {
		Get: "GET",
		Post: "POST"
	};
	var HttpContentType = {
		Text: "text/plain",
		UrlEncoded: "application/x-www-form-urlencoded"
	};
	//  Useful?
	var ErrorFactory = {
		ClientXmlHttpRequestError: function() {
			this.Type = "ClientXmlHttpRequest";
			this.toString = function() { return "The browser was unable to create an XMLHttpRequest object. This may indicate an unknown or unsupported browser or browser settings which restrict the use of Ajax."; };
		},
		ClientScriptError: function(error) {
			this.Type = "ClientScript";
			this.Error = error;
			this.toString = function() {
				return "The browser encountered a script error occurred in the processing of the asynchronous Http request." +
					"<br />Name: " + error.name +
					"<br />Number: " + error.number +
					"<br />Description: " + error.description +
					"<br />Message: " + error.message; };
		},
		TransmissionTimeoutError: function(timeout) {
			this.Type = "TransmissionTimeout";
			this.Timeout = timeout;
			this.toString = function() { return "The server did not respond within the specified timeout (" + this.Timeout + " milliseconds)."; };
		},
		ServerError: function(statusCode, statusMessage) {
			this.Type = "Server";
			this.HttpStatusCode = statusCode;
			this.HttpStatusMessage = statusMessage;
			this.toString = function() {
				return "The server returned a response code indicating something other than success (" +
					this.HttpStatusCode + ": " + this.HttpStatusMessage + ")."; }
		}
	};

	ispost = !!ispost; // explicit conversions to boolean.
	israwdata = !!israwdata;
	
	var longtime = new Date();
		longtime.setYear(longtime.getYear() - 10);

	//  The XHR.
	var xhr = // jhu.CreateTransport();
		(window.XMLHttpRequest && new window.XMLHttpRequest()) ||
		(window.ActiveXObject  && new window.ActiveXObject("Microsoft.XMLHTTP")) ||
		null;

	//  We want at most one of { onsuccess, onfailure } to fire each time DownloadAsync is called
	//  (exactly one if timeout is set to a positive number). Finalize ensures this.
	var extant = true;  // note: nonconst state variable - does the xhr still "exist"?
	var finalize = function() {
		if(!extant) {
			return false;
		} else {
			extant = false;
			xhr && (xhr.onreadystatechange = function() { });
			xhr && xhr.abort();
			return true;
		}
	};
	
	//  There should be a generic functional way to do this kind of wrapping. Thoughts?
	//  Note: Not doing type-checking because exceptions *should* be thrown if objects
	//  are passed as functions.
	//  Note: These exploit the boolean operators' shortcut evaluation strategy.
	//  Note: don't do processing inside the statechange handler. Postpone processing.
	var dosuccess = function(text) {
		window.setTimeout(function() { finalize() && onsuccess && onsuccess(text); }, 0);
	};
	var dofailure = function(error) {
		window.setTimeout(function() { finalize() && onfailure && onfailure(error); }, 0);
	};
	
	//  The XHR calls this function when stuff happens. We want to filter out unnecessary events
	//  and call onsuccess(text) and onfailure() as appropriate.
	var statechange_handler = function() {
		if(xhr.readyState == XhrState.Complete) {
			if(!xhr.status || xhr.status == HttpStatus.Ok)
				return dosuccess(xhr.responseText);
			else
				return dofailure(new ErrorFactory.ServerError(xhr.status, xhr.statusText));
		}
	};
	
	//  Make timeouts work.
	var timeout_handler = function() {
		if(xhr.readyState != XhrState.Complete)
			return dofailure(new ErrorFactory.TransmissionTimeoutError(timeout));
	};
	
	try {
		if(!xhr)
			return dofailure(new ErrorFactory.ClientXmlHttpRequestError());

		//  Pack the data to be sent out.
		var serialized = !data ? null : israwdata ? data : jhu.DictionaryUrlSerialize(data);
		var urlmark = url.indexOf("?") >= 0;
		var urllast = url.charAt(url.length - 1);
		var urlglue = !urlmark ? "?" : urllast != "?" && urllast != "&" ? "&" : "";
		var finalurl = (!serialized || ispost) ? url : (url + urlglue + serialized);
		var finaldata = (!serialized || !ispost) ? null : serialized;

		//  The collection of headers the XHR will need.
		var headers = {
			"Content-Type": israwdata ? HttpContentType.Text : HttpContentType.UrlEncoded,
			"If-Modified-Since": longtime // otherwise IE might cache stuff unexpectedly.
		};
		//  Why, IE and Opera? Why? Why do you forbid binding a COM object's function to its object?
		//  Why does xhr.setRequestHeader.apply(xhr, ...) throw all sorts of errors? Why would you
		//  ruin what otherwise would be beautiful code?
		var setheader = function(key, val) { xhr.setRequestHeader(key, val); }

		//  Make the magic happen.
		timeout && timeout > 0 && window.setTimeout(timeout_handler, timeout);
		xhr.open(ispost ? HttpMethod.Post : HttpMethod.Get, finalurl, true);
		jhu.DictionaryForEach(setheader, headers);
		xhr.onreadystatechange = statechange_handler;
		xhr.send(finaldata);
		
		return {
			Cancel: finalize
		};
	} catch(ex) {
		return dofailure(new ErrorFactory.ClientScriptError(ex));
	}
};



////////////////////////////////////////////////////////////////////////////////
//  DownloadAsyncEx
//      A wrapper for DownloadAsync which takes named parameters instead of
//      ordinal (idenfitied-by-index) parameters. Use this instead of
//      DownloadAsync.
////////////////////////////////////////////////////////////////////////////////

jhu.DownloadAsyncEx = function(params) {
	return jhu.DownloadAsync(
		params.url,
		params.onsuccess,
		params.onfailure,
		params.data,
		params.ispost,
		params.israwdata,
		params.timeout);
};




////////////////////////////////////////////////////////////////////////////////
//  Namespace: jhu
////////////////////////////////////////////////////////////////////////////////

if(typeof jhu == "undefined") jhu = { };



////////////////////////////////////////////////////////////////////////////////
//  Elems
//      A helper object/type to encapsulate the naming scheme and to make
//      getting elements a touch easier. Sort of what Prototype's $ is for,
//      but does different stuff.
////////////////////////////////////////////////////////////////////////////////

var Elems = function(prefix) {
	var byid = function(id) { return document.getElementById(id); };
	this.FindName = jhu.Curry(function(a, b) { return a + b; }, prefix); // illustrating Curry
	this.FindElem = jhu.Compose(byid, jhu.Bind(this, this.FindName)); // illustrating Compose
	this.Add = function() {
		jhu.ArrayForEach(
			jhu.Bind(this, function(c) { this[c] = this.FindElem(c); }), 
			arguments);
	};
};



////////////////////////////////////////////////////////////////////////////////
//  DOM helper functions.
//      Similar to Prototype. (Not yet used.)
////////////////////////////////////////////////////////////////////////////////

jhu.ElementClassNamesGet = function(elem) {
	return elem.className.split(/\s+/);
};
jhu.ElementClassNamesSet = function(elem, names) {
	elem.className = names.join(" ");
};
jhu.ElementClassNamesAdd = function(elem) {
	var orig = jhu.ElementClassNamesGet(elem);
	jhu.ElementClassNamesSet(
		elem,
		jhu.ArrayFilter(
			jhu.Compose(jhu.Negate, jhu.Curry(jhu.ArrayContains, orig)),
			arguments
		).concat(orig)
	);
};
jhu.ElementClassNamesRemove = function(elem) {
	var orig = jhu.ElementClassNamesGet(elem);
	jhu.ElementClassNamesSet(
		elem,
		jhu.ArrayFilter(
			jhu.Compose(jhu.Negate, jhu.Curry(jhu.ArrayContains, arguments)),
			orig
		)
	);
};



////////////////////////////////////////////////////////////////////////////////
//  ShowButton_Click
////////////////////////////////////////////////////////////////////////////////

jhu_GiveFeedback_ShowButton_Click = function() {
	var MyClasses = {
		IconTalk: "icon-talk-16-right",
		IconAjax: "icon-ajax-16-right"
	};
	var MyPos = {
		Top : 25,
		Left : -575,
		Width : 575
	};
	var MyElems = new Elems("jhu_GiveFeedback_");
	closeControl(MyElems.FindName("Message"));

	MyElems.Add("ShowButtonContainer");
	MyElems.ShowButtonContainer.className = MyClasses.IconAjax;

	var url = "../../Framework/JHU_GiveFeedback/JHU_GiveFeedback.aspx";

	new Ajax.Request(url,
        {
            method: 'get',         
            onSuccess: function(transport) {
                MyElems.ShowButtonContainer.className = MyClasses.IconTalk;
                showWin({
                    title: "Give Feedback",
                    content: transport.responseText,
                    width: 530,
                    top: 0,
                    left: -575,
                    offsetElement: MyElems.ShowButtonContainer,
                    offsetCorner: { x: "right", y: "top" }
                });               
                MyElems.Add("OuterContainer");
                MyElems.Add("FeedbackText");
                MyElems.FeedbackText.focus();
            },
            onFailure: function() {
                MyElems.ShowButtonContainer.className = MyClasses.IconTalk;
                var text = "<div id='" + MyElems.FindName("ErrorContainer") + "' class='label' style='width: 100%; position: relative;'>" +
			    "<p>An error has occurred.</p><div id='" + MyElems.FindName("ErrorDetails") + "'><p></p></div></div>";
                showWin({
                    title: "Give Feedback",
                    content: text,
                    width: 530,
                    top: 10,
                    left: -575,
                    offsetElement: MyElems.ShowButtonContainer,
                    offsetCorner: { x: "right", y: "top" }
                });
                MyElems.Add("ErrorDetails");
                MyElems.ErrorDetails.innerHTML = "<p>Details: " + error.toString() + "</p>";
            },
            onComplete: function() {
                
            }
        }
    );
}



////////////////////////////////////////////////////////////////////////////////
//  SubmitButton_Click
////////////////////////////////////////////////////////////////////////////////

jhu_GiveFeedback_SubmitButton_Click = function() {
	
	var MyElems = new Elems("jhu_GiveFeedback_");
	MyElems.Add(
		"FormContainer",
		"ThanksContainer",
		"ErrorContainer",
		"ErrorDetails",
		"FeedbackText",
		"FeedbackTextValidation",
		"MaskIdentity",
		"SubmitButton",
		"CloseButton"
	);

	//  Do some rudimentary validation. Misnamed methods...
	var MyErrors = {
		FeedbackText: {
			Valid: function() {
				return !MyElems.FeedbackText.value.match(/^\s*$/);
			},
			Alert: function() {
				MyElems.FeedbackTextValidation.style.visibility =
					MyErrors.FeedbackText.Valid()
					? "hidden"
					: "visible";
			},
			Setup: function() {
				if(this.Valid()) {
					MyElems.FeedbackText.onchange = function() { };
					MyElems.FeedbackText.onkeyup = function() { };
				} else {
					MyElems.FeedbackText.value = "";
					MyElems.FeedbackText.onchange = this.Alert;
					MyElems.FeedbackText.onkeyup = this.Alert;
				}
			},
			Focus: function() {
				MyElems.FeedbackText.focus();
			}
		}
	};
	for(var name in MyErrors)
		MyErrors[name].Setup();
	for(var name in MyErrors)
		MyErrors[name].Alert();
	for(var name in MyErrors) {
		if(!MyErrors[name].Valid()) {
			MyErrors[name].Focus();
			return;
		}
	}

	//  Show "loading data..." ajax state.
	//  onsuccess and onfailure revert to normal state.
	MyElems.SubmitButton.disabled = true;
	MyElems.SubmitButton.style.visibility = "hidden";
	MyElems.CloseButton.disabled = true;
	MyElems.CloseButton.style.cursor = "default";

	//  Start building the parameters to the ajax call.
	var trim = function(str) { return str.replace(/^\s*/, "").replace(/\s*$/, ""); };
	var url = "../../Framework/JHU_GiveFeedback/jhu_GiveFeedback.aspx";

    new Ajax.Request(url,
        {
            method: 'post',
            parameters: { MaskIdentity: MyElems.MaskIdentity.checked, FeedbackText: trim(MyElems.FeedbackText.value), Location: window.location.href },
            onSuccess: function(transport) {
            if (transport.responseText) {
                    //  onfailure(jhu.DictionaryConcatenate(eval("(" + text + ")"), { toString: function() { ... } }));
                    //  But this fails in IE for some reason. Wierd.
                    var error = eval("(" + transport.responseText + ")");
                    error.toString = function() { return !this.Exception ? this.Message : this.Message +  "<br />" + this.Exception; };
                    onfailure(error);
                } else {
                    MyElems.FormContainer.style.visibility = "hidden";
                    MyElems.ThanksContainer.style.display = "block";
                    MyElems.CloseButton.disabled = false;
                    MyElems.CloseButton.style.cursor = "pointer";
                }
            },
            onFailure: function() {
                MyElems.FormContainer.style.visibility = "hidden";
                MyElems.ErrorContainer.style.display = "block";
                MyElems.ErrorDetails.innerHTML = error && ("<p>Details: " + error.toString() + "</p>");
                MyElems.CloseButton.disabled = false;
                MyElems.CloseButton.style.cursor = "pointer";
            },
            onComplete: function() {

            }
        }
    );
}



////////////////////////////////////////////////////////////////////////////////
//  CloseButton_Click
////////////////////////////////////////////////////////////////////////////////

jhu_GiveFeedback_CloseButton_Click = function() {
	Windows.closeAll();
};




/* Added from user control */
function moveDiv()
	{
		if (parseInt(navigator.appVersion) > 3) 
		{
			if (navigator.appName=="Netscape") 
			{
				winW = window.innerWidth;
				winH = window.innerHeight;
			}
			if (navigator.appName.indexOf("Microsoft")!=-1) 
			{
				winW = document.body.offsetWidth;
				winH = document.body.offsetHeight;
			}
		}
		this.cdiv = document.getElementById("divGenMsg");
		this.cdiv.style.position = "absolute";
		
		xPos = winW - 400;
		yPos = 170;
		
		if (this.cdiv.style)	
		{
			this.cdiv.style.left = xPos;
			this.cdiv.style.top = yPos; 
		} 
		else 
		{
			if (this.cdiv.top) 
			{
				this.cdiv.left = xPos; 
				this.cdiv.top= yPos;   
			}
		}
	}
	

	function close()
	{
		new_closeControl('divGenMsg');
	}

	function askTimeout(timeoutMinutes)
	{
	    var sessionTimeoutWarningMinutes = timeoutMinutes;
	    if (sessionTimeoutWarningMinutes == null) { sessionTimeoutWarningMinutes = "1" }
	    var currentTime = new Date();
	    currentTime.setTime(currentTime.getTime() + 60000 * parseInt(sessionTimeoutWarningMinutes));
		var hours = currentTime.getHours()
		var minutes = currentTime.getMinutes()
		var seconds = currentTime.getSeconds()
		
		if (seconds < 10)
		{
			seconds = "" + seconds + "";
			seconds = "0" + seconds;
		}
		if(hours > 11)
		{
			seconds = seconds + " PM";
		} else 
		{
			seconds = seconds + " AM";
		}
		if (hours >= 13)
			hours -= 12;
		if (hours < 10)
		{
			hours = hours + "";
			hours = "0" + hours;
		}
		if (minutes < 10)
		{
			minutes = minutes + "";
			minutes = "0" + minutes;
		}
		
		if(confirm("Your session will time out at " + hours + ":" + minutes + ":" + seconds + ". Would you like to refresh your session?"))
		{
			var onsuccess = function(text) { if(text == 0){ alert("While you were away, your session has timed out. Please close your browser and re-login."); window.location.href="../../Framework/JHU_Framework/Logout.aspx"; } };
			var onfailure = function() { };
			var returnval = new jhu.DownloadAsync("../../CMN/JHU_AlertsMenuControl/CMN_GetSession.aspx",onsuccess,onfailure,"",false);
			window.clearTimeout(timeoutid);
			sessionTimeout();
		}	
		else
		{
			window.location.href='../../Framework/JHU_Framework/Logout.aspx';
		}
	}
  function openAlert() {
   Dialog.info("To logout and prevent other users from accessing your information:<BR><BR><CENTER><FONT color=red><B>YOU MUST MANUALLY CLOSE ALL BROWSER WINDOWS<BR><BR>MAC USERS MUST QUIT THE APPLICATION</B></FONT></CENTER><BR>This is especially important if you are using a public computer, such as in a library or a lab.<BR>", 
		{className: "alphacube", width:350, height:150});
  }

function showHideInlineForm(control, inLineFormID, elementToCopy, inLineFormControlSetFocus, cellsToHighlight, closeFormText, closeOnly, allowMultipleInlineForms, controlClassName, disableAnimation) {

    allowMultipleInlineForms = true;
    control.className = 'label-arrow-down';

    //if an inline form has already been opened, then we get the id of the control that opened it and that controls innerHTML
    //we use this info later in the process to reset the original control
    if (controlThatOpenedTheForm != undefined) {
        var originalControl = controlThatOpenedTheForm.split("^");
        $(originalControl[0]).innerHTML = originalControl[1];
        $(originalControl[0]).className = originalControl[2];
    }

    controlThatOpenedTheForm = control.id + "^" + control.innerHTML + "^" + controlClassName;                         //so we know the original control and its innerHTML

    //cellsToHighlight is used to define specific cells to highlight in the row above the inline form
    //if cells are not defined, then the entire row is hightlighted
    var arrCell_indexs
    if (cellsToHighlight != undefined) {
        arrCell_indexs = cellsToHighlight.split(",")
    }

    //find the row within the table where the control lives
    var row = control.parentNode.parentNode;         //get the row where the control lives

    // var  rowIndex = row.rowIndex;                           //get the rows index : )
    var tbl = row.parentNode.parentNode;               			 //once we have the row, we can get the table
    var rowIndex = row.rowIndex; //control.id.split("_");

    if ((inlineFormRow == parseInt(rowIndex) + 1) || (closeOnly == true)) {      			   //if the inLineForm is there for the link clicked then this is a close form only, otherwise it is a close form and open another form
        deleteInlineFormRow(control, arrCell_indexs, elementToCopy.id, inLineFormID, true);       //delete the row
        controlThatOpenedTheForm = undefined;                                      //cleanup
        inlineFormRow = "";                                                                   //cleanup
        return;                                                                                   //we are done cause this was a "close only" operation
    }

    //if an inline form exits delete it before opening a new form
    if ((inlineFormRow != null) && (inlineFormRow != "") && (inlineFormRow != undefined)) {
        if (inlineFormRow < rowIndex) {		//reset the rowIndex to account for inlineFormRow
            rowIndex = rowIndex - 1;
        }
        deleteInlineFormRow(control, arrCell_indexs, elementToCopy.id, inLineFormID, false);
    }

    //set the style of the cells/row that is directly above the inline form row 
    var rows = tbl.getElementsByTagName("tr");
    var cells = rows[rowIndex].getElementsByTagName("td");

    //this if/else is broken if cellsToHighlight parameter is not passed from onClick call
    //FIX IT
    if (arrCell_indexs) {
        if (arrCell_indexs.length != 0) {                                                              //user set cells to highlight
            for (i = 0; i <= arrCell_indexs.length - 1; i++) {
                if(cells[arrCell_indexs[i]]){ // SELF-4625 Make sure cell exists)
                    cells[arrCell_indexs[i]].className = "inlineForm-headerRow";
                }
            }
        } else {                                                                                                  //no user set cells to highlight, so highlight the entire row
            for (i = 0; i <= cells.length - 1; i++) {
                if(cells[i]){ // SELF-4625 Make sure cell exists)
                    cells[i].className = "inlineForm-headerRow";
                }
            }
        }
    }

    //set the value for the row where the inline form lives
    inlineFormRow = parseInt(rowIndex) + 1;

    var newRow = tbl.insertRow(inlineFormRow);
    newRow.id = "inLineFormRow";
    var newCell = newRow.insertCell(0);
    //newRow.cells[0].style.width = "100%";    doesn't work : (
    newCell.colSpan = cells.length;
    newCell.id = "inLineFormCell";
    newCell.innerHTML = "<div style=\"display:none\" id=" + inLineFormID + ">text</div>"       //create this div so Position.clone has something in the new row to work with

    $(inLineFormID).innerHTML = $(elementToCopy).innerHTML;
    $(inLineFormID).className = "inlineForm-newRow";

    //snl testing eye candy
    if (!disableAnimation) {
        if ($(inLineFormID) != null) {
            if ($(inLineFormID).style.display == 'none') {
                new Effect.SlideDown(
						inLineFormID,
							{
							    duration: .5
							}
					    );
            } else {
                new Effect.SlideUp(
						inLineFormID,
							{
							    duration: .5
							}
					    );
            }
        }
    }
    else {
        if ($(inLineFormID) != null) {
            if ($(inLineFormID).style.display == 'none') {
                $(inLineFormID).show();
            } else {
                $(inLineFormID).hide();
            }
        }
    }

    //SNL need to fix the setfocus stuff		   
    //  if(inLineFormControlSetFocus) {
    //		inLineFormControlSetFocus.focus();
    // }
    //SNL need to fix the setfocus stuff END
    if (closeFormText != '') {
        control.innerHTML = "<span style=\"cursor: pointer\">" + closeFormText + "</span>";
    }

} //end function


function deleteInlineFormRow(control, cellsToHighlight, expandFormText, inLineFormID, animateClose) {
    var rowWhereTheControlLives = control.parentNode.parentNode;      //get the row             
    var tbl = rowWhereTheControlLives.parentNode.parentNode;            //get the table

    //get the style of the row below the row we delete so we can reset the style of the row above the row we delete : )
    //SNL fix this > what if row we delete is the last row in the table, there is no row below to use : )
    var rows = tbl.getElementsByTagName("tr");
    var theRowBelow = rows[inlineFormRow - 1]; 	       	                //inlineFormRow is a global variable that is set by the initial onClick event
    var cells = theRowBelow.getElementsByTagName("td");

    //set the style of the cells above the inline form back to there original style
    if (cellsToHighlight != undefined) {                                               //specific cells have been passed, so we work only on those
        for (i = 0; i <= cellsToHighlight.length - 1; i++) {
            if(cells[cellsToHighlight[i]]){ // SELF-4625 Make sure cell exists)
                cells[cellsToHighlight[i]].className = theRowBelow.className;
            }
        }
    } else {                                                                                       //no specefic cells were passed, so we work on all cells in the row
        for (i = 0; i <= cells.length - 1; i++) {
            if(cells[i]){ // SELF-4625 Make sure cell exists)
                cells[i].className = theRowBelow.className;
            }
        }
    }

    if ((animateClose == true) && ($(inLineFormID) != null)) {
        var tmp = inlineFormRow;
        new Effect.SlideUp(
					inLineFormID,
						{
						    duration: .5,
						    afterFinish: function (o) { $(tbl.id).deleteRow(tmp); }
						}

				);
    } else {
        $(tbl.id).deleteRow(inlineFormRow);
    }
}


//old school, show/hide an image that is associated with the element
function showHideProgressIndicator(control, action, changeText, customTimeout) {
    var progressIMG = control.id + "_progressIndicator";
    if (action == "show") {                                    	//show progress indicator
        $(progressIMG).style.visibility = 'visible';
        if (changeText) {
            setControlText(control, changeText);
        }
    } else if (action == "timed") {    				//show progress indicator for a period of time
        $(progressIMG).style.visibility = 'visible';
        var orgText = control.innerHTML;
        if (changeText) {
            setControlText(control, changeText);
        }
		// ISIS-263: jcooke9: 7/6/11: added customTimeout param and if not passed, using 5 secs as the default
		var timeout;
		if( (customTimeout == undefined) || (customTimeout == null) ) {
			timeout = 5000;
		} else {
			timeout = customTimeout;
		}
        var t = setTimeout(function () { hideControlStop(control.id, orgText); }, timeout);
    } else if (action == "hide") {                              //hide progress indicator
        $(progressIMG).style.visibility = 'hidden';
    } else {
        $(progressIMG).style.visibility = 'hidden';
    }
}

//replaces showHideProgressIndicator using className instead of associated image
function showHideProgressViaClassName(el, action, changeText, nonProgressStyle, customSpinnerClass, customTimeout) {
    if (nonProgressStyle == null) { nonProgressStyle = 'label-emptyIcon-postiion'; }
    var spinnerClass;
    if (customSpinnerClass == undefined || customSpinnerClass == null) { spinnerClass = 'label-spinner'; } else { spinnerClass = customSpinnerClass; }
    if (action == "show") {
        $(el).className = spinnerClass;
        if (changeText) {
            setControlText(el, changeText);
        }
    } else if (action == "timed") {    				//show progress indicator for a period of time
        var orgText = el.innerHTML;
        var orgClassName = $(el).className;
        $(el).className = spinnerClass;
        if (changeText) {
            setControlText(el, changeText);
        }
		// ISIS-263: jcooke9: 7/6/11: added customTimeout param and if not passed, using 5 secs as the default
		var timeout;
		if( (customTimeout == undefined) || (customTimeout == null) ) {
			timeout = 5000;
		} else {
			timeout = customTimeout;
		}
        var t = setTimeout(function () { hideControlStop(el.id, orgText, orgClassName); }, timeout);
    } else if (action == "hide") {                              //assign element non progress indicator className
        $(el).className = nonProgressStyle;
    } else {
        $(el).className = nonProgressStyle;
    }
}

//change text of a control for a period of time in millisecond
function changeElemInnerHTMLTimed(element, changeText, time) {
    var orgText = element.innerHTML;
    setControlText(element, changeText);
    var t = setTimeout(function () { hideControlStop(element.id, orgText); }, time);
}

//used by showHideProgressIndicator()
function hideControlStop(elID, orgText, orgClassName) {
    var progressIMG = elID + "_progressIndicator";
    if (orgClassName != null) { $(elID).className = orgClassName; }
    if ($(progressIMG)) {
        $(progressIMG).style.visibility = 'hidden';
    }
    setControlText($(elID), orgText);
}

//used by showHideProgressIndicator() and hideControlStop()
function setControlText(control, text) {
    switch (control.tagName) {
        case "SELECT":                          	//dropdown list, dont set text, need to look at this some more
            break;
        case "A":                               	//hyper link, future disable link via href attribute (need to remember orig url)
            control.innerHTML = text;
            break;
        case "INPUT":                           	//submit button
            control.value = text;
            control.disabled = true;
            break;
    }
}

//  Recycles a single window
var showWin = new function () {
    var toPos = function (arr) {
        return {
            left: arr[0],
            top: arr[1]
        };
    };
    var defer = function (fun) {
        var t = setTimeout(fun, 0);
    };
    var lazy = function (gen) {
        var obj = null;
        return function () {
            if (!obj) obj = { val: gen() };
            return obj.val;
        };
    };
    var win = lazy(function () {
        var win = new Window({
            title: null,
            width: 0, height: 0,
            left: 0, top: 0,
            className: "bluelighting",
            resizable: false,
            minimizable: false,
            maximizable: false,
            draggable: true,
            wiredDrag: false,
            showEffect: Element.show,
            hideEffect: Element.hide
        });
        return win;
    });
    var fun = function (opt) {
        var width = opt.width || 0;
        var height = opt.height || 0;
        var top = opt.top || 0;
        var left = opt.left || 0;
        var elem = $(opt.offsetElement);
        var showcenter = opt.showcenter || false;
        var modal = opt.showmodal || false;
        var centertop = opt.centertop;
        var centerleft = opt.centerleft;

        var corn = !opt.offsetCorner
			? { x: "left", y: "top" }
			: { x: opt.offsetCorner.x == "right" ? "right" : "left", y: opt.offsetCorner.y == "bottom" ? "bottom" : "top" }

        if (elem) {
            var dim = elem.getDimensions();
            var loc = toPos(Position.cumulativeOffset(elem));
            top += loc.top;
            left += loc.left;
            if (corn.x == "right") {
                left += dim.width;
            }
            if (corn.y == "bottom") {
                top += dim.height;
            }
        }
        opt.content = opt.content;
        win().setHTMLContent(opt.content);
        win().setTitle(opt.title);
        win().setSize(width, height);
        if (showcenter) {
            win().showCenter(modal, centertop, centerleft);
        }
        else {
            win().setLocation(top, left);
            win().show();
        }
        if (!height) {
            defer(function () {
                win().updateHeight();
            });
        };
    };
    fun.win = win;
    return fun;
};



