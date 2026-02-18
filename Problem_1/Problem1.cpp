#include <iostream>
using namespace std;

vector<int> find(vector<int> &arr, int n){
    int max_idx = 0;
    int max = arr[0];
    int min_idx = 0;
    int min = arr[0];
    int sum = 0;

    for (int i = 0; i<n; ++i){
        // finding max
        if (arr[i]>max){
            max = arr[i];
            max_idx = i;
        }
        
        // finding min
        if (min>arr[i]){
            min = arr[i];
            min_idx = i;
        }

        // finding sum
        sum += arr[i];
    }

    vector <int> result = {max,max_idx,min,min_idx,sum / n};
    return result;
}

int main() {

}
