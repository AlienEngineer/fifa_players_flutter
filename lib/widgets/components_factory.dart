import 'package:flutter/material.dart';

abstract class IComponentsFactory {
  Widget makeNetworkImage(String imgUrl);
}

class ComponentsFactory implements IComponentsFactory {
  @override
  Widget makeNetworkImage(String imgUrl) => Image.network(imgUrl);
}
