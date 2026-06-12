--

return {
	en = {
		tasks = {
			descs = {
				intro = 'Introduction',
				restoreInterface = 'Restore your interface',
				buildMex = 'Building a Metal Extractor',
				buildSolar = 'Building a Solar Collector',
				buildLLT = 'Building a Lotus',
				buildMex2 = 'Building another Metal Extractor',
				buildSolar2 = 'Building another Solar Collector',
				buildFac = 'Building a Factory',
				buildRadar = 'Building a Radar',
				buildCon = 'Building a Constructor',
				conAssist = 'Using a Constructor to assist your Factory',
				buildRaider = 'Building Combat Units',
				raiderTip = 'Keep Producing Units',
				epilogue_start = 'Tips and tricks',
				epilogue_units = 'Armies and Combat',
				epilogue_constructors = 'Constructors and Expansion',
				epilogue_economy = 'Ramping up Production',
				congrats = 'Congratulations!',
			},
			tips = {
				buildMex = 'Metal is used for construction and requires metal spots.',
				buildSolar = 'Energy is used to build and repair. It can be produced anywhere.',
				buildLLT = 'Turrets protect territory, but be careful to not build too many.',
				buildFac = 'Factories are quite expensive, however, the first one is free.',
				buildMex2 = 'Always seek out more metal spots to increase your income.',
				buildSolar2 = 'It is advisable to build at least one Solar per Mex.',
				buildRadar = 'Radar coverage shows distant enemy units as radar blips.',
				buildCon = 'Constructors can build, repair, reclaim and assist construction.',
				conAssist = 'Factories that are assisted by constructors build faster.',
				buildRaider = 'Combat units are used to attack your enemies and make them suffer.',
			},
		},
		steps = { -- I am Nubtron, the multilingual friendly robot.
			intro = [[Hello! I will teach you how to play Zero-K. Just follow my instructions and learn at your own pace.
<(Click next to continue)>]],
			intro2 = [[Just follow my instructions and learn at your own pace. <(Click next to continue)>]],
			intro3 = [[Move the camera with the <arrow keys>, <middle mouse button>, or moving your cursor to the <screen edge>.
<(Click next to continue)>]],
			intro4 = [[Zoom the camera with your mouse's <scroll wheel> or <Page Down> and <Page Up>.
<(Click next to continue)>]],
			intro5 =  [[If you have not done so already, select a commander. Then <left click> near a <metal spot> (grey ring) within the green overlay on the map to place your start position.]],
			selectComm = [[Select your commander by <left clicking> on it or pressing <ctrl+c>.]],
			showMetalMap = [[View the metal map by pressing <F4>.]],
			hideMetalMap = [[Hide the metal map by pressing <F4>.]],
			selectBotLab = [[Select your <Cloakbot Factory> by <left clicking> on it (look for the flashing blue circles).]],
			selectCon = [[Select your constructor by <left clicking> on it (look for the flashing blue circles).]],
			guardFac = [[Have the constructor guard your factory by right clicking on the factory. The constructor will assist it until you give it a different order.]],
			tutorialEnd = [[This is the end of the tutorial. Check out the <campaign> for a more thorough introduction to Zero-K. I can be re-enabled in the <Menu (F10)> under <Help>. Goodbye!
<(Click next to cycle tips, or X to close the tutorial)>]],
			
			selectBuild_m = [[Select the <#replace#> from your build menu (build-icon shown here)]],
			build_m = [[You are now building a #replace#. <Wait for it to finish.>]],
			
			finish = [[You have an unfinished <#replace#> shown by the red circles. <Right click on it to finish building>. ]],
			selectBuild = [[Select the <#replace#> from your build menu (build-icon shown here)]],
			start = [[<Place it near your other structures.> It will turn red if you try to place it on uneven terrain.]],
			build = [[Good work! You are now building a #replace#. <Wait for it to finish.>]],
			
			startMex = [[<Left click> near a <metal spot> (grey ring) to begin construction.]],
			selectBuildMex = [[Click on the <Econ> tab in the command panel below and select the <Metal Extractor>.]],
			startBotLab = [[You can rotate structures with the <[> and <]> keys before placing them. Turn the Cloakbot Factory and place it so that units can easily exit the front.]],
			
			raiderTipState = [[Queue five more more Glaives by <shift-clicking> its button in the build menu.
<(Click next to continue)>]],
			repeatTipState = [[<Repeat> mode can be toggled to loop production, which is good for keeping up production. Queue units while holding <alt> to order non-looped production.
<(Click next to continue)>]],

			epilogue1 = [[Your base is set up and ready to support an army. I will leave you with a few pointers.
<(Click next to continue)>]],
			epilogue2 = [[Select your Glaives then <right click and drag> on the map. This spreads units along a line and is vital for maintaining free firing lines and avoiding area-of-effect.
<(Click next to continue)>]],
			epilogue3 = [[Glaives are great at raiding lightly defended expansion and intercepting enemy raids, however, you will need heavier units as the battle progresses.
<(Click next to continue)>]],
			epilogue4 = [[Ronin and Reaver can be mixed to create a strong early army. Reaver has low range but annihilates raiders, while Ronin can harass enemies at range.
<(Click next to continue)>]],
			epilogue5 = [[Knight and Sling are great at busting entrenched positions. Knight has the health to assault heavy turrets, while Sling can wear down defences from far away.
<(Click next to continue)>]],
			epilogue6 = [[To learn more about a unit <hold space and click> on it, its wreck, or its build button, to bring up its description. Experiment with other units and factories.
<(Click next to continue)>]],
			epilogue7 = [[Your commander is essentially an armed constructor. Always have your commander and at least one constructor out on the map building extra Metal Extractors.
<(Click next to continue)>]],
			epilogue8 = [[Constructors can be given an <Area Mex> command to quickly queue multiple Metal Extractors.
<(Click next to continue)>]],
			epilogue9 = [[Select a <Constructor>, select <Area Mex (W)>, then <click and drag> an area with a few metal spots. Optionally, hold <Ctrl> to queue one Solar near each Mex.
<(Click next to continue)>]],
			epilogue10 = [[You can also <click and drag> Repair, Reclaim and Force Fire to issue a command that targets everything in an area.
<(Click next to continue)>]],
			epilogue11 = [[<Repair> assists construction, and uses energy to heal units. <Reclaim> gathers metal from wrecked units, up to 40% of their original value, and can be used on live units for a 50% refund.
<(Click next to continue)>]],
			epilogue12 = [[Your <metal> and <energy> storage are shown as bars at the top of the screen. The central green numbers are <income> while the rightmost red numbers are <demand>.
<(Click next to continue)>]],
			epilogue13 = [[All construction costs equal amounts metal and energy. Metal is scarce, so aim to keep both your <metal demand> and <energy income> greater than your <metal income>.
<(Click next to continue)>]],
			epilogue14 = [[Constructors spend at a rate equal to their <buildpower>. A few <Caretakers> can boost production, but building many more than you can sustain is redundant.
<(Click next to continue)>]],
			epilogue15 = [[<Construction Plates> can also boost production. To build one, select <Cloakbot Factory> from the <Factory> tab and place it in the circle that appears around your existing factory.
<(Click next to continue)>]],
			epilogue16 = [[Keep producing, expand your territory, and crush the opposition. Perhaps diversify your forces with a new factory, such as a <Tank Foundry> or <Gunship Plant>.
<(Click next to continue)>]],
		}
	}, --end en
	--I let this part between quote because I never used a ' in it.
	fr = {
		tasks = {
			descs = {
				intro = 'Introduction',
				restoreInterface = 'Restaurez votre interface',
				buildMex = 'Construire un extracteur de métal',
				buildSolar = 'Construire un collecteur solaire',
				buildLLT = 'Constuire une tourelle laser légère LLT',
				buildMex2 = 'Construire un autre extracteur sur un autre point de minerai',
				buildSolar2 = 'Construire un autre collecteur solaire',
				buildFac = 'Construire une usine',
				buildRadar = 'Construire un radar',
				buildCon = 'Construire un constructeur',
				conAssist = 'Utilisez le Constructeur pour assister une usine',
				buildRaider = 'Construire des Robots Pilleurs dans une usine',
				congrats = 'Félicitations!',
			},
			tips = { --made this part between [[]] because I used some ' in it.
				buildSolar = [[Les structures générant de l'énergie font fonctionner vos extracteurs et vos usines]],
				buildMex2 = [[Essayez d'acquérir toujours plus de point de minerai pour construire plus d'extracteurs.]],
				buildSolar2 = [[Essayez de construire toujours plus de structures énergétiques pour garder une économie forte.]],
				buildRadar = [[La couverture radar vous indiquer les ennemis en tant que points radars.]],
				buildCon = [[Tout comme votre commandeur, votre constructeur peut construire et assister les constructions.]],
				conAssist = [[Les usines assistées par des constructeurs construisent plus vite.]],
				buildRaider = [[Les unités de combat sont utilisées pour attaquer et détruire vos ennemis.]],
			},
		},
		steps = {
			intro = [[Bonjour! Je suis Nubtron, votre amical compagnon robot multilingue! Je vais vous apprendre à jouer a Zero-K. <(Cliquez ici pour continuer)>]],
			intro2 = [[Vous n'avez qu'à suivre mes instructions. Vous pouvez déplacer cette fenêtre en cliquant autour de ma tête. <(Cliquez ici pour continuer)>]],
			intro3 = [[Entrainez-vous à zoomer avec la camera en utilisant la molette de la souris <(Cliquez ici pour continuer)>]],
			intro4 = [[Vous pouvez déplacer la caméra en utilisant les flèches du clavier, ou en approchant les bords de l'écran avec le curseur. <(Cliquez ici pour continuer)>]],
			intro5 =  [[Choisissez votre position de départ en cliquant sur le sol. Prenons un endroit plat et large pour commencer. Cliquez ensuite sur le bouton <Ready>]],
			selectComm = [[Sélectionnez votre commandeur en cliquant sur lui ou en pressant <ctrl+c>.]],
			showMetalMap = [[Vous pouvez voir la présence de métal sur le sol en pressant <F4>.]],
			hideMetalMap = [[Rappuyez sur <F4> pour cacher l'affichage du metal sur le sol et ainsi revenir à la vue normale.]],
			selectBotLab = [[Selectionnez votre Usine de Robots en cliquant sur elle. (Le cercle bleu vous aidera à la trouver).]],
			selectCon = [[Selectionnez un constructeur en cliquant sur lui. (Le cercle bleu vous aidera à le trouver).]],
			guardFac = [[Ordonnez à votre constructeur de garder votre Usine de Robots en cliquant avec le bouton droit dessus. Le constructeur assistera la production de celle-ci jusqu'à ce que vous lui donniez un autre ordre ou que celle-ci finisse sa file de production.]],
			tutorialEnd = [[C'est la fin de ce tutoriel, je n'ai plus rien à vous apprendre. Vous pouvez éteindre Nubtron et reprendre une activité guerrière normale. Merci et au revoir! (Cliquez pour redémarrer le tutoriel)]],
			
			selectBuild_m = [[Selectionnez #replace# depuis le menu de construction (l'icône est montrée ici).]],
			build_m = [[Vous êtes désormais en train de construire un(e) #replace#. <Patientez jusqu'à son achèvement>]],
			
			finish = [[Vous avez un #replace# non terminé, signalé par des cercles rouges. <Cliquez à l'aide du bouton droit pour le finir.>. ]],
			selectBuild = [[Sélectionnez le #replace# depuis votre menu de construction.]];
			start = [[<Placez-le à proximité d'autres structures.> Il deviendra rouge si vous le placez sur un terrain inaproprié, et vous devrez le re-sélectionner.]],
			build = [[ Bon travail! Vous construisez désormais un(e) #replace#. <Attendez qu'il/elle se termine>]],
			
			startMex = [[Placez-le sur une tâche verte représentant un point de minerai.]],
			selectBuildMex = [[L'icône de construction pour l'Extracteur de metal (Mex) est à droite dans le menu de construction qui lui, est à gauche. Vous suivez toujours ?]],
			startBotLab = [[Avant de la placer, vous pouvez tourner une structure avec les touches <)> et <0>.<Tournez-la et placez-la de sorte que les unités puissent sortir en sortir facilement.>. Elle deviendra rouge si vous tentez de la placer sur un terrain inaproprié.]],
		}
	}, --end fr

	fi = {
		tasks = {
			descs = {
				intro = 'Perehdytys',
				restoreInterface = 'Palauta käyttöliittymä',
				buildMex = 'Rakenna metallikaivos (mex)',
				buildSolar = 'Rakenna aurinkovoimala',
				buildLLT = 'Rakenna kevyt laaseritorni (LLT)',
				buildMex2 = 'Rakenna toinen metallikaivos toiseen metalliesiintymään',
				buildSolar2 = 'Rakenna toinen aurinkovoimala',
				buildFac = 'Tehtaan rakentaminen',
				buildRadar = 'Tutkan rakentaminen',
				buildCon = 'Rakentajayksikön rakentaminen',
				conAssist = 'Käytä rakentaja-yksikköä avustaaksesi tehdastasi',
				buildRaider = 'Hyökkääjä-robottien rakentaminen tehtaassasi',
				congrats = 'Onneksi olkoon!',
			},
			tips = {
				buildSolar = 'Energiaa tuottavat rakennukset pitävät tukikohtasi toimintakuntoisena.',
				buildMex2 = 'Koita aina vallata mahdollisimman monta metalliesiintymää pystyäksesi rakentamaan niihin metallikaivoksia.',
				buildSolar2 = 'Koita aina rakentaa lisää energiaa tuottavia yksiköitä varmistaaksesi resurssiesi kasvun varmistumisen.',
				buildRadar = 'Tutkat varoittavat vihollisten hyökkäyksistä kauan ennenkuin he ovat päässeet tukikohtaasi.',
				buildCon = 'Aivan kuten komentajasi, myös rakentajat pystyvät rakentamaan taloja',
				conAssist = 'Jos rakentaja avustaa tehdasta, valmistuvat yksiköt nopeammin',
				buildRaider = 'Taisteluyksikköjä käytetään vihollisten murskaamiseen, joka on ainoa tapa saavuttaa voitto.',
			},
		},
		steps = {
			intro = [[Terve! Minä olen Nubtron, ystävällinen robottiapurisi. Minä opetan sinua pelaamaan Zero-K:ia opastetun harjoittelun avulla. <(Paina tästä jatkaaksesi)>]],
			intro2 = [[Seuraa vain ohjeitani. Voit liikutella tätä ikkunaa tarttumalla kuvastani hiiren kursorilla. <(Paina tästä jatkaaksesi)>]],
			intro3 = [[Harjoittele näkymän lähentämistä ja loitontamista käyttämällä hiiren rullaa. <(Paina tästä jatkaaksesi)>]],
			intro4 = [[Harjoittele näkymän vierittämistä ylös, alas, vasemmalle sekä oikealle nuolinäppäimien avulla. <(Paina tästä jatkaaksesi)>]],
			intro5 =  [[Aseta aloituskohtasi klikkaamalla kursorilla pelikenttää. Valitse tasainen kohta ja paina <Ready> nappia kun olet valmis aloittamaan pelin.]],
			selectComm = [[Valitse komentajasi kursorin avulla tai painamalla <ctrl+c>.]],
			showMetalMap = [[Avaa metalliesiintymä-näkymä painamalla <F4>.]],
			hideMetalMap = [[Sulje metalliesiintymä-näkymä painamalla <F4>.]],
			selectBotLab = [[Valitse robottitehtaasi vasenta hiiren painiketta käyttäen. (Siniset ympyrät auttavat sinua löytämään sen).]],
			selectCon = [[Valitse yksi rakentaja kursorin avulla (Siniset ympyrät auttavat sinua löytämään sen).]],
			guardFac = [[Aseta rakentaja vartioimaan robottitehdastasi painamalla oikeaa hiiren painiketta tehtan kohdalla. Rakentaja avustaa nyt tehdasta kunnes annat sille toisen komennon.]],
			tutorialEnd = [[Olet läpäissyt Nubtron-harjoittelun! Voit sulkea nubtronin ja jatkaa pelaamista. (Paina tästä käynnistääksesi harjoittelun uudelleen)]],
			
			selectBuild_m = [[Valitse #replace# valikostasi. (Rakennuskuvake näkyy tässä).]],
			build_m = [[Rakennat: #replace#. <Odota kunnes se on valmis.>]],
			
			finish = [[Sinulla on valmistumaton rakennus: #replace# jota punaiset ympyrät osoittavat. <Paina oikealla hiiren painikkeella rakennuksen yllä jatkaaksesi rakentamista>. ]],
			selectBuild = [[Valitse #replace# valikosta (Rakennuskuvake näkyy tässä). ]],
			start = [[<Aseta se muiden rakennustesi lähettyville.> Rakennuskuvake muuttuu punaiseksi, mikäli yrität antaa komennon maastoon johon kyseistä yksikköä ei pysty rakentamaan.]],
			build = [[Hyvin tehty! Rakennat: #replace#. <Odota kunnes se on valmis.>]],
			
			startMex = [[Aseta se metalliesiintymä-näkymässä näkyvään vihreään kohtaan.]],
			selectBuildMex = [[Oikealla puolella tässä ikkunassa näkyy metallikaivoksen rakennuskuvake. Rakentaaksesi sen, vaitse se vasemmalla olevasta rakennusvalikosta.]],
			startBotLab = [[Ennen rakennuskomennon antamista voit kääntää rakennuksen suuntaa käyttämällä <Å> sekä <´> näppäimiä. <Käännä ja aseta rakennus niin, että yksiköt pääsevät helposti poistumaan rakennuksesta>. Rakennuskuvake muuttuu punaiseksi, mikäli yrität antaa komennon maastoon johon kyseistä yksikköä ei pysty rakentamaan.]],
		}
	}, --end fi

	my = {
		tasks = {
			descs = {
				intro = 'Pengenalan',
				restoreInterface = 'Mengembalikan "interface" anda',
				buildMex = 'Membina sebuah penggali logam (mex)',
				buildSolar = 'Membina sebuah Pengumpul Suria ("Solar Collector")',
				buildLLT = 'Membina sebuah Menara Laser Ringan ("Light Laser Tower")',
				buildMex2 = 'Membina sebuah lagi mex di tempat lain.',
				buildSolar2 = 'Membina sebuah lagi Pengumpul Suria',
				buildFac = 'Membina sebuah Kilang',
				buildRadar = 'Membina sebuah Radar',
				buildCon = 'Membina sebuah Jurubina',
				conAssist = 'Mengunakan sebuah Jurubina untuk membantu kilang anda',
				buildRaider = 'Membina robot serangan ringan di kilang',
				congrats = 'Tahniah!',
			},
			tips = {
				buildSolar = 'Bangunan tenaga membekalkan tenaga kepada unit dan kilang anda.',
				buildMex2 = 'Anda harus sentiasa menguasai lebih banyak pusat logam untuk membina lebih penggali logam.',
				buildSolar2 = 'Wajar anda sentiasa berusaha membina lebih bangunan tenaga bagi mengembankan ekonomi anda.',
				buildRadar = 'Unit-unit musuh di dalam kawasan radar ditunjukkan sebagai bintik-bintik.',
				buildCon = 'Seperti Komander awak, jurubina menghasilkan (dan membantu membina) bangunan.',
				conAssist = 'Kilang yang dibantu oleh jurubina mengeluarkan unit dengan lebih cepat.',
				buildRaider = 'Unit ketenteraan bertujuan menentang dan menghapuskan musuh anda.',
			},
		},
		steps = {
			intro = [[Selamat datang! Saya ialah Nubtron, sahabat robot anda yang berbilang bahasa. Saya akan mengajar anda cara bermain Zero-K. <(Klik Next untuk teruskan)>]],
			intro2 = [[Anda hanya perlu menurti arahan saya. Anda boleh mengerakkan kotak di sekelliling mukaku ini. <(Klik Next untuk teruskan)>]],
			intro3 = [[Berlatih menatal kamera dekat dan jauh dengan roda tatal tetikus anda. <(Klik Next untuk teruskan)>]],
			intro4 = [[Berlatih menarik kamera ke atas, bawah, kiri dan kanan dengan kekunci anak panah. <(Klik Next untuk teruskan)>]],
			intro5 =  [[Pilih tempat mula anda dengan mengeklik pada suatu kawasan lapang di peta, kemudian klick butang <Ready> (bersedia).]],
			selectComm = [[Pilih hanya komander awak dengan mengeklik padanya ataupun menekan <ctrl+c>.]],
			showMetalMap = [[Lihat peta logam ("metal map") dengan menekan <F4>.]],
			hideMetalMap = [[Keluar dari peta logam ("metal map") dengan menekan <F4>.]],
			selectBotLab = [[Pilih Kilang Bot anda sahaja dengan mengekliknya (bulatan biru dapat membantu kamu mencarinya).]],
			selectCon = [[Pilih satu pembina dengan mengekliknya (bulatan biru dapat membantu kamu mencarinya).]],
			guardFac = [[Arahkan pembina ini menjaga Kilang Bot anda dengan mengeklik kanan atas Kilang. Pembina berkenaan akan menolong kilang sehingga anda memberinya arahan lain.]],
			tutorialEnd = [[ (Klik di sini untuk mengulangi tutorial)]],
			
			selectBuild_m = [[Pilih #replace#  daripada senarai binaan anda (imej binaan digambarkan di sini).]],
			build_m = [[Anda sedang membina sebuah #replace#. <Tunggu sehingga ia siap.>]],
			
			finish = [[Anda mempunyai sebuah #replace# yang terabai di bulatan merah. <Klik kanan padanya untuk meneruskan kerja>. ]],
			selectBuild = [[Pilih #replace# daripada senarai binaan anda (imej binaan digambarkan di sini). ]],
			start = [[<Letakkannya berhampiran bangunan-bangunan lain anda.> Ia akan menjadi merah jika anda cuba meletakkanya pada tanah yang tidak rata.]],
			build = [[Syabas! Anda kini membina sebuah #replace#. <Tunggu sehingga ia siap.>]],
			
			startMex = [[Letakkannya pada tompok hijau.]],
			selectBuildMex = [[Imej binaan untuk penggali logam (mex) ditunjukkan di kanan. Pilihkannya dari senarai binaan anda di kiri.]],
			startBotLab = [[Sebelum membina sesuatu bangunan, anda boleh menukar arah hadapannya dengan kekunci <[> and <]>. <Pusingkannya supaya unit mudah keluar melalui hadapan kilang>. Ia akan menjadi merah jika anda cuba meletakkanya pada tanah yang tidak rata.]],
		}
	}, --end my

	pl = {
		tasks = {
			descs = {
				intro = 'Wprowadzenie',
				restoreInterface = 'Odnowienei interfejsu',
				buildMex = [[Zbudowanie kopalni (mex'a)]],
				buildSolar = 'Zbudowanie elektrowni slonecznej (Solar Collector)',
				buildLLT = 'Zbudowanie lekkiej wiezyczki (LLT)',
				buildMex2 = [[Zbudowanie kolejnego mex'a na innej latce metalu.]],
				buildSolar2 = 'Zbudowanie kolejnej elektrowni slonecznej',
				buildFac = 'Zbudowanie fabryki',
				buildRadar = 'Zbudowanie radaru',
				buildCon = 'Zbudowanie konstruktora',
				conAssist = 'Uzycie konstruktora do wspomagania fabryki',
				buildRaider = 'Budowanie jednostek w fabryce.',
				congrats = 'Gratulacje!',
			},
			tips = {
				buildSolar = [[Elektrownie dostarczaja prad do mex'ow oraz fabryk.]],
				buildMex2 = [[Zawsze walcz o dodatkowe latki metalu do budowy kolejnych mex'ow.]],
				buildSolar2 = [[Zawsze staraj sie budowac wiecej elektrowni dla zasilania ekonomii.]],
				buildRadar = 'Radar pokazuje odlegle jednostki wroga jako kropki.',
				buildCon = 'Tak jak Commander, konsruktorzy buduja i wspomagaja budowe.',
				conAssist = 'Wspomagane fabryki buduja szybciej.',
				buildRaider = 'Jednostki bojowe uzywane sa do atakowania przeciwnika.',
			},
		},
		steps = {
			intro = [[Dzien dobry! Jestem Nubtron, wielojezyczny, przyjacielski robot. Naucze cie jak grac w Zero-K. <(Nacisnij tutaj aby kontynuowac)>]],
			intro2 = [[Wykonuj moje instrukcje. Mozesz przesuwac to okienko lapiac za moja twarz. <(Nacisnij tutaj aby kontynuowac)>]],
			intro3 = [[Sprobuj przyblizac i oddalac obraz uzywajac kulki/pokretla myszy. <(Nacisnij tutaj aby kontynuowac)>]],
			intro4 = [[Sprobuj przesuwac obraz uzywajac strzalek. <(Nacisnij tutaj aby kontynuowac)>]],
			intro5 =  [[Wybierz pozycje startowa poprzez klikniecie na plaskim terenie, po czym nacisnik przycisk <Ready>.]],
			selectComm = [[Zaznacz samego Commandera poprzez kombinacje <ctrl+c>.]],
			showMetalMap = [[Pokaz metal-mape, naciskajac <F4>.]],
			hideMetalMap = [[Schowaj metal-mape, naciskajac <F4>.]],
			selectBotLab = [[Zaznacz fabryke robotow poprzez nacisniecie jej (niebieskie kolka pomoga Ci ja znalezc).]],
			selectCon = [[Zaznacz konstruktora klikajac go (niebieskie kolka pomoga Ci go znalezc).]],
			guardFac = [[Kaz konstruktorowi wsomagac fabryke, naciskajac ja prawym przyciskiem myszy lub dajac komende Guard. Bedzie ja wspomagac dopoki nie wydasz innego rozkazu.]],
			tutorialEnd = [[To juz koniec samouczka. Mozesz teraz wylaczyc Nubtrona. Do widzenia! (Nacisnij tutaj aby zrestartowac samouczek)]],
				
			selectBuild_m = [[Zaznacz #replace# z menu budowy (ikonka budowy pokazana tutaj).]],
			build_m = [[Budujesz teraz #replace#. <Poczekaj az skonczy sie budowac.>]],
			
			finish = [[Masz niedokonczona budowe: #replace#, zaznaczona czerwonymi kolkami. <Nacisnij na nia prawym przyciskiem aby ja dokonczyc>. ]],
			selectBuild = [[Zaznacz #replace# z menu budowy (ikonka budowy pokazana tutaj). ]],
			start = [[<Postaw go obok innych budowli.> Bedzie czerwona jesli postawisz ja na nierownym terenie i bedziesz musial ustawiac ja od poczatku.]],
			build = [[Dobra robota! Budujesz wlasnie #replace#. <Poczekaj na zakonczenie budowy.>]],
			
			startMex = [[Postaw go na zielonej latce.]],
			selectBuildMex = [[Ikonka mex'a jest pokazana na prawo. Zaznacz ja w menu po lewej.]],
			startBotLab = [[Zanim ja ulokujesz, mozesz obracac budowe klawiszami <[> oraz <]> . <Obroc ja tak, aby jednostki mogly swobodnei wychodzic>. Bedzie czerwona jesli postawisz ja na nierownym terenie i bedziesz musial ustawiac ja od poczatku.]],
		}
	}, --end pl

	zh_CN = {
		tasks = {
			descs = {
				intro = '介绍',
				restoreInterface = '恢复界面',
				buildMex = '建造金属提取器',
				buildSolar = '建造太阳能收集器',
				buildLLT = '建造莲花',
				buildMex2 = '建造另一个金属提取器',
				buildSolar2 = '建造另一个太阳能收集器',
				buildFac = '建造工厂',
				buildRadar = '建造雷达',
				buildCon = '建造工程单位',
				conAssist = '使用工程单位协助工厂',
				buildRaider = '建造战斗单位',
				raiderTip = '继续生产单位',
				epilogue_start = '提示和技巧',
				epilogue_units = '军队和战斗',
				epilogue_constructors = '工程单位和扩张',
				epilogue_economy = '提高产量',
				congrats = '恭喜！',
			},
			tips = {
				buildMex = '金属用于建造，需要金属点。',
				buildSolar = '能量用于建造和修复。可以在任何地方生产。',
				buildLLT = '炮台保护领土，但注意不要建造太多。',
				buildFac = '工厂相当昂贵，但第一个是免费的。',
				buildMex2 = '始终寻找更多金属点以增加收入。',
				buildSolar2 = '建议每个墨西哥至少建造一个太阳能。',
				buildRadar = '雷达覆盖显示远处敌方单位为雷达光点。',
				buildCon = '工程单位可以建造、修复、回收和协助建造。',
				conAssist = '由工程单位协助的工厂建造更快。',
				buildRaider = '战斗单位用于攻击敌人并使他们受苦。',
			},
		},
		steps = {
			intro = [[你好！我将教你如何玩Zero-K。只需按照我的说明操作，按自己的节奏学习。
<(点击下一步继续)>]],
			intro2 = [[只需按照我的说明操作，按自己的节奏学习。<(点击下一步继续)>]],
			intro3 = [[使用<方向键>、<中键>或将光标移到<屏幕边缘>来移动镜头。
<(点击下一步继续)>]],
			intro4 = [[使用鼠标的<滚轮>或<Page Down>和<Page Up>来缩放镜头。
<(点击下一步继续)>]],
			intro5 = [[如果还没有，请选择一个指挥官。然后在地图上绿色覆盖区域内的<金属点>（灰色圆环）附近<左键点击>以放置你的起始位置。]],
			selectComm = [[通过<左键点击>或按<ctrl+c>选择你的指挥官。]],
			showMetalMap = [[按<F4>查看金属地图。]],
			hideMetalMap = [[按<F4>隐藏金属地图。]],
			selectBotLab = [[<左键点击>选择你的<隐形机器人工厂>（寻找闪烁的蓝色圆圈）。]],
			selectCon = [[<左键点击>选择你的工程单位（寻找闪烁的蓝色圆圈）。]],
			guardFac = [[让工程单位右键点击工厂来守卫它。工程单位会协助它，直到你给出不同的命令。]],
			tutorialEnd = [[教程到此结束。查看<战役>以获得更全面的Zero-K介绍。可以在<F10菜单>下的<帮助>中重新启用。再见！
<(点击下一步查看提示，或X关闭教程)>]],
			selectBuild_m = [[从建造菜单中选择<#replace#>（建造图标如图所示）]],
			build_m = [[你正在建造#replace#。<等待建造完成。>]],
			finish = [[你有一个未完成的<#replace#>，由红色圆圈标示。<右键点击它以完成建造>。]],
			selectBuild = [[从建造菜单中选择<#replace#>（建造图标如图所示）]],
			start = [[<将它放在其他建筑附近。>如果尝试放在不平坦的地面上，它会变红。]],
			build = [[做得好！你正在建造#replace#。<等待建造完成。>]],
			startMex = [[在<金属点>（灰色圆环）附近<左键点击>开始建造。]],
			selectBuildMex = [[点击下方命令面板中的<Econ>标签，选择<金属提取器>。]],
			startBotLab = [[放置前可以用<[>和<]>键旋转建筑。旋转隐形机器人工厂并放置，使单位可以轻松从前方出口离开。]],
			raiderTipState = [[通过<shift点击>建造菜单中的按钮来排队生产五个更多Glaives。
<(点击下一步继续)>]],
			repeatTipState = [[<重复>模式可以切换为循环生产，有利于保持产量。按住<alt>排队非循环生产。
<(点击下一步继续)>]],
			epilogue1 = [[你的基地已经建立，准备好支持一支军队。我将给你一些要点。
<(点击下一步继续)>]],
			epilogue2 = [[选择你的Glaives，然后在地图上<右键点击并拖动>。这会沿直线分散单位，对于保持自由射击线和避免范围伤害至关重要。
<(点击下一步继续)>]],
			epilogue3 = [[Glaives擅长突袭防御薄弱的扩张点。保持生产并攻击敌人的经济。
<(点击下一步继续)>]],
			epilogue4 = [[使用<攻击移动>命令让单位沿路径移动并攻击沿途的敌人。
<(点击下一步继续)>]],
			epilogue5 = [[使用<巡逻>命令让单位在路径点之间来回移动。
<(点击下一步继续)>]],
			epilogue6 = [[建造<太阳能收集器>来产生能量。能量用于建造、修复和特殊能力。
<(点击下一步继续)>]],
			epilogue7 = [[建造<金属提取器>在金属点上获取金属。金属是建造的主要资源。
<(点击下一步继续)>]],
			epilogue8 = [[使用<回收>命令从残骸中获取资源。残骸保留了原始单位40%的金属成本。
<(点击下一步继续)>]],
			epilogue9 = [[使用<修复>命令修复受损单位。修复消耗能量。
<(点击下一步继续)>]],
			epilogue10 = [[你还可以<点击并拖动>修复、回收和强制攻击来对区域内所有目标发出命令。
<(点击下一步继续)>]],
			epilogue11 = [[<修复>协助建造，并使用能量治疗单位。<回收>从被摧毁的单位中收集金属，最多40%的原始成本。
<(点击下一步继续)>]],
			startMex2 = [[在另一个金属点附近放置金属提取器。]],
			selectBuildMex2 = [[再次点击<Econ>标签并选择<金属提取器>。]],
			startSolar2 = [[在空地上放置太阳能收集器。]],
			selectBuildSolar2 = [[点击<Econ>标签并选择<太阳能收集器>。]],
			startFac = [[放置你的工厂。确保前方有足够空间让单位出来。]],
			selectBuildFac = [[点击左侧菜单中的<Factory>标签。]],
			startRadar = [[放置雷达以发现远处的敌人。]],
			selectBuildRadar = [[点击<Econ>标签并选择<雷达>。]],
			startCon = [[在工厂中建造工程单位。]],
			selectBuildCon = [[点击工厂菜单中的<工程单位>标签。]],
			conAssist2 = [[让工程单位右键点击工厂来协助它。这会加快生产速度。]],
			buildRaider2 = [[在工厂中排队生产战斗单位。]],
			startMex = [[在金属点附近放置金属提取器。]],
			startBotLab2 = [[放置你的工厂。]],
		},
	}

} -- end text
