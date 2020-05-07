import Foundation
import CoreData


extension Options {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Options> {
        return NSFetchRequest<Options>(entityName: "Options")
    }

    @NSManaged public var country: String?
    @NSManaged public var explicit: Bool
    @NSManaged public var numberOfSearch: Int16
    @NSManaged public var type: String?
    @NSManaged public var id: UUID?

}
