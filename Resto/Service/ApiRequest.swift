
import UIKit

class ApiRequest {
    // Generic Wrapper
    func apiCall<T: Decodable>(completion: @escaping (Result<T, ApiRequestError>) -> Void) {
        fetchRequest { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let genericData = try decoder.decode(T.self, from: data)
                    completion(.success(genericData))
                } catch {
                    completion(.failure(.serialize(identifier: String(describing: self))))
                }
            }
        }
    }
   
    func fetchRequest(completion: @escaping (Result<Data, ApiRequestError>) -> Void) {
        let url = URL(string: "https://alanflament.github.io/TFTest/test.json")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error != nil {
                completion(.failure(.unhandleError))
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                completion(.failure(ApiRequestError.unhandleError))
                return
            }
            
            let status = response.statusCode
            guard (200...299).contains(status) else {
                if status == 404 {
                    completion(.failure(.notFound))
                } else {
                    completion(.failure(.backendError(message: "some error ocurred")))
                }
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
