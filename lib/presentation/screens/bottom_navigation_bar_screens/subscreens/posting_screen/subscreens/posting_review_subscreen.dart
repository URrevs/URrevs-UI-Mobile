import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_review_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/datepicker_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/search_text_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/txt_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/referral_code_help_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';
import 'dart:math' as math;

final productSelectedProvider = StateProvider.autoDispose<bool>((ref) => false);

class PostingReviewSubscreen extends StatefulWidget {
  const PostingReviewSubscreen({Key? key}) : super(key: key);

  @override
  State<PostingReviewSubscreen> createState() => _PostingReviewSubscreenState();
}

class _PostingReviewSubscreenState extends State<PostingReviewSubscreen> {
  PostingReviewModel postingReviewModel = PostingReviewModel(
    productName: '',
    companyName: 'Xiaomi',
    usedSince: DateTime(DateTime.now().year, DateTime.now().month),
    generalRating: 3,
    manufacturingQuality: 3,
    userInterface: 3,
    priceQuality: 3,
    camera: 3,
    callsQuality: 3,
    battery: 3,
    whatUserLikedAboutProduct: '',
    whatUserHatedAboutProduct: '',
    companyRating: 3,
    whatUserLikedAboutCompany: '',
    whatUserHatedAboutCompany: '',
    invitationCode: '',
  );

  late TextEditingController productNameController;
  late TextEditingController usedSinceController;
  late TextEditingController likedAboutProductController;
  late TextEditingController hatedAboutProductController;
  late TextEditingController likedAboutCompanyController;
  late TextEditingController hatedAboutCompanyController;
  late TextEditingController invitationCodeController;

