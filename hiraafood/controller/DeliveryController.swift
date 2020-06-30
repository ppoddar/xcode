import UIKit

/*
 * Container view controller contains
 *     OrderView
 *     AddressSelector
 * Also contans subviews of a label and a button
 */
class DeliveryController: UIViewController {
    var orderView:OrderView
    var selectAddressLabel:UILabel
    var paymentButton:UIButton
    var addressSelector:AddressSelectionView
    var content:UIStackView
    var layoutComplete:Bool
    
    init(order:Order, addresses:Dictionary<String,Address>) {
        orderView       = OrderView(order: order)
        addressSelector = AddressSelectionView(addresses:addresses)
        selectAddressLabel = UIFactory.label("select delivery address")
        paymentButton      = UIFactory.button("pay")
        
        layoutComplete = false
        content = UIStackView(frame: .zero)
        content.axis = .vertical
        content.alignment = .leading
        content.distribution = .fill
        content.autoresizingMask = []
        content.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(nibName: nil, bundle: nil)
        self.view.frame = .zero
        self.view.autoresizingMask = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
 

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        print("======== viewDidLoad =========")
        super.viewDidLoad()
        self.view.backgroundColor = .white

        print("self.view frame \(self.view.frame)")
        print("self.view= \(Unmanaged.passUnretained(self.view).toOpaque())")

    }
    
    override func loadView() {
        print("======== loadView =========")
        super.loadView()
        print("loadView().adding arranged subviews")
        content.addArrangedSubview(orderView.view)
        content.addArrangedSubview(selectAddressLabel)
        content.addArrangedSubview(addressSelector)
        content.addArrangedSubview(paymentButton)
        
        self.view.addSubview(content)
        selectAddressLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        selectAddressLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        paymentButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        paymentButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        paymentButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
    
        //self.view.frame = CGRect(x:0,y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        print("self.view frame \(self.view.frame)")
        print("self.view= \(Unmanaged.passUnretained(self.view).toOpaque())")

    }
    
    override func viewWillLayoutSubviews() {
        if (layoutComplete) {return}
        super.viewWillLayoutSubviews()
        print("======== viewWillLayoutSubviews =========")
        print("self.view= \(Unmanaged.passUnretained(self.view).toOpaque())")
        print("self.view frame \(self.view.frame)")
        print("self.view bounds \(self.view.bounds)")
        print("viewWillLayoutSubviews().setting contraints")
        let safeArea = self.view.safeAreaLayoutGuide
        print("safe area frame \(safeArea.layoutFrame)")
        self.view.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let margins = self.view.layoutMarginsGuide
        
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeArea.topAnchor),
            content.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            content.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            content.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5)
        ])
//        self.view.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        content.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
//        content.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        orderView.view.frame = CGRect(
//            x: margins.layoutFrame.origin.x,
//            y: margins.layoutFrame.origin.y,
//            width: self.view.frame.width - margins.layoutFrame.width,
//            height: self.view.frame.height * 0.5)
//        orderView.view.bounds = CGRect(
//            x: 0,
//            y: 0,
//            width: self.view.frame.width - margins.layoutFrame.width,
//            height: self.view.frame.height * 0.5)
        
        
         
        
//
//        orderView.view.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        orderView.view.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
//        orderView.view.widthAnchor.constraint(equalTo: safeArea.widthAnchor).isActive = true
//        orderView.view.heightAnchor.constraint(equalToConstant: safeArea.layoutFrame.height*0.5).isActive = true
//
//        selectAddressLabel.topAnchor.constraint(equalTo: orderView.view.bottomAnchor, constant: UIConstants.VGAP).isActive = true
//        selectAddressLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//
//        addressSelector.view.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
//        addressSelector.view.topAnchor.constraint(equalTo: selectAddressLabel.bottomAnchor).isActive = true
//
//        paymentButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        paymentButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
 
        layoutComplete = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("======== viewDidLayoutSubviews =========")
        orderView.reloadInputViews()
        addressSelector.reloadInputViews()
    }
    
    
    @objc func pay () {
        let deliveryAddress = addressSelector.selectedAddress
        let billingAddress  = deliveryAddress
        let oid = orderView.order.id 
        let page = PaymentController(oid: oid,
            billingAddress: billingAddress,
            deliveryAddress: deliveryAddress)
        
        show(page, sender: self)
    }
    
}

