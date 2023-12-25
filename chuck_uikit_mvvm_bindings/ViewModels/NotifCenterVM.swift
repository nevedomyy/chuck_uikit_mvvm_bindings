import UIKit

class NotifCenterVM {
    private let apiProvider: ApiProvider
        
    required init(apiProvider: ApiProvider) {
        self.apiProvider = apiProvider
    }
    
    func fetchJoke(){
        NotificationCenter.default.post(
            name: Notifications.fetchJoke,
            object: NotifObject(isLoading: true, joke: nil)
        )
        apiProvider.fetchJoke(){ [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    NotificationCenter.default.post(
                        name: Notifications.fetchJoke,
                        object: NotifObject(isLoading: false, joke: data)
                    )
                case .failure(_):
                    NotificationCenter.default.post(
                        name: Notifications.fetchJoke,
                        object: NotifObject(isLoading: false, joke: nil)
                    )
                }
            }
        }
    }
}

