import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:urrevs_ui_mobile/app/branch_vars.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';

class StringsManager {
  static const String emailAddress = 'urrevsofficial@gmail.com';
  static const String lorem =
      'Exercitation sit nisi tempor. Dolore cupidatat laborum culpa nostrud laborum ea labore nisi Lorem dolor tempor cillum cillum. Amet officia esse ipsum fugiat esse nisi id excepteur ut nostrud eu velit aute. Duis ipsum elit laborum ea duis enim id. Veniam laboris ad dolor eu. Esse adipisicing adipisicing id cupidatat. Ex duis reprehenderit aute anim. Deserunt consequat tempor minim.';
  static const String picsum200x200 = 'https://picsum.photos/200';
  static const String imagePlaceHolder = picsum200x200;
  static String fakeName = faker.person.name();
  static const String phoneImagePlaceHolder =
      'https://w7.pngwing.com/pngs/570/290/png-transparent-mobile-phone-illustration-computer-icons-smartphone-iphone-handphone-angle-gadget-electronics.png';
  static const String longestReviewPros =
      'Xiaomi mi9t or k20  الهاتف باختصار اداك مميزات كثيرة جدا بسعر قليل لو المميزات دي حطتها في شركة تانيه يعدى ال ١٠ الف و هو اعلى نسخة منه ٥٩٩٩ اولا processor Snapdragon 730  الصراحه جربته على كل ال apps التقيلة و مهنجش فاي واحد ده غير التنقل بين ال apps بسرعه جدا و مدة فتح اي واحد من ثانية لي اثنين  Ram 6gb و طبعا مساعدة فالسرعه جدا    اهم جزء camera  بيجي ب٣ كاميرات  ١ . كاميرا ٤٨ ميجا و زاوية واسعة ودي فالتفاصيل خرافة + معالجة الصور في الكام دي حلوة جدا   ٢. Wide angle ودي خالتني اصور بزاوية واسعه جدا ٠.٦ x ومتوقعتش ان الصورة تطلع فيه حلوة وخصوصا فالاضاءة القوية  ٣. كاميرا العزل ودي شايف انها مش اوي الصراحة وشاومي قالت هتظبطها مع الابديت الجديد  تجربة ال hdr فالصور حلوة جدا  .من اكتر الحجات الحلوة night mide و دي بتوزع الاضاءة بشكل ممتاز بالليل وده من اهم السوفتوير فيتشرز اللي اضافتها  بالنسبة للزوم فانت لحد ٢x الصورة حلوة اما بتزود الصورة بتتدمر  الفيديو بيصور لحد 4k او 1080 60 fps ده موجود فاي موبايل انما الجديد ال staplizer اللي شاومي حطته فالموبايل مثبت الكاميرا فالفيديو بشكل رهيب زي كاميرا gopro لو عارفينها +حطو التثبيت ده كمان في الزاوية الواسعه لك ان تتخيل با  في برضو بعض الحجات زي تايم لابس و slow motion بس شايفهم عاديين  ال pop up فيها كل الmodes اللي فوق +٢٠ ميجا وصورها حلوة بس مش واو يعني بس ممكن تغير صوت الكام حاجه روشه متخافش من البوب اب لان احساس الشاشه الكاملة حاجه تانية.   الشاشة amaloed حاجه فخمه جدا وصورة جميلة جدا و خصوصا لما جربت hdr+ على اليوتيوب الشاشة الكاملة حلوة جدا فالفيديوهات  البصمة المدمجه فالشاشة اثبتت نجاحها مش زي a70 سريعه جدا  .برضو قفل الوجه سريع و بيفتح فالاضاءة القليلة   تصميم الموبايل   مريح فالايد والضهر ازاز وشكله جميل و الشاشة gorilla 5plus الموبايل وقع مرتين ومنكسرش   في با بعض الحجات هتلاقوها فالسيتنج لزيزة بس موجودة في موبايلات كتير زي الموبايلين عشان الخصوصية     الموبايل بيشحن في ساعه لحد ٩٠/١٠٠  ';
  static const String longestReviewCons =
      'حاجتين نرفزوني  الموبايل بقالو شهر معايا  الحواف بدات تقشر عشان استخدمت الجراب بتاع شاومي مكشوف من فوق ومن تحت  اداء البطارية بدا يضعف كان بيقعد معايا يومين كاملين دلوبتي يوم ونص';
  static const String longestPhoneName =
      'Asus Zenfone Max Pro (M1) ZB601KL/ZB602K';
  static const String longestCompanyName = 'Sony Ericsson';
  static const String prizeImageLink =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVmqetlFGRGEri6eONcKzyUluyk5LGFNNDXA&usqp=CAU';
  static const String webDomain = BranchVars.webDomain;
  static const String uriPrefix = BranchVars.uriPrefix;
  static const String packageName = 'com.urrevs.urrevsmobile';
  static const String awsBackendApi = 'https://urrevs.com/api';
  static const String herokuBackendApi =
      'https://urrevs-api-dev-mobile.herokuapp.com/';
  static const String currentBackendApi = BranchVars.currentBackendApi;
  static const String mockApiUrl = BranchVars.mockApiUrl;

  static String termsAndConditionsUrl(bool isArabic) => isArabic
      ? 'https://docs.google.com/document/d/e/2PACX-1vTG4kawFFmI0ku7erJPGiOlrp6gYW4Ybj-_qHFMSlTWqgI2dSTPYZPTraZh2MMzqxMn7KmZVL0QiOqJ/pub'
      : 'https://docs.google.com/document/d/e/2PACX-1vSeDAxcK6LJPF1S7Omc-PYfSWbOwLidsq7zQCOMyBu_eQDwnwKdPNvrVPbRAJxWlBV6VE7WQhaExhix/pub';

  static String privacyPolicyUrl(bool isArabic) => isArabic
      ? 'https://docs.google.com/document/d/e/2PACX-1vQmvvk-TcAXnuEVzJsF6XjVKCP1XrUOD100p5LzRTvBxyO1Wqn4NdfBWyr0btht0mx0EhOcnp-rjEjE/pub'
      : 'https://docs.google.com/document/d/e/2PACX-1vTtMyGcmy2IUsM_lXHrIjhoybCWcdYM252L9VDhyklLysGYbBzd5tGDfqr8Zh3giwO0408pXBV-VJJL/pub';
}
