import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import '../utils/ad_constants.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  // Action counter for interstitial ad frequency
  int _actionCounter = 0;
  bool _isInitialized = false;

  // Interstitial ad instances
  InterstitialAd? _navigationInterstitialAd;
  InterstitialAd? _scanCompleteInterstitialAd;

  // Initialize AdMob
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      debugPrint('✅ AdMob initialized successfully');
      
      // Preload interstitial ads
      _loadNavigationInterstitialAd();
      _loadScanCompleteInterstitialAd();
    } catch (e) {
      debugPrint('❌ AdMob initialization failed: $e');
    }
  }

  // Check if AdMob is initialized
  bool get isInitialized => _isInitialized;

  // Create banner ad with specified ad unit ID
  BannerAd createBannerAd({
    required String adUnitId,
    AdSize adSize = AdSize.banner,
    VoidCallback? onAdLoaded,
    void Function(Ad, LoadAdError)? onAdFailedToLoad,
  }) {
    return BannerAd(
      adUnitId: adUnitId,
      size: adSize,
      request: AdRequest(
        keywords: AdConstants.adKeywords,
        nonPersonalizedAds: AdConstants.enableTestMode,
      ),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('✅ Banner Ad loaded: $adUnitId');
          onAdLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('❌ Banner Ad failed to load: $error');
          ad.dispose();
          onAdFailedToLoad?.call(ad, error);
        },
        onAdOpened: (ad) {
          debugPrint('🔄 Banner Ad opened');
        },
        onAdClosed: (ad) {
          debugPrint('🔄 Banner Ad closed');
        },
      ),
    );
  }

  // Load navigation interstitial ad
  void _loadNavigationInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdConstants.navigationInterstitialAdId,
      request: AdRequest(
        keywords: AdConstants.adKeywords,
        nonPersonalizedAds: AdConstants.enableTestMode,
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _navigationInterstitialAd = ad;
          debugPrint('✅ Navigation Interstitial Ad loaded');
          _setInterstitialCallbacks(_navigationInterstitialAd!);
        },
        onAdFailedToLoad: (error) {
          debugPrint('❌ Navigation Interstitial Ad failed to load: $error');
          _navigationInterstitialAd = null;
        },
      ),
    );
  }

  // Load scan complete interstitial ad
  void _loadScanCompleteInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdConstants.scanCompleteInterstitialAdId,
      request: AdRequest(
        keywords: AdConstants.adKeywords,
        nonPersonalizedAds: AdConstants.enableTestMode,
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _scanCompleteInterstitialAd = ad;
          debugPrint('✅ Scan Complete Interstitial Ad loaded');
          _setInterstitialCallbacks(_scanCompleteInterstitialAd!);
        },
        onAdFailedToLoad: (error) {
          debugPrint('❌ Scan Complete Interstitial Ad failed to load: $error');
          _scanCompleteInterstitialAd = null;
        },
      ),
    );
  }

  // Set interstitial ad callbacks
  void _setInterstitialCallbacks(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        debugPrint('🔄 Interstitial Ad showed full screen content');
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('🔄 Interstitial Ad dismissed');
        ad.dispose();
        // Reload the ad for next time
        if (ad == _navigationInterstitialAd) {
          _navigationInterstitialAd = null;
          _loadNavigationInterstitialAd();
        } else if (ad == _scanCompleteInterstitialAd) {
          _scanCompleteInterstitialAd = null;
          _loadScanCompleteInterstitialAd();
        }
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('❌ Interstitial Ad failed to show: $error');
        ad.dispose();
      },
    );
  }

  // Show navigation interstitial ad
  Future<void> showNavigationInterstitialAd() async {
    _incrementActionCounter();
    
    if (!_shouldShowInterstitialAd()) {
      debugPrint('⏭️ Skipping interstitial ad (frequency control)');
      return;
    }

    if (_navigationInterstitialAd != null) {
      await _navigationInterstitialAd!.show();
      _resetActionCounter();
    } else {
      debugPrint('⚠️ Navigation interstitial ad not ready');
      _loadNavigationInterstitialAd(); // Try to load again
    }
  }

  // Show scan complete interstitial ad
  Future<void> showScanCompleteInterstitialAd() async {
    _incrementActionCounter();
    
    if (!_shouldShowInterstitialAd()) {
      debugPrint('⏭️ Skipping scan complete interstitial ad (frequency control)');
      return;
    }

    if (_scanCompleteInterstitialAd != null) {
      await _scanCompleteInterstitialAd!.show();
      _resetActionCounter();
    } else {
      debugPrint('⚠️ Scan complete interstitial ad not ready');
      _loadScanCompleteInterstitialAd(); // Try to load again
    }
  }

  // Action counter management
  void _incrementActionCounter() {
    _actionCounter++;
    debugPrint('📊 Action counter: $_actionCounter');
  }

  void _resetActionCounter() {
    _actionCounter = 0;
    debugPrint('🔄 Action counter reset');
  }

  bool _shouldShowInterstitialAd() {
    return _actionCounter >= AdConstants.interstitialFrequency;
  }

  // Manual action trigger (for testing or specific actions)
  void triggerAction() {
    _incrementActionCounter();
  }

  // Get current action count (for debugging)
  int get actionCount => _actionCounter;

  // Dispose all ads
  void dispose() {
    _navigationInterstitialAd?.dispose();
    _scanCompleteInterstitialAd?.dispose();
    _navigationInterstitialAd = null;
    _scanCompleteInterstitialAd = null;
    debugPrint('🗑️ AdService disposed');
  }

  // Force reload all interstitial ads
  void reloadInterstitialAds() {
    _loadNavigationInterstitialAd();
    _loadScanCompleteInterstitialAd();
    debugPrint('🔄 Reloading all interstitial ads');
  }

  // Check ad availability
  bool get isNavigationAdReady => _navigationInterstitialAd != null;
  bool get isScanCompleteAdReady => _scanCompleteInterstitialAd != null;
}