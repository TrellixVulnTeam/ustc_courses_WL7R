#include "hashtable.h"
#include<iostream>
using namespace std;
hashtable::hashtable(int maxsize){
    sizeindex = maxsize;
    elem = new LHNodeptr[sizeindex];
    for(int i=0;i<sizeindex;i++) elem[i] = NULL;   //������д����elem = null
    countnum = 0;
}
int hashtable::searchword(string s, LHNodeptr &p){
		//���鵽��pָ��ý�㣻
		//���鲻����p�������һ����������
	p=elem[Hash(s)];                                                          // a function to complete
	LHNodeptr q=NULL;
	while(p && p->data.key!=s){q=p;p=p->next;}
						//q����p
	if(p ==NULL&&q == NULL) return Hash(s);     //��ʼʱ��û�ҵ�
	else if(p ==NULL) {p = q; return -1;}            //û�ҵ������ǲ��ǳ�ʼʱ��
	else if(p) return -2;                                   //�ҵ���
}

void hashtable::insertword(string s){
    LHNodeptr p;
    LHNodeptr q;
    q= new LHNode;
    q->data.key = s;q->data.num=0;
	if(searchword(s, p)!=-1)
		elem[searchword(s,p)] = q;
    else p->next=q;
    q->next=NULL;
    countnum++;
}

void hashtable::reset(){
    int  k;
    LHNodeptr p;
    for(k = 0;k<sizeindex;k++){
        if(elem[k]){
            p = elem[k];
            while(p){
                p->data.num=0;
                p = p->next;
            }
        }
    }
}

int Hash(string s){
    char c1,c2;
    c1 = s[1];
    c2 = s[s.length()];
    return (c1*100+c2)%41;
}




