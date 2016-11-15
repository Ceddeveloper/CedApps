' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 
REM  homeScene.brs
REM Functions in this file:
REM     init
REM     onContentChange
REM     itemFocused
REM     itemSelected
REM     OnKeyEvent
REM     onLoadMoreContentCallback
REM     videoplayerBack


'*******************************************************************
'** Init
'** @brief initializes homeScene
'*******************************************************************
sub init()
  m.bgRectangle       = m.top.findNode("BackgroundRect")
  m.overhang          = m.top.findNode("overhang")
  m.rowList           = m.top.findNode("contentRowList")
  m.loadingIndicator  = m.top.findNode("loadingIndicator")
  m.videoplayer       = m.top.findNode("videoplayer")
  m.rowLabelColor     = m.top.findNode("rowLabelColor")
  m.itemMask          = m.top.findNode("itemMask")
  m.pageNo            = 1
  m.jumpToItem        = 0
end sub

'*******************************************************************
'** onContentChange
'** @brief callback function whenever RowList content is updated
'*******************************************************************
Function onContentChange()
  m.rowList.observeField("rowItemFocused", "itemFocused")
  m.rowList.observeField("rowItemSelected", "itemSelected")
  m.rowList.setFocus(true)
  m.rowList.jumpToRowItem = [0, m.jumpToItem]
  m.loadingIndicator.control = "stop"
  m.itemMask.opacity = 0.0
  m.rowLabelColor.visible =  true
End Function

'*******************************************************************
'** itemFocused
'** @brief callback function to perform any task when Row List Item 
'** is focused
'*******************************************************************
Function itemFocused()
  print "item "; m.rowList.rowItemFocused[1]; " in row "; m.rowList.rowItemFocused[0]; " was focused"
  if m.rowList.rowItemFocused[1] < m.rowList.content.getChild(m.rowList.rowItemFocused[0]).NumEpisodes and m.rowList.rowItemFocused[1] = m.rowList.content.getChild(m.rowList.rowItemFocused[0]).getChildCount() -1then
      m.jumpToItem = m.rowList.content.getChild(m.rowList.rowItemFocused[0]).getChildCount() - 1
      m.rowList.unobserveField("rowItemFocused")
      m.rowList.unobserveField("rowItemSelected") 
      m.loadingIndicator.control = "start"
      m.itemMask.opacity = 0.55
      m.pageNo = m.pageNo + 1
      m.task = createObject("roSGNode", "loadChannelCotent")
      m.task.pageNo = m.pageNo.toStr()
      m.task.observeField("content", "onLoadMoreContentCallback")
      m.task.Control = "RUN"
  end if
End Function

'*******************************************************************
'** itemSelected
'** @brief callback function to perform any task when Row List Item 
'** is selected
'*******************************************************************
Function itemSelected()
  print "item "; m.rowList.rowItemSelected[1]; " in row "; m.rowList.rowItemSelected[0]; " was selected"
  m.rowList.unobserveField("rowItemFocused")
  m.rowList.unobserveField("rowItemSelected")
  m.videoplayer.videoSceneNavigateBack = false
  m.videoplayer.visible = true
  m.videoplayer.content = m.rowList.content.getChild(m.rowList.rowItemSelected[0]).getChild(m.rowList.rowItemSelected[1])
  m.videoplayer.observeField("videoSceneNavigateBack", "videoplayerBack")
End Function

'*******************************************************************
'** OnKeyEvent handler
'** @brief handles remote key pressed events
'*******************************************************************
Function OnKeyEvent(key, press) as Boolean
	    print "Home Scene key Event"
      handled = false
      if press then
      	if key = "back" then
      		handled = false

      	else if key = "OK" then
          print "Pressed OK"
          handled = true

        else if key = "options" then
          handled = true

      	else if  key = "down" then
          print "Pressed down"
          handled = true

      	else if key = "up" then
          print "Pressed up"
          handled = true
      	end if

        else if  key = "right" then
          print "Pressed right"
          handled = true

        else if  key = "left" then
          print "Pressed left"
          handled = true
      end if
    return handled
End Function


'*******************************************************************
'** Load More Content
'** @brief Calback function to load new content to RowList
'*******************************************************************
Function onLoadMoreContentCallback()
  print "Loadedd More content"
  m.top.content = m.task.content
End Function

'*******************************************************************
'** videoplayer Navigaate Back
'** @brief Calback function to handle navigate back funcationality
'*******************************************************************
Function videoplayerBack()
  m.rowList.unobserveField("videoSceneNavigateBack")
  m.videoplayer.visible = false
  m.top.setFocus(true)
  m.rowList.setFocus(true)
  m.rowList.observeField("rowItemFocused", "itemFocused")
  m.rowList.observeField("rowItemSelected", "itemSelected")
End Function