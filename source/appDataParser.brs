
REM Process Data from the feed
REM Functions in this file:
REM     processDataItems
REM     getDureationInMinitues


'*************************************************************
'** parseItem
'** @brief parse standart item
'*************************************************************
Function parseItem(item)
	DLitem = {}
    
    DLitem.ContentId                = item.uri.toStr()
    DLitem.Title                    = item.name.toStr()
    DLitem.HDPosterUrl              = ""
    DLitem.SDPosterUrl              = ""
    DLitem.ReleaseDate              = item.release_time.toStr()
    DLItem.userInfo                 = "By "
    DLitem.ShortDescriptionLine1    = getDureationInMinitues(item.duration)
    DLitem.ShortDescriptionLine2    = ""
  
    return DLitem
End Function

'***********************************************************
'** getDureationInMinitues
'** @brief Convert total duration in seconds to Minutes:Seconds format
'***********************************************************
Function getDureationInMinitues(durInSeconds)
    timeToDisplay = ""
    FuncGetTwoDigit = function(digit as Integer) as String
        if digit < 10 then
            return "0" + digit.toStr()
        else
            return digit.toStr()
        end if
    End function

    if durInSeconds <> 0 then
        durMins = Cdbl((durInSeconds MOD 3600) / 60)
        timeSecs = Cdbl((durInSeconds MOD 60))
        timeToDisplay = FuncGetTwoDigit(durMins) + ":" + FuncGetTwoDigit(timeSecs)
    else
        timeToDisplay = "00:00"
    end if
    return timeToDisplay
End Function

