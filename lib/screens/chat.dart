import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
final _firestore=FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagetextcontroller=TextEditingController();

  final _auth=FirebaseAuth.instance;
  String? messagetext;
  @override
       void initState(){
    super.initState();
    getcurruser();
  }

  getcurruser(){
    try{
      final user=_auth.currentUser;
      if(user!=null){
        signedInUser=user;
        print("*****************");
        print(signedInUser.email);
      }

    }
    catch(e){
      print(e);

    }
  }


  /*void getmessages() async{
    final messages=await _firestore.collection('messages').get();

    for(var message in messages.docs)
      print (message.data);
  }*/
  void streammessages() async{
  await  for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 25),
            SizedBox(width: 10),
            Text('MessageMe')
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
  //  streammessages();

      _auth.signOut();
          Navigator.pop(context);

            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            messagestreambilider(),
   /* StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
      List<MessageLine>messageWidgets =[];
      if(!snapshot.hasData) {
        //add spinnerreturn
        return Center(
         child: CircularProgressIndicator(
         backgroundColor: Colors.blue,

         ),
          );
      }


    final messages = snapshot.data!.docs;
    for(var message in messages) {
    final messageText =message.get('text');
    final messageSender =message.get('sender');
    final messageWidget = MessageLine(sender:messageSender,text:messageText);
    messageWidgets.add(messageWidget);
    }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            children: messageWidgets,
          ),
        ); // Column
      },
    ), // StreamBuilder*/



            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
              controller: messagetextcontroller,

                  onChanged: (value) {
                  messagetext=value;



                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messagetextcontroller.clear();
                      print("##############");
                      print(messagetext);
                      print (signedInUser.email);
                      _firestore.collection('messages').add({
                        'text':messagetext,
                        'sender':signedInUser.email,
                        'time':FieldValue.serverTimestamp()
                      });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender,required this.isme, Key? key}) :super(key: key);
  final String? sender;
  final String? text;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(

        crossAxisAlignment:  isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,

        children: [
          Text('$sender',
      style: TextStyle(fontSize: 12, color: Colors.yellow[900]),

    ),
          Material(
            elevation: 5,
           borderRadius: isme?
           BorderRadius.only(
            topLeft: Radius.circular(30),
              bottomLeft:Radius.circular(30),
              bottomRight:Radius.circular(30),
           )

           :BorderRadius.only(
               topRight: Radius.circular(30),
               bottomLeft:Radius.circular(30),
               bottomRight:Radius.circular(30),
           ),
            color: isme ? Colors.blue[800] :Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15, color: isme ? Colors.white : Colors.black45), //
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class messagestreambilider extends StatelessWidget {
  const messagestreambilider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine>messageWidgets =[];
        if(!snapshot.hasData) {
          //add spinnerreturn
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,

            ),
          );
        }


        final messages = snapshot.data!.docs.reversed;
        for(var message in messages) {
          final messageText =message.get('text');
          final messageSender =message.get('sender');
          final currentuser=signedInUser.email;
          if(currentuser == messageSender) {
             // the code of the message from the signed in user
          }
          final messageWidget = MessageLine(
              sender:messageSender,
              text:messageText,
              isme:currentuser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            children: messageWidgets,
          ),
        ); // Column
      },
    ); // StreamBuilder

  }
}
