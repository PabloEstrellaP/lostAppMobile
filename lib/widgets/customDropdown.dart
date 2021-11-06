import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  
  final String value;
  final void Function(String?)? function;
  final List<String> items;
  final bool hasPrefix;

  const CustomDropdown({Key? key, 
    required this.value,
    required this.function,
    required this.items,
    this.hasPrefix = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.only( top: 5, left: 30, bottom: 5, right: 10 ),
      margin: EdgeInsets.only( bottom: 20, top: 15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity( 0.3 ),
            offset: Offset(0, 5),
            blurRadius: 5
          )
        ]
      ),
      child: DropdownButton<String>(
        underline: Container(
          height: 2,
          color: Colors.grey[50],
        ),
        value: this.value,
        onChanged: this.function,
        items: this.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: this.hasPrefix ? int.parse(value) == 1 ? Text('$value año') : Text('$value años') : Text(value),
          );
        }).toList(),
      ),
    );
  }
}