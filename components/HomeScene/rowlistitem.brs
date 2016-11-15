' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 
  sub init()
      m.itemposter = m.top.findNode("itemPoster") 
      m.itemmask = m.top.findNode("itemMask")
      m.titleLabel = m.top.findNode("titleLabel")
      m.userLabel = m.top.findNode("userLabel")
      m.timeLable = m.top.findNode("timeLable")
  end sub

  sub showcontent()
      itemcontent       = m.top.itemContent
      m.itemposter.uri  = itemcontent.HDPosterUrl
      m.titleLabel.text = itemcontent.Title
      m.userLabel.text  = itemcontent.userInfo
      m.timeLable.text  = itemcontent.ShortDescriptionLine1
  end sub

  sub showfocus()
      'scale = 1 + (m.top.focusPercent * 0.28)
      'm.itemposter.scale = [scale, scale]
  end sub

  sub showrowfocus()
      m.itemmask.opacity = 0.75 - (m.top.rowFocusPercent * 0.75)
      m.titleLabel.opacity = m.top.rowFocusPercent
      m.timeLable.opacity = m.top.rowFocusPercent
  end sub
