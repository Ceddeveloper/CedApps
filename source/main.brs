' ********** Copyright 2015 Roku Corp.  All Rights Reserved. ********** 

sub RunUserInterface(args As Dynamic)
	screen = CreateObject("roSGScreen")
    m.global = screen.getGlobalNode()
    m.global.addField("optionDialog","node", false)
    m.global.addField("contentList","assocarray", false)

    scene = screen.CreateScene("SplashScene")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    screen.Show()
    
    while true
        msg = wait(0, m.port)
    end while

    if screen <> invalid then
        screen.Close()
        screen = invalid
    end if
end sub 
