import Foundation
import Combine

class NetworkManagement {
  let queue = DispatchQueue(label: "API", qos: .userInteractive, attributes: .concurrent)
  private var subscriptions = [AnyCancellable]()
  
  func getResults(name:String) -> AnyPublisher<NewResult, Error> {
    let mainString = "https://itunes.apple.com/search?media=movie&term="
    let nameTerm = nameConverter(name: name)
    
    let url = URL(string: mainString + nameTerm)!
    
    return URLSession.shared
      .dataTaskPublisher(for: url)
      .receive(on: queue)
      .map { $0.0 }
      .decode(type: NewResult.self, decoder: JSONDecoder())
      .catch { _ in Empty<NewResult, Error>() }
      .eraseToAnyPublisher()
  }
  
  func performNetworkRequestUsingCombine(url urlWithQuery:URL){
    //let decoder = JSONDecoder()
    
    URLSession.shared.dataTaskPublisher(for: urlWithQuery)
      .map({$0.data})
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { (completionError) in
        switch completionError {
        case .failure(let error):
          print(error.localizedDescription)
        case .finished:
          break
        }
      })
      { (data) in
        guard let stringData = String(data: data, encoding: .utf8) else {return}
        print(stringData)
    }
    .store(in: &subscriptions)
  }
  
  func getResultWithAnotherWay() {
    let conf = URLSessionConfiguration.default
    let session = URLSession.shared
    
    let url = URL(string: "https://itunes.apple.com/search?media=movie&term=back+to+the+future")!
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
    
    request.httpMethod = "GET"
    
    let dataTask = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print(error)
      }
      let responseDict = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
      if let dict = responseDict as? Dictionary<String, Any> {
        let result = dict["results"] as! Array<Any>
        let dict2 = result[0] as! Dictionary<String, Any>
        let longDescription = dict2["currency"] as! String
        let kind = dict2["contentAdvisoryRating"] as! String
        let collectionId = dict2["country"] as! String
        print("\(longDescription), \(kind), \(collectionId)")
      }
    }
    dataTask.resume()
  }
  
  func nameConverter(name: String) -> String {
    var newString = ""
    
    name.lowercased().urlWords.forEach { string in
      newString += "+" + string
    }
    
    return newString
  }
}




