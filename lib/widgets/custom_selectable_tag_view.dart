import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomSelectableTagView extends StatefulWidget {
  const CustomSelectableTagView(
      {super.key, required this.onclick, required this.text});

  final void Function(String text, bool isSelected) onclick;
  final String text;

  @override
  State<CustomSelectableTagView> createState() =>
      _CustomSelectableTagViewState();
}

class _CustomSelectableTagViewState extends State<CustomSelectableTagView> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onclick(widget.text, isSelected);
      },
      child: Container(
        padding: context.paddingLow,
        decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 2)),
        child: Text(widget.text,
            style: isSelected ? _selectedTextStyle() : _notSelectedTextStyle()),
      ),
    );
  }

  TextStyle _notSelectedTextStyle() {
    return Theme.of(context)
        .textTheme
        .bodyMedium!
        .merge(TextStyle(color: Theme.of(context).primaryColor));
  }

  TextStyle _selectedTextStyle() {
    return Theme.of(context)
        .textTheme
        .bodyMedium!
        .merge(const TextStyle(color: Colors.white));
  }
}
