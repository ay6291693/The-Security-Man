import 'package:flutter/material.dart';
import 'package:thesecurityman/aboutus.dart';
import 'package:thesecurityman/profilepage.dart';
import '../constants.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final String identity,username;
  NavigationDrawerWidget(this.identity,this.username);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState(identity,username);
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {

  final String title,username;

  _NavigationDrawerWidgetState(this.title,this.username);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      child: Drawer(
        child: Material(
          color: mainColor,
          child: ListView(
            children: <Widget>[
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 15,),
                    CircleAvatar(
                      radius: 35,
                      child: Image.asset("assets/The.png"),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child:  Column(
                        children: [
                          SizedBox(height: 24,),
                          Text(
                            "Login-As : $title\n\n"+
                                "Username: $username",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Divider(color: Colors.white70,height: 5,thickness: 2,),
              SizedBox(height: 10,),
              Text("   Be Assured, Be Secured ",style: TextStyle(
                  fontSize: 28,color: Colors.white,fontFamily: 'Hina',fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 10,),
              buildMenuItem(
                icon : Icons.people,
                text: 'Profile',
                onClicked: () => selectedItem(context,0),
              ),
              buildMenuItem(
                icon : Icons.favorite,
                text: 'Favourites',
                onClicked: () => selectedItem(context,1),
              ),
              buildMenuItem(
                icon : Icons.info_outline,
                text: 'About Us',
                onClicked: () => selectedItem(context,2),
              ),
              buildMenuItem(
                icon : Icons.perm_contact_cal,
                text: 'Contact Us',
                onClicked: () => selectedItem(context,3),
              ),
              buildMenuItem(
                icon : Icons.update_sharp,
                text: 'Update',
                onClicked: () => selectedItem(context,4),
              ),
              const SizedBox(height: 18,),
              Divider(color: Colors.white70,height: 5,thickness: 2,),
              const SizedBox(height: 18,),
            ],
          ),
        ),
      ),
    );
  }

  buildMenuItem({IconData icon, String text,final Function onClicked}) {
    final color = Colors.white;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child:  ListTile(
        leading: Icon(icon,color: color,size: 30,),
        title: Text(text,style: TextStyle(color: Colors.white,fontSize: 18),),
        hoverColor: Colors.white60,
        onTap: onClicked,
      ),
    );
  }

  selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch(i){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
        break;
      case 1:
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }
}