import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool/global/globals.dart';
import 'package:eschool/view/admin/chat/admin_chat.dart';
import 'package:eschool/view/admin/classes/classes.dart';
import 'package:eschool/view/admin/home/home_page.dart';
import 'package:eschool/view/admin/subjects/subjects.dart';
import 'package:eschool/view/admin/user/add_a_user.dart';
import 'package:eschool/view/admin/user/all_users.dart';
import 'package:eschool/view/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int index = 0;
  bool isExtended = false;

  final selectedColor = Colors.white;
  final unselectedColor = Colors.white60;
  final labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  String? displayName;

  @override
  void initState() {
    Globals.getUid();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final animation = NavigationRail.extendedAnimation(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text('eSchool || Admin View'),
              ),
            ],
          ),
          centerTitle: true,
          leading: Container(),
          actions: [
            FutureBuilder<DocumentSnapshot>(
              future: Globals.getUid(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Snapshot has error");
                } else if (snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data?.data();
                  String uid = data?['uid'];
                  String displayImage = data?['displayUrl'];
                  displayName = data?['displayName'];
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Container(
                            child: Text(
                              displayName.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Container(
                            child: ClipOval(
                              child: Material(
                                color: Colors.grey, // button color
                                child: InkWell(
                                  splashColor: Colors.grey, // inkwell color
                                  child: data?['photoUrl'] == null
                                      ? Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          child: Text(
                                            data?["displayName"]
                                                .substring(0, 1),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                        )
                                      : Image.network(
                                          data?['photoUrl'],
                                          fit: BoxFit.cover,
                                          height: 40,
                                          width: 40,
                                        ),
// onTap: () {
//   setState(() {
//     isProfileClicked = true;
//   });
// },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ));
              },
            ),
          ],
        ),
        body: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            LayoutBuilder(builder: (context, constraint) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      backgroundColor: Theme.of(context).primaryColor,
                      //labelType: NavigationRailLabelType.all,
                      selectedIndex: index,
                      extended: isExtended,
                      //groupAlignment: 0,
                      selectedLabelTextStyle:
                          labelStyle.copyWith(color: selectedColor),
                      unselectedLabelTextStyle:
                          labelStyle.copyWith(color: unselectedColor),
                      selectedIconTheme:
                          IconThemeData(color: selectedColor, size: 50),
                      unselectedIconTheme:
                          IconThemeData(color: unselectedColor, size: 50),
                      onDestinationSelected: (index) =>
                          setState(() => this.index = index),

                      leading: isExtended
                          ? GestureDetector(
                              onTap: () =>
                                  setState(() => isExtended = !isExtended),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.toc,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'DashBoard',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : FloatingActionButton(
                              heroTag: 'onlyIcon',
                              backgroundColor: Colors.red,
                              onPressed: () {
                                setState(() => isExtended = !isExtended);
                              },
                              child: Icon(Icons.toc, color: Colors.white)),

                      // leading: isExtended
                      //     ? Material(
                      //         color: Theme.of(context).primaryColor,
                      //         clipBehavior: Clip.hardEdge,
                      //         // shape: CircleBorder(),
                      //         child: GestureDetector(
                      //           onTap: () => setState(() => isExtended = !isExtended),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             children: [
                      //               Padding(
                      //                 padding: const EdgeInsets.only(left: 15, right: 10),
                      //                 child: Container(
                      //                   child: Icon(
                      //                     Icons.toc,
                      //                     size: 50,
                      //                     color: Colors.white,
                      //                   ),
                      //                 ),
                      //               ),
                      //               Container(
                      //                 child: Text(
                      //                   "Home",
                      //                   style: TextStyle(color: Colors.white),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       )
                      //     : Material(
                      //         color: Theme.of(context).primaryColor,
                      //         clipBehavior: Clip.hardEdge,
                      //         // shape: CircleBorder(),
                      //         child: GestureDetector(
                      //           onTap: () => setState(() => isExtended = !isExtended),
                      //           child: Container(
                      //             // width: 62,
                      //             // height: 62,
                      //
                      //             // fit: BoxFit.fitHeight,
                      //             child: Icon(
                      //               Icons.toc,
                      //               size: 50,
                      //               color: Colors.indigo,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      trailing: isExtended
                          ? GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var isLoggedin =
                                    prefs.setBool("isLoggedin", false);
                                prefs.clear();
                                Globals.googleSignIn.signOut();
                                FirebaseAuth.instance.signOut();
                                Navigator.pushNamed(context, '/');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.logout,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Logout',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : FloatingActionButton(
                              heroTag: 'onlyIcon2',
                              backgroundColor: Colors.red,
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var isLoggedin =
                                    prefs.setBool("isLoggedin", false);
                                prefs.clear();
                                Globals.googleSignIn.signOut();
                                FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Icon(Icons.logout, color: Colors.white)),
                      // trailing: AnimatedRailWidget(
                      //   child: isExtended
                      //       ? Row(
                      //           children: [
                      //             Icon(
                      //               Icons.logout,
                      //               color: Colors.white,
                      //               size: 28,
                      //             ),
                      //             const SizedBox(width: 12),
                      //             Text(
                      //               'Logout',
                      //               style: TextStyle(
                      //                 fontSize: 18,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //       : Icon(Icons.logout, color: Colors.white),
                      // ),
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        // NavigationRailDestination(
                        //   icon: Icon(Icons.account_circle_outlined),
                        //   selectedIcon: Icon(Icons.account_circle),
                        //   label: Text('Users'),
                        // ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.grade),
                          icon: Icon(Icons.grade_outlined),
                          label: Text('Classes'),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.book_outlined),
                          icon: Icon(Icons.book),
                          label: Text('Subjects'),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.person_add_alt_1_outlined),
                          icon: Icon(Icons.person_add_alt_1),
                          label: Text('Add a User'),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.account_circle_outlined),
                          icon: Icon(Icons.account_circle),
                          label: Text('All Users'),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Icon(Icons.chat),
                          icon: Icon(Icons.chat),
                          label: Text('Chat'),
                        ),
                        // NavigationRailDestination(
                        //   selectedIcon: Icon(Icons.pending_actions),
                        //   icon: Icon(Icons.pending_actions_outlined),
                        //   label: Text('Test'),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Expanded(child: buildPages()),
          ],
        ),
      ),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return ClassPage();
      // case 2:
      //   return SubCategories();
      case 2:
        return SubjectPage();
      case 3:
        return AddAUser();
      case 4:
        return AllUsers();
      case 5:
        return AdminChat();
      default:
        return HomePage();
    }
  }
}

// class AnimatedRailWidget extends StatelessWidget {
//   final Widget? child;
//
//   const AnimatedRailWidget({
//     @required this.child,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final animation = NavigationRail.extendedAnimation(context);
//
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) => Container(
//         height: 56,
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//           child: FloatingActionButton.extended(
//             backgroundColor: Colors.red,
//             label: Text('This is text'),
//             isExtended: animation.status != AnimationStatus.dismissed,
//             onPressed: () {},
//           ),
//         ),
//       ),
//       child: child,
//     );
//   }
// }
