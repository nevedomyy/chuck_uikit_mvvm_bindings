import UIKit

class JokeView: UIView{
    private let loader = UIActivityIndicatorView(style: .large)
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0

        addSubviews(loader, label)
        addLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addLayoutConstraint() {
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
    }
    
    func loaderView(){
        label.isHidden = true
        loader.startAnimating()
        label.alpha = 0
    }
    
    func successView(text: String){
        label.text = text
        label.isHidden = false
        loader.stopAnimating()
        UIView.animate(withDuration: 0.2){
            self.label.alpha = 1
        }
    }
    
    func errorView(){
        label.text = "Oops, something went wrong!"
        label.isHidden = false
        loader.stopAnimating()
        UIView.animate(withDuration: 0.2){
            self.label.alpha = 1
        }
    }
}
