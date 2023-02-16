import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_prac/utils/utils.dart';
import 'package:firebase_prac/widgets/round_button.dart';
import 'package:flutter/material.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Posts'),
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

                  databaseRef.child(id).set({
                    'id' : id,
                    'title' :postController.text.toString()
                  }).then((value){

                    Utils().ToastMessage('Post Added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace){
                    Utils().ToastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                }
            ),

          ],

        ),
      ),
    );
  }



}
