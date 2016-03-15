#include<stdio.h>
#include<stdlib.h>

typedef struct vizinho{
    char id_vizinho;
    struct vizinho *prox_viz;
} Vizinho;

typedef struct grafo{
    char id_grafo;
    Vizinho *prox_viz;
    struct grafo *prox;
} Grafo;

Grafo* inicializa();
Grafo* busca_no(Grafo *g, char id_grafo);
Grafo* ins_no(Grafo *g, char id_grafo);
Vizinho* busca_viz(Grafo *g, char id_grafo, char id_vizinho);
void ins_viz(Grafo *g, char id_grafo, char id_vizinho);
void imprime_grafo(Grafo *g);
