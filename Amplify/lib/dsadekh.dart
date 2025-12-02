import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

class DSAVisualizationsPage extends StatefulWidget {
  const DSAVisualizationsPage({super.key});

  @override
  State<DSAVisualizationsPage> createState() => _DSAVisualizationsPageState();
}

class _DSAVisualizationsPageState extends State<DSAVisualizationsPage> with TickerProviderStateMixin {
  late AnimationController _sortController;
  late AnimationController _treeController;
  late AnimationController _graphController;

  int selectedTab = 0;

  final List<Map<String, dynamic>> tabs = [
    {'title': 'Sorting', 'icon': Icons.sort},
    {'title': 'Binary Tree', 'icon': Icons.account_tree},
    {'title': 'Graph BFS/DFS', 'icon': Icons.hub},
    {'title': 'Stack & Queue', 'icon': Icons.view_agenda},
    {'title': 'Linked List', 'icon': Icons.link},
  ];

  @override
  void initState() {
    super.initState();
    _sortController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    _treeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _graphController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));
  }

  @override
  void dispose() {
    _sortController.dispose();
    _treeController.dispose();
    _graphController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('DSA Visualizations', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple.shade700,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            height: 60,
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() => selectedTab = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: selectedTab == index ? Colors.deepPurple.shade600 : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.shade200,
                          blurRadius: selectedTab == index ? 12 : 4,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(tabs[index]['icon'] as IconData,
                            color: selectedTab == index ? Colors.white : Colors.deepPurple.shade700,
                            size: 20),
                        const SizedBox(width: 8),
                        Text(tabs[index]['title'] as String,
                            style: TextStyle(
                              color: selectedTab == index ? Colors.white : Colors.deepPurple.shade700,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: [
                _SortingVisualizationTab(controller: _sortController),
                _BinaryTreeTab(controller: _treeController),
                _GraphTraversalTab(controller: _graphController),
                const _StackQueueTab(),
                const _LinkedListTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 1. SORTING ALGORITHMS VISUALIZATION
class _SortingVisualizationTab extends StatefulWidget {
  final AnimationController controller;

  const _SortingVisualizationTab({required this.controller});

  @override
  State<_SortingVisualizationTab> createState() => _SortingVisualizationTabState();
}

class _SortingVisualizationTabState extends State<_SortingVisualizationTab> {
  List<int> dataArray = [64, 34, 25, 12, 22, 11, 90, 88, 45, 50];
  String selectedAlgorithm = 'Bubble Sort';
  int currentIndex = -1;
  int compareIndex = -1;
  bool isSorting = false;

  final List<String> algorithms = ['Bubble Sort', 'Selection Sort', 'Insertion Sort', 'Quick Sort'];

  void _resetArray() {
    setState(() {
      dataArray = [64, 34, 25, 12, 22, 11, 90, 88, 45, 50];
      currentIndex = -1;
      compareIndex = -1;
      isSorting = false;
    });
  }

  void _randomizeArray() {
    final random = math.Random();
    setState(() {
      dataArray = List.generate(10, (_) => random.nextInt(100) + 10);
      currentIndex = -1;
      compareIndex = -1;
    });
  }

  Future<void> _startSorting() async {
    if (isSorting) return;
    setState(() => isSorting = true);

    switch (selectedAlgorithm) {
      case 'Bubble Sort':
        await _bubbleSort();
        break;
      case 'Selection Sort':
        await _selectionSort();
        break;
      case 'Insertion Sort':
        await _insertionSort();
        break;
      case 'Quick Sort':
        await _quickSort(0, dataArray.length - 1);
        break;
    }

    setState(() {
      isSorting = false;
      currentIndex = -1;
      compareIndex = -1;
    });
  }

  Future<void> _bubbleSort() async {
    for (int i = 0; i < dataArray.length - 1; i++) {
      for (int j = 0; j < dataArray.length - i - 1; j++) {
        setState(() {
          currentIndex = j;
          compareIndex = j + 1;
        });
        await Future.delayed(const Duration(milliseconds: 1000));

        if (dataArray[j] > dataArray[j + 1]) {
          setState(() {
            final temp = dataArray[j];
            dataArray[j] = dataArray[j + 1];
            dataArray[j + 1] = temp;
          });
          await Future.delayed(const Duration(milliseconds: 1000));
        }
      }
    }
  }

  Future<void> _selectionSort() async {
    for (int i = 0; i < dataArray.length - 1; i++) {
      int minIdx = i;
      for (int j = i + 1; j < dataArray.length; j++) {
        setState(() {
          currentIndex = i;
          compareIndex = j;
        });
        await Future.delayed(const Duration(milliseconds: 1000));

        if (dataArray[j] < dataArray[minIdx]) {
          minIdx = j;
        }
      }

      if (minIdx != i) {
        setState(() {
          final temp = dataArray[i];
          dataArray[i] = dataArray[minIdx];
          dataArray[minIdx] = temp;
        });
        await Future.delayed(const Duration(milliseconds: 1000));
      }
    }
  }

  Future<void> _insertionSort() async {
    for (int i = 1; i < dataArray.length; i++) {
      int key = dataArray[i];
      int j = i - 1;

      setState(() => currentIndex = i);
      await Future.delayed(const Duration(milliseconds: 1000));

      while (j >= 0 && dataArray[j] > key) {
        setState(() {
          compareIndex = j;
          dataArray[j + 1] = dataArray[j];
        });
        await Future.delayed(const Duration(milliseconds: 1000));
        j--;
      }
      setState(() {
        dataArray[j + 1] = key;
      });
    }
  }

  Future<void> _quickSort(int low, int high) async {
    if (low < high) {
      int pi = await _partition(low, high);
      await _quickSort(low, pi - 1);
      await _quickSort(pi + 1, high);
    }
  }

  Future<int> _partition(int low, int high) async {
    int pivot = dataArray[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      setState(() {
        currentIndex = high;
        compareIndex = j;
      });
      await Future.delayed(const Duration(milliseconds: 1000));

      if (dataArray[j] < pivot) {
        i++;
        setState(() {
          final temp = dataArray[i];
          dataArray[i] = dataArray[j];
          dataArray[j] = temp;
        });
        await Future.delayed(const Duration(milliseconds: 800));
      }
    }

    setState(() {
      final temp = dataArray[i + 1];
      dataArray[i + 1] = dataArray[high];
      dataArray[high] = temp;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    return i + 1;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sorting Algorithms Visualization',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const SizedBox(height: 10),
          Text(
            '🎯 Watch how different sorting algorithms work step-by-step',
            style: TextStyle(fontSize: 14, color: Colors.deepPurple.shade600, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),

          // Algorithm Selector
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade50, Colors.white],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 20)],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.code, color: Colors.deepPurple),
                    const SizedBox(width: 10),
                    const Text('Select Algorithm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: algorithms.map((algo) {
                    final isSelected = algo == selectedAlgorithm;
                    return GestureDetector(
                      onTap: () => setState(() => selectedAlgorithm = algo),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.deepPurple.shade600 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.deepPurple.shade200),
                        ),
                        child: Text(
                          algo,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.deepPurple.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: isSorting ? null : _startSorting,
                        icon: Icon(isSorting ? Icons.hourglass_empty : Icons.play_arrow),
                        label: Text(isSorting ? 'Sorting...' : 'Start'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: isSorting ? null : _randomizeArray,
                        icon: const Icon(Icons.shuffle),
                        label: const Text('Random'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: isSorting ? null : _resetArray,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Sorting Visualization
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
            ),
            child: CustomPaint(
              painter: SortingPainter(
                dataArray: dataArray,
                currentIndex: currentIndex,
                compareIndex: compareIndex,
              ),
              size: const Size(double.infinity, 400),
            ),
          ),
          const SizedBox(height: 20),

          // Legend
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem(Colors.blue.shade400, 'Unsorted'),
                _buildLegendItem(Colors.red.shade400, 'Current'),
                _buildLegendItem(Colors.orange.shade400, 'Compare'),
                _buildLegendItem(Colors.green.shade400, 'Sort'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class SortingPainter extends CustomPainter {
  final List<int> dataArray;
  final int currentIndex;
  final int compareIndex;

  SortingPainter({
    required this.dataArray,
    required this.currentIndex,
    required this.compareIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = (size.width - 100) / dataArray.length;
    final maxValue = dataArray.reduce(math.max);

    for (int i = 0; i < dataArray.length; i++) {
      final barHeight = (dataArray[i] / maxValue) * (size.height - 100);
      final x = 50 + i * barWidth;
      final y = size.height - 50 - barHeight;

      Color barColor;
      if (i == currentIndex) {
        barColor = Colors.red.shade400;
      } else if (i == compareIndex) {
        barColor = Colors.orange.shade400;
      } else if (i > dataArray.length - 2) {
        barColor = Colors.green.shade400;
      } else {
        barColor = Colors.blue.shade400;
      }

      // Draw bar
      final barPaint = Paint()
        ..shader = LinearGradient(
          colors: [barColor, barColor.withOpacity(0.7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(x, y, barWidth - 10, barHeight));

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth - 10, barHeight),
          const Radius.circular(8),
        ),
        barPaint,
      );

      // Draw value label
      final textPainter = TextPainter(
        text: TextSpan(
          text: dataArray[i].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(x + (barWidth - 10) / 2 - textPainter.width / 2, size.height - 30),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 2. BINARY TREE VISUALIZATION
class _BinaryTreeTab extends StatefulWidget {
  final AnimationController controller;

  const _BinaryTreeTab({required this.controller});

  @override
  State<_BinaryTreeTab> createState() => _BinaryTreeTabState();
}

class _BinaryTreeTabState extends State<_BinaryTreeTab> {
  List<int?> treeNodes = [50, 30, 70, 20, 40, 60, 80];
  int? searchValue;
  int? highlightedIndex;
  String traversalType = 'In-Order';
  List<int> traversalPath = [];
  bool isAnimating = false;

  void _insertNode(int value) {
    setState(() {
      if (treeNodes.length < 15) {
        treeNodes.add(value);
      }
    });
  }

  void _deleteNode() {
    setState(() {
      if (treeNodes.isNotEmpty) {
        treeNodes.removeLast();
      }
    });
  }

  Future<void> _animateTraversal() async {
    if (isAnimating) return;
    setState(() {
      isAnimating = true;
      traversalPath = [];
    });

    List<int> order;
    switch (traversalType) {
      case 'In-Order':
        order = _inOrderTraversal(0);
        break;
      case 'Pre-Order':
        order = _preOrderTraversal(0);
        break;
      case 'Post-Order':
        order = _postOrderTraversal(0);
        break;
      default:
        order = [];
    }

    for (int index in order) {
      setState(() {
        highlightedIndex = index;
        if (index < treeNodes.length && treeNodes[index] != null) {
          traversalPath.add(treeNodes[index]!);
        }
      });
      await Future.delayed(const Duration(milliseconds: 800));
    }

    setState(() {
      isAnimating = false;
      highlightedIndex = null;
    });
  }

  List<int> _inOrderTraversal(int index) {
    if (index >= treeNodes.length || treeNodes[index] == null) return [];
    List<int> result = [];
    result.addAll(_inOrderTraversal(2 * index + 1)); // Left
    result.add(index); // Root
    result.addAll(_inOrderTraversal(2 * index + 2)); // Right
    return result;
  }

  List<int> _preOrderTraversal(int index) {
    if (index >= treeNodes.length || treeNodes[index] == null) return [];
    List<int> result = [];
    result.add(index); // Root
    result.addAll(_preOrderTraversal(2 * index + 1)); // Left
    result.addAll(_preOrderTraversal(2 * index + 2)); // Right
    return result;
  }

  List<int> _postOrderTraversal(int index) {
    if (index >= treeNodes.length || treeNodes[index] == null) return [];
    List<int> result = [];
    result.addAll(_postOrderTraversal(2 * index + 1)); // Left
    result.addAll(_postOrderTraversal(2 * index + 2)); // Right
    result.add(index); // Root
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Binary Tree Visualization',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const SizedBox(height: 10),
          Text(
            '🌳 Explore tree traversals and operations',
            style: TextStyle(fontSize: 14, color: Colors.deepPurple.shade600, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),

          // Controls
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade50, Colors.white],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 20)],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Traversal Type:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DropdownButton<String>(
                        value: traversalType,
                        isExpanded: true,
                        items: ['In-Order', 'Pre-Order', 'Post-Order'].map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (value) => setState(() => traversalType = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: isAnimating ? null : _animateTraversal,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Animate'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _insertNode((math.Random().nextInt(90) + 10)),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Node'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Tree Visualization
          Container(
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
            ),
            child: CustomPaint(
              painter: BinaryTreePainter(
                nodes: treeNodes,
                highlightedIndex: highlightedIndex,
              ),
              size: const Size(double.infinity, 450),
            ),
          ),
          const SizedBox(height: 20),

          // Traversal Path Display
          if (traversalPath.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    '$traversalType Traversal:',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    traversalPath.join(' → '),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green.shade700),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class BinaryTreePainter extends CustomPainter {
  final List<int?> nodes;
  final int? highlightedIndex;

  BinaryTreePainter({required this.nodes, this.highlightedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.isEmpty) return;

    final levelHeight = size.height / 5;
    final nodeRadius = 25.0;

    void drawNode(int index, double x, double y, double horizontalSpacing) {
      if (index >= nodes.length || nodes[index] == null) return;

      final isHighlighted = index == highlightedIndex;

      // Draw connections to children
      final leftChildIndex = 2 * index + 1;
      final rightChildIndex = 2 * index + 2;

      final linePaint = Paint()
        ..color = Colors.grey.shade400
        ..strokeWidth = 2;

      if (leftChildIndex < nodes.length && nodes[leftChildIndex] != null) {
        final leftX = x - horizontalSpacing;
        final leftY = y + levelHeight;
        canvas.drawLine(Offset(x, y), Offset(leftX, leftY), linePaint);
        drawNode(leftChildIndex, leftX, leftY, horizontalSpacing / 2);
      }

      if (rightChildIndex < nodes.length && nodes[rightChildIndex] != null) {
        final rightX = x + horizontalSpacing;
        final rightY = y + levelHeight;
        canvas.drawLine(Offset(x, y), Offset(rightX, rightY), linePaint);
        drawNode(rightChildIndex, rightX, rightY, horizontalSpacing / 2);
      }

      // Draw node circle
      final nodePaint = Paint()
        ..shader = RadialGradient(
          colors: isHighlighted
              ? [Colors.orange.shade400, Colors.orange.shade600]
              : [Colors.blue.shade300, Colors.blue.shade600],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: nodeRadius));

      canvas.drawCircle(Offset(x, y), nodeRadius, nodePaint);
      canvas.drawCircle(
        Offset(x, y),
        nodeRadius,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );

      // Draw node value
      final textPainter = TextPainter(
        text: TextSpan(
          text: nodes[index].toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    drawNode(0, size.width / 2, 50, size.width / 6);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 3. GRAPH TRAVERSAL (BFS/DFS)
class _GraphTraversalTab extends StatefulWidget {
  final AnimationController controller;

  const _GraphTraversalTab({required this.controller});

  @override
  State<_GraphTraversalTab> createState() => _GraphTraversalTabState();
}

class _GraphTraversalTabState extends State<_GraphTraversalTab> {
  Map<int, List<int>> graph = {
    0: [1, 2],
    1: [0, 3, 4],
    2: [0, 5],
    3: [1],
    4: [1, 5],
    5: [2, 4],
  };

  Set<int> visitedNodes = {};
  int? currentNode;
  String traversalType = 'BFS';
  List<int> traversalPath = [];
  bool isAnimating = false;

  Future<void> _startTraversal() async {
    if (isAnimating) return;

    setState(() {
      isAnimating = true;
      visitedNodes = {};
      traversalPath = [];
      currentNode = null;
    });

    if (traversalType == 'BFS') {
      await _bfsTraversal(0);
    } else {
      await _dfsTraversal(0);
    }

    setState(() {
      isAnimating = false;
      currentNode = null;
    });
  }

  Future<void> _bfsTraversal(int start) async {
    Queue<int> queue = Queue();
    queue.add(start);
    visitedNodes.add(start);

    while (queue.isNotEmpty) {
      int node = queue.removeFirst();
      setState(() {
        currentNode = node;
        traversalPath.add(node);
      });
      await Future.delayed(const Duration(milliseconds: 800));

      for (int neighbor in graph[node] ?? []) {
        if (!visitedNodes.contains(neighbor)) {
          visitedNodes.add(neighbor);
          queue.add(neighbor);
        }
      }
    }
  }

  Future<void> _dfsTraversal(int node) async {
    visitedNodes.add(node);
    setState(() {
      currentNode = node;
      traversalPath.add(node);
    });
    await Future.delayed(const Duration(milliseconds: 800));

    for (int neighbor in graph[node] ?? []) {
      if (!visitedNodes.contains(neighbor)) {
        await _dfsTraversal(neighbor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Graph Traversal (BFS/DFS)',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const SizedBox(height: 10),
          Text(
            '🔍 Visualize breadth-first and depth-first search',
            style: TextStyle(fontSize: 14, color: Colors.deepPurple.shade600, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),

          // Controls
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade50, Colors.white],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 20)],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('BFS'),
                        value: 'BFS',
                        groupValue: traversalType,
                        onChanged: (value) => setState(() => traversalType = value!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('DFS'),
                        value: 'DFS',
                        groupValue: traversalType,
                        onChanged: (value) => setState(() => traversalType = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: isAnimating ? null : _startTraversal,
                  icon: const Icon(Icons.play_arrow),
                  label: Text('Start $traversalType'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Graph Visualization
          Container(
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
            ),
            child: CustomPaint(
              painter: GraphPainter(
                graph: graph,
                visitedNodes: visitedNodes,
                currentNode: currentNode,
              ),
              size: const Size(double.infinity, 450),
            ),
          ),
          const SizedBox(height: 20),

          // Traversal Path
          if (traversalPath.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    '$traversalType Traversal Order:',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    traversalPath.join(' → '),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.purple.shade700),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final Map<int, List<int>> graph;
  final Set<int> visitedNodes;
  final int? currentNode;

  GraphPainter({
    required this.graph,
    required this.visitedNodes,
    this.currentNode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final positions = {
      0: Offset(size.width / 2, 80),
      1: Offset(size.width * 0.25, 200),
      2: Offset(size.width * 0.75, 200),
      3: Offset(size.width * 0.15, 340),
      4: Offset(size.width * 0.5, 340),
      5: Offset(size.width * 0.85, 340),
    };

    // Draw edges
    final edgePaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 3;

    graph.forEach((node, neighbors) {
      for (int neighbor in neighbors) {
        if (node < neighbor) {
          canvas.drawLine(positions[node]!, positions[neighbor]!, edgePaint);
        }
      }
    });

    // Draw nodes
    positions.forEach((node, position) {
      final isVisited = visitedNodes.contains(node);
      final isCurrent = node == currentNode;

      Color nodeColor;
      if (isCurrent) {
        nodeColor = Colors.orange.shade600;
      } else if (isVisited) {
        nodeColor = Colors.green.shade600;
      } else {
        nodeColor = Colors.blue.shade400;
      }

      final nodePaint = Paint()
        ..shader = RadialGradient(
          colors: [nodeColor, nodeColor.withOpacity(0.7)],
        ).createShader(Rect.fromCircle(center: position, radius: 30));

      canvas.drawCircle(position, 30, nodePaint);
      canvas.drawCircle(
        position,
        30,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: node.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(position.dx - textPainter.width / 2, position.dy - textPainter.height / 2),
      );
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Queue implementation for BFS
class Queue<T> {
  final List<T> _list = [];

  void add(T value) => _list.add(value);
  T removeFirst() => _list.removeAt(0);
  bool get isNotEmpty => _list.isNotEmpty;
  bool get isEmpty => _list.isEmpty;
}

// 4. STACK & QUEUE TAB
class _StackQueueTab extends StatefulWidget {
  const _StackQueueTab();

  @override
  State<_StackQueueTab> createState() => _StackQueueTabState();
}

class _StackQueueTabState extends State<_StackQueueTab> {
  List<int> stack = [];
  List<int> queue = [];
  String selectedStructure = 'Stack';

  void _push(int value) {
    setState(() {
      if (selectedStructure == 'Stack') {
        stack.add(value);
      } else {
        queue.add(value);
      }
    });
  }

  void _pop() {
    setState(() {
      if (selectedStructure == 'Stack' && stack.isNotEmpty) {
        stack.removeLast();
      } else if (selectedStructure == 'Queue' && queue.isNotEmpty) {
        queue.removeAt(0);
      }
    });
  }

  void _clear() {
    setState(() {
      if (selectedStructure == 'Stack') {
        stack.clear();
      } else {
        queue.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentList = selectedStructure == 'Stack' ? stack : queue;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Stack & Queue Visualization',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const SizedBox(height: 10),
          Text(
            '📚 Understand LIFO and FIFO data structures',
            style: TextStyle(fontSize: 14, color: Colors.deepPurple.shade600, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),

          // Structure Selector
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedStructure = 'Stack'),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: selectedStructure == 'Stack' ? Colors.deepPurple.shade600 : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.deepPurple.shade200),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.layers,
                          color: selectedStructure == 'Stack' ? Colors.white : Colors.deepPurple,
                          size: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Stack (LIFO)',
                          style: TextStyle(
                            color: selectedStructure == 'Stack' ? Colors.white : Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedStructure = 'Queue'),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: selectedStructure == 'Queue' ? Colors.deepPurple.shade600 : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.deepPurple.shade200),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.queue,
                          color: selectedStructure == 'Queue' ? Colors.white : Colors.deepPurple,
                          size: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Queue (FIFO)',
                          style: TextStyle(
                            color: selectedStructure == 'Queue' ? Colors.white : Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Controls
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _push((math.Random().nextInt(90) + 10)),
                  icon: const Icon(Icons.add),
                  label: Text(selectedStructure == 'Stack' ? 'Push' : 'Enqueue'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: currentList.isEmpty ? null : _pop,
                  icon: const Icon(Icons.remove),
                  label: Text(selectedStructure == 'Stack' ? 'Pop' : 'Dequeue'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: currentList.isEmpty ? null : _clear,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Visualization
          Container(
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
            ),
            child: CustomPaint(
              painter: StackQueuePainter(
                items: currentList,
                isStack: selectedStructure == 'Stack',
              ),
              size: const Size(double.infinity, 450),
            ),
          ),
          const SizedBox(height: 20),

          // Info
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              selectedStructure == 'Stack'
                  ? 'Stack follows LIFO (Last In, First Out). The last element added is the first to be removed.'
                  : 'Queue follows FIFO (First In, First Out). The first element added is the first to be removed.',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class StackQueuePainter extends CustomPainter {
  final List<int> items;
  final bool isStack;

  StackQueuePainter({required this.items, required this.isStack});

  @override
  void paint(Canvas canvas, Size size) {
    if (items.isEmpty) {
      final textPainter = TextPainter(
        text: const TextSpan(
          text: 'Empty - Add elements to visualize',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(size.width / 2 - textPainter.width / 2, size.height / 2),
      );
      return;
    }

    final boxWidth = math.min(size.width - 100, 200.0);
    final boxHeight = 50.0;
    final spacing = 10.0;

    if (isStack) {
      // Draw stack (bottom to top)
      for (int i = 0; i < items.length; i++) {
        final y = size.height - 50 - (i + 1) * (boxHeight + spacing);
        final x = size.width / 2 - boxWidth / 2;

        final boxPaint = Paint()
          ..shader = LinearGradient(
            colors: i == items.length - 1
                ? [Colors.orange.shade400, Colors.orange.shade600]
                : [Colors.blue.shade300, Colors.blue.shade500],
          ).createShader(Rect.fromLTWH(x, y, boxWidth, boxHeight));

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, boxWidth, boxHeight),
            const Radius.circular(8),
          ),
          boxPaint,
        );

        final textPainter = TextPainter(
          text: TextSpan(
            text: items[i].toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        textPainter.paint(
          canvas,
          Offset(x + boxWidth / 2 - textPainter.width / 2, y + boxHeight / 2 - textPainter.height / 2),
        );

        // Draw "TOP" label on last element
        if (i == items.length - 1) {
          final topLabel = TextPainter(
            text: const TextSpan(
              text: 'TOP ↑',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout();

          topLabel.paint(canvas, Offset(x + boxWidth + 20, y + 15));
        }
      }
    } else {
      // Draw queue (left to right)
      final startX = 50.0;
      final y = size.height / 2 - boxHeight / 2;

      for (int i = 0; i < items.length; i++) {
        final x = startX + i * (boxWidth + spacing);

        final boxPaint = Paint()
          ..shader = LinearGradient(
            colors: i == 0
                ? [Colors.red.shade400, Colors.red.shade600]
                : [Colors.blue.shade300, Colors.blue.shade500],
          ).createShader(Rect.fromLTWH(x, y, boxWidth, boxHeight));

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, boxWidth, boxHeight),
            const Radius.circular(8),
          ),
          boxPaint,
        );

        final textPainter = TextPainter(
          text: TextSpan(
            text: items[i].toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        textPainter.paint(
          canvas,
          Offset(x + boxWidth / 2 - textPainter.width / 2, y + boxHeight / 2 - textPainter.height / 2),
        );

        // Draw "FRONT" and "REAR" labels
        if (i == 0) {
          final frontLabel = TextPainter(
            text: const TextSpan(
              text: 'FRONT',
              style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            textDirection: TextDirection.ltr,
          )..layout();

          frontLabel.paint(canvas, Offset(x + boxWidth / 2 - frontLabel.width / 2, y - 25));
        }

        if (i == items.length - 1) {
          final rearLabel = TextPainter(
            text: const TextSpan(
              text: 'REAR',
              style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            textDirection: TextDirection.ltr,
          )..layout();

          rearLabel.paint(canvas, Offset(x + boxWidth / 2 - rearLabel.width / 2, y + boxHeight + 10));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 5. LINKED LIST TAB
class _LinkedListTab extends StatefulWidget {
  const _LinkedListTab();

  @override
  State<_LinkedListTab> createState() => _LinkedListTabState();
}

class _LinkedListTabState extends State<_LinkedListTab> {
  List<int> linkedList = [10, 20, 30, 40, 50];
  int? highlightedIndex;

  void _insertAtBeginning() {
    setState(() {
      linkedList.insert(0, math.Random().nextInt(90) + 10);
    });
  }

  void _insertAtEnd() {
    setState(() {
      linkedList.add(math.Random().nextInt(90) + 10);
    });
  }

  void _deleteNode() {
    if (linkedList.isNotEmpty) {
      setState(() {
        linkedList.removeLast();
      });
    }
  }

  Future<void> _animateTraversal() async {
    for (int i = 0; i < linkedList.length; i++) {
      setState(() => highlightedIndex = i);
      await Future.delayed(const Duration(milliseconds: 600));
    }
    setState(() => highlightedIndex = null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Linked List Visualization',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
          const SizedBox(height: 10),
          Text(
            '🔗 See how nodes are linked together',
            style: TextStyle(fontSize: 14, color: Colors.deepPurple.shade600, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),

          // Controls
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _insertAtBeginning,
                icon: const Icon(Icons.first_page, size: 18),
                label: const Text('Insert Head'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _insertAtEnd,
                icon: const Icon(Icons.last_page, size: 18),
                label: const Text('Insert Tail'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              ElevatedButton.icon(
                onPressed: linkedList.isEmpty ? null : _deleteNode,
                icon: const Icon(Icons.delete, size: 18),
                label: const Text('Delete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _animateTraversal,
                icon: const Icon(Icons.play_arrow, size: 18),
                label: const Text('Traverse'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Linked List Visualization - SCROLLABLE HORIZONTALLY
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 15)],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: SizedBox(
                width: linkedList.length * 140.0 + 100,
                height: 300,
                child: CustomPaint(
                  painter: LinkedListPainter(
                    nodes: linkedList,
                    highlightedIndex: highlightedIndex,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Info
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Linked List: Each node contains data and a pointer to the next node. '
                  'Insertion and deletion are O(1) at the head.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class LinkedListPainter extends CustomPainter {
  final List<int> nodes;
  final int? highlightedIndex;

  LinkedListPainter({required this.nodes, this.highlightedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.isEmpty) {
      final textPainter = TextPainter(
        text: const TextSpan(
          text: 'Empty List - Add nodes to visualize',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(size.width / 2 - textPainter.width / 2, size.height / 2),
      );
      return;
    }

    final nodeWidth = 70.0;
    final nodeHeight = 55.0;
    final spacing = 50.0;
    final startX = 30.0;
    final y = size.height / 2 - nodeHeight / 2;

    for (int i = 0; i < nodes.length; i++) {
      final x = startX + i * (nodeWidth + spacing);
      final isHighlighted = i == highlightedIndex;

      // Draw node box
      final boxPaint = Paint()
        ..shader = LinearGradient(
          colors: isHighlighted
              ? [Colors.orange.shade400, Colors.orange.shade600]
              : [Colors.blue.shade300, Colors.blue.shade500],
        ).createShader(Rect.fromLTWH(x, y, nodeWidth, nodeHeight));

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, nodeWidth, nodeHeight),
          const Radius.circular(8),
        ),
        boxPaint,
      );

      // Draw divider line
      canvas.drawLine(
        Offset(x + nodeWidth * 0.6, y),
        Offset(x + nodeWidth * 0.6, y + nodeHeight),
        Paint()..color = Colors.white..strokeWidth = 2,
      );

      // Draw value
      final valuePainter = TextPainter(
        text: TextSpan(
          text: nodes[i].toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      valuePainter.paint(
        canvas,
        Offset(x + nodeWidth * 0.25 - valuePainter.width / 2, y + nodeHeight / 2 - valuePainter.height / 2),
      );

      // Draw arrow pointer
      if (i < nodes.length - 1) {
        final arrowPaint = Paint()
          ..color = Colors.grey.shade700
          ..strokeWidth = 2.5;

        final arrowStart = Offset(x + nodeWidth, y + nodeHeight / 2);
        final arrowEnd = Offset(x + nodeWidth + spacing, y + nodeHeight / 2);

        canvas.drawLine(arrowStart, arrowEnd, arrowPaint);

        // Arrow head
        final arrowHeadPath = Path()
          ..moveTo(arrowEnd.dx, arrowEnd.dy)
          ..lineTo(arrowEnd.dx - 8, arrowEnd.dy - 6)
          ..lineTo(arrowEnd.dx - 8, arrowEnd.dy + 6)
          ..close();
        canvas.drawPath(arrowHeadPath, Paint()..color = Colors.grey.shade700);
      } else {
        // Draw NULL for last node
        final nullPainter = TextPainter(
          text: const TextSpan(
            text: 'NULL',
            style: TextStyle(
              color: Colors.red,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        nullPainter.paint(
          canvas,
          Offset(x + nodeWidth * 0.78 - nullPainter.width / 2, y + nodeHeight / 2 - nullPainter.height / 2),
        );
      }

      // Draw "HEAD" label on first node
      if (i == 0) {
        final headLabel = TextPainter(
          text: const TextSpan(
            text: 'HEAD',
            style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        headLabel.paint(canvas, Offset(x + nodeWidth / 2 - headLabel.width / 2, y - 25));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
