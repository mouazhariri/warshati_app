abstract class MainEvent {}

class ChangeBottomItemEvent extends MainEvent {
  final int selectedItem;

  ChangeBottomItemEvent({required this.selectedItem});
}

class LogOutEvent extends MainEvent {}
