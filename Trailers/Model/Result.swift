import Foundation

public class Results: ObservableObject {
  @Published var results = [Result]()
}

public class Result: Identifiable {

  public var id = UUID()
  @Published var artistName: String
  @Published var collectionName: String?
  @Published var country: String
  @Published var previewUrl: String
  @Published var primaryGenreName: String
  @Published var releaseDate: String
  @Published var artworkUrl30: String
  @Published var trackName: String
  
  init(artistName: String, collectionName: String?, country: String, previewUrl: String, primaryGenreName: String, releaseDate: String, artworkUrl30: String, trackName: String) {
    self.artistName = artistName
    self.collectionName = collectionName
    self.country = country
    self.previewUrl = previewUrl
    self.primaryGenreName = primaryGenreName
    self.releaseDate = releaseDate
    self.artworkUrl30 = artworkUrl30
    self.trackName = trackName
  }
}
