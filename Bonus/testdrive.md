# Provköra ett script innan 

Skriv

	begin transaction

		update Artist set Name='aaaaaaaaaaaaaaa' where ArtistId<=5

	select * from Artist

...se sedan hur många rader som berörs. Om okey kör

	commit

Om du ångrar dej:

	rollback