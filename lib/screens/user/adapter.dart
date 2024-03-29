import 'package:hive/hive.dart';

import 'package:flutter/material.dart';
import 'package:regalo/screens/user/shoppingitem.dart';

class ShoppingItemAdapter extends TypeAdapter<ShoppingItem> {
  @override
  final int typeId = 0;

  @override
  ShoppingItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShoppingItem(
        name: fields[0] as String,
        price: fields[1] as double,
        id: fields[2] as String,
        size: fields[3] as String,
        sellerid: fields[4] as String);
  }

  @override
  void write(BinaryWriter writer, ShoppingItem obj) {
    print(obj.id);
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.sellerid);
  }
}
