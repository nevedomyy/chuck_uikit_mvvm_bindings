import Foundation

struct Notifications {
    static let fetchJoke = Notification.Name("fetchJokeNotification")
}

class NotifObject{
    let isLoading: Bool
    let joke: Joke?
    
    init(isLoading: Bool, joke: Joke?) {
        self.isLoading = isLoading
        self.joke = joke
    }
}
