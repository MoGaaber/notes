import 'package:notes/logic/add_or_edit.dart';

class AddOrEditArgs {
  int dateViewIndex,mainViewIndex;
  SaveOperation saveOperation ;
  AddOrEditArgs(this.saveOperation,this.mainViewIndex,{this.dateViewIndex});
}
