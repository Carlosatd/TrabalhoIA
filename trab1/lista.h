#include<stdio.h>
#include<stdlib.h>

typedef struct lista{
    char info;
    struct lista *prox;
} Lista;

Lista* cria();
Lista* insere(Lista *l,char elem);
void imprime(Lista *l);
Lista* retira(Lista *l,char elem);
Lista* busca(Lista *l,char elem);
void libera(Lista *l);
int vazia(Lista *l);
