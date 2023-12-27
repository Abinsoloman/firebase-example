import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updatepaige extends StatefulWidget {
  final String fst,lst,eml,nmb,grup,id;
  const Updatepaige({super.key,
                    required this.fst,
                    required this.lst,
                    required this.eml,
                    required this.nmb,
                    required this.grup,
                    required this.id});

  @override
  State<Updatepaige> createState() => _UpdatepaigeState();
}

class _UpdatepaigeState extends State<Updatepaige> {

  final CollectionReference details = FirebaseFirestore.instance.collection("detailslist");
  final frst = TextEditingController();
  final last = TextEditingController();
  final eml = TextEditingController();
  final nmbr = TextEditingController();

  final List<String> bldgrp =["A+", "A-", "B", "B+", "O+", "O", "AB+", "AB-"];
  String selectedgroup = "";

  var gender = "";

  void update (docid){
    final data = {
      "firstname":frst.text,
      "lastname" : last.text,
      "email": eml.text,
      "number": nmbr.text,
      "group": selectedgroup
    };
    details.doc(docid).update(data);

  }
  @override
  Widget build(BuildContext context) {
    frst.text = widget.fst;
    last.text = widget.lst;
    eml.text = widget.eml;
    nmbr.text = widget.nmb;
    selectedgroup = widget.grup;
    var docid = widget.id;

    return  Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("update details"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
            child: Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                    child: TextField(
                      controller: frst,
                      decoration: InputDecoration(
                        labelText: "firstname",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10,right: 10),
                    child: TextField(
                      controller: last,
                      decoration: InputDecoration(
                        labelText: "lastname",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: TextField(
                      controller: eml,
                      decoration: InputDecoration(
                        labelText: "email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: TextField(
                      controller: nmbr,
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: "number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: "Male", 
                        groupValue: gender, 
                        onChanged: (value){
                          setState(() {
                            gender = value.toString();
                          });
                        }),Text("Male"),
            
                        Radio(
                      value: "Female", 
                      groupValue: gender, 
                      onChanged: (value){
                        setState(() {
                          gender = value.toString();
                        });
                      }),Text("Female"),
            
                      Radio(
                        value: "other", 
                        groupValue: gender, 
                        onChanged: (value){
                          setState(() {
                            gender = value.toString();
                          });
                        }),Text("Others")
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText:"select blood group",
                        border: OutlineInputBorder()
                      ),
                      items: bldgrp.map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,))
                        .toList(),
                      onChanged: (newvalue){
                        selectedgroup = newvalue.toString();
                      }),
                  ),
                    ElevatedButton(onPressed: (){
                      update(docid);
                      Navigator.pop(context);
                    }, child: Text("Update"))
                    
            
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}