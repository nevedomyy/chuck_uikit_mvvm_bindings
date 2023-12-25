import UIKit

class MainVC: UIViewController {
    private let captions = [
        "Delegate",
        "Closures",
        "Observable",
        "Notification Center",
        "Combine",
    ]
    
    private let targets = [
        #selector(onBtn1Tap),
        #selector(onBtn2Tap),
        #selector(onBtn3Tap),
        #selector(onBtn4Tap),
        #selector(onBtn5Tap),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let img = UIImage(named: "img.jpg")
        let imgView = UIImageView(image: img)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imgView)
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imgView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imgView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        for i in 0..<captions.count {
            let btn = UIButton()
            btn.backgroundColor = .systemGray2
            btn.setTitle(captions[i], for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: targets[i], for: .touchUpInside)
            view.addSubview(btn)
            
            NSLayoutConstraint.activate([
                btn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
                btn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
                btn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(320+i*60)),
                btn.heightAnchor.constraint(equalToConstant: 50),
            ])
        }
    }
    
    @objc private func onBtn1Tap(){
        navigationController?.pushViewController(
            DelegateVC(
                jokeView: JokeView(),
                viewModel: DelegateVM(
                    apiProvider: ApiProvider.shared
                )
            ),
            animated: true
        )
    }
    
    @objc private func onBtn2Tap(){
        navigationController?.pushViewController(
            ClosuresVC(
                jokeView: JokeView(),
                viewModel: ClosuresVM(
                    apiProvider: ApiProvider.shared
                )
            ),
            animated: true
        )
    }
    
    @objc private func onBtn3Tap(){
        navigationController?.pushViewController(
            ObservableVC(
                jokeView: JokeView(),
                viewModel: ObservableVM(
                    apiProvider: ApiProvider.shared
                )
            ),
            animated: true
        )
    }    
    
    @objc private func onBtn4Tap(){
        navigationController?.pushViewController(
            NotifCenterVC(
                jokeView: JokeView(),
                viewModel: NotifCenterVM(
                    apiProvider: ApiProvider.shared
                )
            ),
            animated: true
        )
    }    
    
    @objc private func onBtn5Tap(){
        navigationController?.pushViewController(
            CombineVC(
                jokeView: JokeView(),
                viewModel: CombineVM(
                    apiProvider: ApiProvider.shared
                )
            ),
            animated: true
        )
    }
}

