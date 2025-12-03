import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HscBiologyPage extends StatefulWidget {
  const HscBiologyPage({super.key});

  @override
  _HscBiologyPageState createState() => _HscBiologyPageState();
}

class _HscBiologyPageState extends State<HscBiologyPage> {
  String _selectedModel = 'assets/images/skeleton.glb';
  bool _isLoading = true;
  String? _errorMessage;
  WebViewController? _webViewController;
  final List<Map<String, String>> _models = [

    {
      'name': 'skeleton',
      'path': 'assets/images/skeleton.glb'
    },

    {
      'name': 'Lungs',
      'path': 'assets/images/realistic_human_lungs.glb'
    },



    {
      'name': 'Digestive system',
      'path': 'assets/images/digestive_system__human_anatomy.glb'
    },

    {
      'name': 'Kidneys',
      'path': 'assets/images/human_kidney.glb'
    },
    {
      'name': 'DNA double helix',
      'path': 'assets/images/dna.glb'
    },

    {
      'name': 'Phospholipid Bilayer',
      'path': 'assets/images/Phospholipid_bilayer_Beige.glb'
    },
    {
      'name': 'Rough ER',
      'path': 'assets/images/Rough_ER_Dark_Beige.glb'
    },



  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 15), () {
      if (mounted && _isLoading) {
        setState(() {
          _errorMessage = 'Failed to load $_selectedModel. Try re-exporting the model.';
          _isLoading = false;
        });
      }
    });
  }

  void _onModelChanged(String? value) {
    if (value != null && value != _selectedModel) {
      setState(() {
        _selectedModel = value;
        _isLoading = true;
        _errorMessage = null;
        _webViewController = null;
      });
      Future.delayed(const Duration(seconds: 15), () {
        if (mounted && _isLoading) {
          setState(() {
            _errorMessage = 'Failed to load $_selectedModel. Try re-exporting the model.';
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _webViewController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Biology - 3D Models'),
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButton<String>(
              value: _selectedModel,
              isExpanded: true,
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white, fontSize: 16),
              underline: Container(
                height: 2,
                color: Colors.greenAccent,
              ),
              items: _models.map((model) {
                return DropdownMenuItem<String>(
                  value: model['path'],
                  child: Text(model['name']!),
                );
              }).toList(),
              onChanged: _onModelChanged,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                KeyedSubtree(
                  key: ValueKey(_selectedModel),
                  child: ModelViewer(
                    src: _selectedModel,
                    alt: '3D Model',
                    ar: true,
                    autoRotate: true,
                    cameraControls: true,
                    backgroundColor: const Color(0xFF121212),
                    iosSrc: _selectedModel,
                    disableZoom: false,
                    loading: Loading.eager,
                    onWebViewCreated: (WebViewController controller) {
                      print('WebView created for: $_selectedModel');
                      _webViewController = controller;
                      controller.setNavigationDelegate(
                        NavigationDelegate(
                          onPageStarted: (url) {
                            print('WebView started loading: $url');
                          },
                          onPageFinished: (url) {
                            print('WebView finished loading: $url');
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          onWebResourceError: (error) {
                            print('WebView error: ${error.description}');
                            setState(() {
                              _errorMessage = 'Error loading $_selectedModel: ${error.description}';
                              _isLoading = false;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                  ),
                if (_errorMessage != null)
                  Container(
                    color: const Color(0xFF121212),
                    child: Center(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pinch to zoom, drag to rotate, two-finger drag to pan.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}