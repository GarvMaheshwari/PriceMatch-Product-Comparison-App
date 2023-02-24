class Node<K, V> {
  late V _value;
  late K _key;

  Node(K key, V value) {
    this._key = key;
    this._value = value;
  }

  void setNode(K key, V value) {
    this._value = value;
  }
}
