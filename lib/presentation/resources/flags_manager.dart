import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlagsManager {
  static const bool development = true;
  static bool useMockApi =
      dotenv.get('USE_MOCK') == 'true' ? kDebugMode : false;
}
