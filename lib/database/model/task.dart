class Task{
  static const String collectionName ='Tasks';
  String? id;
  String? title;
  String? desc;
  DateTime? dateTime;
  bool? isDone;

  Task({this.id,this.dateTime,this.desc,this.isDone=false,this.title});
   Task.fromFireStore(Map<String,dynamic>data):
  this(id: data?['id'],
        title: data?['title'],
        desc: data?['desc'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(data?['date']),
        isDone: data?['isDone']
      );
   Map<String,dynamic>toFireStore(){
     return{
       'id':id,
       'title':title,
       'desc':desc,
       'idDone':isDone,

       'date':dateTime?.millisecondsSinceEpoch
     };
   }
}