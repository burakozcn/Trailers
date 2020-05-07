import Foundation
import CoreData


extension ResultModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultModel> {
        return NSFetchRequest<ResultModel>(entityName: "ResultModel")
    }

    @NSManaged public var artistName: String?
    @NSManaged public var artworkUrl30: String?
    @NSManaged public var collectionName: String?
    @NSManaged public var country: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var primaryGenreName: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var trackName: String?

}
