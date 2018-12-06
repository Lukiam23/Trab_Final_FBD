use spotper;
--Consultas
--9a)
select * from album where preco > (select avg(preco) media from album);
--9b) 
select g.nome_grav, count(fp.cod_playlist) 'qtd playlist'
from gravadora g inner join album a on g.cod_grav=a.cod_grav
	 inner join faixa f on a.cod_album = f.cod_album
	 inner join faixa_playlist fp on fp.cod_album = f.cod_album and fp.numero=f.numero
	 inner join faixa_compositor fc on f.numero = fc.numero and f.cod_album = fc.cod_album
	 inner join compositor c on fc.cod_compositor = c.cod_compositor
	 and c.nome='Dvorack'
group by g.cod_grav, g.nome_grav
having COUNT(fp.cod_playlist)>=all(select count(fp.cod_playlist)
							from gravadora g inner join album a on g.cod_grav=a.cod_grav
							inner join faixa f on a.cod_album = f.cod_album
							inner join faixa_playlist fp on fp.cod_album = f.cod_album and fp.numero=f.numero
							inner join faixa_compositor fc on f.numero = fc.numero and f.cod_album = fc.cod_album
							inner join compositor c on fc.cod_compositor = c.cod_compositor
							and c.nome='Dvorack'
							group by g.cod_grav)


--9c)
select top 1 c.nome, count(fp.cod_playlist) qtd_musicas
from compositor c inner join faixa_compositor fc 
on c.cod_compositor = fc.cod_compositor     
inner join faixa f on fc.cod_album = f.cod_album and fc.numero = f.numero
inner join faixa_playlist fp on f.cod_album = fp.cod_album and  fp.numero = f.numero
group by c.nome, c.cod_compositor 
order by 2;
--9d)

(SELECT p.* FROM playlist p
inner join faixa_playlist fp on p.cod_playlist = fp.cod_playlist
inner join faixa f on f.cod_album = fp.cod_album and f.numero = fp.numero
inner join composicao c on c.cod_composicao = f.cod_composicao
inner join faixa_compositor fc on fc.cod_album = f.cod_album and f.numero = fc.numero
inner join compositor co on fc.cod_compositor = co.cod_compositor
inner join periodo_musical pm on co.cod_per = pm.cod_per)
EXCEPT
(SELECT p.* FROM playlist p
inner join faixa_playlist fp on p.cod_playlist = fp.cod_playlist
inner join faixa f on f.cod_album = fp.cod_album and f.numero = fp.numero
inner join composicao c on c.cod_composicao = f.cod_composicao
inner join faixa_compositor fc on fc.cod_album = f.cod_album and f.numero = fc.numero
inner join compositor co on fc.cod_compositor = co.cod_compositor
inner join periodo_musical pm on co.cod_per = pm.cod_per
where c.descricao != '_oncerto' AND pm.descricao != '_arroco');