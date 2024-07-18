import Foundation
import CoreData

@objc(Pokemon)
public class Pokemon: NSManagedObject {
  public static let className = "Pokemon"
  public enum Key {
    static let name = "name"
    static let phoneNumber = "phoneNumber"
    static let imageUrl = "imageUrl"
  }
}
