import Foundation
import Combine

class BaseCoordinator<ResultType> {
  
  private let identifier = UUID()
  private var childCoordinators = [UUID : Any]()
  var subscriptions = Set<AnyCancellable>()
  
  private func store<T>(coordinator: BaseCoordinator<T>) {
    childCoordinators[coordinator.identifier] = coordinator
  }
  
  private func free<T>(coordinator: BaseCoordinator<T>) {
    childCoordinators[coordinator.identifier] = nil
  }
  
  func coordinate<T>(coordinator: BaseCoordinator<T>) {
    store(coordinator: coordinator)
    return coordinator.start()
      .sink { [unowned self] _ in
        self.free(coordinator: coordinator)
    }.store(in: &subscriptions)
  }
  
  func start() -> CurrentValueSubject<ResultType, Never> {
    fatalError("Start method should be implemented")
  }
}
