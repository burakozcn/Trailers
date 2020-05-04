import Foundation

public struct NewResult: Codable {
  
  let resultCount: Int
  let results: Array<Res>
  
}

//let a = ["longDescription": String, "kind": String, "collectionId": Int, "artistName": String, "trackNumber": Int, "discCount": Int, "trackCensoredName": String, "trackCount": Int, "collectionExplicitness": String, "wrapperType": String, "artworkUrl60": String, "releaseDate": String, "discNumber": Int, "trackRentalPrice": Double, "trackTimeMillis": Int, "primaryGenreName": String, "trackHdPrice": Double, "collectionPrice": Double, "collectionCensoredName": String, "collectionHdPrice": Double, "previewUrl": String, "trackId": Int, "collectionArtistId": Int, "collectionArtistViewUrl": String, "currency": String, "collectionName": String, "trackName": String, "artworkUrl30": String, "contentAdvisoryRating": String, "country": String, "artworkUrl100": String, "trackPrice": Double, "collectionViewUrl": String, "trackViewUrl": String, "trackExplicitness": String, "trackHdRentalPrice": Double] as [String : Any]
