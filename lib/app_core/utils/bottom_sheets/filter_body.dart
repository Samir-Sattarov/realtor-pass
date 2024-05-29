import 'package:flutter/material.dart';

class FilterBody extends StatefulWidget {
  final Function(
      int type,
      int maxPrice,
      int minPrice,
      int rooms,
      int square,
      String seller,
      String repair,
      int bathrooms,
      int floors,
      String houseMaterial,
      String windows) onConfirm;
  final int type;
  const FilterBody({super.key, required this.onConfirm, required this.type});

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
