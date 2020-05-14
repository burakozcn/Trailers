import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var isLogin: Bool
    @NSManaged public var name: String
    @NSManaged public var options: Options?
    @NSManaged public var results: NSSet?

}

// MARK: Generated accessors for results
extension User {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: ResultModel)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: ResultModel)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}
