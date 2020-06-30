import UIKit

class AddressSelectionViewController: UIViewController {
    var addressSelectionView:AddressSelectionView
    var layoutCalled:Bool = false
    init(addresses:Dictionary<String,Address>) {
        NSLog("\(type(of:self)).init() with \(addresses)")
        self.addressSelectionView = AddressSelectionView(addresses: addresses)
        self.layoutCalled = false
        super.init(nibName: nil, bundle: nil)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.autoresizingMask = []
        self.view.frame = CGRect(x:0, y:0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height)
        self.view.isUserInteractionEnabled = true
        
        //addressSelectionView.frame = CGRect(x:0, y:100, width: 200, height: 200)
        //addressSelectionView.frame = .zero

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     */
    override func viewDidLoad() {
        //NSLog("\(type(of:self)).viewDidLoad()")
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    /*
     */
    override func loadView() {
        NSLog("\(type(of:self)).loadView()")
        super.loadView()
        self.view.addSubview(addressSelectionView)
        //self.view = addressSelectionView
        
    }
    
    /*
     * Called before this controller will layout
     * its subviews.
     * The frame and bounds of root view of this
     * controller has been computed before this
     * method is called by the framework.
     * This is appropriate method to add constraints
     * on the subviews.
     */
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if (layoutCalled) {return}
        NSLog("\(type(of:self)).viewWillLayoutSubviews() layout called \(layoutCalled)")
        layoutCalled = true
        
        let safeArea = self.view.safeAreaLayoutGuide
        let margins  = self.view.layoutMarginsGuide
        //NSLog("with frame      \(self.view.frame)")
        //NSLog("within safeArea \(safeArea.layoutFrame)")
        //NSLog("with   margin   \(margins.layoutFrame)")
 //ref: https://medium.com/@chritto/bridging-auto-layout-and-frames-9b232d84e63
   /*
        let frame:CGRect = CGRect(
            x: margins.layoutFrame.width,
            y: margins.layoutFrame.height,
            width: addressSelectionView.intrinsicContentSize.width,
            height: addressSelectionView.intrinsicContentSize.height)
        NSLog("addressSelectionView frame \(frame)")
        addressSelectionView.frame = frame
        
        addressSelectionView.backgroundColor = .red
    */
        addressSelectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        addressSelectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
    }
 
}

