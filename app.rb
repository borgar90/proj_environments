require 'fox16'
include Fox
app = FXApp.new("Hi", "FoxTest")
main = FXMainWindow.new(app, "Hello, World!" , nil,nil, DECOR_ALL)
app.create()
main.show(PLACEMENT_SCREEN)
app.run()