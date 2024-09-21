import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/web_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminAccountDetail extends StatefulWidget {
  final uid, email, firstName, password, confrimPassword;
  AdminAccountDetail(
      {super.key,
      required this.confrimPassword,
      required this.email,
      required this.firstName,
      required this.password,
      required this.uid});

  @override
  State<AdminAccountDetail> createState() => _AdminAccountDetailState();
}

class _AdminAccountDetailState extends State<AdminAccountDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                FormSection(
                  confrimPassword: widget.confrimPassword,
                  email: widget.email,
                  firstName: widget.firstName,
                  password: widget.password,
                  uid: widget.uid,
                ),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FormSection extends StatefulWidget {
  final confrimPassword;
  final email;
  final uid;
  final firstName;
  final password;

  const FormSection({
    Key? key,
    required this.password,
    required this.email,
    required this.firstName,
    required this.confrimPassword,
    required this.uid,
  }) : super(key: key);

  @override
  State<FormSection> createState() => FormSectionState();
}

class FormSectionState extends State<FormSection> {
  //Program
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: 448,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset("assets/logo.png"),
            SizedBox(height: 9),
            Row(children: [
              Text(
                "Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.firstName)
            ]),
            SizedBox(height: 9),
            Row(children: [
              Text(
                "Email:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.email,
              )
            ]),
            SizedBox(height: 9),
            Row(children: [
              Text(
                "Password:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.password),
            ]),
            SizedBox(height: 9),
            Row(children: [
              Text(
                "Contact Number:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.confrimPassword,
              )
            ]),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SaveButton(
                    color: mainBtnColor,
                    onTap: () async {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Admin Detail'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text("Email :" + widget.email),
                                  Text("Name :" + widget.firstName),
                                  Text(
                                    "Do you want to remove admin account permantely",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("admin")
                                      .doc(widget.uid)
                                      .delete();

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => WebHome()));
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: "Delete Account"),
              ),
            ),
            SizedBox(height: 10),
          ])),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/logo.png",
            height: 300,
          ))
        ],
      ),
    );
  }
}
