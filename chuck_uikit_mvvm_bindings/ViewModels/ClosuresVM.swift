import UIKit

class ClosuresVM {
    private let apiProvider: ApiProvider
    var showLoader: (() -> ())?
    var showError: (() -> ())?
    var showSuccess: ((Joke) -> ())?
    
    required init(apiProvider: ApiProvider) {
        self.apiProvider = apiProvider
    }
    
    func fetchJoke(){
        self.showLoader?()
        apiProvider.fetchJoke(){ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.showSuccess?(data)
                case .failure(_):
                    self?.showError?()
                }
            }
        }
    }
}

