import Combine
import UIKit
import CoreData

class MainPageViewCoordinator: BaseCoordinator<Void> {
  var masterViewCoordinator: MasterViewCoordinator!
  var window: UIWindow!
  var context: NSManagedObjectContext!
  
  func goToOptions() {
    window = UIApplication.shared.windows.first
    context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    masterViewCoordinator = MasterViewCoordinator(window: window!, context: context, x: .options)
    masterViewCoordinator.start()
  }
  
  func goToAdvanced() {
    window = UIApplication.shared.windows.first
    context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    masterViewCoordinator = MasterViewCoordinator(window: window!, context: context, x: .advancedSearch)
    masterViewCoordinator.start()
  }
}


