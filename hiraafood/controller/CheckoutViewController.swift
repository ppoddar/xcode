import UIKit
class CheckoutViewController: UIViewController {
    var cartViewController:CartViewController
    var checkout:UIButton
    var back:UIButton
    
    init(cart:Cart) {
        self.cartViewController = CartViewController(cart: cart)
        self.checkout = UIFactory.button("proceed to checkout")
        self.back     = UIFactory.button("continue shopping")
        super.init(nibName: nil, bundle: nil)
        back.addTarget(self, action: #selector(backPage), for: .touchUpInside)
        checkout.addTarget(self, action: #selector(createOrder), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.addViewController(cartViewController)
        self.view.addSubview(checkout)
        self.view.addSubview(back)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let cartView:UIView = cartViewController.view
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
        cartView.topAnchor.constraint(equalTo: safeArea.topAnchor),
        cartView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
        cartView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
        cartView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
        
        checkout.topAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -60),
        back.topAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -100),
        checkout.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        back.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
        
    }
    
    @objc func createOrder() {
        guard  let app = UIApplication.shared.delegate as? AppDelegate
            else {return}
        
        let user:User = app.getUser()
        let next:UIViewController = DeliveryController(
            order: app.server.createOrder(items: cartViewController.modelObj.items),
            addresses: app.server.getAddresses(user: user))
        show(next, sender: self)
        /*
        let url:String = "/order/?uid=tester"
        
        let payload:Data? = cartView.modelObj.payload
        Server.singleton.post(
            url:url,
            // payload must be Array or Dictionary
        payload:payload) {result in
            switch (result) {
            case .success:
                do {
                    let json:String = try String(data:result.get(), encoding:.utf8)!
                    NSLog("--------- resposne POST /order/?uid=tester-------")
                    NSLog(json)
                    let order:Order = try JSONDecoder().decode(Order.self, from: json.data(using: .utf8)!)
                    NSLog("received create order response \(order)")
                    Server.singleton.get(url: "/user/addresses/?uid=tester") { result in
                        do {
                            switch(result) {
                            case .success:
                                let json:String = try String(data:result.get(), encoding:.utf8)!
                                let addresses:Dictionary<String,Address> = try JSONDecoder().decode(Dictionary<String,Address>.self, from: json.data(using: .utf8)!)
                                DispatchQueue.main.async {
                                    let page = DeliveryController(order:order, addresses:addresses)
                                    self.show(page, sender: self)
                                }
                                case .failure:
                                self.alert(title:"JSON decoding error", message: "String(describing: error)")
                            }
                        } catch {
                            self.alert(title: "error fetching address", message: String(describing: error))
                        }
                    }
                } catch {
                    self.alert(title: "error creating Order", message: String(describing: error))
                }
            case .failure (let error):
                self.alert(title: "", message:String(describing:error))
            }
        }
     */
    
    }
    
    
}
