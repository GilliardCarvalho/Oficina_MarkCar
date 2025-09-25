import 'package:flutter/cupertino.dart';
import '../theme.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key, required this.title, required this.progress});
  final String title;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: frostedCard(),
      child: Row(
        children: [
          const Icon(CupertinoIcons.car_detailed, size: 36, color: kPrimaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    height: 8,
                    color: const Color(0xFFE7EBF3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(color: kPrimaryBlue),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(CupertinoIcons.chevron_forward, size: 20, color: CupertinoColors.systemGrey2),
        ],
      ),
    );
  }
}