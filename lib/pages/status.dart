import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    // socketService.socket.emit('emitir-mensaje', {});
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Server status: ${socketService.serverStatus}')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socketService.socket.emit('emitir-mensaje',
              {'nombre': 'App Flutter', 'mensaje': 'Mensaje desde Flutter'});
        },
        child: Icon(Icons.call),
        elevation: 1.0,
      ),
    );
  }
}
