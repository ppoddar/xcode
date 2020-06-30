import UIKit
//import Razorpay
class PaymentController: BaseViewController {
    var billingAddress:Address = Address()
    var deliveryAddress:Address = Address()
    var oid:String
    var invoice:Invoice
    init(oid:String, billingAddress:Address, deliveryAddress:Address) {
        self.oid = oid
        self.invoice = Invoice()
        self.billingAddress = billingAddress
        self.deliveryAddress = deliveryAddress
        super.init(nibName:nil, bundle:nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createInvoice()
         //showPaymentForm(invoice: invoice)
        // Do any additional setup after loading the view.
    }
    
    /*
     * server call to create a bill
     */
    func createInvoice() {
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let user:User = User()//app.getUser()
        let urlTemplate = "/invoice/?uid=%@&oid=%@"
        let oid = "1234"
        let url = String(format:urlTemplate, user.name, oid)
        var addresses = IndexedDictionary<Address>()
        addresses.setValue(key:"billingAddress", value:billingAddress)
        addresses.setValue(key:"deliveryAddress", value:deliveryAddress)
        let payload:Data? = JSONHelper().jsonFromDict(type:Address.self, dict:addresses)
        
        Server.singleton.post(url: url,
            payload: payload) { result in
            do {
                switch (result) {
                    case .success:
                        self.invoice = try self.convertServerResponse(result)
                        self.setupView()
                    case .failure (let error):
                        self.raiseAlert("Billing Error", message: String(describing: error))
                }
            } catch {
                
            }
        }
    }
    
    func setupView() {
        let bill = InvoiceView(invoice: invoice)
        self.view.addSubview(bill)
        
        let payButton = UIFactory.button("Pay")
        payButton.addTarget(self, action: #selector(showPaymentForm), for: .touchUpInside)
    }
    
    @objc func showPaymentForm(){
        let app = UIApplication.shared.delegate as! AppDelegate
        let user = User()//app.getUser()
        let options: [String:Any] = [
            "amount": invoice.total, //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "\(app.name) order \(invoice.id)",
            "order_id": invoice.payorder,
            "image": app.logo,
            "name":  app.name,
            "prefill": [
                "contact": user.phone,
                "email": user.email
            ],
            "theme": [
                "color": "#F37254"
            ]
        ]
        NSLog("Razor pay options \(options)")
        //razorpay.open(options)
    }

   

}
