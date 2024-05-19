import 'package:flutter/material.dart';

import '../../shared/cards.dart';

class CardErrorItem extends StatelessWidget {
  final void Function()? onPressed;

  const CardErrorItem({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Cards.filled(
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tidak dapat memuat halaman',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('Maaf terdapat kesalahan sistem'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onPressed,
              child: const Text(
                'Coba Lagi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
