
import UIKit


class OrderPageController: UIViewController {
    var menuView:MenuView?
    var checkout:UIButton
    var menu:Menu
    var cart:Cart
    
    init(menu:Menu) {
        self.menu = menu
        checkout = UIButton()
        checkout.translatesAutoresizingMaskIntoConstraints = false
        checkout.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        cart = Storage.loadCart()
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        configureRoundButton(checkout)
        super.viewDidLayoutSubviews()
        
    }
    
    
    /*
     * sets up this view
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setSceneHeader(titleText: UIConstants.APP_NAME)
        
        self.menuView = MenuView(menu: menu, cart:cart)
        self.addViewController(menuView!)
        self.view.addSubview(checkout)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(itemInsertedInCart(_:)),
                                               name: .itemInsertedInCart,
                                               object: nil)
        
        
        // calls server to create an order when check is clicked
        checkout.addTarget(self,
                           action:#selector(createOrder),
                           for:.touchUpInside)
    }
    
    func  configureRoundButton(_ btn:UIButton) {
        btn.backgroundColor = .red
        btn.tintColor = UIColor.white
        btn.setTitle("+", for: .normal)
        let size:CGFloat = 40
        btn.bounds = CGRect(x:0,y:0, width:size, height: size)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width:0.0, height:5.0)
        btn.layer.masksToBounds = false
        btn.layer.shadowRadius = 2.0
        btn.layer.shadowOpacity = 0.5
        btn.layer.cornerRadius = 0.5*btn.bounds.size.width
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        
    }
    /*
     * This is appropiate to set constraints on
     * constituent views as the bounds of root
     * view has been set
     */
    override func viewWillLayoutSubviews() {
        NSLog("---------> viewWillLayoutSubviews --- view bounds are set now")
        NSLog("view bounds \(self.view.bounds)")
        let safeArea = self.view.safeAreaLayoutGuide
        NSLog("safeArea \(safeArea.layoutFrame)")
        self.view.layoutMargins = UIEdgeInsets(top: safeArea.layoutFrame.origin.y,
                                               left: safeArea.layoutFrame.origin.x,
                                               bottom: safeArea.layoutFrame.height,
                                               right: safeArea.layoutFrame.width)
        
        let margins = self.view.layoutMarginsGuide
        NSLog("margins \(margins.layoutFrame)")
        
        menuView?.view.bounds = CGRect(x: margins.layoutFrame.origin.x,
                                       y: margins.layoutFrame.origin.y,
                                       width: margins.layoutFrame.width,
                                       height: margins.layoutFrame.height)
        menuView?.view.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        menuView?.view.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        menuView?.view.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
        menuView?.view.heightAnchor.constraint(equalTo: safeArea.heightAnchor).isActive = true
        
        checkout.frame = CGRect(x:safeArea.layoutFrame.width-100, y:safeArea.layoutFrame.height-100, width: 24, height: 24)
        checkout.bounds = CGRect(x:0, y:0, width:24, height:24)
        checkout.leftAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -100).isActive = true
        checkout.topAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -100).isActive = true
        //checkout.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        //checkout.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        super.viewWillLayoutSubviews()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        NSLog("OrderPageController.updateViewConstraints")
        let safeArea = self.view.safeAreaLayoutGuide.layoutFrame
        self.view.frame  = safeArea
        for view in self.view.subviews {
            NSLog("subviews \(view.self)")
        }
        
    }
    
//    func addControllerView(_ child:UIViewController, to:UIView) {
//        self.addChild(child)
//        to.addSubview(child.view)
//        child.didMove(toParent: self)
//        
//    }
    @objc func itemInsertedInCart(_ notification:Notification) {
        NSLog("MenuViewControoler receievd notifictaion \(notification)")
        checkout.isEnabled = true
        //cartView.reloadData()
    }
    
    @objc func createOrder() {
        if (self.cart.isEmpty) {
            alert(title: "", message: "empty cart")
        }
        let checkout:CheckoutViewController = CheckoutViewController(cart:cart)
        show(checkout, sender:self)
        
    }
    
    func refresh() {
        checkout.isEnabled = !self.cart.isEmpty
    }
}


extension Notification.Name {
    static let itemInsertedInCart = Notification.Name("itemInsertedInCart")
}

/*
 * set constraint on each child controller views
 */
/*/
 override func viewDidLayoutSubviews() {
 NSLog("OrderPageController.viewDidLayoutSubviews")
 guard let menu = menuView.view else { return}
 guard let cart = cartView.view else { return}
 
 menu.translatesAutoresizingMaskIntoConstraints = false
 cart.translatesAutoresizingMaskIntoConstraints = false
 menu.clipsToBounds = true
 cart.clipsToBounds = true
 menu.backgroundColor = .red
 cart.backgroundColor = .red
 
 let safeArea = self.view.safeAreaLayoutGuide.layoutFrame
 self.view.frame  = safeArea
 menu.frame = CGRect(x:safeArea.minX, y:safeArea.minY,     width: safeArea.width, height: safeArea.height*0.5)
 cart.frame = CGRect(x:safeArea.minX, y:safeArea.minY+safeArea.height*0.5, width: safeArea.width, height: safeArea.height*0.3)
 
 menu.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
 menu.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
 menu.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
 //menu.heightAnchor.constraint(equalTo: self.view.Anchor).isActive = true
 cart.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
 cart.topAnchor.constraint(equalTo: menu.bottomAnchor).isActive = true
 cart.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
 
 checkout.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
 checkout.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
 
 NSLog("menu frame \(menu.frame)")
 NSLog("cart frame \(cart.frame)")
 }
 */


