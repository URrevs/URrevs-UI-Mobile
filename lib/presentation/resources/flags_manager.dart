import 'package:flutter/foundation.dart';

class FlagsManager {
  static const bool development = true;
  static const bool useMockApi = !kDebugMode ? false : true;
}
