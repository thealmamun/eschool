// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:eschool/global/globals.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AdminChat extends StatefulWidget {
//   @override
//   ListViewHome createState() {
//     return new ListViewHome();
//   }
// }
//
// class ListViewHome extends State<AdminChat> {
//   List<String> titles = ["List 1", "List 2", "List 3"];
//   final subtitles = [
//     "Here is list 1 subtitle",
//     "Here is list 2 subtitle",
//     "Here is list 3 subtitle"
//   ];
//   final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
//   bool isClicked = false;
//   TextEditingController? chatController;
//   String? _displayName;
//   String? message;
//   String? receiverUid;
//   String? receiverDisplayName;
//   String? receiverUserType;
//   String? receiverPhotoUrl;
//   String? myUid;
//
//   String? name, photoUrl, displayName, email;
//
//   List<String>? uidList = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     chatController = TextEditingController();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       Globals.userRef.doc(Globals.auth.currentUser!.uid).get().then((value) {
//         setState(() {
//           _displayName = value['displayName'];
//           photoUrl = value['photoUrl'];
//           email = value['email'];
//           myUid = value['uid'];
//         });
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     chatController!.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   // height: 200,
//                   width: MediaQuery.of(context).size.width / 5,
//                   padding: EdgeInsets.all(20),
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: Globals.userRef!
//                         .orderBy('createdAt', descending: true)
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       print(snapshot.data?.docs.length);
//                       if (snapshot.hasError) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//
//                       return new ListView.builder(
//                         physics: AlwaysScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (context, index) {
//                           var item = snapshot.data!.docs[index];
//                           var email = snapshot.data!.docs[index]['email'];
//                           var uid = snapshot.data!.docs[index]['uid'];
//                           var displayName =
//                               snapshot.data!.docs[index]['displayName'];
//                           var bio = snapshot.data!.docs[index]['bio'];
//                           var photoUrl = snapshot.data!.docs[index]['photoUrl'];
//                           var userType = snapshot.data!.docs[index]['userType'];
//                           var classValue = snapshot.data!.docs[index]['class'];
//                           uidList!.add(uid.toString());
//                           print(uidList);
//                           print('uid');
//                           print(uid);
//
//                           if (uid == Globals.auth.currentUser!.uid) {
//                             return Container();
//                           } else
//                             return Card(
//                                 child: Container(
//                               // height: 100,
//                               width: MediaQuery.of(context).size.width / 5,
//                               child: ListTile(
//                                 onTap: () {
//                                   setState(() {
//                                     isClicked = true;
//                                     receiverUid = uid;
//                                     receiverPhotoUrl = photoUrl;
//                                     receiverUserType = userType;
//                                     receiverDisplayName = displayName;
//                                     getMessages(receiverUid.toString());
//                                     print(receiverUid);
//                                   });
//                                   Scaffold.of(context).showSnackBar(SnackBar(
//                                     content: Text(
//                                         receiverUid.toString() + ' pressed!'),
//                                   ));
//                                 },
//                                 title: Text(displayName),
//                                 subtitle: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(userType),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Text(
//                                         bio,
//                                         textAlign: TextAlign.start,
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 leading: CircleAvatar(
//                                     backgroundImage: NetworkImage(photoUrl)),
//                                 // trailing: Icon(icons[index])
//                               ),
//                             ));
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 isClicked
//                     ? Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.all(20),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width / 3,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     child: ListTile(
//                                       onTap: () {
//                                         setState(() {
//                                           // isClicked = true;
//                                         });
//                                       },
//                                       title:
//                                           Text(receiverDisplayName.toString()),
//                                       subtitle:
//                                           Text(receiverUserType.toString()),
//                                       leading: CircleAvatar(
//                                           backgroundImage: NetworkImage(
//                                               receiverPhotoUrl.toString())),
//                                       // trailing: Icon(icons[index])
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Colors.grey.shade100),
//                                   child: Container(
//                                     // padding: EdgeInsets.all(20),
//                                     height:
//                                         MediaQuery.of(context).size.height / 2,
//                                     width:
//                                         MediaQuery.of(context).size.width / 2,
//                                     child: StreamBuilder<QuerySnapshot>(
//                                       stream:
//                                           // getMessages(receiverUid.toString()),
//                                           FirebaseFirestore.instance
//                                               .collection(
//                                                   'chats/$myUid/messages')
//                                               .orderBy('createdAt',
//                                                   descending: false)
//                                               .snapshots(),
//                                       builder: (BuildContext context,
//                                           AsyncSnapshot<QuerySnapshot>
//                                               snapshot) {
//                                         if (snapshot.hasError) {
//                                           return Center(
//                                               child:
//                                                   Text('Something went wrong'));
//                                         }
//
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return Center(child: Text("Loading"));
//                                         }
//
//                                         return new ListView.builder(
//                                           physics:
//                                               AlwaysScrollableScrollPhysics(),
//                                           shrinkWrap: true,
//                                           itemCount: snapshot.data!.docs.length,
//                                           itemBuilder: (BuildContext context,
//                                               int index) {
//                                             var item =
//                                                 snapshot.data!.docs[index];
//                                             var newIndex = index + 1;
//                                             var chatMessage = snapshot
//                                                 .data!.docs[index]['message'];
//
//                                             final DateTime now = DateTime.now();
//                                             final DateTime timestamp = (snapshot
//                                                         .data!.docs[index]
//                                                     ['createdAt'] as Timestamp)
//                                                 .toDate();
//                                             final DateFormat formatter =
//                                                 DateFormat('yyyy-MM-dd hh:mm');
//                                             final String createdAt =
//                                                 formatter.format(timestamp);
//                                             print(createdAt);
//
//                                             print(chatMessage);
//
//                                             bool isMe = snapshot.data!
//                                                     .docs[index]['idUser'] ==
//                                                 Globals.auth.currentUser!.uid;
//
//                                             return Padding(
//                                               padding: EdgeInsets.all(20),
//                                               child: Container(
//                                                 child: isMe
//                                                     ? Column(
//                                                         children: [
//                                                           Row(
//                                                             children: [
//                                                               Expanded(
//                                                                   flex: 4,
//                                                                   child:
//                                                                       Container()),
//                                                               Expanded(
//                                                                   flex: 5,
//                                                                   child:
//                                                                       Container(
//                                                                     decoration:
//                                                                         BoxDecoration(
//                                                                       color: Colors
//                                                                           .blueAccent,
//                                                                       borderRadius: BorderRadius.only(
//                                                                           topRight: Radius.circular(
//                                                                               10.0),
//                                                                           bottomRight: Radius.circular(
//                                                                               0.0),
//                                                                           topLeft: Radius.circular(
//                                                                               10.0),
//                                                                           bottomLeft:
//                                                                               Radius.circular(10.0)),
//                                                                     ),
//                                                                     child:
//                                                                         Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(
//                                                                               8.0),
//                                                                       child:
//                                                                           Text(
//                                                                         chatMessage,
//                                                                         style: GoogleFonts.redHatDisplay(
//                                                                             color:
//                                                                                 Colors.white),
//                                                                       ),
//                                                                     ),
//                                                                   )),
//                                                             ],
//                                                           ),
//                                                           Align(
//                                                               alignment: Alignment
//                                                                   .centerRight,
//                                                               child: Text(
//                                                                 createdAt
//                                                                     .toString(),
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black38,
//                                                                     fontSize:
//                                                                         8),
//                                                               ))
//                                                         ],
//                                                       )
//                                                     : Column(
//                                                         children: [
//                                                           Row(
//                                                             children: [
//                                                               Expanded(
//                                                                   flex: 5,
//                                                                   child:
//                                                                       Container(
//                                                                     decoration:
//                                                                         BoxDecoration(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       borderRadius: BorderRadius.only(
//                                                                           topRight: Radius.circular(
//                                                                               10.0),
//                                                                           bottomRight: Radius.circular(
//                                                                               10.0),
//                                                                           topLeft: Radius.circular(
//                                                                               10.0),
//                                                                           bottomLeft:
//                                                                               Radius.circular(0.0)),
//                                                                     ),
//                                                                     child:
//                                                                         Padding(
//                                                                       padding:
//                                                                           const EdgeInsets.all(
//                                                                               8.0),
//                                                                       child:
//                                                                           Text(
//                                                                         chatMessage,
//                                                                         style: GoogleFonts.redHatDisplay(
//                                                                             color:
//                                                                                 Colors.black87),
//                                                                       ),
//                                                                     ),
//                                                                   )),
//                                                               Expanded(
//                                                                   flex: 4,
//                                                                   child:
//                                                                       Container()),
//                                                             ],
//                                                           ),
//                                                           Align(
//                                                               alignment: Alignment
//                                                                   .centerLeft,
//                                                               child: Text(
//                                                                 createdAt
//                                                                     .toString(),
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black38,
//                                                                     fontSize:
//                                                                         8),
//                                                               ))
//                                                         ],
//                                                       ),
//                                               ),
//                                             );
//                                           },
//
//                                           // children: snapshot.data!.docs
//                                           //     .map((DocumentSnapshot document) {
//                                           //   return new ListTile(
//                                           //     title: new Text(document.data()?['category']),
//                                           //     // subtitle: new Text(document.data()?['subject']),
//                                           //   );
//                                           // }).toList(),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.all(20.0),
//                                   width: MediaQuery.of(context).size.width / 2,
//                                   decoration:
//                                       BoxDecoration(color: Colors.white12),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Expanded(
//                                         flex: 10,
//                                         child: Container(
//                                           height: 50,
//                                           // width: MediaQuery.of(context)
//                                           //         .size
//                                           //         .width *
//                                           //     .5,
//                                           child: TextField(
//                                             controller: chatController,
//                                             onChanged: (value) {
//                                               message = value;
//                                             },
//                                             decoration: InputDecoration(
//                                                 hintText: 'Write Something.. ',
//                                                 border: OutlineInputBorder()),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                             height: 50,
//                                             width: 50,
//                                             decoration: BoxDecoration(
//                                                 color: Colors.indigo,
//                                                 shape: BoxShape.circle),
//                                             child: IconButton(
//                                                 onPressed: () async {
//                                                   await uploadMessage(
//                                                       receiverUid.toString(),
//                                                       message.toString());
//                                                 },
//                                                 icon: Icon(
//                                                   Icons.send,
//                                                   color: Colors.white,
//                                                 )),
//                                           ))
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     : Expanded(
//                         child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: DottedBorder(
//                           borderType: BorderType.RRect,
//                           radius: Radius.circular(12),
//                           padding: EdgeInsets.all(20),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.all(Radius.circular(12)),
//                             child: Container(
//                               height: MediaQuery.of(context).size.height * .7,
//                               width: MediaQuery.of(context).size.width,
//                               color: Colors.grey.shade300,
//                               child: Center(
//                                 child: Text(
//                                   'Please select a user to start chat.',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future uploadMessage(String idUser, String message) async {
//     final refMessages =
//         FirebaseFirestore.instance.collection('chats/$myUid/messages');
//     refMessages.add({
//       'idUser': Globals.auth.currentUser!.uid,
//       'urlAvatar': "myUrlAvatar",
//       'username': _displayName,
//       'message': message,
//       'createdAt': FieldValue.serverTimestamp()
//     }).then((value) {
//       print('Message sent successfully');
//       chatController!.clear();
//       message = '';
//     });
//   }
//
//   Stream<QuerySnapshot> getMessages(String idUser) => FirebaseFirestore.instance
//       .collection('chats/$myUid/messages')
//       .orderBy('createdAt', descending: true)
//       .snapshots();
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eschool/global/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class AdminChat extends StatefulWidget {
  @override
  ListViewHome createState() {
    return new ListViewHome();
  }
}

class ListViewHome extends State<AdminChat> {
  List<String> titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  bool isClicked = false;
  TextEditingController? chatController;
  String? _displayName;
  String? message;
  String? receiverUid;
  String? receiverDisplayName;
  String? receiverUserType;
  String? receiverPhotoUrl;
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatController = TextEditingController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Globals.userRef.doc(Globals.auth.currentUser!.uid).get().then((value) {
        if (mounted) {
          setState(() {
            _displayName = value['displayName'];
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    chatController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 5,
                  padding: EdgeInsets.all(20),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Globals.userRef
                        .orderBy('createdAt', descending: true)
                        // .where('uid',
                        //     isLessThanOrEqualTo: Globals.auth.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      // print(snapshot.data?.docs.length);
                      if (snapshot.hasError) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return new ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // itemCount: snapshot.data!.docs.length,
                        itemCount: snapshot.data!.docs.length,

                        itemBuilder: (context, index) {
                          var item = snapshot.data!.docs[index];
                          // var newIndex = index + 1;
                          var email = snapshot.data!.docs[index]['email'];
                          uid = snapshot.data!.docs[index]['uid'];
                          var userId = uid;
                          // var firstName = snapshot.data!.docs[index]['firstName'];
                          // var lastName = snapshot.data!.docs[index]['lastName'];
                          var displayName =
                              snapshot.data!.docs[index]['displayName'];
                          // var password = snapshot.data!.docs[index]['password'];
                          // var userName = snapshot.data!.docs[index]['userName'];
                          var bio = snapshot.data!.docs[index]['bio'];
                          var photoUrl = snapshot.data!.docs[index]['photoUrl'];
                          // var phoneNumber = snapshot.data!.docs[index]['phoneNumber'];
                          var userType = snapshot.data!.docs[index]['userType'];
                          // var publicUrl = snapshot.data!.docs[index]['publicUrl'];
                          // var isAdmin = snapshot.data!.docs[index]['isAdmin'];
                          var classValue = snapshot.data!.docs[index]['class'];

                          if (uid == Globals.auth.currentUser!.uid) {
                            return Container();
                          } else
                            return Card(
                                child: Container(
                              width: MediaQuery.of(context).size.width / 5,
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    isClicked = true;
                                    // receiverUid = uid;
                                    receiverUid = userId;
                                    receiverDisplayName = displayName;
                                    receiverUserType = userType;
                                    receiverPhotoUrl = photoUrl;
                                  });
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ChatScreen()));

                                  // setState(() {
                                  //   titles
                                  //       .add('List' + (titles.length + 1).toString());
                                  //   subtitles.add('Here is list' +
                                  //       (titles.length + 1).toString() +
                                  //       ' subtitle');
                                  //   icons.add(Icons.zoom_out_sharp);
                                  // });
                                  // Scaffold.of(context).showSnackBar(SnackBar(
                                  //   content: Text(titles[index] + ' pressed!'),
                                  // ));
                                },
                                title: Text(displayName),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   email,
                                    //   style: TextStyle(
                                    //       color: Colors.black87),
                                    // ),
                                    Text(userType),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        bio,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(photoUrl)),
                                // trailing: Icon(icons[index])
                              ),
                            ));
                        },

                        // children: snapshot.data!.docs
                        //     .map((DocumentSnapshot document) {
                        //   return new ListTile(
                        //     title: new Text(document.data()?['category']),
                        //     // subtitle: new Text(document.data()?['subject']),
                        //   );
                        // }).toList(),
                      );
                    },
                  ),
                ),
                isClicked
                    ? Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        // isClicked = true;
                                      });
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => Chat()));

                                      // setState(() {
                                      //   titles
                                      //       .add('List' + (titles.length + 1).toString());
                                      //   subtitles.add('Here is list' +
                                      //       (titles.length + 1).toString() +
                                      //       ' subtitle');
                                      //   icons.add(Icons.zoom_out_sharp);
                                      // });
                                      // Scaffold.of(context).showSnackBar(SnackBar(
                                      //   content: Text(titles[index] + ' pressed!'),
                                      // ));
                                    },
                                    title: Text(receiverDisplayName.toString()),
                                    subtitle: Text(receiverUserType.toString()),
                                    leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            receiverPhotoUrl.toString())),
                                    // trailing: Icon(icons[index])
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade100),
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width * .5,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: Globals.chatRef!
                                      // .where('senderUid',
                                      //     isEqualTo: receiverUid)
                                      // .where('receiverUid',
                                      //     isEqualTo:
                                      //         Globals.auth.currentUser!.uid)
                                      .orderBy('createdAt', descending: false)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text('Something went wrong'));
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: Text("Loading"));
                                    }

                                    return new ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var item = snapshot.data!.docs[index];
                                        var newIndex = index + 1;
                                        var message = snapshot.data!.docs[index]
                                            ['message'];
                                        final DateTime timestamp =
                                            (snapshot.data!.docs[index]
                                                    ['createdAt'] as Timestamp)
                                                .toDate();
                                        final DateTime now = DateTime.now();
                                        final DateFormat formatter =
                                            DateFormat('yyyy-MM-dd hh:mm');
                                        final String createdAt =
                                            formatter.format(timestamp);
                                        // print(createdAt);
                                        print(
                                            snapshot.data!.docs[index].data());

                                        bool isDisplay =
                                            ((snapshot.data!.docs[index]
                                                            ['senderUid'] ==
                                                        Globals
                                                            .auth
                                                            .currentUser!
                                                            .uid) ||
                                                    (snapshot.data!.docs[index]
                                                            ['receiverUid'] ==
                                                        Globals
                                                            .auth
                                                            .currentUser!
                                                            .uid)) &&
                                                ((snapshot.data!.docs[index]
                                                            ['senderUid'] ==
                                                        receiverUid) ||
                                                    (snapshot.data!.docs[index]
                                                            ['receiverUid'] ==
                                                        receiverUid));

                                        bool isMe = snapshot.data!.docs[index]
                                                ['senderUid'] ==
                                            Globals.auth.currentUser!.uid;

                                        bool isReceiver = snapshot.data!
                                                .docs[index]['receiverUid'] ==
                                            uid;

                                        // var firstName = snapshot.data!.docs[index]
                                        //     ['firstName'];
                                        // var lastName = snapshot.data!.docs[index]
                                        //     ['lastName'];
                                        // var displayName = snapshot
                                        //     .data!.docs[index]['displayName'];
                                        // var password = snapshot.data!.docs[index]
                                        //     ['password'];
                                        // var userName = snapshot.data!.docs[index]
                                        //     ['userName'];
                                        // var bio =
                                        //     snapshot.data!.docs[index]['bio'];
                                        // var photoUrl = snapshot.data!.docs[index]
                                        //     ['photoUrl'];
                                        // var phoneNumber = snapshot
                                        //     .data!.docs[index]['phoneNumber'];
                                        // var userType = snapshot.data!.docs[index]
                                        //     ['userType'];
                                        // var publicUrl = snapshot.data!.docs[index]
                                        //     ['publicUrl'];
                                        // var isAdmin =
                                        //     snapshot.data!.docs[index]['isAdmin'];
                                        // var classValue =
                                        //     snapshot.data!.docs[index]['class'];
                                        return Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 3,
                                                bottom: 3),
                                            child: isDisplay
                                                ? (isMe
                                                    ? Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      Container()),
                                                              Expanded(
                                                                  flex: 5,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .blueAccent,
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(
                                                                              10.0),
                                                                          bottomRight: Radius.circular(
                                                                              0.0),
                                                                          topLeft: Radius.circular(
                                                                              10.0),
                                                                          bottomLeft:
                                                                              Radius.circular(10.0)),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        message,
                                                                        style: GoogleFonts.redHatDisplay(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                createdAt
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        8),
                                                              ))
                                                        ],
                                                      )
                                                    : Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  flex: 5,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(
                                                                              10.0),
                                                                          bottomRight: Radius.circular(
                                                                              10.0),
                                                                          topLeft: Radius.circular(
                                                                              10.0),
                                                                          bottomLeft:
                                                                              Radius.circular(0.0)),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        message,
                                                                        style: GoogleFonts.redHatDisplay(
                                                                            color:
                                                                                Colors.black87),
                                                                      ),
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      Container()),
                                                            ],
                                                          ),
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                createdAt
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        8),
                                                              ))
                                                        ],
                                                      ))
                                                : Container());
                                      },

                                      // children: snapshot.data!.docs
                                      //     .map((DocumentSnapshot document) {
                                      //   return new ListTile(
                                      //     title: new Text(document.data()?['category']),
                                      //     // subtitle: new Text(document.data()?['subject']),
                                      //   );
                                      // }).toList(),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(20.0),
                                width: MediaQuery.of(context).size.width / 2,
                                decoration:
                                    BoxDecoration(color: Colors.white12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: Container(
                                        height: 50,
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width *
                                        //     .5,
                                        child: TextField(
                                          controller: chatController,
                                          onChanged: (value) {
                                            message = value;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Write Something.. ',
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.indigo,
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                              onPressed: () {
                                                var id = Uuid().v4().toString();
                                                Globals.chatRef!.add({
                                                  'id': id,
                                                  'senderUid': Globals
                                                      .auth.currentUser!.uid,
                                                  'senderName': _displayName,
                                                  'message': message,
                                                  'receiverUid': receiverUid,
                                                  'receiverDisplayName':
                                                      receiverDisplayName,
                                                  'receiverUserType':
                                                      receiverUserType,
                                                  'receiverPhotoUrl':
                                                      receiverPhotoUrl,
                                                  'createdAt': FieldValue
                                                      .serverTimestamp()
                                                }).then((value) {
                                                  // print(
                                                  //     'message sent successfully');
                                                  chatController!.clear();
                                                  message = '';
                                                });
                                              },
                                              icon: Icon(
                                                Icons.send,
                                                color: Colors.white,
                                              )),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          padding: EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .7,
                              width: MediaQuery.of(context).size.width / 2,
                              color: Colors.grey.shade300,
                              child: Center(
                                child: Text(
                                  'Please select a user to start chat.',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
