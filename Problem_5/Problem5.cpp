#include <iostream>
using namespace std;

vector<vector<int>> matrix_multiplication(vector<vector<int>> &A, vector<vector<int>> &B, int n){
    vector<vector<int>> result (n, vector<int> (n,0));

    for (int i = 0; i<n;++i){
        for (int j = 0; j<n;++j){
            for (int k = 0; k<n; ++k){
                result[i][j] += A[i][k]*B[k][j];
            }
        }
    }

    return result;
}

int main()
{
    
    return 0;
}