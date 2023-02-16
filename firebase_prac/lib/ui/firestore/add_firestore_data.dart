import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_prac/utils/utils.dart';
import 'package:firebase_prac/widgets/round_button.dart';
import 'package:flutter/material.dart';


class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({Key? key}) : super(key: key);

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {

  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
                height: 50
            ),

            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration:const InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder()
              ),

            ),
            const SizedBox(
                height:30
            ),
            RoundButton(
                title: 'Add',
                loading : loading,
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().microsecondsSinceEpoch.toString();

                  fireStore.doc(id).set({

                    'title' : postController.text.toString(),
                    'id' : id

                  }).then((value){

                    setState(() {
                      loading = false;
                    });
                    Utils().ToastMessage('Post Added');

                  }).onError((error, stackTrace){

                    setState(() {
                      loading = false;
                    });

                    Utils().ToastMessage(error.toString());

                  });

                }
            ),

          ],

        ),
      ),
    );
  }



}
