class AppConstants {
  // App Info
  static const String appName = 'AI Math Solver';
  static const String appVersion = '1.0.0';
  
  // API URLs (Replace with your actual API endpoints)
  static const String openAIApiUrl = 'https://api.openai.com/v1/chat/completions';
  static const String deepSeekApiUrl = 'https://api.deepseek.com/v1/chat/completions';
  static const String keyDeepseek= "sk-6c0438ad49a4438bb348bbb5a182fd1a";
  
  // Storage Keys
  static const String themeKey = 'theme_mode';
  static const String chatHistoryKey = 'chat_history';
  static const String recentProblemsKey = 'recent_problems';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double cardElevation = 4.0;
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 3);
  
  // Image Settings
  static const int maxImageSize = 1024; // pixels
  static const int imageQuality = 85; // percentage
  
  // Chat Settings
  static const int maxChatHistory = 50;
  static const int maxMessageLength = 1000;
}