import 'package:notes/logic/add_or_edit.dart';

class AddOrEditArgs {
  int dateViewIndex, mainViewIndex;
  bool isAdd;
  AddOrEditArgs(this.isAdd, this.mainViewIndex, {this.dateViewIndex});
}
