import '/shared/theme.dart';
import '/ui/widgets/custom_textformfield.dart';
import '/ui/widgets/top_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class ChatUsPage extends StatefulWidget {
  const ChatUsPage({Key? key}) : super(key: key);

  @override
  _WhatsAppFormPageState createState() => _WhatsAppFormPageState();
}

class _WhatsAppFormPageState extends State<ChatUsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendToWhatsApp() async {
    String contact = "6285173044086";
    String name = _nameController.text;
    String email = _emailController.text;
    String message = _messageController.text;

    String text = "Nama: $name%0AEmail: $email%0APesan/Masalah: $message";

    String androidUrl = "whatsapp://send?phone=$contact&text=$text";
    String iosUrl = "https://wa.me/$contact?text=${Uri.encodeComponent(text)}";
    String webUrl =
        'https://api.whatsapp.com/send/?phone=$contact&text=${Uri.encodeComponent(text)}';

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      }
    } catch (e) {
      print('object');
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 35,
              ),
              TopSectionWidget(
                title: "Contact Us via WhatsApp",
                back: true,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      title: 'Nama',
                      hintText: 'Masukkan nama anda',
                    ),
                    SizedBox(height: 10),
                    CustomTextFormField(
                      controller: _emailController,
                      title: 'Email',
                      hintText: 'Masukkan Email anda',
                    ),
                    SizedBox(height: 25),
                    TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // label: Text("Pesan/Masalah"),
                        hintText: "Tuliskan pesan atau permasalahan anda",
                        hintStyle: mediumTextStyle,
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _sendToWhatsApp,
                      child: const Text('Send via Whatsapp'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
