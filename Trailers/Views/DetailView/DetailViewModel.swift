import UIKit
import SwiftUI

class DetailViewModel: ObservableObject {
  var viewCoordinator: DetailViewCoordinator!
  @Published var detailResult: Result
  
  init(detailResult: Result) {
    self.detailResult = detailResult
  }
  
  func startView() {
    let window = UIApplication.shared.windows.first!
    let contentView = DetailView(result: detailResult)
    window.rootViewController = UIHostingController(rootView: contentView)
  }
  
  func goToListView() {
    viewCoordinator = DetailViewCoordinator(detailResult: detailResult)
    viewCoordinator.goToListView()
  }
}
