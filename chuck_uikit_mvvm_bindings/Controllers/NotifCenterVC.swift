import UIKit

class NotifCenterVC: UIViewController {
    private let viewModel: NotifCenterVM
    private let jokeView: JokeView
    
    init(jokeView: JokeView, viewModel: NotifCenterVM) {
        self.jokeView = jokeView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = jokeView
        
        addObs()
        
        fetchJoke()
    }

    private func addObs(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateState),
            name: Notifications.fetchJoke,
            object: nil
        )
    }
    
    @objc private func updateState(notification: Notification){
        guard let notifObj = notification.object as? NotifObject else { return }
        if (notifObj.isLoading){
            jokeView.loaderView()
        } else{
            let text = notifObj.joke?.value ?? ""
            if (text.isEmpty){
                jokeView.errorView()
            } else{
                jokeView.successView(
                    text: text
                )
            }
        }
    }

    private func fetchJoke(){
        viewModel.fetchJoke()
    }
}
