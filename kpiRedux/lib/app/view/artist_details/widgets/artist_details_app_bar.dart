

import 'package:flutter/material.dart';

PreferredSizeWidget detailsAppBar(BuildContext context) {
  return AppBar(
    title: const Text('Artist Details'),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.of(context).pop(),
    ),
  );
}