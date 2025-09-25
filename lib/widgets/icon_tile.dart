import 'package:flutter/cupertino.dart';
import '../theme.dart';

class IconTile extends StatelessWidget {
  const IconTile({super.key, required this.icon, required this.title, this.subtitle, this.onTap, this.active = true});
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: active ? 1 : 0.5,
      child: Container(
        decoration: frostedCard(22),
        child: CupertinoButton(
          padding: const EdgeInsets.all(16),
          onPressed: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: kPrimaryBlue),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!, style: const TextStyle(fontSize: 13, color: CupertinoColors.systemGrey)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}