import 'package:flutter/material.dart';

class HomeSubscreen extends StatefulWidget {
  const HomeSubscreen({Key? key}) : super(key: key);

  @override
  State<HomeSubscreen> createState() => _HomeSubscreenState();
}

class _HomeSubscreenState extends State<HomeSubscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          bool? b = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              content: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('hello'),
              ),
            ),
          );
          print(b);
        },
        child: Text('CLICK'),
      ),
    );
  }
}
