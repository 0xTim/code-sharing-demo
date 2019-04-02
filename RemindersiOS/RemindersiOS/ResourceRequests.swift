import Foundation

enum GetResourcesRequest<ResourceType> {
    case success([ResourceType])
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

//enum AcronymUserRequestResult {
//    case success(User)
//    case failure
//}
//
//enum CategoryAddResult {
//    case success
//    case failure
//}
//
//struct AcronymRequest {
//    let resource: URL
//    
//    init(acronymID: Int) {
//        let resourceString = "http://locahost:8080/api/acronyms/\(acronymID)"
//        guard let resourceURL = URL(string: resourceString) else {
//            fatalError()
//        }
//        
//        self.resource = resourceURL
//    }
//    
//    func getUser(completion: @escaping (AcronymUserRequestResult) -> Void) {
//        let url = resource.appendingPathComponent("user")
//        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
//            guard let jsonData = data else {
//                completion(.failure)
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let user = try decoder.decode(User.self, from: jsonData)
//                completion(.success(user))
//            } catch {
//                completion(.failure)
//            }
//        }
//        dataTask.resume()
//    }
//    
//    func getCategories(completion: @escaping (GetResourcesRequest<Category>) -> Void) {
//        let url = resource.appendingPathComponent("categories")
//        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
//            guard let jsonData = data else {
//                completion(.failure)
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let categories = try decoder.decode([Category].self, from: jsonData)
//                completion(.success(categories))
//            } catch {
//                completion(.failure)
//            }
//        }
//        dataTask.resume()
//    }
//    
//    func update(with updateData: Acronym, completion: @escaping (SaveResult<Acronym>) -> Void) {
//        do {
//            var urlRequest = URLRequest(url: resource)
//            urlRequest.httpMethod = "PUT"
//            urlRequest.httpBody = try JSONEncoder().encode(updateData)
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
//                guard let httpResponse = response as? HTTPURLResponse,
//                    httpResponse.statusCode == 200,
//                    let jsonData = data else {
//                        completion(.failure)
//                        return
//                }
//                
//                do {
//                    let acronym = try JSONDecoder().decode(Acronym.self, from: jsonData)
//                    completion(.success(acronym))
//                } catch {
//                    completion(.failure)
//                }
//            }
//            dataTask.resume()
//        } catch {
//            completion(.failure)
//        }
//    }
//    
//    func delete() {
//        var urlRequest = URLRequest(url: resource)
//        urlRequest.httpMethod = "DELETE"
//        let dataTask = URLSession.shared.dataTask(with: urlRequest)
//        dataTask.resume()
//    }
//    
//    func add(category: Category, completion: @escaping (CategoryAddResult) -> Void) {
//        guard let categoryID = category.id else {
//            completion(.failure)
//            return
//        }
//        
//        let url = resource.appendingPathComponent("categories").appendingPathComponent("\(categoryID)")
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { _, response, _ in
//            guard let httpResponse = response as? HTTPURLResponse,
//                httpResponse.statusCode == 201 else {
//                    completion(.failure)
//                    return
//            }
//            
//            completion(.success)
//        }
//        dataTask.resume()
//    }
//}
