import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import '../theme.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({
    super.key,
    required this.title,
    this.date,
    this.time,
    this.vehicle = "Toyota Corolla",
    this.plate = "ABC-1234",
  });

  final String title;
  final DateTime? date;
  final TimeOfDay? time;
  final String vehicle;
  final String plate;

  Event _buildEvent() {
    final d = date ?? DateTime.now();
    final t = time ?? const TimeOfDay(hour: 10, minute: 0);
    final start = DateTime(d.year, d.month, d.day, t.hour, t.minute);
    final end = start.add(const Duration(hours: 1));
    return Event(
      title: 'Agendamento: $title',
      description: 'Veículo: $vehicle • Placa: $plate',
      location: 'Mark Car - Centro Automotivo - Rua Roberto Ziemann, 5312 - Amizade - Jaraguá do Sul',
      startDate: start,
      endDate: end,
      allDay: false,
      iosParams: const IOSParams(reminder: Duration(minutes: 30)),
      androidParams: const AndroidParams(emailInvites: []),
    );
  }

  // Formata para o Google Calendar (UTC -> YYYYMMDDTHHMMSSZ)
  String _fmtGCal(DateTime dt) {
    final u = dt.toUtc();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${u.year}${two(u.month)}${two(u.day)}T${two(u.hour)}${two(u.minute)}00Z';
  }

  Future<void> _addToCalendar(BuildContext context) async {
    final e = _buildEvent();
    // tenta pelo app nativo
    final ok = await Add2Calendar.addEvent2Cal(e);
    if (ok) return;

    // fallback: Google Calendar na web
    final start = e.startDate;
    final end = e.endDate ?? e.startDate.add(const Duration(hours: 1));
    final gcal = Uri.https('calendar.google.com', '/calendar/render', {
      'action': 'TEMPLATE',
      'text': e.title,
      'details': e.description ?? '',
      'location': e.location ?? '',
      'dates': '${_fmtGCal(start)}/${_fmtGCal(end)}',
    });

    final launched = await launchUrl(gcal, mode: LaunchMode.externalApplication);
    if (!launched) {
      await showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Não foi possível abrir o calendário'),
          content: const Text('Tente novamente ou instale um app de calendário.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = date ?? DateTime(2025, 9, 25);
    final t = time ?? const TimeOfDay(hour: 10, minute: 0);
    final dateStr = "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}";
    final timeStr = "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Detalhes do Serviço")),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: frostedCard(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(CupertinoIcons.check_mark_circled_solid, color: kPrimaryBlue),
                      SizedBox(width: 8),
                      Text("Agendamento Confirmado!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _kv("Data", dateStr),
                  _kv("Horário", timeStr),
                  _kv("Serviço", title),
                  _kv("Veículo", vehicle),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: frostedCard(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Detalhes do Veículo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  _kv("Modelo", "Corolla"),
                  _kv("Placa", plate),
                  _kv("Ano", "2023"),
                  _kv("Última Revisão", "15/03/2025"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton.filled(
                    child: const Text("Adicionar ao Calendário"),
                    onPressed: () => _addToCalendar(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CupertinoButton(
                    child: const Text("Voltar ao Início"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _kv(String k, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(width: 140, child: Text("$k:", style: const TextStyle(color: CupertinoColors.systemGrey))),
        Expanded(child: Text(v, style: const TextStyle(fontWeight: FontWeight.w600))),
      ],
    ),
  );
}
