import UIKit

class TOCViewController: UIViewController {
    private var profile:UIImageView
    private var toc:TOC
    private var content:UIStackView
    static let cellIdentifer:String = "cell"
    
    init() {
        self.toc = TOC()
        self.profile = UIImageView(image: UIImage(named: "shakti"))
        self.content = UIStackView()
        super.init(nibName: nil, bundle: nil)
        
        profile.translatesAutoresizingMaskIntoConstraints = false
        toc.translatesAutoresizingMaskIntoConstraints = false
        content.translatesAutoresizingMaskIntoConstraints = false

        content.axis = .vertical
        content.distribution = .fill
        content.alignment = .center

        //self.navigationController?.delegate = self
        self.view.frame = .zero
        
 }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("\(type(of: self)).viewDidLoad() navigation controller \(String(describing: navigationController)) ")
        super.viewDidLoad()
        self.setNavigationBar()
        toc.reloadData()
    }
    
    override func loadView() {
        super.loadView()
    
        profile.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        profile.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)

        content.addArrangedSubview(profile)
        content.addArrangedSubview(toc)
        
        self.view.addSubview(content)
        //print("table intrinsic size \(toc.intrinsicContentSize)")
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeArea.topAnchor),
            content.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            content.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            content.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        next?.touchesBegan(touches, with: event)
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool) {
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool) {
    }
    
}

