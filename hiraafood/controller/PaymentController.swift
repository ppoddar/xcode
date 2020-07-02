import UIKit
//import Razorpay
class PaymentController: BaseViewController {
    var invoiceView:InvoiceView
    //var billingAddress:Address  = Address()
    //var deliveryAddress:Address = Address()
    var content:UIStackView
    var paymentButton:UIButton
    var layoutComplete:Bool
     init(invoice:Invoice) {
        self.invoiceView = InvoiceView(invoice:invoice)
        self.content = UIStackView(frame: .zero)
        //self.billingAddress = billingAddress
        //self.deliveryAddress = deliveryAddress
        self.content = UIStackView()
        self.paymentButton   = UIFactory.button("pay")
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
         invoiceView.reloadInputViews()
         NSLog("\(type(of:self)).view.frame \(self.view.frame)")
         NSLog("\(type(of:self)).view= \(Unmanaged.passUnretained(self.view).toOpaque())")
     }
     
     override func loadView() {
         NSLog("======== \(type(of:self)).loadView =========")
         super.loadView()
         NSLog("loadView().adding arranged subviews")
         content.addArrangedSubview(invoiceView.view)
         content.addArrangedSubview(paymentButton)
         
         invoiceView.view.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)

         self.view.addSubview(content)
         paymentButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.vertical)
         paymentButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
         
         paymentButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
     
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
         
         let bill = invoiceView.asTable
         NSLayoutConstraint.activate([
             content.topAnchor.constraint(equalTo: safeArea.topAnchor),
             content.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             content.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
             content.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.6),
             
             bill.leadingAnchor.constraint(equalTo: content.leadingAnchor),
             bill.trailingAnchor.constraint(equalTo: content.trailingAnchor),
             bill.topAnchor.constraint(equalTo: content.topAnchor),
         ])
         layoutComplete = true
     }
      
     
     @objc func pay () {
         
     }
     
     
 }

