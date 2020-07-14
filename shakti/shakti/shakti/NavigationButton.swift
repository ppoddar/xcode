import UIKit

class NavigationButton: UIButton {
    var controller:PoemViewController?
    var forward:Bool
    
    init(forward:Bool) {
        self.forward = forward
        super.init(frame:.zero)
        let systemName:String = forward ? "arrowtriangle.right.fill" : "arrowtriangle.left.fill"
        self.setImage(UIImage(systemName: systemName),
            for: .normal)
        self.setTitleColor(.blue, for: .normal)
        self.tintColor =  .blue
        
        self.addTarget(self, action: #selector(showPoem), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showPoem() {
        if forward {
            controller?.showNext()
        } else {
            controller?.showPrev()
        }
    }
    
}

