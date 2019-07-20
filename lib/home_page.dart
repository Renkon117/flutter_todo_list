import 'package:flutter/material.dart';
import 'package:flutter_sample_app/shared_prefs.dart';
import 'app_background.dart';
import 'completed_task_page.dart';

var homePageKey = GlobalKey<_HomePageState>();

List<String> listItems = [];
// SharePrefs.getListItems()
List<bool> completedItems = [];

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _validate = false;
  final TextEditingController eCtrl = new TextEditingController();

  @override
  void dispose() {
    eCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do list App"),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              setState(() {});
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CompletedTasks(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          AppBackgroundPage(),
          Column(
            children: <Widget>[
              Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.7),
                    color: Colors.white),
                margin: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: eCtrl,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Things to do",
                          errorText: _validate ? 'The input is empty.' : null,
                          contentPadding: const EdgeInsets.only(
                              left: 25.0, bottom: 15.0, top: 15.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                        autocorrect: true,
                        onSubmitted: (text) {
                          setState(() {
                            if (text.isEmpty) {
                              _validate = true;
                            } else {
                              _validate = false;
                              completedItems.add(false);
                              listItems.add(text);
                              //SharePrefs.setListItems(listItems);
                              eCtrl.clear();
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 70,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.7)),
                        onPressed: () {},
                        color: Colors.blueAccent,
                        child: new IconButton(
                          padding: new EdgeInsets.symmetric(vertical: 10.0),
                          color: Colors.white,
                          hoverColor: Colors.white,
                          icon: Icon(
                            IconData(57669, fontFamily: 'MaterialIcons'),
                          ),
                          onPressed: () {
                            setState(() {
                              if (eCtrl.text.isEmpty) {
                                _validate = true;
                              } else {
                                _validate = false;
                                completedItems.add(false);
                                listItems.add(eCtrl.text);
                                //SharePrefs.setItemName(eCtrl.text);
                                //SharePrefs.setListItems(listItems);
                                eCtrl.clear();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: new ListView.builder(
                  itemCount: listItems.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(child: Text(listItems[index])),
                            Container(
                              width: 40,
                              child: InkWell(
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.redAccent,
                                  ),
                                  onTap: () {
                                    listItems.removeAt(index);
                                    completedItems.removeAt(index);
                                    setState(() {});
                                  }),
                            ),
                            Container(
                                width: 30,
                                child: InkWell(
                                  child: Icon(
                                    (completedItems[index] == false)
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box,
                                    color: Colors.greenAccent,
                                  ),
                                  onTap: () {
                                    if (completedItems[index] == false) {
                                      completedItems[index] = true;
                                    } else {
                                      completedItems[index] = false;
                                    }
                                    setState(() {});
                                  },
                                )),
                          ],
                        ),
                        onTap: () {
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
