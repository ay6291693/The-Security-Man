import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thesecurityman/Database_Models/user_model.dart';
import 'package:thesecurityman/constants.dart';

class ProfilePage extends StatefulWidget {
  final String identity;
  const ProfilePage({Key key,this.identity}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

   String profileImage;

  User user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void setProfileImage(String identity){
    if(identity=="Customer"){
      this.profileImage="assets/Customer.jpg";
    }else if(identity=="Security Man"){
      this.profileImage="assets/Splash.jpg";
    }else{
      this.profileImage="assets/business-partner.jpg";
    }
  }
  @override
  void initState() {
    super.initState();
    setProfileImage(widget.identity);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value){
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainColor, //const Color(0xFF40C4FF),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 40,
                    letterSpacing: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width*0.4,
                height: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image:  DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(profileImage),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Name: ${loggedInUser.name}",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Phone No : ${loggedInUser.phoneNum}',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Email : ${loggedInUser.email}',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        height: 55,
                        //width: double.infinity,
                        // ignore: deprecated_member_use
                        child: Center(
                          child: Text(
                            "Be Assured, Be Secure",
                            style: TextStyle(
                              fontSize: 25,
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 400, left: 184),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: const Icon(
                  Icons.verified_user,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = mainColor; //const Color(0xFF40C4FF);

    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}