  @override
  void initState() {
    super.initState();
    productNameController =
        TextEditingController(text: postingReviewModel.productName);
    // NOTE: I am not sure about this controller.
    usedSinceController = TextEditingController(text: '');
    likedAboutProductController = TextEditingController(
        text: postingReviewModel.whatUserLikedAboutProduct);
    hatedAboutProductController = TextEditingController(
        text: postingReviewModel.whatUserHatedAboutProduct);
    likedAboutCompanyController = TextEditingController(
        text: postingReviewModel.whatUserLikedAboutCompany);
    hatedAboutCompanyController = TextEditingController(
        text: postingReviewModel.whatUserHatedAboutCompany);
    invitationCodeController =
        TextEditingController(text: postingReviewModel.invitationCode);
  }

  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;
  bool star6 = false;
  bool star7 = false;
  bool star8 = false;
  final _formKey = GlobalKey<FormState>();
  bool productSelected = false;
  void onProductNameChanged() {
    if (productNameController.text.isNotEmpty) {
      if (!productSelected) {
        setState(() {
          productSelected = true;
        });
      }
    } else {
      if (productSelected) {
        setState(() {
          productSelected = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool productSelected = ref.watch(productSelectedProvider);
    return SingleChildScrollView(
      padding: AppEdgeInsets.screenPadding.copyWith(bottom: 10.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.chooseProduct.tr() + ':',
                style: TextStyleManager.s18w500),
            SearchTextField(
              searchCtl: productNameController,
              fillColor: ColorManager.textFieldGrey,
              hasErrorMsg: true,
              hintText: LocaleKeys.writeProductName.tr(),
              errorMsg: LocaleKeys.productNameErrorMsg.tr(),
              onChange: onProductNameChanged,
            ),
            SizedBox(height: 20.h),
            Text(
              LocaleKeys.howLongHaveYouOwnedThisProduct.tr(),
              style: TextStyleManager.s18w500,
            ),
            DatePickerField(
              dateController: usedSinceController,
              hintText: LocaleKeys.purchaseDate.tr(),
              fillColor: ColorManager.textFieldGrey,
              isMonthDatePicker: true,
              hasErrorMsg: true,
              errorMsg: LocaleKeys.purchaseDateErrorMsg.tr(),
            ),
            SizedBox(height: 20.h),
            Text(LocaleKeys.rateOverallExpericence.tr(),
                style: TextStyleManager.s18w500),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // general rating bar
                CustomRatingBar(
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star1) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star1 = true;
                      postingReviewModel.generalRating = rating.toInt();
                    }
                  },
                ),
                SizedBox(height: 5.h),
                // manufacturing quality bar
                RatingEntry(
                  title: LocaleKeys.manufacturingQuality.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star2) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star2 = true;
                      postingReviewModel.manufacturingQuality = rating.toInt();
                    }
                  },
                ),
                // user interface bar
                RatingEntry(
                  title: LocaleKeys.userInterface.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star3) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star3 = true;
                      postingReviewModel.userInterface = rating.toInt();
                    }
                  },
                ),
                // price quality bar
                RatingEntry(
                  title: LocaleKeys.priceQuality.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star4) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star4 = true;
                      postingReviewModel.priceQuality = rating.toInt();
                    }
                  },
                ),
                // camera bar
                RatingEntry(
                  title: LocaleKeys.camera.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star5) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star5 = true;
                      postingReviewModel.camera = rating.toInt();
                    }
                  },
                ),
                // calls quality bar
                RatingEntry(
                  title: LocaleKeys.callsQuality.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star6) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star6 = true;
                      postingReviewModel.callsQuality = rating.toInt();
                    }
                  },
                ),
                // battery bar
                RatingEntry(
                  title: LocaleKeys.battery.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star7) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star7 = true;
                      postingReviewModel.battery = rating.toInt();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // what do you like about this product
            Text(LocaleKeys.whatDoYouLikeAboutThisProduct.tr(),
                style: TextStyleManager.s18w500),
            TxtField(
              textController: likedAboutProductController,
              hintText: LocaleKeys.pros.tr(),
              keyboardType: TextInputType.text,
              fillColor: ColorManager.textFieldGrey,
              errorMsg: LocaleKeys.likedAboutProductErrorMsg.tr(),
              hasErrorMsg: true,
            ),
            SizedBox(height: 20.h),
            // what do you hate about this product
            Text(LocaleKeys.whatDoYouHateAboutThisProduct.tr(),
                style: TextStyleManager.s18w500),
            TxtField(
              textController: hatedAboutProductController,
              hintText: LocaleKeys.cons.tr(),
              keyboardType: TextInputType.text,
              fillColor: ColorManager.textFieldGrey,
              errorMsg: LocaleKeys.hateAboutProductErrorMsg.tr(),
              hasErrorMsg: true,
            ),
            SizedBox(height: 40.h),
            productSelected
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // rate the manufacturer
                      Text(LocaleKeys.howDoYouRateTheManufacturer.tr(),
                          style: TextStyleManager.s18w500),
                      Center(
                        child: CustomRatingBar(
                          onRatingUpdate: (rating) {
                            FocusScope.of(context).unfocus();
                            if (!star8) {
                              setState(() {
                                //starsPoints++;
                              });
                            }
                            if (rating != 0) {
                              star8 = true;
                              postingReviewModel.companyRating = rating.toInt();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // what do you like about the manufacturer
                      Text(
                          LocaleKeys.WhatDoYouLikeAbout.tr() +
                              ' ' +
                              postingReviewModel.companyName,
                          style: TextStyleManager.s18w500),
                      TxtField(
                        textController: likedAboutCompanyController,
                        hintText: LocaleKeys.pros.tr(),
                        keyboardType: TextInputType.text,
                        fillColor: ColorManager.textFieldGrey,
                        errorMsg:
                            LocaleKeys.likedAboutManufacturerErrorMsg.tr(),
                        hasErrorMsg: true,
                      ),
                      SizedBox(height: 20.h),
                      // what do you hate about the manufacturer
                      Text(
                          LocaleKeys.whatDoYouHateAbout.tr() +
                              ' ' +
                              postingReviewModel.companyName,
                          style: TextStyleManager.s18w500),
                      TxtField(
                        textController: hatedAboutCompanyController,
                        hintText: LocaleKeys.cons.tr(),
                        keyboardType: TextInputType.text,
                        fillColor: ColorManager.textFieldGrey,
                        errorMsg:
                            LocaleKeys.hatedAboutManufacturerErrorMsg.tr(),
                        hasErrorMsg: true,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  )
                : SizedBox(),

            Row(
              children: [
                Text(LocaleKeys.enterInvitationCode.tr() + ':',
                    style: TextStyleManager.s18w500),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: context.isArabic
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Icon(
                            IconsManager.help,
                            size: 30.sp,
                          ),
                        )
                      : Icon(
                          IconsManager.help,
                          size: 30.sp,
                        ),
                  color: ColorManager.blue,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReferralCodeHelpDialog();
                      },
                    );
                  },
                )
              ],
            ),
            Align(
              alignment: context.isArabic
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: 140.w,
                  child: TxtField(
                    textController: invitationCodeController,
                    hintText: LocaleKeys.invitationCode.tr(),
                    keyboardType: TextInputType.text,
                    fillColor: ColorManager.textFieldGrey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            GradButton(
                text: Text(
                  LocaleKeys.postReview.tr(),
                  style: TextStyleManager.s18w700,
                ),
                icon: Icon(IconsManager.add, size: 28.sp),
                width: 360.w,
                reverseIcon: false,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class RatingEntry extends StatelessWidget {
  const RatingEntry({
    required this.title,
    required this.onRatingUpdate,
    Key? key,
  }) : super(key: key);

  final String title;
  final Function(double) onRatingUpdate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: SizedBox(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  title + ':',
                  style: TextStyleManager.s18w500,
                ),
              ),
              CustomRatingBar(onRatingUpdate: onRatingUpdate),
            ]),
      ),
    );
  }
}

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({
    required this.onRatingUpdate,
    Key? key,
  }) : super(key: key);

  final Function(double) onRatingUpdate;
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      itemSize: 35.sp,
      initialRating: 0,
      minRating: 1,
      glowRadius: 2,
      unratedColor: ColorManager.grey,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
      ratingWidget: RatingWidget(
        full: Icon(
          IconsManager.star,
          color: ColorManager.blue,
          size: 30.sp,
        ),
        half: Icon(
          IconsManager.starOutlined,
          color: ColorManager.black,
          size: 30.sp,
        ),
        empty: Icon(
          IconsManager.starOutlined,
          color: ColorManager.black,
          size: 30.sp,
        ),
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
