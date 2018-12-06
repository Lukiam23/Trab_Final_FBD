from kivy.app import App
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
from kivy.uix.popup import Popup
from datetime import datetime


import pyodbc
server_name =  "LAPTOP-3HO5A040\\SQLEXPRESS"
db_name = "spotper"
cnxn = pyodbc.connect('Driver={SQL Server};'
                      'Server='+server_name+';'
                      'Database='+db_name+';'
                      'Trusted_Connection=yes;')
cursor = cnxn.cursor()

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

class EditScreen(Menu):
	def __init__(self,**kwargs):
		super(EditScreen,self).__init__(**kwargs)

	def submit(self,album,*args):
		cursor = cnxn.cursor()
		edit = self.manager.get_screen(name='editscreen')
		try:
			cursor.execute("UPDATE dbo.album SET descricao = '%s',preco = '%s', dt_compra = '%s', tipo_compra = '%s', dt_grav = '%s' where cod_album = %s" %(edit.ids.description.text,edit.ids.price.text,edit.ids.purchaseDate.text,edit.ids.purchaseType.text,edit.ids.recordDate.text,album.cod_album))
			popup = Popup(title='Sucess',content=Label(text='Data Updated!'),size_hint=(None, None), size=(200, 200))
			popup.open()
			cursor.commit()
		except:
			popup = Popup(title='Warning',content=Label(text='Verify Your Entry!'),size_hint=(None, None), size=(200, 200))
			popup.open()
		cursor.close() 

class GenericScreen(Menu):
	def __init__(self,**kwargs):
		super(GenericScreen,self).__init__(**kwargs)		


class MusicScreen(Menu):
	
	def __init__(self,**kwargs):
		super(MusicScreen,self).__init__(**kwargs)
		self.buttonsCods = {}
		self.playlistSelected = '-'

	def fillButton(self,cod,playlist,*arg):
		self.ids.btn.text = playlist
		self.playlistSelected = cod
		self.ids.dropdown.dismiss()

	def addPlaylist(self,btn,numero,cod,*args):
		if cod not in self.buttonsCods:
			btn.background_color = (25/255, 181/255, 254/255, 1)
			self.buttonsCods[cod] = btn 
		else:
			btn.background_color = (0.1,0.1,0.1,1)
			del self.buttonsCods[cod]

	def add(self):
		if self.ids.playlistName.text == '':
			popup = Popup(title='Warning',content=Label(text='Please, select a playlist!'),size_hint=(None, None), size=(200, 200))
			popup.open()
		else:
			for i in self.buttonsCods:
				#musica com código: i será adicionada na playlist com código self.playlistSelected
				self.buttonsCods[i].background_color = (0.1,0.1,0.1,1)
	
	def populate(self):	
		self.countId = 0

		self.ids.box.clear_widgets()
		cursor = cnxn.cursor()
		cursor.execute("SELECT * from dbo.faixa")	
		for music in cursor:
			mcs = Button(text=music.descricao,font_size=20,size_hint_y=None,height=50,background_color=(0.1,0.1,0.1,1))
			mcs.bind(on_release=partial(self.addPlaylist,mcs,music.numero,music.cod_album))
			self.ids.box.add_widget(mcs)
		cursor.close()		
		
		
class PlayListScreen(Menu):
	box = ObjectProperty(None)
	def __init__(self,**kwargs):
		super(PlayListScreen,self).__init__(**kwargs)

	def playlistWindow(self,playlist,*args):
		generic = self.manager.get_screen(name='generic')
		self.manager.current = 'generic'
		generic.ids.title.text = playlist.nome
		generic.ids.box.clear_widgets()	
		cursor = cnxn.cursor()

		cursor.execute("SELECT f.descricao as descricao FROM dbo.faixa f INNER JOIN dbo.faixa_playlist fp on f.cod_album = fp.cod_album INNER JOIN dbo.playlist pl on pl.cod_playlist = fp.cod_playlist INNER JOIN dbo.album a on a.cod_album = f.cod_album where pl.cod_playlist = %s " %(playlist.cod_playlist))
		for music in cursor:
			btn = Label(text=music.descricao,font_size=20,size_hint_y=None,height=50,text_size= self.size,halign='left',valign='middle',pos_hint={'top': 1,'x':0.18})
			generic.ids.box.add_widget(btn)
		cursor.close()


	def add(self):
		newplaylist = self.ids.newplaylist.text
		cursor = cnxn.cursor()
		cursor.execute("SELECT max(cod_playlist) as cod_playlist from dbo.playlist")
		row = cursor.fetchone()
		date = datetime.now()
		stringdata = str(date.day)+"/"+str(date.month)+"/"+str(date.year)
		cursor.execute("INSERT into playlist values(%d,'%s','%s','00:00:00')" %(row.cod_playlist+1,newplaylist.upper(),stringdata))
		cursor.commit()
		cursor.close()
		self.populate()
		
	def populate(self):	
		self.ids.box.clear_widgets()
		cursor = cnxn.cursor()
		cursor.execute("SELECT * from dbo.playlist")
		
		for playlist in cursor:
			btn = Button(text=playlist.nome,font_size=20,size_hint_y=None,height=50,background_color=(0.1,0.1,0.1,1))
			btn.bind(on_press=partial(self.playlistWindow,playlist))
			self.ids.box.add_widget(btn)
		cursor.close()

