# Movie Match -Flutter-sovellus

Cross-Platform Mobile Application Development -opintojakson tehtävä, joka vaatii taustalle [gRPC-palvelinohjelman] pienin muokkauksin. Muokkaukset on tehtävä lib/moviematch_server.dart-tiedostossa olevan MovieMatchService-luokan streamState-metodin request-parametrin listen-metodikutsun parametrina olevan callback-funktion toteutusosan for-silmukkaan. Silmukan ehtolauseen toteutusosasassa olevan matchMessage-muuttujan on oltava kuvan 1 mukainen.

![Kuva 1](images/matchMessage.png)

## Sovellus

Aloitusnäkymä, jossa käyttäjänimi on mahdollista vaihtaa:

![Kuva aloitusnäkymästä](images/StartPage.png)

Elokuvien selausnäkymä:

![Kuva elokuvien selausnäkymästä](images/GeneratorPage.png)

Kun vähintään kaksi eri käyttäjää on tykännyt samasta elokuvasta, ilmoittaa sovellus tästä ponnahtavan modaalisivun avulla:

![Kuva modaali-ikkunasta](images/Modal.png)

Näkymä, jossa voi vastapuolikohtaisesti tarkastella elokuvia, joista on yhteisesti tykätty:

![Kuva näkymästä, jossa on lueteltu yhteiset tykkäykset](images/MatchPage.png)

## Arkkitehtuuri

![Havainnekuva sovelluksen arkkitehtuurista](images/Architecture.png)

## Puutteet
- Sovelluksen käyttöliittymä ei vielä skaaladu vaakatasoon
- Sovellus ei toimi tällä hetkellä selainpohjaisesti
