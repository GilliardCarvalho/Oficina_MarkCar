import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import '../theme.dart';
import 'service_details.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final nameCtrl = TextEditingController();
  final plateCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  DateTime? date;
  TimeOfDay? time;
  String selectedService = "Troca de Óleo";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Agendar Serviço")),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _field("Nome / WhatsApp", nameCtrl),
            _field("Placa do Veículo", plateCtrl),
            _field("Marca/Modelo", modelCtrl),
            const SizedBox(height: 4),
            const Text("Serviço", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ["Troca de Óleo", "Revisão Completa", "Balanceamento", "Alinhamento"].map((s) {
                final active = s == selectedService;
                return CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  onPressed: () => setState(() => selectedService = s),
                  color: active ? CupertinoColors.white : CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  child: Text(s, style: TextStyle(
                    color: active ? kPrimaryBlue : CupertinoColors.black,
                    fontWeight: FontWeight.w700,
                  )),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            const Text("Data & Horário", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _pickerButton("Data", onTap: () async {
                  final now = DateTime.now();
                  await showCupertinoModalPopup(context: context, builder: (_) {
                    DateTime temp = date ?? now;
                    return _pickerSheet(
                      CupertinoDatePicker(
                        minimumDate: now,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (d) => temp = d,
                      ),
                      onOk: () => setState(() => date = temp),
                    );
                  });
                }, value: date == null ? null : "${date!.day.toString().padLeft(2,'0')}/${date!.month.toString().padLeft(2,'0')}/${date!.year}")),
                const SizedBox(width: 12),
                Expanded(child: _pickerButton("Horário", onTap: () async {
                  await showCupertinoModalPopup(context: context, builder: (_) {
                    var h = time?.hour ?? 10;
                    var m = time?.minute ?? 0;
                    return _pickerSheet(
                      CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        initialTimerDuration: Duration(hours: h, minutes: m),
                        onTimerDurationChanged: (d) {
                          h = d.inHours;
                          m = d.inMinutes % 60;
                        },
                      ),
                      onOk: () => setState(() => time = TimeOfDay(hour: h, minute: m)),
                    );
                  });
                }, value: time == null ? null : "${time!.hour.toString().padLeft(2,'0')}:${time!.minute.toString().padLeft(2,'0')}")),
              ],
            ),
            const SizedBox(height: 18),
            const Text("Horários Disponíveis", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            _availabilityBar(),
            const SizedBox(height: 18),
            primaryButton("Confirmar Agendamento", onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (_) => ServiceDetailsScreen(
                title: selectedService,
                date: date,
                time: time,
                vehicle: modelCtrl.text.isEmpty ? "Toyota Corolla" : modelCtrl.text,
                plate: plateCtrl.text.isEmpty ? "ABC-1234" : plateCtrl.text,
              )));
            }),
          ],
        ),
      ),
    );
  }

  Widget _field(String placeholder, TextEditingController c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE1E6EF))),
      child: CupertinoTextField(
        controller: c,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        placeholder: placeholder,
        decoration: const BoxDecoration(color: CupertinoColors.white),
      ),
    );
  }

  Widget _pickerButton(String label, {required VoidCallback onTap, String? value}) {
    return Container(
      decoration: BoxDecoration(color: CupertinoColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE1E6EF))),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        onPressed: onTap,
        child: Row(
          children: [
            Text(label, style: const TextStyle(color: CupertinoColors.systemGrey)),
            const Spacer(),
            Text(value ?? "Selecionar", style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 6),
            const Icon(CupertinoIcons.chevron_down, size: 18, color: CupertinoColors.systemGrey2),
          ],
        ),
      ),
    );
  }

  Widget _pickerSheet(Widget child, {required VoidCallback onOk}) {
    return Container(
      height: 260,
      color: CupertinoColors.systemGroupedBackground,
      child: Column(
        children: [
          Expanded(child: child),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(child: const Text("Cancelar"), onPressed: () => Navigator.pop(context)),
              CupertinoButton(child: const Text("OK", style: TextStyle(fontWeight: FontWeight.w700)), onPressed: () { Navigator.pop(context); onOk(); }),
            ],
          )
        ],
      ),
    );
  }

  Widget _availabilityBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: frostedCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            _Legend(color: Color(0xFF21C46B), text: "Livre"),
            SizedBox(width: 12),
            _Legend(color: Color(0xFFFFC107), text: "Médio"),
            SizedBox(width: 12),
            _Legend(color: Color(0xFFBDBDBD), text: "Ocupado"),
          ]),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, c) {
              final width = c.maxWidth;
              return SizedBox(
                height: 12,
                child: Stack(
                  children: [
                    _segment(0, width * 0.35, const Color(0xFF21C46B)),
                    _segment(width * 0.35, width * 0.25, const Color(0xFFFFC107)),
                    _segment(width * 0.60, width * 0.40, const Color(0xFFBDBDBD)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _segment(double left, double w, Color color) {
    return Positioned(left: left, right: null, child: Container(width: w, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8))));
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.text});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 14, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(7))),
      const SizedBox(width: 6),
      Text(text, style: const TextStyle(fontSize: 14)),
    ]);
  }
}