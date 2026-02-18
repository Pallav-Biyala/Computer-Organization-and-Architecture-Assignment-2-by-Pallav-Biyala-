#include <iostream>
using namespace std;

vector<vector<int>> sum_matrix(vector<vector<int>> &A, vector<vector<int>>&B){
    int n = A.size();
    vector<vector<int>> sum(n, vector<int> (n,0));

    for (int i = 0; i<n; ++i){
        for (int j = 0; j<n;++j){
            sum[i][j] = A[i][j]+B[i][j];
        }
    }
    return sum;
}

int main()
{
    
    return 0;
}