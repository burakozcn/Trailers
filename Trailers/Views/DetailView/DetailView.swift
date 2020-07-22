import SwiftUI
import AVKit

struct DetailView: View {
  @State var viewModel: DetailViewModel!
  @State var result: Result
  
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  var body: some View {
    NavigationView {
        VideoPlayer(player: AVPlayer(url: URL(string: self.result.previewUrl)!))
              .navigationBarTitle("Trailer Video")
              .navigationBarItems(leading: Button("< Back") {
                self.viewModel = DetailViewModel(detailResult: self.result)
                self.viewModel.goToListView()
              })
    }
  }
}

  struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
      DetailView(result: Result(artistName: "Burak Ozcan", collectionName: "Stories", country: "Turkey", previewUrl: "", primaryGenreName: "", releaseDate: "", artworkUrl30: "", trackName: "Story of Burak"))
    }
}

//      VStack {
//        return GeometryReader { proxy in
//          ZStack {
//            VideoPlayerContainerView(url: URL(string: self.result.previewUrl)!)
//            if proxy.size.width < proxy.size.height {
//              VStack {
//                Spacer()
//                  .frame(width: self.width, height: self.height * 0.55, alignment: .center)
//                Text("\(self.result.trackName)")
//                  .frame(width: self.width, height: self.height * 0.1, alignment: .center)
//                Text("\(self.result.collectionName ?? "")")
//                  .frame(width: self.width, height: self.height * 0.1, alignment: .center)
//                Spacer()
//                  .frame(width: self.width, height: self.height * 0.23, alignment: .center)
//              }
//            }
//          }
//        }
//      }
//      .navigationBarTitle("Trailer Video")
//      .navigationBarItems(leading: Button("< Back") {
//        self.viewModel = DetailViewModel(detailResult: self.result)
//        self.viewModel.goToListView()
//      })