class AlbumsScreen(Menu):
	box = ObjectProperty(None)
	def __init__(self,**kwargs):
		super(AlbumsScreen,self).__init__(**kwargs)
		self.albumsData = {}

	def edit(self,album,*arg):
		edit = self.manager.get_screen(name='editscreen')
		self.manager.current = 'editscreen'
		edit.ids.title.text = "Editar %s" %(album.descricao)
		edit.ids.description.text = album.descricao
		edit.ids.recorder.text = str(album.cod_grav)
		edit.ids.price.text = str(album.preco)
		edit.ids.purchaseDate.text = album.dt_compra
		edit.ids.purchaseType.text = str(album.tipo_compra)
		edit.ids.recordDate.text = str(album.dt_grav) 
		edit.ids.submit.bind(on_press=partial(edit.submit,album))



	def search(self):
		description  = self.ids.textsearch.text
		cursor = cnxn.cursor()
   
		cursor.execute("SELECT * from dbo.album where descricao LIKE  '%"+description+"%'")
		self.ids.box.clear_widgets()
		lista = []
		for i in cursor:
			lista.append(i)
		if( len(lista) == 0):
			popup = Popup(title='Warning',content=Label(text='Album Not Found!'),size_hint=(None, None), size=(200, 200))
			popup.open()
		else:
			for album in lista:
				titulo = album.descricao
				if(len(titulo)>60):
					titulo = titulo.split()
					titulo = " ".join(titulo[0:5]) + "..."
				btn = Button(text=titulo,font_size=20,size_hint_y=None,height=100,background_color=(0.1,0.1,0.1,1))
				editButton = Button(pos_hint={'top':0.97,'right':0.97},text = 'Edit',size_hint = (0.05,None),height = '48dp')
				editButton.bind(on_press=partial(self.edit,album))
				btn.bind(on_press=partial(self.musics,album,editButton))
				self.ids.box.add_widget(btn)
		cursor.close()

	def musics(self,album,editbutton,*args):
		
		generic = self.manager.get_screen(name='generic')
		self.manager.current = 'generic'
		generic.ids.title.text = album.descricao
		generic.ids.box.clear_widgets()	
		cursor = cnxn.cursor()

		cursor.execute("SELECT nome as nome FROM dbo.playlist")

		cursor.execute("SELECT * FROM dbo.faixa where cod_album = %d" %(album.cod_album))
		generic.ids.floatlayout.add_widget(editbutton)


		generic.ids.price.text = "Price: "+str(album.preco)
		generic.ids.dt_grav.text = "Record Date: "+str(album.dt_grav)
		generic.ids.dt_compra.text = "Purchase Date:"+str(album.dt_compra)
		generic.ids.tipo_compra.text = "Purchase Type:"+str(album.tipo_compra)

		for music in cursor:
			btn = Label(text=music.descricao,font_size=20,size_hint_y=None,height=50,text_size= self.size,halign='left',valign='middle',pos_hint={'top': 1,'x':0.18})
			generic.ids.box.add_widget(btn)
		cursor.close()

	def populate(self):	
		self.ids.box.clear_widgets()	
		cursor = cnxn.cursor()
		cursor.execute("SELECT * from dbo.album")
	
		for album in cursor:
			titulo = album.descricao
			if(len(titulo)>60):
				titulo = titulo.split()
				titulo = " ".join(titulo[0:5]) + "..."

			btn = Button(text=titulo,font_size=20,size_hint_y=None,height=100,background_color=(0.1,0.1,0.1,1))
			editButton = Button(pos_hint={'top':0.97,'right':0.97},text = 'Edit',size_hint = (0.05,None),height = '48dp')
			editButton.bind(on_press=partial(self.edit,album))
			btn.bind(on_press=partial(self.musics,album,editButton))
			self.ids.box.add_widget(btn)
		cursor.close()




class RecorderScreen(Menu):
	pass

class CompositorScreen(Menu):
	pass

class MusicalPeriod(Menu):
	pass

class Manager(ScreenManager):
	pass


class ActionApp(App):
	def build(self):
		self.title = "SpotPer"
		return Manager()

myApp = ActionApp()
if __name__ == '__main__':
	myApp.run()
	cnxn.close()