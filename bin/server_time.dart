import 'dart:convert';
import 'package:web_socket_channel/io.dart';

//active symbols
//tick stream

void main(List<String> arguments) {
  final channel =IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');
  

  // channel.stream.listen((message){
  //   final decodedMessage = jsonDecode(message);
  //   final serverTimeAsEpoch = decodedMessage['time'];
  //   final serverTime = DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);
  //   print('Time is: $serverTime');
  //   channel.sink.close();
  // });

  // channel.sink.add('{"time": 1}');

  channel.stream.listen((tick) {
    final decodedMessage = jsonDecode(tick);
    final name = decodedMessage['tick']['symbol'];
    final price = decodedMessage['tick']['quote'];
    final epochTime = decodedMessage['tick']['epoch'];
    final time = DateTime.fromMillisecondsSinceEpoch(epochTime*1000);


    print('Name: $name, Price: $price, Date: $time');
    // channel.sink.close();
  });

  channel.sink.add('{"ticks":"frxUSDCAD"}');
}
