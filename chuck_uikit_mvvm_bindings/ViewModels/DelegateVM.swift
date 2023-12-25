import UIKit

protocol DelegateVCDelegate: AnyObject {
    func showLoader()
    func showError()
    func showSuccess(joke: Joke)
}

class DelegateVM {
    private let apiProvider: ApiProvider
    
    weak var delegate: DelegateVCDelegate?
    
    required init(apiProvider: ApiProvider) {
        self.apiProvider = apiProvider
    }
    
    func fetchJoke(){
        delegate?.showLoader()
        apiProvider.fetchJoke(){ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.delegate?.showSuccess(joke: data)
                case .failure(_):
                    self?.delegate?.showError()
                }
            }
        }
    }
}

