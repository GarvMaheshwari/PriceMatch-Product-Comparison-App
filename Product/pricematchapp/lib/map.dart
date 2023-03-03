import 'node.dart';

class Map<K, V> {
  late List<Node> _bucket;
  late int length;

  void add(K key, V value) {
    Node temp = new Node(key, value);
    _bucket.add(temp);
    length++;
  }

  void replace(K key, V value) {
    int i = 0;

    while (_bucket.elementAt(i) != key) {
      i++;
      if (i > length) {
        return;
      }
    }
    _bucket.elementAt(i).setNode(key, value);
  }

//instead use recursion here
  void getBucket() {
    for (int i = 0; i < _bucket.length; i++) {
      print(_bucket.elementAt(i));
    }
  }
}
