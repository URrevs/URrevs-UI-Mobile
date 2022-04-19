import 'dart:math';

import 'package:faker/faker.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

class DummyDataManager {
  static bool get randomBool => Random().nextBool();
  static int get randomInt => Random().nextInt(100000000);
  static String get randomText => StringsManager.lorem;

  static String get authorName => faker.person.name();

  static DateTime get postedDate =>
      faker.date.dateTime(minYear: 2000, maxYear: 2022);

  static DateTime get usedSinceDate =>
      faker.date.dateTime(minYear: 2000, maxYear: 2021);

  static int get views => DummyDataManager.randomInt;

  static String get imageUrl => StringsManager.picsum200x200;

  static String get productName => 'Oppo Reno 5';

  static String get targetName => faker.company.name();

  static List<int> get scores =>
      List.generate(7, (_) => Random().nextInt(5) + 1);

  static int get likeCount => DummyDataManager.randomInt;

  static int get commentCount => DummyDataManager.randomInt;

  static int get shareCount => DummyDataManager.randomInt;
}
