import Foundation

let resultCache = ResultCache()

class ResultCache: NSCache<NSString, Results> {
  
  subscript(key: NSString) -> Results? {
    get {
      return object(forKey: key)
    }
    set {
      if let newValue = newValue {
        setObject(newValue, forKey: key)
      } else {
        removeObject(forKey: key)
      }
    }
  }
}
