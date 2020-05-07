import Combine
import UIKit
import CoreData

class MainPageViewCoordinator: BaseCoordinator<Void> {
  var masterViewCoordinator: MasterViewCoordinator!
  var listViewCoordinator: ListViewCoordinator!
  var window: UIWindow!
  var context: NSManagedObjectContext!
  var persistence: Persistence!
  
  func goToOptions() {
    persistence = Persistence()
    
    window = UIApplication.shared.windows.first
    context = persistence.persistentContainer.viewContext
    masterViewCoordinator = MasterViewCoordinator(window: window!, context: context, x: .options)
    return coordinate(coordinator: masterViewCoordinator)
  }
  
  func goToAdvanced() {
    persistence = Persistence()
    
    window = UIApplication.shared.windows.first
    context = persistence.persistentContainer.viewContext
    masterViewCoordinator = MasterViewCoordinator(window: window!, context: context, x: .advancedSearch)
    return coordinate(coordinator: masterViewCoordinator)
  }
  
  func goToListView(results: Results) {
    listViewCoordinator = ListViewCoordinator(results: results)
    return coordinate(coordinator: listViewCoordinator)
  }
}


