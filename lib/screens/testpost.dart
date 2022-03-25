import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train/post.dart';
import 'package:flutter_train/screens/posts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class TestPost extends StatefulWidget {
  const TestPost({Key? key}) : super(key: key);

  @override
  State<TestPost> createState() => _TestPostState();
}

class _TestPostState extends State<TestPost> {
  List<Map<String, dynamic>> data = [
    // تعريف ليست ليتم تخزين بها بيانات البوست
    //{'name': "Sayed", 'time': "7", 'des': 'dfdsf'}
  ];
  String? imageUrl;
  final f1 =
          TextEditingController(), // تعريف المتغريات من نوع تكست اديتينج كنترولر للتحكم بالتكست فيلد من حيث جلب التكست الذى بداخله او مسحه
      f2 = TextEditingController(),
      f3 = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<
      FormState>(); // مفتاح خاص بالفورم للتحقق من التكست فيلد بداخلها انه ليس به اخطاء
  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: Text(
        'FaceBook',
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      )),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('post').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // TODO: do something with the error
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final list = snapshot.data!.docs
                  .map((e) => post.fromMap(e.data() as Map<String, dynamic>))
                  .toList();
              return ListView.builder(
                // تقوم بوضع الويدجات فوق بعض او بجانب بعض و لكن تحتاج الي
                itemCount:
                    list.length, // عدد مرات التكرار و هنا يمثل عدد عناصر الليست
                itemBuilder: (context, index) {
                  // البيلدر و يتم ادراج به الديزاين المراد تكراره
                  return DesignPost(
                    // اذهب الي كود ال design post
                    name: list[index].name!,
                    time: list[index].time.toString(),
                    descripsion: list[index].details.toString(),
                    image: list[index].image,
                    //  image: data[list]['file'],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        // يتم استخدامه لاظهار مودل بوتوم شيت يتم من خلاله وضع قيم الداتا الخاصه بالبوست

        onPressed: () {
          showModalBottomSheet<void>(
            // طريقه اظهار الشيت  ثابته
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                    25), //يتم عمل شكل دائرى للبوردر الخاص بالشيت من اليمين و اليسار بالاعلي
                topLeft: Radius.circular(25),
              ),
            ),
            backgroundColor: Colors.white,
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 300,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    // يتم وضع بداخلها التكست فيلد لكي عمل الفحص عليه
                    key: formkey, //
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType
                                .name, //  شكل الكيبورد اللي بيظهر بالهاتف
                            onChanged: (s) {
                              //  مسئوله اى تغيير بيحصل ف التكست فييلد
                              print(s);
                            },
                            validator: (s) {
                              // مسئول عن فحص التكست فيلد في حاله لو سبنه فارغ او الباسورد اقل من 8 احرف و غيره
                              if (s!.isEmpty) {
                                return "this field is required";
                              } else if (s.length < 3) {
                                return "enter valid name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                // مسئول عن الديزاين الخاص بالتكست فيلد
                                prefixIcon: Icon(Icons.abc), // ايقونه باليسار
                                suffixIcon: Icon(Icons.add), // ايقونه باليمين
                                border: OutlineInputBorder(),
                                label: Text(
                                    "Name"), // كلمه تظهر بالتكست فيلد لتوضيح استخدامه
                                hintText:
                                    "enter your name"), //  كلمه تظهر بالتكست فيلد لتوضيح استخدامه
                            controller:
                                f1, // الكنترولر الذى تم تعريفه بالاعلي و هو المسئول عن التحكم بالتكست فيلد و لكل تكست فيلد كنترولر خاص بيه
                          ),
                          // TextField(
                          //   controller: f2,
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: f3,
                            decoration: InputDecoration(
                                // مسئول عن الديزاين الخاص بالتكست فيلد
                                prefixIcon: Icon(Icons.abc), // ايقونه باليسار
                                suffixIcon: Icon(Icons.add), // ايقونه باليمين
                                border: OutlineInputBorder(),
                                label: Text(
                                    "Description"), // كلمه تظهر بالتكست فيلد لتوضيح استخدامه
                                hintText: "enter description"),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final ImagePicker _picker =
                                    ImagePicker(); // اوبجكت من كلاس اسمه imagepicker
                                // Pick an image
                                final XFile? image = await _picker.pickImage(
                                    //باستخدم الاوبجكت دا عشان اوصل للصور اللي ف المعرض الصور بتاع الجهاز
                                    source: ImageSource.gallery);
                                pickedImage = File(image!
                                    .path); // تحويل الصوره من صيفه اكس فايل ال فايل ليسهل للهاتف التعامل معها
                              },
                              child: Text('PickImage')),
                          ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  String fileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  // firebase_storage.Reference ref =
                                  //     firebase_storage.FirebaseStorage.instance
                                  //         .ref()
                                  //         .child(fileName);
                                  try {
                                    firebase_storage.TaskSnapshot
                                        storageTaskSnapshot =
                                        await firebase_storage
                                            .FirebaseStorage.instance
                                            .ref(fileName)
                                            .putFile(pickedImage!);
                                    imageUrl = await storageTaskSnapshot.ref
                                        .getDownloadURL();
                                  } on firebase_core
                                      .FirebaseException catch (e) {
                                    // e.g, e.code == 'canceled'
                                    print(e);
                                  }
                                  await firebase_storage
                                      .FirebaseStorage.instance
                                      .ref(fileName)
                                      .putFile(pickedImage!);

                                  // يتم التحقق ان كل التكست فيلد ليس بها اخطا و ذلك باستخدام المفتاح المعرف مسبقا
                                  // setState(() {
                                  // data.add({
                                  //   // يتم وضع الداتا الموجوده بالتكست فيلد داخل الليست
                                  //   'name': f1.text,
                                  //   'time': DateTime.now().toString(),
                                  //   'des': f3.text,
                                  //   "file": pickedImage
                                  // });
                                  var d = post(
                                      name: f1.text,
                                      details: f3.text,
                                      time: DateTime.now(),
                                      image: imageUrl!);
                                  await FirebaseFirestore.instance
                                      .collection('post')
                                      .doc()
                                      .set(d.toMap())
                                      .then((value) {
                                    f1.clear(); // يتم مسح الكلام اللي جوا التكست فيلد
                                    f2.clear();
                                    f3.clear();
                                    Navigator.pop(context);
                                  });
                                  // يتم استخدامها للرجوع لصفحه السابقه و هنا تستخدم لاغلاق المودل بوتوم شييت
                                  //  });
                                }
                              },
                              child: Text('add'))
                        ],
                        // wooProduct: widget.wooProduct,
                        // url: url,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// class DesignPost extends StatelessWidget {
