import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseexampletest/creat.dart';
import 'package:firebaseexampletest/update.dart';
import 'package:flutter/material.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final CollectionReference details = FirebaseFirestore.instance.collection('detailslist');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Details"),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>creatpaige()));
        },
        child: Icon(Icons.add),),
        body: StreamBuilder(
          stream: details.snapshots(), 
          builder: (context,AsyncSnapshot snapshot){
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,

                itemBuilder: (context, index){
                  final DocumentSnapshot detailssnap = snapshot.data?.docs[index];
                  //print("**************$detailssnap");
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 20,
                            blurStyle: BlurStyle.outer
                          )
                        ],
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10,left: 10,),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.red,
                                  child: Text(detailssnap["group"],
                                  style: TextStyle(
                                    color: Colors.white
                                  ),),
                                ),
                              ),
                              
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(detailssnap["firstname"]),
                                  ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(detailssnap["lastname"]),
                          ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(detailssnap["email"]),
                              ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(detailssnap["number"]),
                          ),
                           Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(detailssnap["gender"]),
                          ),
                          
                            ],
                          ),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Updatepaige(
                                    fst: detailssnap["firstname"], 
                                    lst: detailssnap["lastname"], 
                                    eml: detailssnap["email"], 
                                    nmb: detailssnap["number"], 
                                    grup: detailssnap["group"], 
                                    id: detailssnap.id)));
                                }, icon: Icon(Icons.edit)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(onPressed: (){
                                                            details.doc(detailssnap.id).delete();
                                                          }, icon: Icon(Icons.delete)),
                              )
                            ],
                          ),

                            ],
                          ),
                        ],
                      ), 
                    ),
                  );
                });
            }
            return Container();
          }
          ),
    );
    
  }
}