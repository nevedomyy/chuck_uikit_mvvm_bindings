import UIKit

class ObservableVC: UIViewController {
    private let viewModel: ObservableVM
    private let jokeView: JokeView
    
    init(jokeView: JokeView, viewModel: ObservableVM) {
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
        
        bindViewModel()
        
        fetchJoke()
    }

    private func bindViewModel(){
        viewModel.jokeObs.bind { [weak self] isLoading, joke in
            if (isLoading){
                self?.jokeView.loaderView()
            } else{
                let text = joke?.value ?? ""
                if (text.isEmpty){
                    self?.jokeView.errorView()
                } else{
                    self?.jokeView.successView(
                        text: text
                    )
                }
            }
        }
    }

    private func fetchJoke(){
        viewModel.fetchJoke()
    }
}
