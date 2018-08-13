class Solution {
public:
    /**
     * @param matrix : the martix
     * @return: the distance of grid to the police
     */
    vector<vector<int>> policeDistance(vector<vector<int>> &matrix ) {
        // Write your code here
        int n = matrix.size();
        if( n == 0 ) return vector<vector<int>>();
        int m = matrix[0].size();
        vector<vector<int>> ans(n, vector<int>(m,0));
        vector<vector<bool>> visited(n, vector<bool>(m, false));
        std::queue<pair<int,int>> queue;
        
        for(int i=0; i<n; i++)
            for(int j=0; j<m; j++)
            {
                if( matrix[i][j]==1 ) {
                    queue.push(make_pair(i*m+j, 0));
                    visited[i][j] = true;
                    ans[i][j] = 0;
                }
                else if( matrix[i][j] == -1 )
                {
                    visited[i][j] = true;
                    ans[i][j] = -1;
                }
            }
            
        while( !queue.empty() )
        {
            int q_size = queue.size();
            for( int i=0; i<q_size; i++ )
            {
                auto point = queue.front();
                queue.pop();
                for( int k = 0; k < 4; k++ )
                {
                    int qi = point.first/m + di[k];
                    int qj = point.first%m + dj[k];
                    if( check_valid(qi, qj, n, m) && !visited[qi][qj] )
                    {
                        visited[qi][qj] = true;
                        ans[qi][qj] = point.second+1;
                        queue.push(make_pair(qi*m+qj, ans[qi][qj]));
                    }
                }
            }
        }
        return ans;
    }
    bool check_valid(int _i, int _j, int n, int m)
    {
        return (_i>=0 && _i<n && _j>=0 && _j<m);
    }
    int di[4] = {1, -1, 0, 0};
    int dj[4] = {0, 0, 1, -1};
};
