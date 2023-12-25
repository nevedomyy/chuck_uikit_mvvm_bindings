import UIKit

class DelegateVC: UIViewController {
    private let viewModel: DelegateVM
    private let jokeView: JokeView
    
    init(jokeView: JokeView, viewModel: DelegateVM) {
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
        
        viewModel.delegate = self
        
        fetchJoke()
    }

    private func fetchJoke(){
        viewModel.fetchJoke()
    }
}

extension DelegateVC: DelegateVCDelegate {
    func showLoader(){
        jokeView.loaderView()
    }
    
    func showError(){
        jokeView.errorView()
    }
    
    func showSuccess(joke: Joke){
        jokeView.successView(
            text: joke.value
        )
    }
}
