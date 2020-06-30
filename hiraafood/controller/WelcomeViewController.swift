import UIKit

class WelcomeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setSceneHeader(titleText: "Welcome")
    }
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        let logo:UIImage? = UIImage(named: "logo")
        let imageView:UIImageView = UIImageView(image: logo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        let title:UILabel = UIFactory.label("best food in town")
        title.font = UIFont.systemFont(ofSize: 12)
        imageView.addSubview(title)
        
        self.view.addSubview(imageView)
        
        let click = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.enterMain))
        imageView.addGestureRecognizer(click)
        
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
    }
    
    @objc func enterMain() throws {
        NSLog("============ Starting main application ============")
        
        let menu = TestDataFactory.getMenu()
        let page = OrderPageController()
        page.menu = menu
        show(page, sender: self)
        //self.modalPresentationStyle = .fullScreen
        //present(page, animated: true)
        /*
        DispatchQueue.global().async {
        
        
        Server.singleton.get(
            url:  "/item/catalog") {result in
                NSLog("received response from /item/catlog")
            switch (result) {
            case .success:
                do {
                    let rawData = try result.get()
                    let items:[Item] = try JSONDecoder().decode([Item].self, from: rawData)
                    NSLog("decoded response to \(items.count) items")
                    DispatchQueue.main.async {
                            let menu:Menu = Menu()
                            menu.items = items
                            let controller = OrderPageController(menu: menu)
                            self.present(controller, animated: true)
                    }
                } catch {
                    self.alert(title:"error /item/catlog", message: String(describing: error))
                }
            case .failure(let error) :
                self.alert(title:"Can not fetch menu", message: String(describing: error))
            }
        }
 
    }
 */
    }
}