//   DesignPost(
//       {Key? key,
//       required this.name,
//       required this.time,
//       required this.descripsion,
//       required this.image})
//       : super(key: key);
//   String name,
//       time,
//       descripsion; // يتم تعريف الداتا المتغيره الخاص بالبوست كاسم الشخص و الوصف و الصوره
//   String image;
//   String url = // مثال للصوره
//       'https://scontent.fcai1-2.fna.fbcdn.net/v/t1.6435-1/186498607_2913876452226196_5327581913643662490_n.jpg?stp=dst-jpg_s320x320&_nc_cat=104&ccb=1-5&_nc_sid=7206a8&_nc_eui2=AeHkAQ-BxGsyODCa3b42T2yLD1bpxPmUIFAPVunE-ZQgUFNN4RpA4cpjskmC0nFJrIuOKXoTzUX22JW58x2B6qUy&_nc_ohc=C8GlOG06j2UAX83GCUN&_nc_ht=scontent.fcai1-2.fna&oh=00_AT-tsLg1stgoObQZK-zvj9pY_JLSZpA8_CowkX4URJHdYA&oe=624E118F';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 420,
//       padding: EdgeInsets.all(10),
//       child: Card(
//         // لجعل البوست علي هيئه كارت و له ارتفاع مستفل عن الشاشه
//         elevation: 5, //قيمه الارتفاع
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ListTile(
//               leading: CircleAvatar(
//                   backgroundImage: Image.network(url)
//                       .image), //الليدينج يظهراول جرء علي اليسار بالليست تايل
//               // و تم وضع الصوره اللي تم تعريفها فوق (url)و التى ستاتى عند استخدام
//               //ال design post سيتطلب منى ذكر لينك الصوره و البوست و الوصف
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name, //هنا وضع الاسم الذى تم تعريفه بالاعلي
//                     //'Sayed Ashrf',
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade500,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '$time h', //هنا وضع الوقت الذى تم تعريفه بالاعلي
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade500,
//                         fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//               // subtitle: Column(
//               //   children: [
//               //     Text(
//               //       'Duty post that I had to do a lot....Thank you, Mr.I am very, very grateful to your grandfather and I am sure that you will reach the highest ranks as a result of your help to everyone who needs you. I wrote this statement, not only because when years pass by and I see it - and you are better than all of us - I say that you were my colleague and taught me .. No, I wrote it too, because when you see it, you say that what arrived and stayed She understands and knows about such-and-such. I was helping her and she still didn\'t know anything and she was still learning. I was the one who taught her and helped her.',
//               //       style: TextStyle(
//               //           fontSize: 12,
//               //           color: Colors.grey.shade500,
//               //           fontWeight: FontWeight.bold),
//               //     ),
//               //   ],
//               // ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Text(
//                 descripsion,
//                 //   'REERAS ,It is not just a place, it is a country that we work for and we devote our efforts to its progress and the secret of its strength is our collective work and our union  Sayed Ashrf our Flutter Developer',
//                 style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.bold),
//                 maxLines: 5,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Center(
//               child: Image.network(
//                 // هنا تم وضع الصوره اللي تم تعريفها بالاعلي و هي بالاصل تاتى من الهاتف و تم استخدام
//                 // نوع file لهدا السبب
//                 image,
//                 width: 250,
//                 height: 250,
//                 fit: BoxFit.fill,
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             Container(
//               height: 25,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Row(
//                     children: [
//                       Text('Like'),
//                       SizedBox(
//                         width: 3,
//                       ),
//                       Icon(
//                         Icons.favorite_sharp,
//                         size: 20,
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text('Comment'),
//                       SizedBox(
//                         width: 3,
//                       ),
//                       Icon(
//                         Icons.comment,
//                         size: 20,
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text('Share'),
//                       SizedBox(
//                         width: 3,
//                       ),
//                       Icon(
//                         Icons.share,
//                         size: 20,
//                       )
//                     ],
//                   ),
//                   // Container(
//                   //   width: MediaQuery.of(context).size.width * .25,
//                   // ),
//                   // VerticalDivider(
//                   //   color: Colors.grey.shade500,
//                   //   thickness: .5,
//                   // ),
//                   // Container(
//                   //   width: MediaQuery.of(context).size.width * .25,
//                   // ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
