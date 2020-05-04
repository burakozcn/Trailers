import Foundation

class MainPageViewModel {
  var mainPageViewCoordinator: MainPageViewCoordinator!

  
  func goToOptions() {
    mainPageViewCoordinator = MainPageViewCoordinator()
    mainPageViewCoordinator.goToOptions()
  }
  
  func goToAdvanced() {
    mainPageViewCoordinator = MainPageViewCoordinator()
    mainPageViewCoordinator.goToAdvanced()
  }
  
  func goToListView(results: Results) {
    mainPageViewCoordinator = MainPageViewCoordinator()
    mainPageViewCoordinator.goToListView(results: results)
  }
}
