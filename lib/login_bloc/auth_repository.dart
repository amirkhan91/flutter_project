class AuthRepository{
  Future<void> login() async{
    print('Attempting login');
    Future.delayed(const Duration(seconds: 3));
    print('Logged in');
  }
}