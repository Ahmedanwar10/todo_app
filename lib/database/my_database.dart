import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/user.dart';

import 'model/Task.dart';

class MyDataBase{

  static CollectionReference<User>getUserCollection(){
    return FirebaseFirestore.instance
        .collection(User.collectionName)
        .withConverter<User>(

      fromFirestore: (snapshot, options) => User.FromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),);
  }
  static CollectionReference<Task> getTasksCollection(String uid) {
    return getUserCollection().doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
      fromFirestore: (snapshot, options) {
        final data = snapshot.data();
        if (data == null) {
          throw StateError('بيانات مفقودة للمهمة ID: ${snapshot.id}');
        }
        return Task.fromFireStore(data);
      },
      toFirestore: (task, options) => task.toFireStore(),
    );
  }



  static Future<void>addUser (User user){
   var collection = getUserCollection();
   return collection.doc(user.id).set(user);
  }//هنا علشان في set ف funcدس مش هتتنفذ غير لما تنده علي addUser
  static Future<User?>readUser(String id) async{
    var collection= getUserCollection();
    var docSnapshot = await collection.doc(id).get();
    return docSnapshot.data();
  }//هنا استخدمنا await and async واستنيت data ترجع وبعد كدا عملت return
}