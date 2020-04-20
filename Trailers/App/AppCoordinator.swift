import UIKit
import Combine
import CoreData

class AppCoordinator: BaseCoordinator<Void> {
  private weak var window: UIWindow?
  private var context: NSManagedObjectContext
  
  init(window: UIWindow, context: NSManagedObjectContext) {
    self.window = window
    self.context = context
  }
  
  override func start() -> CurrentValueSubject<Void, Never> {
    let masterViewCoordinator = MasterViewCoordinator(window: window!, context: context, x: .main)
    coordinate(coordinator: masterViewCoordinator)
    
    return CurrentValueSubject<Void, Never>.init(())
  }
}
