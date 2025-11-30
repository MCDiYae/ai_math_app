import 'dart:io';

class AdConstants {
  // App ID (Replace with your actual AdMob App ID)
  static final String appId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544~3347511713' // Test App ID for Android
      : 'ca-app-pub-3940256099942544~1458002511'; // Test App ID for iOS

  // Banner Ad Unit IDs
  static String homeBannerAdId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' // Test Banner for Android
      : 'ca-app-pub-3940256099942544/2934735716'; // Test Banner for iOS

  static String chatBannerAdId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' // Test Banner for Android
      : 'ca-app-pub-3940256099942544/2934735716'; // Test Banner for iOS

  static String scanBannerAdId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' // Test Banner for Android
      : 'ca-app-pub-3940256099942544/2934735716'; // Test Banner for iOS

  // Interstitial Ad Unit IDs
  static String navigationInterstitialAdId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712' // Test Interstitial for Android
      : 'ca-app-pub-3940256099942544/4411468910'; // Test Interstitial for iOS

  static String scanCompleteInterstitialAdId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712' // Test Interstitial for Android
      : 'ca-app-pub-3940256099942544/4411468910'; // Test Interstitial for iOS

  // Ad Settings
  static  int interstitialFrequency = 4; // Show ad every 3 actions
  static  int bannerRefreshInterval = 60; // Refresh banner every 60 seconds
  static  bool enableTestMode = false; // Set to false for production

  // Production Ad IDs (Replace these with your actual AdMob Ad Unit IDs)
  static String prodAppId = Platform.isAndroid
      ? 'ca-app-pub-1132671221545305~4454369803' // Your Android App ID
      : 'ca-app-pub-1132671221545305~6492325888'; // Your iOS App ID

  static String prodHomeBannerAdId = Platform.isAndroid
      ? 'ca-app-pub-1132671221545305/6365167525' // Your Android Banner ID
      : 'ca-app-pub-1132671221545305/8426895091'; // Your iOS Banner ID

  static String prodNavigationInterstitialAdId = Platform.isAndroid
      ? 'ca-app-pub-1132671221545305/1744445983' // Your Android Interstitial ID
      : 'ca-app-pub-1132671221545305/8118282643'; // Your iOS Interstitial ID

  // Helper methods
  static String getCurrentAppId() {
    return enableTestMode ? appId : prodAppId;
  }

  static String getCurrentHomeBannerAdId() {
    return enableTestMode ? homeBannerAdId : prodHomeBannerAdId;
  }

  static String getCurrentNavigationInterstitialAdId() {
    return enableTestMode ? navigationInterstitialAdId : prodNavigationInterstitialAdId;
  }

  // Ad targeting keywords (for better ad relevance)
  static  List<String> adKeywords = [
    'math',
    'education',
    'learning',
    'student',
    'homework',
    'calculator',
    'algebra',
    'geometry',
    'calculus',
  ];
}