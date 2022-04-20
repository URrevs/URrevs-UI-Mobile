import 'dart:math';

import 'package:faker/faker.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/reply.dart';

class DummyDataManager {
  static bool get randomBool => Random().nextBool();
  static int get randomInt => Random().nextInt(100000000);
  static String get randomText => StringsManager.lorem;
  static String get sentenceOrMore =>
      faker.lorem.sentences(Random().nextInt(3) + 1).join(' ');

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

  static String get reply =>
      faker.lorem.sentences(Random().nextInt(3) + 1).join(' ');

  static List<Reply> get replies => List.generate(
        Random().nextInt(3) + 1,
        (_) => Reply.dummyInstance,
      );
  static List<CommentTree> get comments => List.generate(
        Random().nextInt(3) + 1,
        (_) => CommentTree.dummyInstance,
      );
}
