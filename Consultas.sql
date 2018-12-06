--use master
use spotper;
--Consultas
--9a)Listar os álbum com preço de compra maior que a média de preços de compra
--de todos os álbuns
select * from album where preco > (select avg(preco) media from album);


--9b) Listar nome da gravadora com maior número de playlists que possuem pelo
--uma faixa composta pelo compositor Dvorack.

--select * from compositor
select g.nome_grav, count(fp.cod_playlist) 'qtd playlist'
from gravadora g inner join album a on g.cod_grav=a.cod_grav
	 inner join faixa f on a.cod_album = f.cod_album
	 inner join faixa_playlist fp on fp.cod_album = f.cod_album and fp.numero=f.numero
	 inner join faixa_compositor fc on f.numero = fc.numero and f.cod_album = fc.cod_album
	 inner join compositor c on fc.cod_compositor = c.cod_compositor
	 and c.nome='Linkin Park'
group by g.cod_grav, g.nome_grav
having COUNT(fp.cod_playlist)>=all(select count(fp.cod_playlist)
							from gravadora g inner join album a on g.cod_grav=a.cod_grav
							inner join faixa f on a.cod_album = f.cod_album
							inner join faixa_playlist fp on fp.cod_album = f.cod_album and fp.numero=f.numero
							inner join faixa_compositor fc on f.numero = fc.numero and f.cod_album = fc.cod_album
							inner join compositor c on fc.cod_compositor = c.cod_compositor
							and c.nome='Linkin Park'
							group by g.cod_grav)


--9c) Listar nome do compositor com maior número de faixas nas playlists
--	  existentes.
-- N está otimizado
select top 1 c.nome, count(fp.cod_playlist) qtd_musicas
from compositor c inner join faixa_compositor fc 
on c.cod_compositor = fc.cod_compositor     
inner join faixa f on fc.cod_album = f.cod_album and fc.numero = f.numero
inner join faixa_playlist fp on f.cod_album = fp.cod_album and  fp.numero = f.numero
group by c.nome, c.cod_compositor 
order by 2;


--9d) Listar playlists, cujas faixas (todas) têm tipo de composição “Concerto” e
--	  período “Barroco”

(SELECT p.cod_playlist, p.nome FROM playlist p
inner join faixa_playlist fp on p.cod_playlist = fp.cod_playlist
inner join faixa f on f.cod_album = fp.cod_album and f.numero = fp.numero
inner join composicao c on c.cod_composicao = f.cod_composicao
inner join faixa_compositor fc on fc.cod_album = f.cod_album and f.numero = fc.numero
inner join compositor co on fc.cod_compositor = co.cod_compositor
inner join periodo_musical pm on co.cod_per = pm.cod_per
group by p.cod_playlist, p.nome)
EXCEPT
(SELECT p.cod_playlist,p.nome FROM playlist p
inner join faixa_playlist fp on p.cod_playlist = fp.cod_playlist
inner join faixa f on f.cod_album = fp.cod_album and f.numero = fp.numero
inner join composicao c on c.cod_composicao = f.cod_composicao
inner join faixa_compositor fc on fc.cod_album = f.cod_album and f.numero = fc.numero
inner join compositor co on fc.cod_compositor = co.cod_compositor
inner join periodo_musical pm on co.cod_per = pm.cod_per
where c.descricao not like '_oncerto' OR pm.descricao not like '_arroco'
group by p.cod_playlist, p.nome);