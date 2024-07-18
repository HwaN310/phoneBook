import Foundation
import CoreData


extension Pokemon {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
    return NSFetchRequest<Pokemon>(entityName: "Pokemon")
  }
  
  @NSManaged public var name: String?
  @NSManaged public var phoneNumber: String?
  @NSManaged public var imageUrl: String?
  
}

extension Pokemon : Identifiable {
  
}
