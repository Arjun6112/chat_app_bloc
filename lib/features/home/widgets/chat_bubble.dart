import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble(
      {super.key,
      required this.index,
      required this.isMe,
      required this.message});
  bool isMe;
  int index;
  String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            const CircleAvatar(
              radius: 16,
              backgroundImage:
                  NetworkImage('https://randomuser.me/api/portraits/men/8.jpg'),
            ),
          const SizedBox(width: 8),
          IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isMe ? Colors.teal : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                maxLines: 8,
                message,
                style: GoogleFonts.poppins(
                  color: isMe ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 8),
          if (isMe)
            const CircleAvatar(
              radius: 16,
              backgroundImage:
                  NetworkImage('https://randomuser.me/api/portraits/men/7.jpg'),
            ),
        ],
      ),
    );
  }
}
