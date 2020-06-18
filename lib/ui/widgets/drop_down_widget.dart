import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown({Key key, this.items, this.onSelecteItem, this.selectedItem})
      : super(key: key);
  final List<String> items;
  final Function(int, String) onSelecteItem;
  final String selectedItem;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String dropdownValue = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items != null) {
      var index = widget.items.indexOf(widget.selectedItem);
      if (index == -1) {
        index = 0;
      }
      dropdownValue = widget.items.length > 0 ? widget.items[index] : '';
    }
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Color.fromARGB(255, 44, 44, 44),
        fontSize: 16,
      ),
      underline: Container(
        color: Colors.transparent,
      ),
      onChanged: (String newValue) {
        var index = widget.items.indexOf(newValue);
        widget.onSelecteItem(index, newValue);
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
