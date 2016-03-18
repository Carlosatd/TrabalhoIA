%

:-dynamic datashow/2.
:-dynamic computador/2.
:-dynamic ar/2.
:-dynamic esta/2.
:-dynamic ocupada(sala,professor).
:-dynamic hora.

%Salas Disponiveis
sala(s1).
sala(s2).
sala(s3).

%professores
professor(aline).
professor(marcos).
professor(rosseti).
professor(martinhon).

%aonde estão os professores no momento
esta(aline,casa).
esta(marcos,uff).
esta(rosseti,uff).
esta(martinhon,casa).

%quando chegam e vão embora
chega(aline,12).
chega(marcos,17).
chega(rosseti,9).
chega(martinhon,7).
embora(aline,19).
embora(marcos,23).
embora(rosseti,17).
embora(martinhon,12).

%aulas dos professores
aula(aline, s1, 16, 18).
aula(marcos,s2, 20, 22).
aula(rosseti,s1,14,16).
aula(martinhon,s3,08,10).

%preferencias de casa um
usa_datashow(aline).
usa_computador(aline).
usa_computador(marcos).
usa_computador(martinhon).
usa_ar(rosseti).
usa_ar(aline).
usa_ar(marcos).


%professor so pode dar aula se estiver na faculdade
esta_na_faculdade(X):-esta(X,uff)-> write(X),write_ln(' esta na uff');esta(X,aula)->write(X),write_ln(' esta em aula');write(X),write_ln(' não está na uff').

%professor da aula em determinado horario
dar_aula(X,Y):- sala_aberta(X,Y) ->(esta(X,uff)->(retract(esta(X,_)),assert(esta(X,aula)),usa_aparelhos(X), write_ln('aula'));write_ln('professor nao tem aula agora')); write_ln('não é possivel ter aula').
sala_aberta(X,Y):- (esta_na_faculdade(X),aula(X,S,Y,_)) -> esta_ocupada(X,S) ; write_ln('professor não tem aula nesse horario'),fail.

%ligar os aparelhos de acordo com o professor
usa_aparelhos(X):-(usa_ar(X)->liga_ar(X);write_ln('ar desligado')),(usa_computador(X)->liga_computador(X);write_ln('pc desligado')),(usa_datashow(X)->liga_datashow(X);write_ln('datashow desligado')),!.

liga_ar(X):-assert(ar(X,ligado)), write_ln('ar ligado').
liga_computador(X):-assert(computador(X,ligado)),write_ln('computador ligado').
liga_datashow(X):-assert(datashow(X,ligado)),write_ln('datashow ligado').

%verificar se a sala esta ocupada
esta_ocupada(X,S):- ocupada(S,X)->write_ln('sala ocupada'), fail;assert(ocupada(S,X)).


%desligar aparelhos
desliga_aparelhos(X):-(usa_ar(X)->desliga_ar(X);write_ln('ar não está ligado')),(usa_computador(X)->desliga_computador(X);write_ln('pc nao está ligado')),(usa_datashow(X)->desliga_datashow(X);write_ln('datashow não está ligado')),!.

desliga_ar(X):-retract(ar(X,ligado)),assert(ar(X,desligado)), write_ln('ar desligado').
desliga_computador(X):-retract(computador(X,ligado)),assert(computador(X,desligado)),write_ln('computador desligado').
desliga_datashow(X):-retract(datashow(X,ligado)),assert(datashow(X,desligado)),write_ln('datashow desligado').

%terminar a aula
terminar_aula(X,Y):- (esta(X,aula),aula(X,S,_,Y))->(retract(ocupada(S,X)),desliga_aparelhos(X),write_ln('fim da aula'));write_ln('não esta em aula').


%buscas
busca_hor(H):- aula(P,S,H,F)->dar_aula(P,H);true.
busca_ter(H):- aula(P,S,I,H)->terminar_aula(P,H);true.

%verifica quando o professor chega ou sai
chega_prof(H,L):- chega(X,H)->(retract(esta(X,_)),assert(esta(X,L)),write(X),write_ln(' chegou'));true.
sai_prof(H):-embora(X,H)->(retract(esta(X,_)),assert(esta(X,casa)),write(X),write_ln(' foi embora'));true.

%simula um dia normal
dia(I):-
  write('HORA: '),
  write_ln(I),
  I < 24,
  chega_prof(I,uff),
  busca_ter(I),
  busca_hor(I),
  sai_prof(I),
  I2 is I+1,
  dia(I2).

