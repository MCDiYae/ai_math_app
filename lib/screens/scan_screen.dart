import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scan_provider.dart';
import '../widgets/scan_result_card.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Scanner'),
        actions: [
          Consumer<ScanProvider>(
            builder: (context, scanProvider, child) {
              return IconButton(
                icon: const Icon(Icons.delete_sweep),
                tooltip: 'Clear all',
                onPressed: scanProvider.scanResults.isNotEmpty
                    ? () => _showClearAllDialog(context, scanProvider)
                    : null,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProcessingIndicator(),
          _buildCurrentImagePreview(),
          _buildActionButtons(context),
          const Divider(height: 1),
          Expanded(child: _buildResultsList()),
        ],
      ),
    );
  }

  Widget _buildProcessingIndicator() {
    return Consumer<ScanProvider>(
      builder: (context, scanProvider, child) {
        if (!scanProvider.isProcessing) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.blue.shade50,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  scanProvider.currentStep,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrentImagePreview() {
    return Consumer<ScanProvider>(
      builder: (context, scanProvider, child) {
        final currentImage = scanProvider.currentImage;
        if (currentImage == null || !scanProvider.isProcessing) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.all(16),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              currentImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Consumer<ScanProvider>(
        builder: (context, scanProvider, child) {
          final isProcessing = scanProvider.isProcessing;
          
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isProcessing ? null : () => _scanFromCamera(context, scanProvider),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isProcessing ? null : () => _scanFromGallery(context, scanProvider),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('From Gallery'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: isProcessing ? null : () => _scanMultipleFromGallery(context, scanProvider),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Multiple Photos'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildResultsList() {
    return Consumer<ScanProvider>(
      builder: (context, scanProvider, child) {
        final results = scanProvider.scanResults;
        
        if (results.isEmpty && !scanProvider.isProcessing) {
          return _buildEmptyState();
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ScanResultCard(
              scanResult: result,
              onRetry: () => _retryProcessing(context, scanProvider, result),
              onDelete: () => _deleteScanResult(context, scanProvider, result),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.document_scanner_outlined,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No scanned documents yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Take a photo or select from gallery to get started',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scanFromCamera(BuildContext context, ScanProvider scanProvider) async {
    try {
      await scanProvider.scanFromCamera();
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    }
  }

  Future<void> _scanFromGallery(BuildContext context, ScanProvider scanProvider) async {
    try {
      await scanProvider.scanFromGallery();
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    }
  }

  Future<void> _scanMultipleFromGallery(BuildContext context, ScanProvider scanProvider) async {
    try {
      await scanProvider.scanMultipleFromGallery();
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    }
  }

  Future<void> _retryProcessing(BuildContext context, ScanProvider scanProvider, result) async {
    try {
      await scanProvider.retryProcessing(result);
    } catch (e) {
      if (context.mounted) {
        _showError(context, e.toString());
      }
    }
  }

  void _deleteScanResult(BuildContext context, ScanProvider scanProvider, result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Result'),
          content: const Text('Are you sure you want to delete this scan result?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                scanProvider.deleteScanResult(result);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showClearAllDialog(BuildContext context, ScanProvider scanProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Results'),
          content: const Text('Are you sure you want to clear all scan results? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                scanProvider.clearAllResults();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}