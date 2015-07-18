////
////  main.c
////  MyTestC
////
////  Created by 赵远 on 15/4/12.
////  Copyright (c) 2015年 赵远. All rights reserved.
////
//
//#include <stdio.h>
//
///*
// 将一个字符串分成X和Y两个部分，在每部分字符串上定义反转操作，如X^T，即把X的所有字符反转（如，X="abc"，那么X^T="cba"），那么就得到下面的结论：(X^TY^T)^T=YX，显然就解决了字符串的反转问题。
// 
// 例如，字符串 abcdef ，若要让def翻转到abc的前头，只要按照下述3个步骤操作即可：
// 
// 首先将原字符串分为两个部分，即X:abc，Y:def；
// 将X反转，X->X^T，即得：abc->cba；将Y反转，Y->Y^T，即得：def->fed。
// 反转上述步骤得到的结果字符串X^TY^T，即反转字符串cbafed的两部分（cba和fed）给予反转，cbafed得到defabc，形式化表示为(X^TY^T)^T=YX，这就实现了整个反转。
// */
//
//void ReverseString(char* s,int from,int to)
//{
//    while (from < to)
//    {
//        char t = s[from];
//        s[from++] = s[to];
//        s[to--] = t;
//    }
//}
//
//void LeftRotateString(char* s,int n,int m)
//{
////    m %= n;               //若要左移动大于n位，那么和%n 是等价的
//    ReverseString(s, 0, m - 1); //反转[0..m - 1]，套用到上面举的例子中，就是X->X^T，即 abc->cba
//    ReverseString(s, m, n - 1); //反转[m..n - 1]，例如Y->Y^T，即 def->fed
////    ReverseString(s, 0, n - 1); //反转[0..n - 1]，即如整个反转，(X^TY^T)^T=YX，即 cbafed->defabc。
//}
//
//int main(int argc, const char * argv[]) {
//    // insert code here...
//    char sting[] = "I am a student.";
//    printf("====:%s",sting);
//    LeftRotateString(sting, 15, 0);
//    printf("===%s",sting);
//    return 0;
//}
//

#include "stdio.h"
#include "stdlib.h"
//#include "io.h"
#include "math.h"
#include "time.h"

#define OK 1
#define ERROR 0
#define TRUE 1
#define FALSE 0

#define MAXSIZE 100 /* 存储空间初始分配量 */

#define SUCCESS 1
#define UNSUCCESS 0
#define HASHSIZE 12 /* 定义散列表长为数组的长度 */
#define NULLKEY -32768

typedef int Status;	/* Status是函数的类型,其值是函数结果状态代码，如OK等 */

typedef struct
{
    int *elem; /* 数据元素存储基址，动态分配数组 */
    int count; /*  当前数据元素个数 */
}HashTable;

int m=0; /* 散列表表长，全局变量 */

/* 初始化散列表 */
Status InitHashTable(HashTable *H)
{
    int i;
    m=HASHSIZE;
    H->count=m;
    H->elem=(int *)malloc(m*sizeof(int));
    for(i=0;i<m;i++)
        H->elem[i]=NULLKEY;
    return OK;
}

/* 散列函数 */
int Hash(int key)
{
    return key % m; /* 除留余数法 */
}

/* 插入关键字进散列表 */
void InsertHash(HashTable *H,int key)
{
    int addr = Hash(key); /* 求散列地址 */
    while (H->elem[addr] != NULLKEY) /* 如果不为空，则冲突 */
    {
        addr = (addr+1) % m; /* 开放定址法的线性探测 */
    }
    H->elem[addr] = key; /* 直到有空位后插入关键字 */
}

/* 散列表查找关键字 */
Status SearchHash(HashTable H,int key,int *addr)
{
    *addr = Hash(key);  /* 求散列地址 */
    while(H.elem[*addr] != key) /* 如果不为空，则冲突 */
    {
        *addr = (*addr+1) % m; /* 开放定址法的线性探测 */
        if (H.elem[*addr] == NULLKEY || *addr == Hash(key)) /* 如果循环回到原点 */
            return UNSUCCESS;	/* 则说明关键字不存在 */
    }
    return SUCCESS;
}

int main()
{
    int arr[HASHSIZE]={12,67,56,16,25,37,22,29,15,47,48,34};
    int i,p,key,result;
    HashTable H;
    
    key=39;
    
    InitHashTable(&H);
    for(i=0;i<m;i++)
        InsertHash(&H,arr[i]);
    
    result=SearchHash(H,key,&p);
    if (result)
        printf("查找 %d 的地址为：%d \n",key,p);
    else
        printf("查找 %d 失败。\n",key);
    
    for(i=0;i<m;i++)
    {
        key=arr[i];
        SearchHash(H,key,&p);
        printf("查找 %d 的地址为：%d \n",key,p);
    }
    
    return 0;
}

