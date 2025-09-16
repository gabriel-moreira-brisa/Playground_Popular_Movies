import 'package:mobx/mobx.dart';
import '../services/auth_service.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final AuthService _authService = AuthService();

  @observable
  bool isLoading = false; // iniciar tela

  @observable
  String? errorMessage;

  @observable
  bool loginSuccess = false; // acessar

  @action
  Future<void> doLogin(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    loginSuccess = false;

    // Validação simples caso não coloque nada nos campos
    if (username.isEmpty || password.isEmpty) {
      errorMessage = "Email e senha são obrigatórios.";
      isLoading = false;

      return;
    }

    try {
      final bool success = await _authService.login(username, password);
      if (success == true) {
        loginSuccess = true;
      } else {
        // A lógica de login retornou 'false', então as credenciais são inválidas
        errorMessage = "Usuário e senha inválidos.";
      }
    } catch (e) {
      errorMessage = "Ocorreu um erro. Tente novamente.";
    } finally {
      isLoading = false;
    }
  }
}
// email -> a senha 
// senha == senha
  