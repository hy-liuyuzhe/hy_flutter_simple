class DropSelectObject {
  String? title;
  List<DropSelectObject>? children;
  bool selected;
  bool selectedCleanOther;

  DropSelectObject(
      {this.title,
      this.children,
      this.selected = false,
      this.selectedCleanOther = false});

  DropSelectObject clone() {
    DropSelectObject newData = DropSelectObject();
    newData.title = title;
    newData.children =  [];
    children?.forEach((item) {
      newData.children?.add(item.clone());
    });

    newData.selected = selected;
    newData.selectedCleanOther = selectedCleanOther;
    return newData;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropSelectObject &&
          runtimeType == other.runtimeType &&
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}
