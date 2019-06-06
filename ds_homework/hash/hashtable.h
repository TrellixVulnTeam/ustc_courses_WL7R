#ifndef HASHTABLE_H_INCLUDED
#define HASHTABLE_H_INCLUDED
#include<string>
using namespace std;
typedef struct{
    string key;
    int num;
}Elemtype;

typedef struct LHNode{
	Elemtype	data;
	struct LHNode		*next;		//��¼��
}LHNode,*LHNodeptr;



class hashtable
{
public:
    hashtable(int maxsize = 43);
    int searchword(string s, LHNodeptr &p);   //�ڱ����ҵ��ʣ�����λ��ָ��p
    void insertword(string s);//�ڱ��в����µĴ�
    void reset();  //���ñ��йؼ��ʵĴ�����
    LHNodeptr	*elem;
	int		countnum;		//��¼��
	int		sizeindex;  //��ϣ������
};

int Hash(string s);



#endif // HASHTABLE_H_INCLUDED
