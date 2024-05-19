import 'package:flutter/material.dart';
import 'package:irone/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:remixicon/remixicon.dart';

class StepperStatus extends StatelessWidget {
  const StepperStatus({
    super.key,
    required this.phaseState,
    required this.firstTittle,
    required this.secondTittle,
    required this.finishTittle,
    this.extendetTittle,
  });
  final int phaseState;
  final String firstTittle;
  final String secondTittle;
  final String finishTittle;
  final String? extendetTittle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffB00020),
                  ),
                  child: Icon(
                    phaseState > 0 ? Remix.check_line : Remix.number_1,
                    size: phaseState > 0 ? 14 : 12,
                    color: Colors.white,
                  ),
                ),
                4.widthBox,
                Text(
                  firstTittle,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: phaseState == 0 ? Color(0xffB00020) : Colors.grey),
                )
              ],
            ),
            16.widthBox,
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: phaseState > 0 ? Color(0xffB00020) : Colors.grey,
                  ),
                  child: Icon(
                    phaseState > 1 ? Remix.check_line : Remix.number_2,
                    size: phaseState > 1 ? 14 : 12,
                    color: Colors.white,
                  ),
                ),
                4.widthBox,
                Text(
                  secondTittle,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: phaseState == 1 ? Color(0xffB00020) : Colors.grey),
                )
              ],
            ),
            16.widthBox,
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: phaseState > 1 ? Color(0xffB00020) : Colors.grey,
                  ),
                  child: Icon(
                    Remix.number_3,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
                4.widthBox,
                Text(
                  finishTittle,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: phaseState > 2 ? Color(0xffB00020) : Colors.grey),
                )
              ],
            ),
            extendetTittle != null
                ? Row(
                    children: [
                      16.widthBox,
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              phaseState == 3 ? Color(0xffB00020) : Colors.grey,
                        ),
                        child: Icon(
                          Remix.number_4,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      4.widthBox,
                      Text(
                        extendetTittle ?? '',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: phaseState == 3
                                ? Color(0xffB00020)
                                : Colors.grey),
                      )
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
