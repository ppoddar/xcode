
import UIKit
let checkout:UIButton = {
    let btn = UIFactory.button("Checkout")
    btn.backgroundColor = .black
    btn.tintColor = .white
    btn.isEnabled = false // disabled to start with
    return btn
}()

class OrderPageController: UIViewController {
    var menu:Menu?
    var cart:Cart = Storage.loadCart()
    
    /*
     * set constraint on each child controller views
     */
    /*/
    override func viewDidLayoutSubviews() {
        print("OrderPageController.viewDidLayoutSubviews")
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
              
        print("menu frame \(menu.frame)")
        print("cart frame \(cart.frame)")
    }
    */

    
    
    /*
     * sets up this view
     */
    override func loadView() {
        super.loadView()
        guard let menu = menu else {
            return
        }
        let menuView = MenuView(menu: menu)
        let cartView = CartView(cart: cart)
        
        NSLog("MenuViewController.loadView() -- adds subviews")

        self.addViewController(menuView)
        self.addViewController(cartView)
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
    
    @objc func itemInsertedInCart(_ notification:Notification) {
        print("MenuViewControoler receievd notifictaion \(notification)")
        checkout.isEnabled = true
        //cartView.reloadData()
    }
    
    @objc func createOrder() {
        print("----------- createOrder ------------ ")
        let url:String = "/order/?uid=tester"
        Server.singleton.post(
            url:url,
            payload:cart.items) {result in
                switch (result) {
                case .success:
                    do {
                        let order:Order = try JSONDecoder().decode(Order.self, from: result.get())
                        print("received create order response \(order)")
                        let page = AddressViewController(order:order)
                        //self.goto(page:page)
                    } catch {
                        print(error)
                        //self.raiseAlert("error creating Order", message: String(describing: error))
                    }
                case .failure (let error):
                    print(error)
                    //self.raiseAlert("", message:String(describing:error))
                }
        }
    }
}


extension Notification.Name {
    static let itemInsertedInCart = Notification.Name("itemInsertedInCart")
}

