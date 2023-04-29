import 'package:flutter_login_arp/utils/dialogs.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:flutter_login_arp/api/account_api.dart';
import 'package:flutter_login_arp/data/authentication_client.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';
import '../utils/logs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationClient _authenticationClient =
      GetIt.instance<AuthenticationClient>();
  final _accountAPI = GetIt.instance<AccountAPI>();
  User? _user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountAPI.getUserInfo();
    if (response.data != null) {
      _user = response.data;
      setState(() {});
      // print(response.data!.email);
    }
  }

  Future<void> _signOut() async {
    await _authenticationClient.signOut();
    Navigator.pushNamedAndRemoveUntil(context, 'login', (_) => false);
  }

  Future<void> _pickImageCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    final PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);
    // Logs.p.i(pickedFile);
    // ProgressDialog.show(context);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final fileName = path.basename(pickedFile.path);
      final response = await _accountAPI.updateAvatarImage(bytes, fileName);
      if (response.data != null) {
        _user = _user?.copyWith(avatarUrlImage: response.data);
        setState(() {});

        // final String imageUrl = "http://192.168.20.13:9000${response.data}";
        // Logs.p.i(imageUrl);
      }
    }
    // ProgressDialog.dissmiss(context);
  }

  Future<void> _pickImageGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    final PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    Logs.p.i(pickedFile);
    // ProgressDialog.show(context);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final fileName = path.basename(pickedFile.path);
      final response = await _accountAPI.updateAvatarImage(bytes, fileName);
      if (response.data != null) {
        _user = _user?.copyWith(avatarUrlImage: response.data);
        setState(() {});
        // ProgressDialog.dissmiss(context);
        // final String imageUrl = "http://192.168.20.13:9000${response.data}";
        // Logs.p.i(imageUrl);
      }
      Dialogs.alert(context,
          title: 'Update Image Gallery', description: 'image damaged');
    }
    ProgressDialog.dissmiss(context);

    // ProgressDialog.dissmiss(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Welcome to Home Page',
        )),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (_user == null) CircularProgressIndicator(),
          if (_user != null)
            Column(
              children: [
                if (_user!.avatarUrlImage != null)
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                    child: ClipOval(
                      child: Image.network(
                        "http://192.168.20.13:9000${_user!.avatarUrlImage}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Text(_user!.id),
                Text(_user!.email),
                Text(_user!.username),
                Text(_user!.createdAt.toString())
              ],
            ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: TextButton(
              child: Text(
                'Update Avatar image to Camera',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: _pickImageCamera,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: const Color.fromARGB(255, 248, 145, 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: TextButton(
              child: Text(
                'Update Avatar image to Gallery',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              onPressed: _pickImageGallery,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color.fromARGB(255, 248, 145, 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: TextButton(
              child: Text(
                'Sign Out',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              onPressed: _signOut,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color.fromARGB(255, 248, 145, 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
