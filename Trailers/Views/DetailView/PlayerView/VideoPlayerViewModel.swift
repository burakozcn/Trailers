import Foundation

class VideoPlayerViewModel: ObservableObject {
  @Published var videoPos: Double = 0
  @Published var videoDuration: Double = 0
  @Published var seeking = false
}
