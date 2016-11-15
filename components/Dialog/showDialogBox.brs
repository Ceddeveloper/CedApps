Function showDialogBox(title as String, msg as String, buttons, callBack)
  m.global.optionDialog.visible = true
  m.global.optionDialog.title = title
  m.global.optionDialog.message = msg
  m.global.optionDialog.buttons = buttons
  m.global.optionDialog.focusButton = 0
  m.global.optionDialog.setFocus(true)
  m.global.optionDialog.ObserveField("buttonSelected",callBack)
End Function