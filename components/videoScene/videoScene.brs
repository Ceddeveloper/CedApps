' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 
REM  VideoScene.brs
REM Functions in this file:
REM     init
REM     onVideoContentChange
REM     OnKeyEvent
REM     setupVideoPlayer
REM     setVideo
REM     onVideoContentChange
REM     OnVideoPlayerPositionChange
REM     OnVideoPlayerStateChange
REM     playerErrorDialogHandler


'*******************************************************************
'** Init
'** @brief initializes videoScene
'*******************************************************************
sub init()
  m.videoplayer = m.top.FindNode("videoPlayer")
  setupVideoPlayer()
end sub

'*******************************************************************
'** onVideoContentChange
'** @brief updated VideoScene UI when video content changes
'*******************************************************************
Function onVideoContentChange()
  setVideo()
End Function


'*******************************************************************
'** OnKeyEvent handler
'** @brief handles remote key pressed events
'*******************************************************************
' Main Remote keypress event loop
Function OnKeyEvent(key, press) as Boolean
    print "Video Scene key: " key
    handled = false
    if press then
      if key = "back" then
        handled = true
        m.videoPlayer.control = "stop"
        m.videoPlayer.unobserveField("state")
        m.videoPlayer.unobserveField("position")
        m.videoPlayer.visible = false
        m.top.videoSceneNavigateBack = true
      else if key = "OK" then

      else if key = "up" then
        handled = true
      else if key = "down" then
        handled = true
      end if
    end if
    return handled
End Function

'*******************************************************************
'** setupVideoPlayer
'** @brief initalizes video player
'*******************************************************************
sub setupVideoPlayer()
  m.videoPlayer.enableCookies()
  m.videoPlayer.bufferingBar.filledBarBlendColor = "#05057FFF"
  m.videoPlayer.retrievingBar.filledBarBlendColor = "#05057FFF"
  m.videoPlayer.trickPlayBar.filledBarBlendColor = "#05057FFF"
end sub

'*******************************************************************
'** setVideo
'** @brief Sets video content
'*******************************************************************
function setVideo() as void
  print "setting video"
  m.videoContent = createObject("RoSGNode", "ContentNode")
  m.videoContent.url = ""
  m.videoContent.title =""
  m.videoContent.streamformat = "hls"
  subtitle_config = {
   TrackName: "eia608/1"
  }   
  m.videoContent.SubtitleConfig = subtitle_config
  m.videoPlayer.visible = true
  m.videoPlayer.setFocus(true)
  m.videoPlayer.content = m.videoContent
  m.videoPlayer.control = "play"
  m.videoPlayer.observeField("state", "OnVideoPlayerStateChange")
  m.videoPlayer.observeField("position", "OnVideoPlayerPositionChange")
end function

'*******************************************************************
'** OnVideoPlayerPositionChange
'** @brief video player Position Change event handler
'*******************************************************************
sub OnVideoPlayerPositionChange()
  'print m.videoplayer.position
end sub

'*******************************************************************
'** OnVideoPlayerStateChange
'** @brief video player state Change event handler
'*******************************************************************
Sub OnVideoPlayerStateChange()
    ? "VideoScene > OnVideoPlayerStateChange : state == ";m.videoPlayer.state
    if m.videoPlayer.state = "error"
        'hide vide player in case of error
        print "Error Code: " m.videoPlayer.errorCode
        print "Error Msg : " m.videoPlayer.errorMsg
        
        m.videoPlayer.unobserveField("state")
        m.videoPlayer.unobserveField("position")

        buttons = ["close"]
        showDialogBox("Video Playback Failure","We are not able to play selected content at thie time, Please try again later.", buttons, "playerErrorDialogHandler")
    else if  m.videoPlayer.state = "paused" or m.videoPlayer.state = "stopped"

    else if m.videoPlayer.state = "buffering"

    else if m.videoPlayer.state = "playing"
     
    else if m.videoPlayer.state = "finished"
        'hide vide player if video is finished
        m.videoPlayer.unobserveField("state")
        m.videoPlayer.unobserveField("position")
        m.videoPlayer.control = "stop"
        m.videoPlayer.visible = false
        m.top.videoSceneNavigateBack = true
    end if
end Sub


'*******************************************************************
'** playerErrorDialogHandler
'** @brief videoScene error handler
'*******************************************************************
Function playerErrorDialogHandler()
  m.global.optionDialog.visible = false
  m.top.videoSceneNavigateBack = true
end Function