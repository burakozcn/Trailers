import SwiftUI
import Combine

class DetailViewCoordinator: BaseCoordinator<Void> {
  var detailViewModel: DetailViewModel!
  var listViewCoordinator: ListViewCoordinator!
  var detailResult: Result
  var cache: NSCache<NSString, Results>!
  
  init(detailResult: Result) {
    self.detailResult = detailResult
  }
  
  override func start() -> CurrentValueSubject<Void, Never> {
    detailViewModel = DetailViewModel(detailResult: detailResult)
    detailViewModel.startView()
    
    return CurrentValueSubject(())
  }
  
  func goToListView() {
    let results = resultCache["results"]
    
    listViewCoordinator = ListViewCoordinator(results: results!)
    return coordinate(coordinator: listViewCoordinator)
  }
}
