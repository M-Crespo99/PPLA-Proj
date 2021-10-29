#include <iostream>


int main(){
	std::cout << "Before" << std::endl;
	
	system("./downward/fast-downward.py");
	
	std::cout << "after" << std::endl;
	return 0;
	
}
