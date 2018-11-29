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
from functools import partial
from kivy.clock import Clock

Config.set('graphics', 'width', '1380')
Config.set('graphics', 'height', '715')
Config.set('kivy','window_icon','C:\\Users\\mscor\\Documents\\2018.2\\FBD\\logo.jpg')
#Config.set('graphics','resizable', False)



class Menu(Screen):
	def __init__(self,**kwargs):
		super(Menu,self).__init__(**kwargs)
	def on_enter(self):
		Clock.schedule_once(self.listAllMusics)
	def listAllPlaylist(self,*arg):
		playlistscreen = self.manager.get_screen(name='playlist')
		playlistscreen.populate()
	def listAllAlbums(self,*arg):
		albumscreen = self.manager.get_screen(name='albums')	
		albumscreen.populate()
	def listAllMusics(self,*arg):
		musicscreen = self.manager.get_screen(name='music')	
		musicscreen.populate()


class GenericScreen(Menu):
	def __init__(self,**kwargs):
		super(GenericScreen,self).__init__(**kwargs)		


class MusicScreen(Menu):
	
	def __init__(self,**kwargs):
		super(MusicScreen,self).__init__(**kwargs)

	def populate(self):	
		self.ids.box.clear_widgets()
		tarefas = ["Four seasons","Virus","Trino Del Diablo" ]	
		for tarefa in tarefas:
			playlist = Button(text=tarefa,font_size=20,size_hint_y=None,height=50,background_color=(0.1,0.1,0.1,1))
			self.ids.box.add_widget(playlist)
		playlists = ["Classica","Barroca","Moderna" ]	
		
		
		
class PlayListScreen(Menu):
	box = ObjectProperty(None)
	def __init__(self,**kwargs):
		super(PlayListScreen,self).__init__(**kwargs)
		
	def populate(self):	
		self.ids.box.clear_widgets()
		tarefas = ["Classica","Barroca","Moderna" ]	
		for tarefa in tarefas:
			playlist = Button(text=tarefa,font_size=20,size_hint_y=None,height=50,background_color=(0.1,0.1,0.1,1))
			self.ids.box.add_widget(playlist)

class AlbumsScreen(Menu):
	box = ObjectProperty(None)
	def __init__(self,**kwargs):
		super(AlbumsScreen,self).__init__(**kwargs)
		self.albumsData = {}

	def search(self):
		self.description  = self.ids.textsearch.text
		print(self.description)
	def musics(self,album,*args):
		
		generic = self.manager.get_screen(name='generic')
		self.manager.current = 'generic'
		generic.ids.title.text = album
		generic.ids.box.clear_widgets()	
		for i in range(1,3):
			btn = Label(text="Musica do Album",font_size=20,size_hint_y=None,height=50,text_size= self.size,halign='left',valign='middle',pos_hint={'top': 1,'x':0.18})

			generic.ids.box.add_widget(btn)

	def populate(self):	
		self.ids.box.clear_widgets()	
		self.albums = ["Florence and the Machine: Between Two Lungs","Bethoven","Niccolo Paganini"]
		i = 0
		for album in self.albums:
			titulo = album
			if(len(titulo)>60):
				titulo = titulo.split()
				titulo = " ".join(titulo[0:5]) + "..."

			btn = Button(text=titulo,font_size=20,size_hint_y=None,height=100,background_color=(0.1,0.1,0.1,1))
			btn.bind(on_press=partial(self.musics,album))
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


class ActionApp(App):
	def build(self):
		self.title = "SpotPer"
		return Manager()

myApp = ActionApp()
if __name__ == '__main__':
	myApp.run()