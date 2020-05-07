import Combine
import UIKit

class LoginViewCoordinator: BaseCoordinator<Void> {
  private var loginViewModel: LoginViewModel!
  private var masterViewCoordinator: MasterViewCoordinator!
  
  override func start() -> CurrentValueSubject<Void, Never> {
    loginViewModel = LoginViewModel()
    loginViewModel.startView()
    
    return CurrentValueSubject(())
  }
  
  func goToMasterView() {
    let window = UIApplication.shared.windows.first
    let context = Persistence().persistentContainer.viewContext
    
    masterViewCoordinator = MasterViewCoordinator(window: window!, context: context, x: .main)
    coordinate(coordinator: masterViewCoordinator)
  }
}
