import 'package:flutter/material.dart';
import '../services/ad_services.dart';

/// Utility class for managing interstitial ads throughout the app
class InterstitialAdManager {
  static final AdService _adService = AdService();

  /// Show interstitial ad when navigating between main screens
  /// Call this before navigation (Home → Chat/Scan)
  static Future<void> showNavigationAd({
    required BuildContext context,
    required VoidCallback onComplete,
    bool forceShow = false,
  }) async {
    try {
      if (forceShow) {
        // Force show ad regardless of frequency
        await _adService.showNavigationInterstitialAd();
      } else {
        // Respect frequency settings
        _adService.triggerAction();
        await _adService.showNavigationInterstitialAd();
      }
      
      // Always call onComplete after ad attempt
      onComplete();
    } catch (e) {
      debugPrint('❌ Error showing navigation interstitial: $e');
      // Continue with navigation even if ad fails
      onComplete();
    }
  }

  /// Show interstitial ad after scan completion
  /// Call this after OCR results are displayed
  static Future<void> showScanCompleteAd({
    required BuildContext context,
    VoidCallback? onComplete,
    bool forceShow = false,
  }) async {
    try {
      if (forceShow) {
        // Force show ad regardless of frequency
        await _adService.showScanCompleteInterstitialAd();
      } else {
        // Respect frequency settings
        _adService.triggerAction();
        await _adService.showScanCompleteInterstitialAd();
      }
      
      onComplete?.call();
    } catch (e) {
      debugPrint('❌ Error showing scan complete interstitial: $e');
      onComplete?.call();
    }
  }

  /// Get current action count (for debugging)
  static int get actionCount => _adService.actionCount;

  /// Check if ads are ready
  static bool get isNavigationAdReady => _adService.isNavigationAdReady;
  static bool get isScanCompleteAdReady => _adService.isScanCompleteAdReady;

  /// Manually trigger action counter (for testing)
  static void triggerAction() => _adService.triggerAction();

  /// Reload all interstitial ads
  static void reloadAds() => _adService.reloadInterstitialAds();
}

/// Widget for handling navigation with interstitial ads
class AdNavigator extends StatelessWidget {
  final Widget child;
  final String routeName;
  final bool showAdBeforeNavigation;

  const AdNavigator({
    super.key,
    required this.child,
    required this.routeName,
    this.showAdBeforeNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleNavigation(context),
      child: child,
    );
  }

  void _handleNavigation(BuildContext context) {
    if (showAdBeforeNavigation) {
      // Show ad before navigation
      InterstitialAdManager.showNavigationAd(
        context: context,
        onComplete: () {
          if (context.mounted) {
            Navigator.pushNamed(context, routeName);
          }
        },
      );
    } else {
      // Navigate directly
      Navigator.pushNamed(context, routeName);
    }
  }
}

/// Custom button with integrated ad functionality
class AdNavigationButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String routeName;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showAdBeforeNavigation;

  const AdNavigationButton({
    super.key,
    required this.text,
    required this.icon,
    required this.routeName,
    this.backgroundColor,
    this.textColor,
    this.showAdBeforeNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _handleNavigation(context),
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }

  void _handleNavigation(BuildContext context) {
    if (showAdBeforeNavigation) {
      InterstitialAdManager.showNavigationAd(
        context: context,
        onComplete: () {
          if (context.mounted) {
            Navigator.pushNamed(context, routeName);
          }
        },
      );
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }
}

/// Widget to show interstitial ad after scan completion
class ScanCompleteAdTrigger extends StatefulWidget {
  final Widget child;
  final VoidCallback? onAdComplete;

  const ScanCompleteAdTrigger({
    super.key,
    required this.child,
    this.onAdComplete,
  });

  @override
  State<ScanCompleteAdTrigger> createState() => _ScanCompleteAdTriggerState();
}

class _ScanCompleteAdTriggerState extends State<ScanCompleteAdTrigger> {
  bool _hasTriggeredAd = false;

  @override
  void initState() {
    super.initState();
    // Trigger ad after a short delay to ensure UI is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasTriggeredAd) {
        _triggerScanCompleteAd();
      }
    });
  }

  void _triggerScanCompleteAd() {
    if (_hasTriggeredAd) return;
    
    _hasTriggeredAd = true;
    InterstitialAdManager.showScanCompleteAd(
      context: context,
      onComplete: widget.onAdComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Debug widget for testing ad functionality
class AdDebugPanel extends StatelessWidget {
  const AdDebugPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Ad Debug Panel',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Action Count: ${InterstitialAdManager.actionCount}'),
          Text('Navigation Ad Ready: ${InterstitialAdManager.isNavigationAdReady}'),
          Text('Scan Complete Ad Ready: ${InterstitialAdManager.isScanCompleteAdReady}'),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => InterstitialAdManager.triggerAction(),
                child: const Text('Trigger Action'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => InterstitialAdManager.reloadAds(),
                child: const Text('Reload Ads'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}