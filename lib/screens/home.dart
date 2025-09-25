import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show CircleAvatar;
import '../theme.dart';
import '../widgets/widgets.dart';
import 'schedule.dart';
import 'history.dart';
import 'contact.dart';
import 'service_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill), label: "Home"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_grid_2x2), label: "Services"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled_solid), label: ""),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.clock), label: "History"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: "Perfil"),
        ],
      ),
      tabBuilder: (context, index) {
        if (index == 0) return _HomeTab();
        if (index == 1) return _ServicesTab();
        if (index == 2) return CupertinoTabView(builder: (_) => const ScheduleScreen());
        if (index == 3) return CupertinoTabView(builder: (_) => const HistoryScreen());
        return CupertinoTabView(builder: (_) => const ContactScreen());
      },
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (_) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Mark Car'),
          trailing: CircleAvatar(
            radius: 14,
            backgroundColor: CupertinoColors.systemGrey2,
            child: const Icon(
              CupertinoIcons.person_alt,
              size: 16,
              color: CupertinoColors.white,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                const Text(
                  'Bem-vindo, Carlos',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                const VehicleCard(
                  title: 'Seu veículo: Toyota Corolla',
                  progress: 0.6,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    children: [
                      IconTile(
                        icon: CupertinoIcons.calendar,
                        title: 'Agendar',
                        subtitle: 'Serviço',
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => const ScheduleScreen(),
                            ),
                          );
                        },
                      ),
                      const IconTile(
                        icon: CupertinoIcons.shield_lefthalf_fill,
                        title: 'Serviços',
                        subtitle: 'Disponíveis',
                      ),
                      IconTile(
                        icon: CupertinoIcons.person_2_fill,
                        title: 'Meus',
                        subtitle: 'Agendamentos',
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => const HistoryScreen(),
                            ),
                          );
                        },
                      ),
                      IconTile(
                        icon: CupertinoIcons.doc_text,
                        title: 'Histórico',
                        subtitle: 'Manutenções',
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => const HistoryScreen(),
                            ),
                          );
                        },
                      ),
                      IconTile(
                        icon: CupertinoIcons.location_solid,
                        title: 'Contato/',
                        subtitle: 'Localização',
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => const ContactScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _ServicesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Serviços")),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _serviceTile(context, "Troca de Óleo"),
          _serviceTile(context, "Revisão Completa"),
          _serviceTile(context, "Balanceamento"),
          _serviceTile(context, "Alinhamento"),
        ],
      ),
    );
  }

  Widget _serviceTile(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: frostedCard(),
      child: CupertinoListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        leading: const Icon(CupertinoIcons.gear_solid, color: kPrimaryBlue),
        trailing: const Icon(CupertinoIcons.chevron_forward),
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (_) => ServiceDetailsScreen(title: title)));
        },
      ),
    );
  }
}

class CupertinoListTile extends StatelessWidget {
  const CupertinoListTile({super.key, required this.title, this.leading, this.trailing, this.onTap});
  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      onPressed: onTap,
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 12)],
          Expanded(child: DefaultTextStyle(style: const TextStyle(color: CupertinoColors.black, fontSize: 16), child: title)),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}