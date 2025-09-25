import 'package:flutter/cupertino.dart';
import '../theme.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ("Troca de Óleo", "Toyota Corolla"),
      ("Revisão Completa", "Toyota Corolla"),
      ("Freios", "Toyota Corolla"),
      ("Alinhamento", "Toyota Corolla"),
    ];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Histórico de Manutenções"),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            // Botão "Exportar Histórico" no final da lista
            if (index == items.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  height: 56,
                  child: primaryButton(
                    "Exportar Histórico",
                    onPressed: () {},
                  ),
                ),
              );
            }

            final it = items[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: frostedCard(),
              child: ListTileCupertino(
                title: Text(
                  it.$1,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(it.$2),
                trailing: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 140),
                  child: CupertinoButton.filled(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onPressed: () {},
                    borderRadius: BorderRadius.circular(16),
                    child: const Text("Ver Detalhes"),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListTileCupertino extends StatelessWidget {
  const ListTileCupertino({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          if (leading != null) leading!,
          if (leading != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 16,
                  ),
                  child: title,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  DefaultTextStyle(
                    style: const TextStyle(
                      color: CupertinoColors.systemGrey,
                      fontSize: 14,
                    ),
                    child: subtitle!,
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
