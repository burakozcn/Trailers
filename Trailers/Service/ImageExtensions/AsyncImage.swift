import SwiftUI

struct AsyncImage<PlaceHolder: View>: View {
  private let configuration: (Image) -> Image
  @ObservedObject private var loader: ImageLoader
  private let placeholder: PlaceHolder?
  
  init(url: URL, placeholder: PlaceHolder? = nil, cache: ImageCache? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
    loader = ImageLoader(url: url, cache: cache)
    self.placeholder = placeholder
    self.configuration = configuration
  }
  
  var body: some View {
    image
      .onAppear(perform: loader.load)
      .onDisappear(perform: loader.cancel)
  }
  
  private var image: some View {
    Group {
      if loader.image != nil {
        configuration(Image(uiImage: loader.image!))
          .resizable()
      } else {
        placeholder
      }
    }
  }
}
