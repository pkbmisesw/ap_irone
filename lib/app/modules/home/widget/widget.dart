import 'package:flutter/material.dart';
import 'package:irone/theme.dart';
import 'package:remixicon/remixicon.dart';

class ExpandedParent extends StatelessWidget {
  final String tittle;
  final IconData icon;
  final Widget children;
  const ExpandedParent(
      {super.key,
      required this.tittle,
      required this.icon,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
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
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: const Color(0xFF0063F7),
              ),
              SizedBox(
                width: 11,
              ),
              Text(
                tittle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0063F7),
                ),
              ),
            ],
          ),
          children: [children],
        ),
      ),
    );
  }
}

class ExpandedChildren extends StatelessWidget {
  final String tittle;
  final String image;
  final Widget children;
  const ExpandedChildren(
      {super.key,
      required this.tittle,
      required this.image,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Container(
        padding: EdgeInsets.only(bottom: 9),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 24,
              width: 24,
            ),
            SizedBox(width: 10),
            Text(
              tittle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      children: [children],
    );
  }
}

class ExpandedTile extends StatelessWidget {
  const ExpandedTile(
      {super.key,
      required this.tittle,
      required this.image,
      this.onTap,
      this.withIcon = false});
  final String tittle;
  final String image;
  final Function()? onTap;
  final bool withIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(children: [
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              margin: EdgeInsets.only(left: 12),
              child: Container(
                padding: EdgeInsets.only(bottom: 9),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      image,
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        tittle,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    withIcon
                        ? Icon(
                            Remix.arrow_right_s_line,
                            color: bgRed,
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
