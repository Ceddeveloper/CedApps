REM App Data Manager 
REM Functions in this file:
REM     makeServiceCall
REM     AddAndSetFields


'*************************************************************
'** app apicall api call builder
'** endpoint  - api suffix to be added to base url
'** Return: AA, which is parsed Json or XML
'*************************************************************
Function makeServiceCall(url = "" as String, typeofRequet = "" as String, method = "GET", timeout = 30000 as Integer) as Object
    print "url: " url
    result = invalid
    parsed = invalid
    success = false
    failure = false
    cookies = ""
    port = CreateObject("roMessagePort")
    xfer = CreateObject("roURLTransfer")
    xfer.SetPort(port)
    xfer.EnablePeerVerification(false)

    xfer.SetURL(url)
    xfer.SetRequest(method)

    if method = "POST" or method = "PUT"
        xfer.SetRequest(method)
        success = xfer.AsyncPostFromString("")
    else
        success = xfer.AsyncGetToString()
    end if
    if success
        msg = wait(timeout, port)
        if msg = invalid
            xfer.AsyncCancel()

        else if type(msg) = "roUrlEvent"
            if msg.GetString() <> invalid and msg.GetString() <> "" then
                result = msg.GetString()
            end if
        end if
    end if

    if result <> invalid and result <> "" then
        if typeofRequet = "json"
            parsed = ParseJson(result)
            if parsed = invalid then
                failure = true
            end if
        else if typeofRequet = "xml"
            parsed = CreateObject("roXmlElement")
            if not parsed.Parse(result) then
                failure = true
            end if
        end if
    else
        failure = true
    end if
    return parsed
End Function

'*************************************************************
'** Add Fields that are not in content Meta data
'** Return: object
'*************************************************************
Function AddAndSetFields(node as object, aa as object)
    addFields = {}
    setFields = {}
    for each field in aa
 	    if node.hasField(field)
    	     setFields[field] = aa[field]
       else
        	 addFields[field] = aa[field]
       end if
    end for
    node.setFields(setFields)
    node.addFields(addFields)
End Function