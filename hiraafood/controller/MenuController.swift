
import UIKit
class MenuController: UIViewController {
    var menuView:MenuView
    var checkout:UIButton
    var menu:Menu
    var cart:Cart
    var layoutComplete:Bool
    init(menu:Menu) {
        self.menu = menu
        checkout = MenuController.newRoundButton()
        cart = Storage.loadCart()
        self.menuView = MenuView(menu: menu, cart:cart)
        self.layoutComplete = false
        super.init(nibName:nil, bundle:nil)
        self.view.backgroundColor = .white
        self.title = "Menu"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     * sets up this view
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setSceneHeader()

    }
    
    override func loadView() {
        super.loadView()
        checkout.addTarget(self,
                           action:#selector(createOrder),
                           for:.touchUpInside)
        
        self.addViewController(menuView)
        self.view.addSubview(checkout)
        

    }
    
    

    /*
     * This is appropriate to set constraints on
     * constituent views as the bounds of root
     * view has been set
     */
    override func viewWillLayoutSubviews() {
        if (layoutComplete) {return}
        NSLog("\(type(of:self)).viewWillLayoutSubviews --- view bounds are set now")
        NSLog("view bounds \(self.view.bounds)")
        let safeArea = self.view.safeAreaLayoutGuide
        NSLog("safeArea \(safeArea.layoutFrame)")
        /*
        self.view.layoutMargins = UIEdgeInsets(top: safeArea.layoutFrame.origin.y,
                                               left: safeArea.layoutFrame.origin.x,
                                               bottom: safeArea.layoutFrame.height,
                                               right: safeArea.layoutFrame.width)
        */
        let margins = self.view.layoutMarginsGuide
        NSLog("margins \(margins.layoutFrame)")
        /*
        menuView.view.bounds = CGRect(x: margins.layoutFrame.origin.x,
                                      y: margins.layoutFrame.origin.y,
                                      width: margins.layoutFrame.width,
                                      height: margins.layoutFrame.height)
        */

        menuView.view.topAnchor.constraint(equalTo: margins.topAnchor, constant: 24).isActive = true
        menuView.view.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        menuView.view.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
        menuView.view.heightAnchor.constraint(equalTo: margins.heightAnchor).isActive = true
        
        checkout.frame = CGRect(x:safeArea.layoutFrame.width-100, y:safeArea.layoutFrame.height-100, width: 24, height: 24)
        checkout.bounds = CGRect(x:0, y:0, width:24, height:24)
        checkout.leftAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -100).isActive = true
        checkout.topAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -100).isActive = true
        
        //super.viewWillLayoutSubviews()
        layoutComplete = true
    }
    
    /*
    override func updateViewConstraints() {
        super.updateViewConstraints()
        NSLog("OrderPageController.updateViewConstraints")
        let safeArea = self.view.safeAreaLayoutGuide.layoutFrame
        self.view.frame  = safeArea
        for view in self.view.subviews {
            NSLog("subviews \(view.self)")
        }
        
    }
    */
    func itemInsertedInCart() {
        checkout.isEnabled = !self.cart.isEmpty
    }
    
    @objc func createOrder() {
        if (self.cart.isEmpty) {
            alert(title: "", message: "empty cart")
        }
        let checkout:CheckoutViewController = CheckoutViewController(cart:cart)
        show(checkout, sender:self)
        
    }
    
    static func  newRoundButton() -> UIButton {
        
        
        let btn:UIButton = UIButton()
        
        let imageConfiguration = UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .bold,
            scale: .large)
        let image  = UIImage(
            systemName: "cart.fill",
            withConfiguration: imageConfiguration)
        image?.withTintColor(.red, renderingMode: .alwaysOriginal)
        btn.setImage(image, for: [.normal,.selected,.highlighted])
        btn.setPreferredSymbolConfiguration(imageConfiguration, forImageIn: [.normal,.selected,.highlighted])
        let size:CGFloat = 80
        btn.bounds = CGRect(x:0,y:0, width:size, height: size)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width:0.0, height:5.0)
        btn.layer.masksToBounds = false
        btn.layer.shadowRadius = 2.0
        btn.layer.shadowOpacity = 0.5
        btn.layer.cornerRadius = 0.5*btn.bounds.size.width
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        
        return btn
        
    }
}

