import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'modules/arcivetasks.dart';
import 'modules/donetasks.dart';
import 'modules/newtaskscreen.dart';
class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int currentIndex=0;
  List<Widget> Screens=[
    const NewTasks(),
    const DoneTasks(),
    const ArciveTasks(),
  ];
  List<String> titless=[
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
@override
  void initState() {
    super.initState();
    createDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          titless[currentIndex]
        ),
        centerTitle: true,

      ),
      body: Screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          var name= await getName();
         print("name: $name");
        },

        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        currentIndex: currentIndex,
        onTap: (index){
        setState(() {
          currentIndex=index;
        });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(
           icon: Icon(
             Icons.menu,

           ),

            label: "Tasks",
          ),
          BottomNavigationBarItem(

            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: "Done",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: "Archive",
          ),
        ],
      ),

    );
  }

  Future<String> getName()async {
    return "Hossam Ezz";
  }
  void createDatabase()async{
    var database=await openDatabase(
      "todo.db",version: 1,
      onCreate: (database,version)async{
        print('database created');
       await database.execute(
         "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT,status TEXT)"
       );
      },
      onOpen: (database){
        print("database opened");
      }
    );

  }
  void insertDatabase(){

  }
}
