import UIKit

class ClosuresVC: UIViewController {
    private let viewModel: ClosuresVM
    private let jokeView: JokeView
    
    init(jokeView: JokeView, viewModel: ClosuresVM) {
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
        
        callbacks()
        
        fetchJoke()
    }
    
    private func callbacks(){
        viewModel.showLoader = { [weak self] in
            self?.jokeView.loaderView()
        }
        viewModel.showError = { [weak self] in
            self?.jokeView.errorView()
        }
        viewModel.showSuccess = { [weak self] joke in
            self?.jokeView.successView(
                text: joke.value
            )
        }
    }

    private func fetchJoke(){
        viewModel.fetchJoke()
    }
}
