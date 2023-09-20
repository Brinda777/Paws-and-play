import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/AdoptViewModel.dart';
import '../model/AdoptModel.dart';

class Adoption extends StatefulWidget {
  const Adoption({Key? key}) : super(key: key);

  @override
  State<Adoption> createState() => _AdoptionState();
}

class _AdoptionState extends State<Adoption> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late AdoptionViewModel _adoptionViewModel;

  void _deleteAdopt(String id) async {
    await db.collection('adopt').doc(id).delete();
  }

  @override
  void initState() {
    _adoptionViewModel = Provider.of<AdoptionViewModel>(context, listen: false);
    _adoptionViewModel.getAdopt();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var adoptDog = context.watch<AdoptionViewModel>().adoptDog;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(191, 134, 143, 30),
            title: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Adoption Application",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            )),
        body: StreamBuilder(
            stream: adoptDog,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<AdoptionModel>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error");
              } else {
                return ListView(children: [
                  ...snapshot.data!.docs.map((document) {
                    AdoptionModel adoptDog = document.data();
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/SubPage");
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("Delete dog from the list?"),
                              content: Text(
                                  "Are you sure you want to delete this dog?"),
                              actions: [
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    _deleteAdopt(document.id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: ListTile(
                        leading: Container(
                          width: MediaQuery.of(context).size.height / 20,
                          height: MediaQuery.of(context).size.height / 20,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(adoptDog.imageUrl!),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Show the popup dialog when the button is tapped
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Adopt the pet"),
                                      content: Text(
                                          "Are you sure you want to adopt this pet?"),
                                      actions: [
                                        TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .pushNamed("/Payment");
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.done),
                            ),
                            SizedBox(width: 5),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Delete the item from Firestore and the UI
                                FirebaseFirestore.instance
                                    .collection('adopt')
                                    .doc(adoptDog.dogId)
                                    .delete();
                                _adoptionViewModel.deleteAdopt(adoptDog.dogId);
                              },
                            ),
                          ],
                        ),
                        title: Text(adoptDog.dogName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                // Here is the explicit parent TextStyle
                                style: new TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  new TextSpan(text: "Breed :"),
                                  new TextSpan(
                                    text: adoptDog.breed,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ]);
              }
            }));
  }
}
