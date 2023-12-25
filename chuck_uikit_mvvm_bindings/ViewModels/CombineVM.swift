import UIKit
import Combine

class CombineVM {
    private let apiProvider: ApiProvider
    var jokeCVS = CurrentValueSubject<NotifObject, Never>(NotifObject(isLoading: false, joke: nil))
        
    required init(apiProvider: ApiProvider) {
        self.apiProvider = apiProvider
    }
    
    func fetchJoke(){
        jokeCVS.send(NotifObject(isLoading: true, joke: nil))
        apiProvider.fetchJoke(){ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.jokeCVS.send(NotifObject(isLoading: false, joke: data))
                case .failure(_):
                    self?.jokeCVS.send(NotifObject(isLoading: false, joke: nil))
                }
            }
        }
    }
}

