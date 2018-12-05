CREATE TRIGGER DURACAO_PLAYLSIT
ON faixa_playlist
AFTER INSERT, UPDATE, DELETE
AS
DECLARE @cod_play INT
DECLARE @temp_exec_play INT

IF (EXISTS(SELECT * FROM deleted))
BEGIN
	SELECT @cod_play=@cod_play FROM deleted
	SELECT @temp_exec_play = sum(tmp_exec)
	FROM faixa f INNER JOIN faixa_playlist fp ON
	f.cod_album = fp.cod_album and
	f.numero = fp.numero

END
ELSE
BEGIN

END

	