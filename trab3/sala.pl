%

:-dynamic datashow/2.
:-dynamic computador/2.
:-dynamic ar(_,desligado).
:-dynamic esta/2.

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
usa_ar(rosseti).
usa_ar(aline).
usa_ar(marcos).


%professor so pode dar aula se estiver na faculdade
esta_na_faculdade(X):-esta(X,uff),write_ln('professor esta na uff').
esta_na_faculdade(X):-esta(X,casa),write_ln('professor nao esta na uff').

%professor da aula em determinado horario
dar_aula(X,Y):- sala_aberta(X,Y),retract(esta(X,_)),assert(esta(X,aula)),usa_aparelhos(X).
sala_aberta(X,Y):- esta_na_faculdade(X),aula(X,_,Y,_),write_ln('aula').
sala_aberta(X,Y):- esta_na_faculdade(X),\+ aula(X,_,Y,_), write_ln('professor nao tem aula agora').
sala_aberta(X,Y):- \+ esta_na_faculdade(X), write_ln('professor nao esta em sala').


%ligar os aparelhos de acordo com o professor
usa_aparelhos(X):-liga_ar(X);liga_computador(X);liga_datashow(X);!.
usa_aparelhos(X):-liga_ar(X),liga_computador(X),!.
usa_aparelhos(X):- \+liga_ar(X); liga_computador(X);liga_datashow(X),!.
usa_aparelhos(X):- \+liga_ar(X);\+ liga_computador(X); \+ liga_datashow(X); white_ln('nao usa nada'),!.


liga_ar(X):-usa_ar(X),assert(ar(X,ligado)), write_ln('ar ligado').
liga_computador(X):-usa_computador(X),assert(computador(X,ligado)),write_ln('computador ligado').
liga_datashow(X):-usa_datashow(X),assert(datashow(X,ligado)),write_ln('usa datashow').



%desligar aparelhos
desliga_aparelhos(X):-usa_ar(X),assert(ar(X,desliga)),usa_computador(X),assert(computador(X,desliga)),usa_datashow(X),assert(datashow(X,desliga)),write_ln('datashow, computador e ar desligados').
%desliga_aparelhos(X):-\+ usa_ar(X),usa_computador(X),assert(computador(X,desliga)),usa_datashow(X),assert(datashow(X,desliga)),write_ln('datashow e computador desligados').
%desliga_aparelhos(X):-\+ usa_ar(X),usa_computador(X),assert(computador(X,desliga)),\+ usa_datashow(X),write_ln('computador desligado').
%desliga_aparelhos(X):- usa_ar(X),\+ usa_computador(X),\+usa_datashow(X),write_ln('ar desligado').

%terminar a aula
%terminar_aula(X,Y):- esta(X,aula),aula(X,_,_,Y),desliga_aparelhos(X),write_ln('fim da aula').
%terminar_aula(X,Y):-\+ esta(X,aula), write_ln('professor nao esta dando aula').


%cod antigo inutilizado
%liga_aparelhos(X,Y):-sala_aberta(X,Y),\+liga_datashow(X);\+usa_computador(X);\+usa_ar(X).
%liga_datashow(X):-\+usa_datashow(X);assert(datashow(X,ligado)).
%ar_ligado(X):- \+usa_ar(X).