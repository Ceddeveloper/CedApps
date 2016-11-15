' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 
REM  splashScene.brs
REM Functions in this file:
REM     init
REM     onLoadContentCallback
REM     errorDialogHandler

'*******************************************************************
'** Init
'** @brief initializes splashScene
'*******************************************************************
sub init()
  m.homeScene 	        = m.top.FindNode("HomeScene")
  m.optionsDialog 	    = m.top.FindNode("OptionsDialog")
  m.loadingIndicator    = m.top.FindNode("loadingIndicator")
  m.global.optionDialog = m.top.findNode("OptionsDialog")
  
  m.task = createObject("roSGNode", "loadChannelCotent")
  m.task.observeField("content", "onLoadContentCallback")
  m.task.Control = "RUN"
  m.homeScene.visible = true
end sub

'********************************************************************
'** Load Content
'** @brief callback Function loads content into RowList on homescreen
'********************************************************************
Function onLoadContentCallback()
	m.loadingIndicator.control = "stop"
  if m.task.reqStatus = "failed"
    buttons = ["close"]
    showDialogBox("Network Error","Please check your Internet Connection.", buttons, "errorDialogHandler")
  else
    m.top.homescreenContent = m.task.content
    m.homeScene.setFocus(true)
  end if
End Function

'********************************************************************
'** errorDialogHandler
'** @brief Error Dialog handler
'********************************************************************
Function errorDialogHandler()
  m.global.optionDialog.visible = false
End Function