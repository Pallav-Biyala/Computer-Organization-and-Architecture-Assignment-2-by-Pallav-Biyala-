#include <iostream>
using namespace std;

class quicksort{
private:
    void swap(int &a, int &b){
        int temp = a;
        a = b;
        b = temp;
    }

    int partition(vector<int>&arr, int low, int high){
        int pivot = arr[high]; // taking pivot as high element
        int i = low-1;

        for (int j = low; j< high; ++j){
            if (arr[j] <= pivot){
                i++;
                swap(arr[i],arr[j]);
            }
        }
        swap(arr[i+1], arr[high]);
        return i+1;
    }

    void quicksort(vector<int>&arr, int low, int high){
        if (low<high){
            int p = partition(arr,low,high); // p is at correct position now
            quicksort(arr, low, p-1); // sort left half
            quicksort(arr, p+1, high); // sort right half
        }
    } 

public:
      vector<int> sort(vector<int>&arr){
        int n = arr.size();
        quicksort(arr, 0, n-1);
      }
};

int main()
{
    
    return 0;
}