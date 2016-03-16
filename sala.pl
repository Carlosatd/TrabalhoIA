%

:-dynamic datashow/2.
:-dynamic computador/2.
:-dynamic ar/2.
:-dynamic esta/2.
:-dynamic ocupada(sala,professor).

sala(s1).
sala(s2).
sala(s3).
professor(aline).
professor(marcos).
professor(rosseti).
professor(martinhon).
esta(aline,casa).
esta(marcos,uff).
esta(rosseti,uff).
esta(martinhon,casa).
aula(aline, s1, 16, 18).
aula(marcos,s2, 20, 22).
usa_datashow(aline).
usa_computador(aline).
usa_computador(marcos).
usa_computador(martinhon).
usa_ar(rosseti).
usa_ar(aline).
usa_ar(marcos).


%professor so pode dar aula se estiver na faculdade
esta_na_faculdade(X):-esta(X,uff)-> write_ln('professor esta na uff');esta(X,aula)->write_ln('professor esta em aula');write_ln('professor não está na uff').

%professor da aula em determinado horario
dar_aula(X,Y):- sala_aberta(X,Y) ->(esta(X,uff)->(retract(esta(X,_)),assert(esta(X,aula)),usa_aparelhos(X));write_ln('professor nao tem aula agora')); write_ln('não é possivel ter aula').
sala_aberta(X,Y):- esta_na_faculdade(X),aula(X,S,Y,_) -> esta_ocupada(X,S),write_ln('aula') ; write_ln('professor não tem aula nesse horario'),fail.

%ligar os aparelhos de acordo com o professor
usa_aparelhos(X):-(usa_ar(X)->liga_ar(X);write_ln('ar desligado')),(usa_computador(X)->liga_computador(X);write_ln('pc desligado')),(usa_datashow(X)->liga_datashow(X);write_ln('datashow desligado')),!.

liga_ar(X):-assert(ar(X,ligado)), write_ln('ar ligado').
liga_computador(X):-assert(computador(X,ligado)),write_ln('computador ligado').
liga_datashow(X):-assert(datashow(X,ligado)),write_ln('datashow ligado').

%verificar se a sala esta ocupada
esta_ocupada(X,S):- ocupada(S,X)-> fail;assert(ocupada(S,X)).


%desligar aparelhos
desliga_aparelhos(X):-(usa_ar(X)->desliga_ar(X);write_ln('ar não está ligado')),(usa_computador(X)->desliga_computador(X);write_ln('pc nao está ligado')),(usa_datashow(X)->desliga_datashow(X);write_ln('datashow não está ligado')),!.

desliga_ar(X):-retract(ar(X,ligado)),assert(ar(X,desligado)), write_ln('ar desligado').
desliga_computador(X):-retract(computador(X,ligado)),assert(computador(X,desligado)),write_ln('computador desligado').
desliga_datashow(X):-retrac(datashow(X,ligado)),assert(datashow(X,desligado)),write_ln('datashow desligado').

%terminar a aula
terminar_aula(X,Y):- (esta(X,aula),aula(X,S,_,Y))->(retract(ocupada(S,X)),desliga_aparelhos(X),write_ln('fim da aula'));write_ln('não esta em aula').


%erros encontrados: varias notificações de professor nao esta na uff, professor dando aula fora do horario.