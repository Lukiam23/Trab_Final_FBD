from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager,Screen, FadeTransition
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.scrollview import ScrollView
from kivy.config import Config
from kivy.properties import ObjectProperty
Config.set('graphics', 'width', '1380')
Config.set('graphics', 'height', '715')
Config.set('kivy','window_icon','C:\\Users\\mscor\\Documents\\2018.2\\FBD\\logo.jpg')
#Config.set('graphics','resizable', False)



class Menu(Screen):
	pass

class MusicScreen(Menu):
	def __init__(self,**kwargs):
		super(MusicScreen,self).__init__(**kwargs)
		self.tarefas = [str(x) for x in range(1,100)]
		#for tarefa in self.tarefas:
		#	self.ids.box.add_widget(Label(text=tarefa,font_size=30,size_hint_y=None,height=200))
		
class PlayListScreen(Menu):
	pass

class AlbunsScreen(Menu):
	pass

class RecorderScreen(Menu):
	pass

class CompositorScreen(Menu):
	pass

class MusicalPeriod(Menu):
	pass

class Manager(ScreenManager):
	menu = ObjectProperty(None)
	musicScreen = ObjectProperty(None)
	playListScreen = ObjectProperty(None)
	albunsScreen = ObjectProperty(None)
	recorderScreen = ObjectProperty(None)
	compositorScreen = ObjectProperty(None)
	musicalPeriod = ObjectProperty(None)
	
presentation = Builder.load_file("main.kv")

class MyApp(App):

    def build(self):
        self.title = "SportPer"
        return presentation


if __name__ == '__main__':
    MyApp().run()