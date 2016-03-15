#include "grafo.h"

Grafo* inicializa(){
    return NULL;
}

Grafo* busca_no(Grafo *g, char id_grafo){
    Grafo *p=g;
    while(p&&p->id_grafo!=id_grafo){
        p=p->prox;
    }
    return p;
}

Grafo* ins_no(Grafo *g, char id_grafo){
    Grafo *novo=busca_no(g,id_grafo);
    if(novo)return g;
    novo=(Grafo*)malloc(sizeof(Grafo));
    novo->id_grafo=id_grafo;
    novo->prox_viz=NULL;
    novo->prox=g;
    return novo;
}

Vizinho* busca_viz(Grafo *g, char id_grafo, char id_vizinho){
    Grafo *p = busca_no(g,id_grafo);
    if(!p)return NULL;
    Vizinho *v=p->prox_viz;
    while(v&&v->id_vizinho!=id_vizinho){
        v=v->prox_viz;
    }
    return v;
}

void ins_viz(Grafo *g, char id_grafo, char id_vizinho){
    Grafo *p1 = busca_no(g,id_grafo);
    if(!p1)return;
    Grafo *p2 = busca_no(g,id_vizinho);
    if(!p2)return;
    Vizinho *no1to2=busca_viz(g,id_grafo,id_vizinho);
    if(no1to2)return;
    no1to2=(Vizinho*)malloc(sizeof(Vizinho));
    no1to2->id_vizinho=id_vizinho;
    no1to2->prox_viz=p1->prox_viz;
    p1->prox_viz=no1to2;
}

void imprime_grafo(Grafo *g){
    Grafo *p=g;
    while(p){
        if(p->id_grafo==' '){
                printf("b/: ");
            }else{
                printf("%c: ",p->id_grafo);
            }
        Vizinho *v=p->prox_viz;
        while(v){
            if(v->id_vizinho==' '){
                printf("b/ ");
            }else{
                printf("%c ",v->id_vizinho);
            }
            v=v->prox_viz;
        }
        printf("\n");
        p=p->prox;
    }
}
