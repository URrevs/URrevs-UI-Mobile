import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_question_model.dart';

class PostingQuestionSubscreen extends StatefulWidget {
  const PostingQuestionSubscreen({Key? key}) : super(key: key);

  @override
  State<PostingQuestionSubscreen> createState() =>
      _PostingQuestionSubscreenState();
}

class _PostingQuestionSubscreenState extends State<PostingQuestionSubscreen> {
  PostingQuestionModel postingQuestionModel =
      PostingQuestionModel(productName: '', question: '');

  late TextEditingController productNameController;
  late TextEditingController questionController;

  @override
  void initState() {
    super.initState();
    productNameController =
        TextEditingController(text: postingQuestionModel.productName);
    questionController =
        TextEditingController(text: postingQuestionModel.question);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('review posting'),
    );
  }
}
