import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:silahan_kawan/app/data/models/pengurus/item_pengurus_model.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/theme.dart';

class PengurusDetail extends StatelessWidget {
  const PengurusDetail({super.key, required this.data});
  final ItemPengurusModel? data;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: (data != null)
          ? CachedNetworkImage(
              imageUrl: '${ConstantsEndpoints.urlImgBanner}${data?.gambar}',
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: Container(
                  width: double.infinity,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/img/no_image.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ).animate().fadeIn(duration: 800.ms),
            )
          : Container(
              width: double.infinity,
            ),
      children: [
        Text(
          data?.nama ?? '',
          style: TextStyle(color: trueBlack, fontWeight: FontWeight.w600),
        ),
        Text(
          data?.jabatan ?? '',
          style: TextStyle(color: bgGrey, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
