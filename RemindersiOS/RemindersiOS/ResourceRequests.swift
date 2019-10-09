import Foundation

enum GetResourcesRequest<ResourceType> {
    case success([ResourceType])
    case failure
}

enum SaveResult<ResourceType> {
    case success(ResourceType)
    case failure
}

struct ResourceRequest<ResourceType> where ResourceType: Codable {
    
    let baseURL = "http://localhost:8080/api/"
    let resourceURL: URL
    
    init(resourcePath: String) {
        guard let resourceURL = URL(string: baseURL) else {
            fatalError()
        }
        
        self.resourceURL = resourceURL.appendingPathComponent(resourcePath)
    }
    
    func getAll(completion: @escaping (GetResourcesRequest<ResourceType>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let resources = try decoder.decode([ResourceType].self, from: jsonData)
                completion(.success(resources))
            } catch {
                
                completion(.failure)
            }
        }
        dataTask.resume()
    }
}

struct UserRequest {
    let resource: URL
    
    init(userID: UUID) {
        let resourceString = "http://localhost:8080/api/users/\(userID)"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        
        self.resource = resourceURL
    }
    
    func update(with updateData: User, completion: @escaping (SaveResult<User>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resource)
            urlRequest.httpMethod = "PUT"
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            urlRequest.httpBody = try encoder.encode(updateData)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    let jsonData = data else {
                        completion(.failure)
                        return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let user = try decoder.decode(User.self, from: jsonData)
                    completion(.success(user))
                } catch {
                    completion(.failure)
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure)
        }
    }
}
