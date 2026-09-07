import 'package:flutter/material.dart';

Widget MyError(String error, {required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Icon(Icons.error, size: 50),
          Text("Error: $error"),
          FilledButton(
            onPressed: onPressed,
            child: Text("ម្តងទៀត"),
          ),
        ],
      ),
    );
  }