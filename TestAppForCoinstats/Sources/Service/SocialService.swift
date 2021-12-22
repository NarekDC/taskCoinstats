
import Foundation

class ApiService {

    var myFeed: [FeedInfoData] = []
    var errorMessage = ""
    
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    fileprivate func updateResults(_ data: Data) {
        myFeed.removeAll()
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            let rawFeed = try decoder.decode(Response.self, from: data)
            myFeed = rawFeed.data
        } catch let decodeError as NSError {
            errorMessage += "Decoder error: \(decodeError.localizedDescription)"
            return
        }
    }
    
    func getResults(from url: URL, completion: @escaping ([FeedInfoData]) -> Void) {
        dataTask = defaultSession.dataTask(with: url) { [weak self] (data, response, error)
            in
            print(data ?? "")
            defer { self?.dataTask = nil }
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self?.updateResults(data)
                completion(self?.myFeed ?? [FeedInfoData]())
            }
        }
        dataTask?.resume()
    }
}

