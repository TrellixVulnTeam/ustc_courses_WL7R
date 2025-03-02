// WordsFrequencyStatistics.cpp: 定义控制台应用程序的入口点。
//



#include <iostream>
#include <string>
#include <vector>
#include "functions.h"
#include <time.h>
using namespace std;


int main(int argc, char* argv[])
{
	time_t start, end;
	double cost;
	time(&start);
	if (argc != 2) {
		cout << "wrong paremeter, please input the folder's full path";
		return 1;
	}
	string homepath = argv[1];
	vector<string> files;
	char* buffer = NULL;
	long size = 0;
	//get all the files names, and put them into vector<string> files
	getallfiles(homepath, files);
	for (int i = 0; i < files.size(); i++)
	{
		//transfer the content to the RAM at one time, and get the head pointer buffer
		getcontent(files[i], buffer, size);//buffer apply memory in this function
		/*
		all above have been tested
		*/
		statistics(buffer, size);//TODO:free the memory of buffer in this function
		//TODO
	}
	outputresult();
	time(&end);
	cost = difftime(end, start);
	cout << "totally cost: " << cost << "s" << endl;
  	return 0;
}

