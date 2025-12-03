// dsa_practice_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class DSAPracticePage extends StatefulWidget {
  const DSAPracticePage({super.key});

  @override
  State<DSAPracticePage> createState() => _DSAPracticePageState();
}

class _DSAPracticePageState extends State<DSAPracticePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'DSA Practice - 35 Problems',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade700.withOpacity(0.8),
                    Colors.indigo.shade600.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Arrays & Strings'),
            Tab(text: 'Linked Lists'),
            Tab(text: 'Trees & BST'),
            Tab(text: 'Graphs'),
            Tab(text: 'DP & Greedy'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.indigo.shade50,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 140),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search problems...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProblemList(_getArrayProblems()),
                  _buildProblemList(_getLinkedListProblems()),
                  _buildProblemList(_getTreeProblems()),
                  _buildProblemList(_getGraphProblems()),
                  _buildProblemList(_getDPProblems()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProblemList(List<DSAProblem> problems) {
    final filteredProblems = problems
        .where((p) =>
    p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        p.problem.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    if (filteredProblems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No problems found',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredProblems.length,
      itemBuilder: (context, index) {
        return ProblemCard(problem: filteredProblems[index]);
      },
    );
  }

  // Arrays & Strings Problems (Q1-Q7)
  List<DSAProblem> _getArrayProblems() {
    return [
      DSAProblem(
        title: 'Q1: Two Sum',
        problem: 'Given an array and a target, return indices of two elements whose sum equals the target.',
        solution: '''#include <vector>
#include <unordered_map>
using namespace std;

vector<int> twoSum(vector<int>& nums, int target) {
    unordered_map<int, int> seen;
    for (int i = 0; i < nums.size(); i++) {
        int complement = target - nums[i];
        if (seen.find(complement) != seen.end()) {
            return {seen[complement], i};
        }
        seen[nums[i]] = i;
    }
    return {}; // No solution found
}''',
        complexity: 'Time: O(n), Space: O(n)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q2: Maximum Subarray (Kadane\'s Algorithm)',
        problem: 'Find the maximum possible subarray sum.',
        solution: '''#include <vector>
#include <algorithm>
using namespace std;

int maxSubArray(vector<int>& nums) {
    int maxSum = nums[0];
    int currentSum = nums[0];
    
    for (int i = 1; i < nums.size(); i++) {
        currentSum = max(nums[i], currentSum + nums[i]);
        maxSum = max(maxSum, currentSum);
    }
    return maxSum;
}''',
        complexity: 'Time: O(n), Space: O(1)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q3: Best Time to Buy and Sell Stock',
        problem: 'Compute max profit from one buy and one sell (sell after buy).',
        solution: '''#include <vector>
#include <algorithm>
using namespace std;

int maxProfit(vector<int>& prices) {
    int minPrice = prices[0];
    int maxProfit = 0;
    
    for (int i = 1; i < prices.size(); i++) {
        maxProfit = max(maxProfit, prices[i] - minPrice);
        minPrice = min(minPrice, prices[i]);
    }
    return maxProfit;
}''',
        complexity: 'Time: O(n), Space: O(1)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q4: Product of Array Except Self',
        problem: 'Return array where each position is product of all other elements (no division).',
        solution: '''#include <vector>
using namespace std;

vector<int> productExceptSelf(vector<int>& nums) {
    int n = nums.size();
    vector<int> result(n, 1);
    
    // Left pass
    int leftProduct = 1;
    for (int i = 0; i < n; i++) {
        result[i] = leftProduct;
        leftProduct *= nums[i];
    }
    
    // Right pass
    int rightProduct = 1;
    for (int i = n - 1; i >= 0; i--) {
        result[i] *= rightProduct;
        rightProduct *= nums[i];
    }
    
    return result;
}''',
        complexity: 'Time: O(n), Space: O(1) excluding output',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q5: Longest Substring Without Repeating Characters',
        problem: 'Find length of longest substring with all distinct characters.',
        solution: '''#include <string>
#include <unordered_map>
#include <algorithm>
using namespace std;

int lengthOfLongestSubstring(string s) {
    unordered_map<char, int> lastIndex;
    int maxLen = 0;
    int left = 0;
    
    for (int right = 0; right < s.length(); right++) {
        if (lastIndex.find(s[right]) != lastIndex.end()) {
            left = max(left, lastIndex[s[right]] + 1);
        }
        lastIndex[s[right]] = right;
        maxLen = max(maxLen, right - left + 1);
    }
    return maxLen;
}''',
        complexity: 'Time: O(n), Space: O(min(n, alphabet size))',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q6: Subarray Sum Equals K',
        problem: 'Count subarrays whose sum equals k.',
        solution: '''#include <vector>
#include <unordered_map>
using namespace std;

int subarraySum(vector<int>& nums, int k) {
    unordered_map<int, int> prefixCount;
    prefixCount[0] = 1;
    int count = 0;
    int prefixSum = 0;
    
    for (int num : nums) {
        prefixSum += num;
        if (prefixCount.find(prefixSum - k) != prefixCount.end()) {
            count += prefixCount[prefixSum - k];
        }
        prefixCount[prefixSum]++;
    }
    return count;
}''',
        complexity: 'Time: O(n), Space: O(n)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q7: Group Anagrams',
        problem: 'Group strings into lists of anagrams.',
        solution: '''#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
using namespace std;

vector<vector<string>> groupAnagrams(vector<string>& strs) {
    unordered_map<string, vector<string>> groups;
    
    for (string& s : strs) {
        string key = s;
        sort(key.begin(), key.end());
        groups[key].push_back(s);
    }
    
    vector<vector<string>> result;
    for (auto& [key, group] : groups) {
        result.push_back(group);
    }
    return result;
}''',
        complexity: 'Time: O(n * m log m), Space: O(n * m)',
        difficulty: 'Medium',
      ),
    ];
  }

  // Linked Lists Problems (Q8-Q14)
  List<DSAProblem> _getLinkedListProblems() {
    return [
      DSAProblem(
        title: 'Q8: Reverse a Singly Linked List',
        problem: 'Reverse a singly linked list.',
        solution: '''struct ListNode {
    int val;
    ListNode* next;
    ListNode(int x) : val(x), next(nullptr) {}
};

ListNode* reverseList(ListNode* head) {
    ListNode* prev = nullptr;
    ListNode* curr = head;
    
    while (curr != nullptr) {
        ListNode* next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }
    return prev;
}''',
        complexity: 'Time: O(n), Space: O(1)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q9: Detect Cycle in Linked List',
        problem: 'Determine if a linked list has a cycle.',
        solution: '''bool hasCycle(ListNode* head) {
    if (!head || !head->next) return false;
    
    ListNode* slow = head;
    ListNode* fast = head;
    
    while (fast && fast->next) {
        slow = slow->next;
        fast = fast->next->next;
        if (slow == fast) return true;
    }
    return false;
}''',
        complexity: 'Time: O(n), Space: O(1)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q10: Merge Two Sorted Linked Lists',
        problem: 'Merge two sorted linked lists into one sorted list.',
        solution: '''ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
    ListNode dummy(0);
    ListNode* tail = &dummy;
    
    while (l1 && l2) {
        if (l1->val <= l2->val) {
            tail->next = l1;
            l1 = l1->next;
        } else {
            tail->next = l2;
            l2 = l2->next;
        }
        tail = tail->next;
    }
    
    tail->next = l1 ? l1 : l2;
    return dummy.next;
}''',
        complexity: 'Time: O(n + m), Space: O(1)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q11: Remove Nth Node From End',
        problem: 'Remove the nth node from end in one pass.',
        solution: '''ListNode* removeNthFromEnd(ListNode* head, int n) {
    ListNode dummy(0);
    dummy.next = head;
    ListNode* fast = &dummy;
    ListNode* slow = &dummy;
    
    // Move fast n+1 steps ahead
    for (int i = 0; i <= n; i++) {
        fast = fast->next;
    }
    
    // Move both until fast reaches end
    while (fast) {
        fast = fast->next;
        slow = slow->next;
    }
    
    // Remove nth node
    slow->next = slow->next->next;
    return dummy.next;
}''',
        complexity: 'Time: O(n), Space: O(1)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q12: Add Two Numbers (as Linked Lists)',
        problem: 'Add two numbers stored in reversed linked lists.',
        solution: '''ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    ListNode dummy(0);
    ListNode* curr = &dummy;
    int carry = 0;
    
    while (l1 || l2 || carry) {
        int sum = carry;
        if (l1) {
            sum += l1->val;
            l1 = l1->next;
        }
        if (l2) {
            sum += l2->val;
            l2 = l2->next;
        }
        
        carry = sum / 10;
        curr->next = new ListNode(sum % 10);
        curr = curr->next;
    }
    
    return dummy.next;
}''',
        complexity: 'Time: O(max(m, n)), Space: O(max(m, n))',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q13: Stack Implementation',
        problem: 'Implement stack with push, pop, top, isEmpty.',
        solution: '''#include <vector>
using namespace std;

class Stack {
private:
    vector<int> data;
    
public:
    void push(int x) {
        data.push_back(x);
    }
    
    void pop() {
        if (!data.empty()) {
            data.pop_back();
        }
    }
    
    int top() {
        return data.back();
    }
    
    bool isEmpty() {
        return data.empty();
    }
};''',
        complexity: 'Time: O(1) per operation',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q14: Queue Using Two Stacks',
        problem: 'Implement FIFO queue using two stacks.',
        solution: '''#include <stack>
using namespace std;

class MyQueue {
private:
    stack<int> inStack;
    stack<int> outStack;
    
    void transfer() {
        if (outStack.empty()) {
            while (!inStack.empty()) {
                outStack.push(inStack.top());
                inStack.pop();
            }
        }
    }
    
public:
    void push(int x) {
        inStack.push(x);
    }
    
    int pop() {
        transfer();
        int val = outStack.top();
        outStack.pop();
        return val;
    }
    
    int peek() {
        transfer();
        return outStack.top();
    }
    
    bool empty() {
        return inStack.empty() && outStack.empty();
    }
};''',
        complexity: 'Time: O(1) amortized per operation',
        difficulty: 'Medium',
      ),
    ];
  }

  // Trees & BST Problems (Q15-Q21)
  List<DSAProblem> _getTreeProblems() {
    return [
      DSAProblem(
        title: 'Q15: Binary Tree Traversals',
        problem: 'Implement preorder, inorder, and postorder traversals.',
        solution: '''struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

// Inorder: Left -> Root -> Right
void inorder(TreeNode* root, vector<int>& result) {
    if (!root) return;
    inorder(root->left, result);
    result.push_back(root->val);
    inorder(root->right, result);
}

// Preorder: Root -> Left -> Right
void preorder(TreeNode* root, vector<int>& result) {
    if (!root) return;
    result.push_back(root->val);
    preorder(root->left, result);
    preorder(root->right, result);
}

// Postorder: Left -> Right -> Root
void postorder(TreeNode* root, vector<int>& result) {
    if (!root) return;
    postorder(root->left, result);
    postorder(root->right, result);
    result.push_back(root->val);
}''',
        complexity: 'Time: O(n) each, Space: O(h)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q16: Maximum Depth of Binary Tree',
        problem: 'Compute the maximum depth (height).',
        solution: '''int maxDepth(TreeNode* root) {
    if (!root) return 0;
    return 1 + max(maxDepth(root->left), maxDepth(root->right));
}''',
        complexity: 'Time: O(n), Space: O(h)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q17: Check if Tree is Height-Balanced',
        problem: 'Check if tree is balanced (height difference ≤ 1 for all nodes).',
        solution: '''int checkHeight(TreeNode* root, bool& balanced) {
    if (!root) return 0;
    
    int leftHeight = checkHeight(root->left, balanced);
    int rightHeight = checkHeight(root->right, balanced);
    
    if (abs(leftHeight - rightHeight) > 1) {
        balanced = false;
    }
    
    return 1 + max(leftHeight, rightHeight);
}

bool isBalanced(TreeNode* root) {
    bool balanced = true;
    checkHeight(root, balanced);
    return balanced;
}''',
        complexity: 'Time: O(n), Space: O(h)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q18: Validate Binary Search Tree',
        problem: 'Check if tree is a valid BST.',
        solution: '''bool isValidBST(TreeNode* root, long minVal = LONG_MIN, long maxVal = LONG_MAX) {
    if (!root) return true;
    
    if (root->val <= minVal || root->val >= maxVal) {
        return false;
    }
    
    return isValidBST(root->left, minVal, root->val) &&
           isValidBST(root->right, root->val, maxVal);
}''',
        complexity: 'Time: O(n), Space: O(h)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q19: Lowest Common Ancestor in BST',
        problem: 'Find LCA of two nodes in a BST.',
        solution: '''TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
    if (!root) return nullptr;
    
    // Both nodes in left subtree
    if (p->val < root->val && q->val < root->val) {
        return lowestCommonAncestor(root->left, p, q);
    }
    
    // Both nodes in right subtree
    if (p->val > root->val && q->val > root->val) {
        return lowestCommonAncestor(root->right, p, q);
    }
    
    // Split point is the LCA
    return root;
}''',
        complexity: 'Time: O(h), Space: O(h)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q20: Level Order Traversal (BFS)',
        problem: 'Return nodes level by level.',
        solution: '''#include <queue>
#include <vector>
using namespace std;

vector<vector<int>> levelOrder(TreeNode* root) {
    vector<vector<int>> result;
    if (!root) return result;
    
    queue<TreeNode*> q;
    q.push(root);
    
    while (!q.empty()) {
        int levelSize = q.size();
        vector<int> currentLevel;
        
        for (int i = 0; i < levelSize; i++) {
            TreeNode* node = q.front();
            q.pop();
            currentLevel.push_back(node->val);
            
            if (node->left) q.push(node->left);
            if (node->right) q.push(node->right);
        }
        result.push_back(currentLevel);
    }
    return result;
}''',
        complexity: 'Time: O(n), Space: O(n)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q21: Diameter of Binary Tree',
        problem: 'Find longest path between any two nodes.',
        solution: '''int diameterHelper(TreeNode* root, int& diameter) {
    if (!root) return 0;
    
    int leftHeight = diameterHelper(root->left, diameter);
    int rightHeight = diameterHelper(root->right, diameter);
    
    diameter = max(diameter, leftHeight + rightHeight);
    return 1 + max(leftHeight, rightHeight);
}

int diameterOfBinaryTree(TreeNode* root) {
    int diameter = 0;
    diameterHelper(root, diameter);
    return diameter;
}''',
        complexity: 'Time: O(n), Space: O(h)',
        difficulty: 'Easy',
      ),
    ];
  }

  // Graph Problems (Q22-Q28)
  List<DSAProblem> _getGraphProblems() {
    return [
      DSAProblem(
        title: 'Q22: BFS Traversal',
        problem: 'Print BFS order from a source node.',
        solution: '''#include <vector>
#include <queue>
#include <unordered_set>
using namespace std;

void bfs(int start, vector<vector<int>>& graph) {
    unordered_set<int> visited;
    queue<int> q;
    
    q.push(start);
    visited.insert(start);
    
    while (!q.empty()) {
        int node = q.front();
        q.pop();
        cout << node << " ";
        
        for (int neighbor : graph[node]) {
            if (visited.find(neighbor) == visited.end()) {
                visited.insert(neighbor);
                q.push(neighbor);
            }
        }
    }
}''',
        complexity: 'Time: O(V + E), Space: O(V)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q23: Count Connected Components',
        problem: 'Count connected components in undirected graph.',
        solution: '''void dfs(int node, vector<vector<int>>& graph, vector<bool>& visited) {
    visited[node] = true;
    for (int neighbor : graph[node]) {
        if (!visited[neighbor]) {
            dfs(neighbor, graph, visited);
        }
    }
}

int countComponents(int n, vector<vector<int>>& graph) {
    vector<bool> visited(n, false);
    int count = 0;
    
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i, graph, visited);
            count++;
        }
    }
    return count;
}''',
        complexity: 'Time: O(V + E), Space: O(V)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q24: Number of Islands',
        problem: 'Count islands in a 2D grid (4-directional).',
        solution: '''void dfs(vector<vector<char>>& grid, int i, int j) {
    if (i < 0 || i >= grid.size() || j < 0 || j >= grid[0].size() || 
        grid[i][j] == '0') {
        return;
    }
    
    grid[i][j] = '0'; // Mark as visited
    
    dfs(grid, i + 1, j);
    dfs(grid, i - 1, j);
    dfs(grid, i, j + 1);
    dfs(grid, i, j - 1);
}

int numIslands(vector<vector<char>>& grid) {
    if (grid.empty()) return 0;
    
    int count = 0;
    for (int i = 0; i < grid.size(); i++) {
        for (int j = 0; j < grid[0].size(); j++) {
            if (grid[i][j] == '1') {
                count++;
                dfs(grid, i, j);
            }
        }
    }
    return count;
}''',
        complexity: 'Time: O(R × C), Space: O(R × C)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q25: Cycle Detection in Directed Graph',
        problem: 'Detect if directed graph has a cycle.',
        solution: '''bool hasCycleDFS(int node, vector<vector<int>>& graph, 
                 vector<int>& state) {
    // state: 0 = unvisited, 1 = visiting, 2 = visited
    state[node] = 1;
    
    for (int neighbor : graph[node]) {
        if (state[neighbor] == 1) return true; // Back edge
        if (state[neighbor] == 0 && hasCycleDFS(neighbor, graph, state)) {
            return true;
        }
    }
    
    state[node] = 2;
    return false;
}

bool hasCycle(int n, vector<vector<int>>& graph) {
    vector<int> state(n, 0);
    
    for (int i = 0; i < n; i++) {
        if (state[i] == 0) {
            if (hasCycleDFS(i, graph, state)) return true;
        }
    }
    return false;
}''',
        complexity: 'Time: O(V + E), Space: O(V)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q26: Topological Sort',
        problem: 'Output topological ordering of a DAG.',
        solution: '''#include <stack>
using namespace std;

void topSortDFS(int node, vector<vector<int>>& graph, 
                vector<bool>& visited, stack<int>& result) {
    visited[node] = true;
    
    for (int neighbor : graph[node]) {
        if (!visited[neighbor]) {
            topSortDFS(neighbor, graph, visited, result);
        }
    }
    
    result.push(node);
}

vector<int> topologicalSort(int n, vector<vector<int>>& graph) {
    vector<bool> visited(n, false);
    stack<int> result;
    
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            topSortDFS(i, graph, visited, result);
        }
    }
    
    vector<int> order;
    while (!result.empty()) {
        order.push_back(result.top());
        result.pop();
    }
    return order;
}''',
        complexity: 'Time: O(V + E), Space: O(V)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q27: Shortest Path in Unweighted Graph',
        problem: 'Find shortest path length using BFS.',
        solution: '''vector<int> shortestPath(int n, vector<vector<int>>& graph, int start) {
    vector<int> dist(n, -1);
    queue<int> q;
    
    dist[start] = 0;
    q.push(start);
    
    while (!q.empty()) {
        int node = q.front();
        q.pop();
        
        for (int neighbor : graph[node]) {
            if (dist[neighbor] == -1) {
                dist[neighbor] = dist[node] + 1;
                q.push(neighbor);
            }
        }
    }
    return dist;
}''',
        complexity: 'Time: O(V + E), Space: O(V)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q28: Dijkstra\'s Algorithm',
        problem: 'Shortest path in weighted graph with non-negative weights.',
        solution: '''#include <queue>
#include <vector>
#include <climits>
using namespace std;

vector<int> dijkstra(int n, vector<vector<pair<int, int>>>& graph, int start) {
    vector<int> dist(n, INT_MAX);
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
    
    dist[start] = 0;
    pq.push({0, start}); // {distance, node}
    
    while (!pq.empty()) {
        auto [d, u] = pq.top();
        pq.pop();
        
        if (d > dist[u]) continue;
        
        for (auto [v, weight] : graph[u]) {
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pq.push({dist[v], v});
            }
        }
    }
    return dist;
}''',
        complexity: 'Time: O((V + E) log V), Space: O(V)',
        difficulty: 'Hard',
      ),
    ];
  }

  // DP & Greedy Problems (Q29-Q35)
  List<DSAProblem> _getDPProblems() {
    return [
      DSAProblem(
        title: 'Q29: Binary Search',
        problem: 'Find target in sorted array.',
        solution: '''int binarySearch(vector<int>& nums, int target) {
    int left = 0, right = nums.size() - 1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        
        if (nums[mid] == target) return mid;
        else if (nums[mid] < target) left = mid + 1;
        else right = mid - 1;
    }
    return -1;
}''',
        complexity: 'Time: O(log n), Space: O(1)',
        difficulty: 'Easy',
      ),
      DSAProblem(
        title: 'Q30: First and Last Occurrence',
        problem: 'Find first and last positions of target in sorted array.',
        solution: '''int findFirst(vector<int>& nums, int target) {
    int left = 0, right = nums.size() - 1;
    int result = -1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] == target) {
            result = mid;
            right = mid - 1; // Continue searching left
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
}

int findLast(vector<int>& nums, int target) {
    int left = 0, right = nums.size() - 1;
    int result = -1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] == target) {
            result = mid;
            left = mid + 1; // Continue searching right
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
}

vector<int> searchRange(vector<int>& nums, int target) {
    return {findFirst(nums, target), findLast(nums, target)};
}''',
        complexity: 'Time: O(log n), Space: O(1)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q31: 0/1 Knapsack',
        problem: 'Maximize value with capacity constraint.',
        solution: '''// Space-optimized version
int knapsackOptimized(vector<int>& weights, vector<int>& values, int W) {
    vector<int> dp(W + 1, 0);
    
    for (int i = 0; i < weights.size(); i++) {
        for (int w = W; w >= weights[i]; w--) {
            dp[w] = max(dp[w], values[i] + dp[w - weights[i]]);
        }
    }
    return dp[W];
}''',
        complexity: 'Time: O(nW), Space: O(W)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q32: Coin Change (Minimum Coins)',
        problem: 'Find minimum coins to make amount.',
        solution: '''int coinChange(vector<int>& coins, int amount) {
    vector<int> dp(amount + 1, INT_MAX);
    dp[0] = 0;
    
    for (int i = 1; i <= amount; i++) {
        for (int coin : coins) {
            if (coin <= i && dp[i - coin] != INT_MAX) {
                dp[i] = min(dp[i], dp[i - coin] + 1);
            }
        }
    }
    
    return dp[amount] == INT_MAX ? -1 : dp[amount];
}''',
        complexity: 'Time: O(n × amount), Space: O(amount)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q33: Longest Increasing Subsequence',
        problem: 'Find length of LIS.',
        solution: '''// O(n log n) Binary Search solution
int lengthOfLIS(vector<int>& nums) {
    vector<int> tails;
    
    for (int num : nums) {
        auto it = lower_bound(tails.begin(), tails.end(), num);
        if (it == tails.end()) {
            tails.push_back(num);
        } else {
            *it = num;
        }
    }
    return tails.size();
}''',
        complexity: 'Time: O(n log n), Space: O(n)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q34: Activity Selection / Interval Scheduling',
        problem: 'Select maximum non-overlapping intervals.',
        solution: '''struct Interval {
    int start, end;
};

bool compare(Interval a, Interval b) {
    return a.end < b.end;
}

int activitySelection(vector<Interval>& intervals) {
    if (intervals.empty()) return 0;
    
    sort(intervals.begin(), intervals.end(), compare);
    
    int count = 1;
    int lastEnd = intervals[0].end;
    
    for (int i = 1; i < intervals.size(); i++) {
        if (intervals[i].start >= lastEnd) {
            count++;
            lastEnd = intervals[i].end;
        }
    }
    return count;
}''',
        complexity: 'Time: O(n log n), Space: O(1)',
        difficulty: 'Medium',
      ),
      DSAProblem(
        title: 'Q35: N-Queens',
        problem: 'Place N queens on N×N board so none attack each other.',
        solution: '''class NQueens {
private:
    vector<vector<string>> solutions;
    
    bool isSafe(vector<string>& board, int row, int col, int n) {
        // Check column
        for (int i = 0; i < row; i++) {
            if (board[i][col] == 'Q') return false;
        }
        
        // Check upper-left diagonal
        for (int i = row - 1, j = col - 1; i >= 0 && j >= 0; i--, j--) {
            if (board[i][j] == 'Q') return false;
        }
        
        // Check upper-right diagonal
        for (int i = row - 1, j = col + 1; i >= 0 && j < n; i--, j++) {
            if (board[i][j] == 'Q') return false;
        }
        
        return true;
    }
    
    void solve(vector<string>& board, int row, int n) {
        if (row == n) {
            solutions.push_back(board);
            return;
        }
        
        for (int col = 0; col < n; col++) {
            if (isSafe(board, row, col, n)) {
                board[row][col] = 'Q';
                solve(board, row + 1, n);
                board[row][col] = '.'; // Backtrack
            }
        }
    }
    
public:
    vector<vector<string>> solveNQueens(int n) {
        vector<string> board(n, string(n, '.'));
        solve(board, 0, n);
        return solutions;
    }
};''',
        complexity: 'Time: O(N!), Space: O(N²)',
        difficulty: 'Hard',
      ),
    ];
  }
}

// Problem Card Widget
class ProblemCard extends StatefulWidget {
  final DSAProblem problem;

  const ProblemCard({super.key, required this.problem});

  @override
  State<ProblemCard> createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getDifficultyColor() {
    switch (widget.problem.difficulty) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor().withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.problem.difficulty,
                          style: TextStyle(
                            color: _getDifficultyColor(),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      RotationTransition(
                        turns: _rotationAnimation,
                        child: Icon(
                          Icons.expand_more,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.problem.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.problem.problem,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined,
                          size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        widget.problem.complexity,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Solution',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, color: Colors.white70),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: widget.problem.solution));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Code copied to clipboard!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        tooltip: 'Copy code',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.problem.solution,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 13,
                        fontFamily: 'Courier',
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Data Model
class DSAProblem {
  final String title;
  final String problem;
  final String solution;
  final String complexity;
  final String difficulty;

  DSAProblem({
    required this.title,
    required this.problem,
    required this.solution,
    required this.complexity,
    required this.difficulty,
  });
}
