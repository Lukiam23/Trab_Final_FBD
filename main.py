from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager,Screen, FadeTransition
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.scrollview import ScrollView
from kivy.config import Config
Config.set('graphics', 'width', '1380')
Config.set('graphics', 'height', '715')
Config.set('kivy','window_icon','C:\\Users\\mscor\\Documents\\2018.2\\FBD\\logo.jpg')
#Config.set('graphics','resizable', False)



class Menu(Screen):
	def __init__(self,**kwargs):
		super(Menu,self).__init__(**kwargs)

class MusicScreen(Menu):
	def __init__(self,**kwargs):
		super(MusicScreen,self).__init__(**kwargs)

class PlayListTable(ScrollView):
	def __init__(self,**kwargs):
		super().__init__(**kwargs)
		self.data = [str(x) for x in range(1,100)]
		for row in self.data:
			self.ids.box.add_widget(Label(text="Test"))
			
		

class PlayListScreen(Menu):
	def __init__(self,**kwargs):
		super(PlayListScreen,self).__init__(**kwargs)



class AlbunsScreen(Menu):
	pass

class RecorderScreen(Menu):
	pass

class CompositorScreen(Menu):
	pass

class MusicalPeriod(Menu):
	pass

class ScreenManagement(ScreenManager):
	pass
	

presentation = Builder.load_file("main.kv")
class MyApp(App):

    def build(self):
        self.title = "SportPer"
        return presentation


if __name__ == '__main__':
    MyApp().run()