import '../models/message_model.dart';

import '../models/user_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Widget _buildMessage(Message message, bool isMe, BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          margin: isMe
              ? EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: MediaQuery.of(context).size.width * 0.25)
              : const EdgeInsets.only(top: 8.0, bottom: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: isMe
                ? Theme.of(context).colorScheme.secondary
                : const Color(0xFFFFEFEE),
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.time,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                message.text,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        if (!isMe)
          IconButton(
            icon: message.isLiked
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            iconSize: 30.0,
            color: message.isLiked
                ? Theme.of(context).colorScheme.primary
                : Colors.blueGrey,
            onPressed: () {},
          )
      ],
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      color: Colors.white,
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Enter your message..",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[100],
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
          prefixIcon: IconButton(
            icon: const Icon(
              Icons.emoji_emotions,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(top: 15.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final Message message = messages[index];
                    bool isMe = message.sender.id == currentUser.id;
                    return _buildMessage(message, isMe, context);
                  },
                ),
              ),
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }
}
