import 'package:flutter/cupertino.dart';
import '../theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // Abre conversa no WhatsApp com mensagem inicial
  Future<void> _abrirWhatsApp(BuildContext context) async {
    const phone = '5547999999999'; // DDI+DDD+numero (sem espaços/traços)
    final text = Uri.encodeComponent('Olá, gostaria de agendar um serviço.');
    final uri = Uri.parse('https://wa.me/$phone?text=$text');

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      await showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('WhatsApp não encontrado'),
          content: const Text('Instale o WhatsApp ou verifique o número.'),
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

  // Abre o discador do telefone
  Future<void> _ligar(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: '47991015312'); // seu número aqui
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      await showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Não foi possível abrir o telefone'),
          content: const Text('Verifique as permissões ou tente novamente.'),
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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Contato/Localização"),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              decoration: frostedCard(),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    color: const Color(0xFFDDE7FF),
                    child: const Center(
                      child: Icon(CupertinoIcons.map_pin_ellipse, size: 64, color: kPrimaryBlue),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rua Roberto Ziemann, 3151 - Amizade - Jaraguá do Sul",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                        SizedBox(height: 4),
                        Text("Santa Catarina, Brasil", style: TextStyle(color: CupertinoColors.systemGrey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _infoRow(CupertinoIcons.phone, "(47) 9 9999-9999"),
            _infoRow(CupertinoIcons.mail, "contato@markcar.com.br"),
            _infoRow(CupertinoIcons.time, "Seg-Sex: 8h às 18h | Sáb: 8h às 12h"),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    child: const Text("Ligar"),
                    onPressed: () => _ligar(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CupertinoButton.filled(
                    child: const Text("WhatsApp"),
                    onPressed: () => _abrirWhatsApp(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: frostedCard(),
      child: Row(
        children: [
          Icon(icon, color: kPrimaryBlue),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
