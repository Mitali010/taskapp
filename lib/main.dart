import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'datamodel.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.orange[100],
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
          )
          
        ),
        home: const LoginScreen(),
        
      
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}
Future<Datamodel?> submitData(String name, String job) async{
  var response = await http.post(Uri.https('reqres.in', 'api/users'),
  body: {"name" :name, "job" : job,

  });
  var data = response.body;
  print(data);

  if(response.statusCode == 201) {
    String responseString = response.body;
    datamodelFromJson(responseString);
  }
  else {
    return null;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late Datamodel _datamodel;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
  
        title: const  Center(child: Text('Rest API', style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.orange[100],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField (
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name here',
                
                ),
                controller: nameController,
            ),
            const SizedBox(height: 20,),
            TextField (
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter job title here',
                
                ),
                controller: jobController,
            ),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: () async {
              String name = nameController.text;
              String job = jobController.text;

              Datamodel? data = await submitData(name, job);
              setState(() {
                _datamodel = data!;
              });
            }
            , child: const Text('Submit'))
            
          ],
        ),
      ),

     

    );
    
  }
}

