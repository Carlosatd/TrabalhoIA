#include "lista.h"

Lista* cria(){
    return NULL;
}

Lista* insere(Lista *l,char elem){
    Lista *novo;
    novo = (Lista*)malloc(sizeof(Lista));
    novo->info=elem;
    novo->prox=l;
    return novo;
}
void imprime(Lista *l){
    Lista *p;
    for(p=l;p;p=p->prox){
        printf("%c ",p->info);
    }
}

Lista* retira(Lista *l,char elem){
    Lista *p,*ant;
    ant=NULL;
    for(p=l;p&&p->info!=elem;p=p->prox){
        ant=p;
    }

    if(!p){
        return l;
    }
    if(!ant){
        l=p->prox;
    }else{
        ant->prox=p->prox;
    }
    free(p);
    return l;
}

Lista* busca(Lista *l,char elem){
    Lista *p;
    p=l;
    while(p&&p->info!=elem){
        p=p->prox;
    }
    if(!p){
        return NULL;
    }
    return p;
}

void libera(Lista *l){
    Lista *p = l, *q;
    while(p){
        q = p;
        p = p->prox;
        free(q);
    }
}

int vazia(Lista *l){
    return(l==NULL);
}
