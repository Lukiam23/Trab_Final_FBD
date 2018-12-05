use spotper;
--Consultas
--9a)
select * from album where preco > (select avg(preco) media from album);
--9b) incompleta
SELECT g.nome_grav
FROM gravadora g 
inner join album a on a.cod_grav = g.cod_grav
inner join faixa f on f.cod_album = a.cod_album
inner join faixa_playlist fp on f.numero = fp.numero and f.cod_album = fp.cod_album


--9c) N está otimizado
select top 1 c.nome, count(fp.cod_playlist) qtd_musicas
from compositor c inner join faixa_compositor fc 
on c.cod_compositor = fc.cod_compositor     
inner join faixa f on fc.cod_album = f.cod_album and fc.numero = f.numero
inner join faixa_playlist fp on f.cod_album = fp.cod_album and  fp.numero = f.numero
group by c.nome, c.cod_compositor 
order by 2;
--9d) errada pois n verifica todas as músicas das playlists

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
where c.descricao != '_oncerto' OR pm.descricao != '_arroco');