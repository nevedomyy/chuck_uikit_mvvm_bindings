import UIKit

class ObservableVM {
    private let apiProvider: ApiProvider
    var jokeObs: Observable<(isLoading: Bool, joke: Joke?)> = Observable((false, nil))
        
    required init(apiProvider: ApiProvider) {
        self.apiProvider = apiProvider
    }
    
    func fetchJoke(){
        jokeObs.value.isLoading = true
        apiProvider.fetchJoke(){ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.jokeObs.value.joke = data
                case .failure(_):
                    self?.jokeObs.value.joke = nil
                }
                self?.jokeObs.value.isLoading = false
            }
        }
    }
}

