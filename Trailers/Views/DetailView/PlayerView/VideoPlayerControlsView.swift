import SwiftUI
import AVFoundation

struct VideoPlayerControlsView : View {
  @Binding private(set) var videoPos: Double
  @Binding private(set) var videoDuration: Double
  @Binding private(set) var seeking: Bool
  @State var timeReverse = false
  let player: AVPlayer
  
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  @State private var playerPaused = true
  
  var body: some View {
    HStack {
      Button(action: togglePlayPause) {
        Image(systemName: playerPaused ? "play" : "pause")
      }
      .frame(width: width * 0.08, height: height * 0.12, alignment: .center)
      Slider(value: $videoPos, in: 0...1, onEditingChanged: sliderEditingChanged)
        .frame(width: width * 0.61, height: height * 0.12, alignment: .center)
      Text("\(!timeReverse ? "" : "-")\(!timeReverse ? secondsToHoursMinutesSeconds(videoPos * videoDuration) : secondsToHoursMinutesSeconds((videoDuration - videoPos * videoDuration)))")
        .onTapGesture {
          self.timeReverse = !self.timeReverse
      }
      .frame(width: width * 0.20, height: height * 0.12, alignment: .center)
      Button(action: screenOrientation) {
        Image(systemName: "arrow.up.left.and.arrow.down.right")
      }
      .frame(width: width * 0.05, height: height * 0.12, alignment: .center)
    }
  }
  
  private func screenOrientation() {
    
  }
  
  private func togglePlayPause() {
    pausePlayer(!playerPaused)
  }
  
  private func pausePlayer(_ pause: Bool) {
    playerPaused = pause
    if playerPaused {
      player.pause()
    }
    else {
      player.play()
    }
  }
  
  private func sliderEditingChanged(editingStarted: Bool) {
    if editingStarted {
      seeking = true
      pausePlayer(true)
    }
    
    if !editingStarted {
      let targetTime = CMTime(seconds: videoPos * videoDuration,
                              preferredTimescale: 600)
      player.seek(to: targetTime) { _ in
        self.seeking = false
        self.pausePlayer(false)
      }
    }
  }
  
  private func secondsToHoursMinutesSeconds (_ seconds : TimeInterval) -> String {
    let sec = Int(seconds)
    let hrs = sec / 3600
    let mins = (sec % 3600) / 60
    let secs = (sec % 3600) % 60
    return String(format: "%02d:%02d:%02d", hrs, mins, secs)
  }
}
