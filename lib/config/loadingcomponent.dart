import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Isloading extends StatelessWidget {
  const Isloading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator()
        // CupertinoActivityIndicator(radius: 20),
        );
  }
}
