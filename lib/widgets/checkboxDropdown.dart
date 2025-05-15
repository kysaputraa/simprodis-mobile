import 'package:flutter/material.dart';

class CheckboxDropdownFromArray extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onItemSelected;
  final String hintText;

  const CheckboxDropdownFromArray({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.hintText = 'Select Items',
  });

  @override
  State<CheckboxDropdownFromArray> createState() =>
      _CheckboxDropdownFromArrayState();
}

class _CheckboxDropdownFromArrayState extends State<CheckboxDropdownFromArray> {
  final Map<String, bool> _isSelected = {};
  List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize _isSelected map with all items set to false
    for (final item in widget.items) {
      _isSelected[item] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        // This callback is called when a PopupMenuItem is selected (not the checkbox)
        // We'll handle the selection directly in the itemBuilder.
      },
      onCanceled: () {
        // Update the selected items when the popup is closed
        final selected =
            _isSelected.keys.where((key) => _isSelected[key] == true).toList();
        if (_selectedItems.toString() != selected.toString()) {
          setState(() {
            _selectedItems = selected;
          });
          widget.onItemSelected(_selectedItems);
        }
      },
      itemBuilder: (BuildContext context) {
        return widget.items.map((item) {
          return PopupMenuItem<String>(
            value: item, // The value doesn't directly matter for checkbox
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isSelected[item] ?? false,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isSelected[item] = newValue!;
                        });
                      },
                    ),
                    Text(item),
                  ],
                );
              },
            ),
          );
        }).toList();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedItems.isEmpty
                  ? widget.hintText
                  : _selectedItems.join(', '),
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
