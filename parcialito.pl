% PARCIAL VOCALOID -------------------------------------------------------------------------------------------------------------------------------------
    

cantante(megurineLuka).
sabeCantar(megurineLuka, cancion(nightfever,4)).
sabeCantar(megurineLuka, cancion(foreverYoung,5)).

cantante(hatsuneMiku).
sabeCantar(hatsuneMiku, cancion(tellYourWorld,4)).

cantante(gumi).
sabeCantar(gumi, cancion(foreverYoung,4)).
sabeCantar(gumi, cancion(tellYourWorld,5)).


cantante(seeU).
sabeCantar(seeU, cancion(novemberRain,6)).
sabeCantar(seeU, cancion(nightFever,5)).

cantante(kaito).

% EJERCICIO 1

sabe2Canciones(Vocaloid):-
    cantante(Vocaloid),
    sabeCantar(Vocaloid,cancion(C1,_)),
    sabeCantar(Vocaloid,cancion(C2,_)),
    C1\=C2.

duracionTotCanciones(Vocaloid,DuracionTot):-
    cantante(Vocaloid),
    findall(Duracion, sabeCantar(Vocaloid,cancion(_,Duracion)), Duraciones),
    sumlist(Duraciones, DuracionTot).
    

esNovedoso(Vocaloid):-
    sabe2Canciones(Vocaloid),
    duracionTotCanciones(Vocaloid,DuracionTot),
    DuracionTot < 15.


% EJERCICIO 2

cantanteAcelerado(Vocaloid):-
    cantante(Vocaloid),
    not(((sabeCantar(Vocaloid, cancion(_,Duracion))), Duracion > 4)).



% EJERCICIO 2

concierto(mikuExpo,estadosUnidos,2000,gigante,requisitos(2,6)).

%requisito capaz

concierto(magicalMirai,japon,3000,gigante,requisitos(3,10)).
%requisito capaz

concierto(vocalektVisions,estadosUnidos,1000,mediano,requisitos(9)).
%requisito capaz

concierto(mikuFest,argentina,100,pequeno,requisitos(1,4)).
%requisito capaz

puedeParticipar(Vocaloid, concierto(Nombre,Pais,Fama,gigante,requisitos(CancionesMinimas,DuracionMinTotal))):-
    cantante(Vocaloid),
    concierto(Nombre,Pais,Fama,gigante,requisitos(CancionesMinimas,DuracionMinTotal)),
    findall(Duracion, sabeCantar(Vocaloid,cancion(_,Duracion)), Duraciones),
    length(Duraciones, CantidadCanciones),
    CantidadCanciones > CancionesMinimas,
    sumlist(Duraciones, DuracionTot),
    DuracionTot > DuracionMinTotal.
    
puedeParticipar(Vocaloid, concierto(Nombre,Pais,Fama,mediano,requisitos(DuracionMax))):-
    concierto(Nombre,Pais,Fama,mediano,requisitos(DuracionMax)),
    cantante(Vocaloid),
    findall(Duracion, sabeCantar(Vocaloid,cancion(_,Duracion)), Duraciones),
    sumlist(Duraciones, DuracionTot),
    DuracionTot < DuracionMax.


puedeParticipar(Vocaloid, concierto(Nombre,Pais,Fama,pequeno,requisitos(CancionMin,DuracionMin))):-
    concierto(Nombre,Pais,Fama,pequeno,requisitos(CancionMin,DuracionMin)),
    cantante(Vocaloid),
    sabeCantar(Vocaloid, cancion(_,Duracion)),
    Duracion > DuracionMin.


puedeParticipar(hatsuneMiku, concierto(Nombre,Pais,Fama,gigante,requisitos(CancionesMinimas,DuracionMinTotal))):-
    concierto(Nombre,Pais,Fama,gigante,requisitos(CancionesMinimas,DuracionMinTotal)).

puedeParticipar(hatsuneMiku, concierto(Nombre,Pais,Fama,mediano,requisitos(DuracionMax))):-
    concierto(Nombre,Pais,Fama,mediano,requisitos(DuracionMax)).

puedeParticipar(hatsuneMiku, concierto(Nombre,Pais,Fama,pequeno,requisitos(CancionMin,DuracionMin))):-
    concierto(Nombre,Pais,Fama,pequeno,requisitos(CancionMin,DuracionMin)).


% EJERCICIO 3

famaTotal(Vocaloid,CantidadDeFamaAcumulada):-
    cantante(Vocaloid),
    findall(Fama, concierto(_,_,Fama,_,requisitos(_,_)), FamaAcumulada),
    sumlist(FamaAcumulada,FamaTotal),
    findall(Cancion, sabeCantar(Vocaloid,Cancion), Canciones),
    length(Canciones, CantidadCanciones),
    CantidadDeFamaAcumulada is CantidadCanciones * FamaTotal.


vocaloidMasFamoso(Vocaloid):-
    cantante(Vocaloid),
    famaTotal(Vocaloid,CantidadDeFamaAcumulada),
    not((famaTotal(_,CantidadDeFamaAcumulada2), CantidadDeFamaAcumulada2>CantidadDeFamaAcumulada)).

% EJERCICIO 4

conoce(megurineLuka,hatsuneMiku).
conoce(megurineLuka,gumi).
conoce(gumi,seeU).
conoce(seeU,kaito).

unicoParticipante(Vocaloid,Concierto):-
    cantante(Vocaloid),
    puedeParticipar(Vocaloid,Concierto),
    not((conoce(Vocaloid,Vocaloid2), puedeParticipar(Vocaloid2,Concierto))).

seConocen(Vocaloid1, Vocaloid2):-
    cantante(Vocaloid1),
    cantante(Vocaloid2),
    conoce(Vocaloid1,Vocaloid2).

seConocen(Vocaloid1, Vocaloid2):-
    cantante(Vocaloid1),
    cantante(Vocaloid2),
    conoce(Vocaloid1,Vocaloid),
    seConocen(Vocaloid, Vocaloid2).
