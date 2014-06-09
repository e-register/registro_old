Registro Elettronico
============

Questo è il registro elettronico creato da Edoardo Morassutto. 

La storia di questo registro è abbastanza lunga e intricata... basti pensare
che questo è il 4 rewrite completo D:

- La prima versione è stata scritta in PHP e supportava solo la gestione (mooolto
basilare) delle valutazioni, era vulnerabile a praticamente tutti gli attacchi
e aveva una grafica estremamente scadente
- La seconda versione è stata progettata per cambiare grafica e rimodernare e 
pulire il codice dalle mille sciocchezze che sono state scritte. Il risulato è 
stato un registro _quasi_ carino da vedere ma assolutamente orribile da usare
- La terza versione (quella che doveva rifare la storia) è stata scritta in PHP 
ed è stato il frutto di attenti progetti a tavolino pre-codifica, i quali hanno 
reso possibile una strutturazione più modulare è concreta alle funzionalità
implementate e implementabili. Sono state introdotte moooolte ottimizzazioni, 
sia sul database che sul codice del server. Il mio computer era in grado di 
gestire diversi milioni di valutazioni in meno di mezzo secondo con una sola 
richiesta alla volta. Numerosissimi controlli di sicurezza e di protezione dei
dati sono stati introdotti (altrimenti tutto sarebbe ancora più veloce ;) )

Siamo giunti quindi alla quarta versione, progetto assolutamente sperimentale.

E' la prima volta che programmo in [Ruby](https://github.com/ruby/ruby) e verrà 
utilizzata la libreria [Rails](https://github.com/rails/rails) con la quale 
penso di fare uno sviluppo molto più rapido delle varie funzionalità, comprese
le varie prove con i test (con l'ausilio di [Travis-CI](https://travis-ci.org)).

Lo sviluppo iniziale sarà abbastanza veloce, verrà infatti utilizzato il progetto
e il modello della terza versione. Sarà quindi principalmente un porting in Ruby
on Rails.

La fase iniziale del progetto subirà un rallentamento per apprendere appieno le
funzionalità messe a disposizione da Rails, capire bene come vanno organizzati 
i modelli e come gestire tutto. Appena mi sarò impratichito bene il progetto
avrà un rapido aumento di produzione.


[![Build Status](https://travis-ci.org/registro-dev/registro.svg?branch=master)](https://travis-ci.org/registro-dev/registro)
