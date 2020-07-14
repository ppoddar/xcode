import UIKit
class HeaderViewController: UIViewController {
    var profile:UIImageView
    var nameLabel:UILabel
    var subtitleLabel:UILabel

    init() {
        let image:UIImage = UIImage(named: "shakti")!
        self.profile       = UIImageView(image: image)
        self.nameLabel     = UILabel()
        self.subtitleLabel = UILabel()

        super.init(nibName: nil, bundle: nil)
        
        profile.translatesAutoresizingMaskIntoConstraints       = false
        nameLabel.translatesAutoresizingMaskIntoConstraints     = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.title = "Shakti"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
    }
    
    override func loadView() {
        super.loadView()
        nameLabel.text = ""
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        nameLabel.textColor = .white
        subtitleLabel.text = "1933-95"
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitleLabel.textColor = .white
        self.view.addSubview(profile)
        profile.addSubview(nameLabel)
        profile.addSubview(subtitleLabel)
        
        profile.isUserInteractionEnabled = true
        let click:UIGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(showIndex))
        let swipe:UIGestureRecognizer = UISwipeGestureRecognizer(target: self,
            action: #selector(showIndex))

        
        profile.addGestureRecognizer(click)
        profile.addGestureRecognizer(swipe)
    }
    
    override func viewWillLayoutSubviews() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profile.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            profile.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 12),
            nameLabel.centerXAnchor.constraint(equalTo: profile.centerXAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: profile.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)

        ])
    }

    
    @objc func showIndex() {
        let toc:TOCViewController = TOCViewController()
        self.navigationController?.show(toc, sender: self)
    }
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get { .fullScreen }
        set { assertionFailure("Shouldnt change that 😠") }
    }
    /*
    func configureNavigationBar(title:String) {
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.title = title
        
        // Make the navigation bar's title with red text.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // With a red background, make the title more readable.
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance // For iPhone small navigation bar in landscape.

        // Make all buttons with green text.
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
        navigationItem.compactAppearance?.buttonAppearance = buttonAppearance // For iPhone small navigation bar in landscape.
    }
    */
    
    func configureNavigationBar(title:String) {
        self.title = title
        self.navigationController!.navigationBar.barStyle = .black

    }
}
