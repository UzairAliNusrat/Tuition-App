import 'package:tuition_app_project/Repositories/userRepository.dart';
import 'package:uuid/uuid.dart';

class Userrepo{
  static final FirebaseUserRepository userRepo = FirebaseUserRepository();
}

class IDgenerator{
  static const uuid = Uuid();
}