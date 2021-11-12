import 'package:get/get.dart';
import 'package:kiwigames/shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LobbyProvider extends GetConnect {
  Future<Response> createLobby() => get('test/generatelobby');

  Future<Response> checkLobby(String lobbyCode) {
    return get(lobbyCode);
  }

  WebSocketChannel connectToLobby(String code) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://kiwigames.ovh/$code'),
    );
    return channel;
  }
}
