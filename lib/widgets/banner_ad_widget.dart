import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_services.dart';

class BannerAdWidget extends StatefulWidget {
  final String adUnitId;
  final AdSize adSize;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;

  const BannerAdWidget({
    super.key,
    required this.adUnitId,
    this.adSize = AdSize.banner,
    this.margin,
    this.backgroundColor,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isAdFailed = false;
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    // Check if AdMob is initialized
    if (!_adService.isInitialized) {
      debugPrint('⚠️ AdMob not initialized, skipping banner ad');
      return;
    }

    _bannerAd = _adService.createBannerAd(
      adUnitId: widget.adUnitId,
      adSize: widget.adSize,
      onAdLoaded: () {
        if (mounted) {
          setState(() {
            _isAdLoaded = true;
            _isAdFailed = false;
          });
        }
      },
      onAdFailedToLoad: (ad, error) {
        if (mounted) {
          setState(() {
            _isAdLoaded = false;
            _isAdFailed = true;
          });
        }
      },
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Don't show anything if AdMob is not initialized
    if (!_adService.isInitialized) {
      return const SizedBox.shrink();
    }

    // Don't show anything if ad failed to load
    if (_isAdFailed) {
      return const SizedBox.shrink();
    }

    // Show loading placeholder while ad is loading
    if (!_isAdLoaded || _bannerAd == null) {
      return Container(
        margin: widget.margin,
        height: widget.adSize.height.toDouble(),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Loading ad...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show the actual ad
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ),
      ),
    );
  }
}

// Predefined banner ad widgets for different screens
class HomeBannerAd extends StatelessWidget {
  const HomeBannerAd({super.key});

  @override
  Widget build(BuildContext context) {
    return BannerAdWidget(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      adSize: AdSize.banner,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

class ChatBannerAd extends StatelessWidget {
  const ChatBannerAd({super.key});

  @override
  Widget build(BuildContext context) {
    return BannerAdWidget(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      adSize: AdSize.banner,
      margin: const EdgeInsets.all(8),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

class ScanBannerAd extends StatelessWidget {
  const ScanBannerAd({super.key});

  @override
  Widget build(BuildContext context) {
    return BannerAdWidget(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      adSize: AdSize.banner,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

// Large banner for better visibility (optional)
class LargeBannerAd extends StatelessWidget {
  final String adUnitId;
  
  const LargeBannerAd({
    super.key,
    required this.adUnitId,
  });

  @override
  Widget build(BuildContext context) {
    return BannerAdWidget(
      adUnitId: adUnitId,
      adSize: AdSize.largeBanner,
      margin: const EdgeInsets.all(16),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

// Adaptive banner for responsive design
class AdaptiveBannerAd extends StatefulWidget {
  final String adUnitId;
  
  const AdaptiveBannerAd({
    super.key,
    required this.adUnitId,
  });

  @override
  State<AdaptiveBannerAd> createState() => _AdaptiveBannerAdState();
}

class _AdaptiveBannerAdState extends State<AdaptiveBannerAd> {
  AdSize? _adSize;

  @override
  void initState() {
    super.initState();
    _loadAdaptiveAdSize();
  }

  Future<void> _loadAdaptiveAdSize() async {
    final screenWidth = MediaQuery.of(context).size.width.truncate();
    final adSize = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      screenWidth,
    );
    
    if (mounted) {
      setState(() {
        _adSize = adSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_adSize == null) {
      // Show loading or fallback to regular banner
      return BannerAdWidget(
        adUnitId: widget.adUnitId,
        adSize: AdSize.banner,
        margin: const EdgeInsets.all(16),
        backgroundColor: Theme.of(context).colorScheme.surface,
      );
    }
    
    return BannerAdWidget(
      adUnitId: widget.adUnitId,
      adSize: _adSize!,
      margin: const EdgeInsets.all(16),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}