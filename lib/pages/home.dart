import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 4),
    Band(id: '3', name: 'Héroes del Silencio', votes: 3),
    Band(id: '4', name: 'Nirvana', votes: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'BandNames',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print(direction);
        // llamar el borrado
      },
      background: Container(
        padding: EdgeInsets.only(left: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Eliminar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        color: Colors.red,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            band.name.substring(0, 2),
          ),
          backgroundColor: Colors.blue.shade100,
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();
    if (Platform.isAndroid) {
      //Android
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("New band name"),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              onPressed: () => addBandToList(textController.text),
              child: Text("Add"),
              elevation: 5,
              textColor: Colors.blue,
            )
          ],
        ),
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New Band Name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Add'),
              isDefaultAction: true,
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
                child: Text('Dismiss'),
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context))
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(Band(
        id: DateTime.now().toString(),
        name: name,
        votes: 2,
      ));
    }
    Navigator.pop(context);
  }
}
