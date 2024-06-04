import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/theme.dart';
import 'multi_select.dart';

class SingleSelect<T extends Object> extends StatefulWidget {
  final List<SelectItem<T>> items;
  final Function(T? selectedItem)? onSelect;

  SingleSelect({
    Key? key,
    required this.items,
    this.onSelect,
  }) : super(key: key);

  @override
  State<SingleSelect> createState() => _SingleSelectState<T>();
}

class _SingleSelectState<T extends Object> extends State<SingleSelect<T>> {
  final TextEditingController searchController = TextEditingController();
  T? selectedValue;

  List<SelectItem<T>> get filteredItems {
    final regex = RegExp(
      searchController.text,
      caseSensitive: false,
    );

    return widget.items
        .where(
          (item) => regex.hasMatch(item.label),
        )
        .toList();
  }

  @override
  void initState() {
    searchController.addListener(
      () {
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgWhite,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: TextField(
              controller: searchController,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: const UnderlineInputBorder(),
                isDense: true,
                hintText: 'Search...',
                hintStyle: TextStyle(fontSize: 12),
                suffixIcon: Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: filteredItems.map(
                (item) {
                  return InkWell(
                    onTap: () {
                      setState(
                        () {
                          selectedValue = item.value;
                        },
                      );

                      if (widget.onSelect != null) {
                        widget.onSelect!(selectedValue);
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.label,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.poppins(
                                color: selectedValue == item.value
                                    ? bgRed
                                    : basicBlack,
                              ),
                            ),
                          ),
                          if (selectedValue == item.value)
                            Icon(
                              Icons.check,
                              color: bgRed,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 24,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: bgGreyLite,
                  width: 1,
                ),
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bgRed,
              ),
              onPressed: () {
                Get.back();
                // setState(() {
                //   widget.selected.clear();
                //   widget.selected.addAll(checkedItems);
                // });
                // if (widget.onSelect != null) {
                //   widget.onSelect!(widget.selected);
                // }
              },
              child: Text(
                'Apply',
                style: TextStyle(fontWeight: FontWeight.w600, color: bgWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
