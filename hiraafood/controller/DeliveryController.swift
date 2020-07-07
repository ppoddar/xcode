import UIKit

/*
 * Container view controller contains
 *     OrderViewController
 *     AddressSelector
 * Also contans subviews of a label and a button
 */
class DeliveryController: UIViewController {
    var orderViewController: OrderViewController
    var selectAddressLabel: UILabel
    var paymentButton: UIButton
    var addressSelector: AddressSelectionView
    var content:UIStackView
    var layoutComplete:Bool
    /*
     * construct with order and addresses
     * A container view controller accepts
     * all model object it requires to populate
     * its subviews and child controllers
     */
    init(order:Order, addresses:Dictionary<String,Address>) {
        orderViewController = OrderViewController(order: order)
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
        NSLog("\(type(of:self)).viewDidLoad()")
        super.viewDidLoad()
        self.view.backgroundColor = .white
        orderViewController.reloadInputViews()
        addressSelector.showAddress()
        NSLog("\(type(of:self)).view.frame \(self.view.frame)")
        NSLog("\(type(of:self)).view= \(Unmanaged.passUnretained(self.view).toOpaque())")
    }
    
    override func loadView() {
        NSLog("\(type(of:self)).loadView()")
        super.loadView()
        NSLog("\(type(of:self)).loadView() adding arranged subviews")
        content.addArrangedSubview(orderViewController.view)
        content.addArrangedSubview(selectAddressLabel)
        content.addArrangedSubview(addressSelector)
        content.addArrangedSubview(paymentButton)
        
        orderViewController.view.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        selectAddressLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        //UIFactory.border(selectAddressLabel)
        //UIFactory.border(addressSelector)

        selectAddressLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        selectAddressLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        paymentButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
        paymentButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        
        paymentButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
    
        self.view.addSubview(content)

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
        
        let orderTable = orderViewController.asTable
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
        let app = UIApplication.shared.delegate as? AppDelegate
        let invoice = app?.server.createInvoice(
            order: orderViewController.modelObj,
            billingAddress: billingAddress,
            deliveryAddress: deliveryAddress)
        let page = PaymentController(invoice: invoice!)
        
        show(page, sender: self)
    }
    
    
}

