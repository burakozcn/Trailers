import UIKit
import Combine
import CoreData

class MasterViewCoordinator: BaseCoordinator<Void> {
  private weak var window: UIWindow!
  private var masterViewModel: MasterViewModel!
  private var context: NSManagedObjectContext
  private var x: PageSelection
  
  init(window: UIWindow, context: NSManagedObjectContext, x: PageSelection) {
    self.window = window
    self.context = context
    self.x = x
    super.init()
  }
  
  override func start() -> CurrentValueSubject<Void, Never> {
    masterViewModel = MasterViewModel()
    masterViewModel.startView(window: window, context: context, x: x)
    
    return CurrentValueSubject(())
  }
}
