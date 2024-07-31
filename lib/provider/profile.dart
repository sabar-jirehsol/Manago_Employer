import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends ChangeNotifier {
  PickedFile? imageFile;
  String? name;
  ImagePicker _picker = ImagePicker();
  String? state;
  bool seen = false;

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    imageFile = pickedFile;
    notifyListeners();
  }

  changeName(String nameTyped) async {
    name = nameTyped;
    notifyListeners();
  }

  changeState(String nameTyped) async {
    state = nameTyped;
    notifyListeners();
  }

  changeSeen() {
    seen = true;
    notifyListeners();
  }
}
