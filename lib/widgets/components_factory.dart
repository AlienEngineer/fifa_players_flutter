import 'package:flutter/material.dart';

abstract class IComponentsFactory {
  Image makeNetworkImage(String imgUrl);
}

class ComponentsFactory implements IComponentsFactory {
  @override
  Image makeNetworkImage(String imgUrl) => Image.network(imgUrl);
}
