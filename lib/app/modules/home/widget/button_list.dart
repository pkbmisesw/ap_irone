import 'package:flutter/material.dart';
import 'package:silahan_kawan/theme.dart';

class SettingData {
  final String image;
  final String title;
  final Function()? onTap;
  final List<SettingData> children;

  SettingData({
    required this.image,
    required this.title,
    this.onTap,
    required this.children,
  });
}

class UnExpandableRecords extends StatelessWidget {
  final SettingData _data;

  const UnExpandableRecords({required SettingData data}) : _data = data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 5,
          ),
        ],
      ),
      child: InkWell(
        onTap: _data.onTap ?? () {},
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Row(
            children: [
              Image.asset(
                _data.image,
                height: 20,
                width: 20,
              ),
              SizedBox(width: 11),
              Expanded(
                child: Text(
                  _data.title,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: bgRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
