from kivy.app import App
from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager,Screen, FadeTransition
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.scrollview import ScrollView
from kivy.config import Config
from kivy.properties import ObjectProperty
from kivy.uix.boxlayout import BoxLayout

Config.set('graphics', 'width', '1380')
Config.set('graphics', 'height', '715')
Config.set('kivy','window_icon','C:\\Users\\mscor\\Documents\\2018.2\\FBD\\logo.jpg')
#Config.set('graphics','resizable', False)



class Menu(Screen):
	def __init__(self,**kwargs):
		super(Menu,self).__init__(**kwargs)


class GenericScreen(Menu):
	def __init__(self,**kwargs):
		super(GenericScreen,self).__init__(**kwargs)
		


class MusicScreen(Menu):
	
	def __init__(self,**kwargs):
		super(MusicScreen,self).__init__(**kwargs)
		
		
class PlayListScreen(Menu):
	box = ObjectProperty(None)
	def __init__(self,**kwargs):
		super(PlayListScreen,self).__init__(**kwargs)
		
	def populate(self):	
		self.ids.box.clear_widgets()
		tarefas = [str(x) for x in range(1,100)]	
		for tarefa in tarefas:
			self.ids.box.add_widget(Label(text=tarefa,font_size=30,size_hint_y=None,height=200))

class AlbumsScreen(Menu):
	box = ObjectProperty(None)
	def __init__(self,**kwargs):
		super(AlbumsScreen,self).__init__(**kwargs)
		self.albumsData = {}
	def musics(self,album):
		self.manager.current = "generic"
	def populate(self):	
		self.ids.box.clear_widgets()
		tarefas = [str(x) for x in range(1,100)]	
		for tarefa in tarefas:
			original = "Florence and the Machine: Between Two Lungs"
			if(len(original)>50):
				text = original.split()
				text = " ".join(text[0:5]) + "..."
			else:
				text=original
			btn = Button(text=text,font_size=20,size_hint_y=None,height=100,background_color=(0.1,0.1,0.1,1),on_press=lambda a:self.musics(original))
			self.ids.box.add_widget(btn)


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
	albumsScreen = ObjectProperty(None)
	recorderScreen = ObjectProperty(None)
	compositorScreen = ObjectProperty(None)
	musicalPeriod = ObjectProperty(None)

class Teste(BoxLayout):
	pass

class ActionApp(App):

	def build(self):
		self.title = "SpotPer"
		return Manager()

myApp = ActionApp()
if __name__ == '__main__':
	myApp.run()