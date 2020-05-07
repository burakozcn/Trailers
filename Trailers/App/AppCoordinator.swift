import UIKit
import Combine
import CoreData

class AppCoordinator: BaseCoordinator<Void> {
  private weak var window: UIWindow?
  private var context: NSManagedObjectContext
  private var loginViewCoordinator: LoginViewCoordinator!
  
  init(window: UIWindow, context: NSManagedObjectContext) {
    self.window = window
    self.context = context
  }
  
  override func start() -> CurrentValueSubject<Void, Never> {
    loginViewCoordinator = LoginViewCoordinator()
    coordinate(coordinator: loginViewCoordinator)
    
    return CurrentValueSubject<Void, Never>.init(())
  }
}
