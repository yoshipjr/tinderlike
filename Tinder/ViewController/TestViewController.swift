import UIKit


final class TestViewConroller: UIViewController {

    private lazy var testView: UIView = {

        let view = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        NSLayoutConstraint.activate([
            testView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            testView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
