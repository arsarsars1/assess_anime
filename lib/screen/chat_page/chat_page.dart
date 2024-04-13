import 'package:assess_anime/controller/chat_controller.dart';
import 'package:assess_anime/core/colors/colors.dart';
import 'package:assess_anime/core/utils/extension.dart';
import 'package:assess_anime/screen/chat_page/widget/chat_widget.dart';
import 'package:assess_anime/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController editingController = TextEditingController();
  bool _fieldNotEmpty = false;

  @override
  void initState() {
    super.initState();
    editingController.addListener(_checkField1);
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  void _checkField1() {
    setState(() {
      _fieldNotEmpty = editingController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX(
        init: ChatController(),
        builder: (controller) {
          return Scaffold(
            body: controller.chatModel.value != null
                ? ListView.builder(
                    itemCount: controller.chatModel.value!.data.length,
                    itemBuilder: (context, index) {
                      return ChatWidget();
                    })
                : Center(
                    child: const Text(
                      "No Chat Found",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            bottomNavigationBar: Container(
              height: 100,
              decoration: BoxDecoration(
                color: CustomColors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Jane",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                          color: Colors.white),
                    ),
                  ],
                ),
                Row(children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff454545),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFieldCustom(
                        hintText: "Type a message...",
                        borderColor: Colors.transparent,
                        controller: editingController,
                        validator: (value) {
                          if (value.isNotNullOrEmpty()) {
                            return null;
                          } else {
                            return "Field is required";
                          }
                        },
                      ),
                    ),
                  ),
                  if (_fieldNotEmpty)
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle),
                    )
                ])
              ]),
            ),
          );
        },
      ),
    );
  }
}
