import Foundation
import Alamofire

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

class APIManager {
    func fetchData<T: Decodable>(url: URL, completion: @escaping (APIResult<T>) -> Void) {
        checkInternetConnection { isConnected in
            guard isConnected else {
                completion(.failure(NSError(domain: "NoInternet", code: 0, userInfo: nil)))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    let noDataError = NSError(domain: "com.example.avito_test", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(.failure(noDataError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    private func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        let reachability = NetworkReachabilityManager()
        reachability?.startListening { status in
            if status == .reachable(.ethernetOrWiFi) || status == .reachable(.cellular) {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

