import UIKit

/*
 * Container view controller contains
 *     OrderView
 *     AddressSelector
 * Also contans subviews of a label and a button
 */
class DeliveryController: UIViewController {
    var orderView: OrderView
    var selectAddressLabel: UILabel
    var paymentButton: UIButton
    var addressSelector: AddressSelectionView
    var content:UIStackView
    var layoutComplete:Bool
    
    let server:ServerProtocol = MockServer()
    
    init(order:Order, addresses:Dictionary<String,Address>) {
        orderView          = OrderView(order: order)
        addressSelector    = AddressSelectionView(addresses:addresses)
        selectAddressLabel = UIFactory.label("select delivery address")
        paymentButton      = UIFactory.button("pay")
        content = UIStackView(frame: .zero)
        layoutComplete = false
        
        super.init(nibName: nil, bundle: nil)

        content.axis = .vertical
        content.alignment = .center
        content.distribution = .fill
        content.spacing = UIConstants.VGAP
        content.autoresizingMask = []
        content.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.frame = .zero
        self.view.autoresizingMask = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        NSLog("======== viewDidLoad =========")
        super.viewDidLoad()
        self.view.backgroundColor = .white
        orderView.reloadInputViews()
        addressSelector.showAddress()
        NSLog("\(type(of:self)).view.frame \(self.view.frame)")
        NSLog("\(type(of:self)).view= \(Unmanaged.passUnretained(self.view).toOpaque())")
    }
    
    override func loadView() {
        NSLog("======== \(type(of:self)).loadView =========")
        super.loadView()
        NSLog("loadView().adding arranged subviews")
        content.addArrangedSubview(orderView.view)
        content.addArrangedSubview(selectAddressLabel)
        content.addArrangedSubview(addressSelector)
        content.addArrangedSubview(paymentButton)
        
        orderView.view.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        selectAddressLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        UIFactory.border(selectAddressLabel)
        UIFactory.border(addressSelector)

        self.view.addSubview(content)
        selectAddressLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        selectAddressLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        paymentButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        paymentButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        
        paymentButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
    
        //self.view.frame = CGRect(x:0,y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        NSLog("\(type(of:self)).view.frame \(self.view.frame)")
        NSLog("\(type(of:self)).view \(Unmanaged.passUnretained(self.view).toOpaque())")

    }
    
    override func viewWillLayoutSubviews() {
        if (layoutComplete) {return}
        super.viewWillLayoutSubviews()
        NSLog("======== \(type(of:self)).viewWillLayoutSubviews =========")
        NSLog("\(type(of:self)).view= \(Unmanaged.passUnretained(self.view).toOpaque())")
        NSLog("\(type(of:self)).view frame \(self.view.frame)")
        NSLog("\(type(of:self)).view bounds \(self.view.bounds)")
        NSLog("\(type(of:self)).viewWillLayoutSubviews().setting contraints")
        let safeArea = self.view.safeAreaLayoutGuide
        NSLog("\(type(of:self)).safe area frame \(safeArea.layoutFrame)")
        self.view.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
//        let margins = self.view.layoutMarginsGuide
        
        let orderTable = orderView.asTable
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeArea.topAnchor),
            content.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            content.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            content.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.6),
            
            orderTable.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            orderTable.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            orderTable.topAnchor.constraint(equalTo: content.topAnchor),
        ])
        layoutComplete = true
    }
     
    @objc func pay () {
        let deliveryAddress = addressSelector.selectedAddress
        let billingAddress  = deliveryAddress
        let invoice = server.createInvoice(
            order: orderView.modelObj,
            billingAddress: billingAddress,
            deliveryAddress: deliveryAddress)
        let page = PaymentController(invoice: invoice)
        
        show(page, sender: self)
    }
    
    
}

