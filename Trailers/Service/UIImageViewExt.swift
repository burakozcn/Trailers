import Foundation
import UIKit
import Combine

extension UIImageView {
  private var subscriptions: [AnyCancellable] {
    get {
      return [AnyCancellable]()
    }
    set {
      [AnyCancellable]()
    }
  }
  
  func downloaded(from url: URL, completion: @escaping (UIImage) -> ()) {
    URLSession.shared.dataTaskPublisher(for: url)
      .map({$0.data})
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { (completionError) in
        switch completionError {
        case .failure(let error):
          print(error.localizedDescription)
        case .finished:
          break
        }
      })
      { [weak self] (data) in
        guard let image = UIImage(data: data) else {return}
        completion(image)
    }
    .store(in: &subscriptions)
  }
}
