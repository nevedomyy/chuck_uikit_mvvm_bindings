import UIKit
import Combine

class CombineVC: UIViewController {
    private let viewModel: CombineVM
    private let jokeView: JokeView
    
    var cancellables = Set<AnyCancellable>()
    
    init(jokeView: JokeView, viewModel: CombineVM) {
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
        viewModel.jokeCVS.sink { [weak self] notifObj in
            if (notifObj.isLoading){
                self?.jokeView.loaderView()
            } else{
                let text = notifObj.joke?.value ?? ""
                if (text.isEmpty){
                    self?.jokeView.errorView()
                } else{
                    self?.jokeView.successView(
                        text: text
                    )
                }
            }
        }.store(in: &cancellables)
    }

    private func fetchJoke(){
        viewModel.fetchJoke()
    }
}

