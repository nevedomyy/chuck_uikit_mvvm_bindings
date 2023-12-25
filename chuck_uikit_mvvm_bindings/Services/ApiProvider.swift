import Foundation

class ApiProvider{
    /// The shared singleton object
    static let shared = ApiProvider()
    
    private init(){}
    
    func fetchJoke(completion: @escaping (Result<Joke, Error>) -> Void) {
        let urlString = "https://api.chucknorris.io/jokes/random"
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiProviderError.failedToCreateURL))
            return
        }
        guard let req = request(url: url) else {
            completion(.failure(ApiProviderError.failedToCreateRequest))
            return
        }
        URLSession.shared.dataTask(with: req){ data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ApiProviderError.failedToFetchData))
                return
            }
            do{
                let result = try JSONDecoder().decode(Joke.self, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func request(url: URL) -> URLRequest? {
        return URLRequest(url: url)
    }
}

enum ApiProviderError: Error{
    case failedToCreateRequest
    case failedToCreateURL
    case failedToFetchData
}
