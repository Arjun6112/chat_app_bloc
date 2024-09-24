import 'package:chat_app_bloc/features/auth/models/user_model.dart';
import 'package:chat_app_bloc/features/auth/providers/user_provider.dart';
import 'package:chat_app_bloc/features/home/widgets/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final UserModel? chattingWith;
  TextEditingController messageController = TextEditingController();
  var chats = [];
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  void connectToChat() {
    socket.connect();

    // Listening to chatMessage event from server
    socket.on('chatMessage', (data) {
      print('Message from ${data['sender']}: ${data['message']}');
      setState(() {
        chats.add(data['message']);
      });
    });

    // Sending a message

    // Handle disconnection
    socket.onDisconnect((_) => print('Disconnected from server'));
  }

  void sendMessage(String message) {
    print('Sending message: $message');
    socket.emit('chatMessage', {
      'sender': 'Arjun',
      'message': messageController.text,
    });
    setState(() {});
  }

  @override
  void initState() {
    chattingWith = Provider.of<UserProvider>(context, listen: false).user;
    connectToChat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            Badge(
                backgroundColor: Colors.white,
                textColor: Colors.black,
                label: const Text(
                    '1'), // Replace '3' with the actual number of notifications
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications, color: Colors.white),
                )),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ],
          title: Text(
            chattingWith!.name ?? 'Chat App',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey[800],
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user!.photoUrl ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhlkcYn1vUCIm0wYZgrbiA6HV3fftniQtk9Q&s'),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.network(
                            height: 30,
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpQC8fRvUkc_gTfctqryw4dR21HAt8yUfy2w&s")
                      ],
                    ),
                  ],
                ),
              ),
              for (int i = 1; i <= 15; i++) ...[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/$i.jpg'),
                  ),
                  title: Text('Friend $i',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.chat),
        // ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final isMe = index % 2 == 0;
                  return ChatBubble(
                    index: index,
                    message: chats[index],
                    isMe: isMe,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.video_call,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mic,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      )),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextField(
                      onSubmitted: (value) {
                        sendMessage(value);
                        chats.add(value);
                        messageController.clear();
                      },
                      controller: messageController,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        hintText: 'Type a message...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          gapPadding: 0,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        chats.add(messageController.text);
                        sendMessage(messageController.text);
                        messageController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
