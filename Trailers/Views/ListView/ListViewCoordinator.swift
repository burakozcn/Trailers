import SwiftUI
import UIKit
import Combine

class ListViewCoordinator:BaseCoordinator<Void> {
  var listViewModel: ListViewModel!
  let results: Results
  var masterCoordinator: MasterViewCoordinator!
  var detailViewCoordinator: DetailViewCoordinator!
  
  init(results: Results) {
    self.results = results
  }
  
  override func start() -> CurrentValueSubject<Void, Never> {
    listViewModel = ListViewModel(results: results)
    let contentView = ListView().environmentObject(results)
    
    let window = UIApplication.shared.windows.first
    window?.rootViewController = UIHostingController(rootView: contentView)
    return CurrentValueSubject(())
  }
  
  func goToMainView() {
    let window = UIApplication.shared.windows.first
    let context = Persistence().persistentContainer.viewContext
    
    masterCoordinator = MasterViewCoordinator(window: window!, context: context, x: .main)
    return coordinate(coordinator: masterCoordinator)
  }
  
  func goToDetailView(detailResult: Result) {
    detailViewCoordinator = DetailViewCoordinator(detailResult: detailResult)
    return coordinate(coordinator: detailViewCoordinator)
  }
}
