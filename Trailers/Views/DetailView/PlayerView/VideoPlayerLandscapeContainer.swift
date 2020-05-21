import SwiftUI
import AVFoundation

struct VideoPlayerLandscapeContainerView : View {
  @ObservedObject var viewModel: VideoPlayerViewModel
  private let player: AVPlayer
  
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  init(url: URL) {
    player = AVPlayer(url: url)
    viewModel = VideoPlayerViewModel()
    
    print("HERE LANDSCAPE")
  }
  
  var body: some View {
    ZStack {
      VStack {
        Spacer()
          .frame(width: width, height: height * 0.07, alignment: .center)
        VideoPlayerView(videoPos: Binding<Double>(
          get: { self.viewModel.videoPos},
          set: { self.viewModel.videoPos = $0}),
                        videoDuration: Binding<Double>(
                          get: { self.viewModel.videoDuration },
                          set: { self.viewModel.videoDuration = $0 }),
                        seeking: Binding<Bool>(
                          get: { self.viewModel.seeking },
                          set: { self.viewModel.seeking = $0 }),
                        player: player)
          .frame(width: width, height: height * 0.74, alignment: .center)
        Spacer()
          .frame(width: width, height: height * 0.17, alignment: .center)
      }
      VStack {
        Spacer()
          .frame(width: width, height: height * 0.80, alignment: .center)
        VideoPlayerControlsView(videoPos: Binding<Double>(
          get: { self.viewModel.videoPos},
          set: { self.viewModel.videoPos = $0}),
                                videoDuration: Binding<Double>(
                                  get: { self.viewModel.videoDuration },
                                  set: { self.viewModel.videoDuration = $0 }),
                                seeking: Binding<Bool>(
                                  get: { self.viewModel.seeking },
                                  set: { self.viewModel.seeking = $0 }),
                                player: player)
          .frame(width: width, height: height * 0.17, alignment: .center)
          .onDisappear {
            self.player.replaceCurrentItem(with: nil)
        }
      }
    }
  }
}
