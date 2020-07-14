import UIKit

class PoemViewController: UIViewController {
    var index:Int = 0
    var original:Bool = true
    var poemView:PoemView
    let translate:TranslateButton
    let audio:SoundPlayerButton
    let share:ShareButton
    let nextPoem:NavigationButton
    let prevPoem:NavigationButton

    //var layoutComplete:Bool = false
    var openedAudioPlayer = false
    
    init()  {
        self.poemView  = PoemView()
        self.translate = TranslateButton()
        self.audio     = SoundPlayerButton()
        self.share     = ShareButton()
        self.nextPoem  = NavigationButton(forward:true)
        self.prevPoem  = NavigationButton(forward:false)
        
        super.init(nibName: nil, bundle: nil)
    
        let poem:Poem = Poems.instance[index][original ? 0 : 1]

        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.isUserInteractionEnabled = true
        self.poemView.isUserInteractionEnabled = true
        self.poemView.font = original ? UIStyle.BENGALI_FONT : UIStyle.ENGLISH_FONT
        self.title = poem.title
        self.poemView.text = FileReader.read(fileName: poem.path)
        self.audio.audio = poem.audio

        self.translate.controller = self
        nextPoem.controller = self
        prevPoem.controller = self
        audio.controller = self
        share.controller = self

        self.nextPoem.controller = self
        self.prevPoem.controller = self
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var description: String {
        return "poem \(String(describing: self.title)) index=\(index) original=\(original)"
    }
    /*
     * Shows original version of a poem at
     * given index at original/translated form
     */
     func showPoem(index:Int, original:Bool) {
        self.index = index
        self.original   = original
        let poem:Poem = Poems.instance[index][original ? 0:1]
        
        print("poem view frame (before text)=\(poemView.frame)")
        print("poem view bounds (before text)=\(poemView.bounds)")
        print("poem view content size (before text)=\(poemView.contentSize)")

        self.poemView.text = poem.text()
        print("poem view frame (after text)=\(poemView.frame)")
         print("poem view bounds (after text)=\(poemView.bounds)")
         print("poem view content size (after text)=\(poemView.contentSize)")
        self.audio.audio = poem.audio
        self.title = poem.title
        self.poemView.font = original ? UIStyle.BENGALI_FONT : UIStyle.ENGLISH_FONT
        self.poemView.scrollRangeToVisible(NSRange(location:0, length:0))

        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.audio.addTarget(self,
            action: #selector(openAudioPlayer),
            for: .touchUpInside)
   }
    /*
     * show next poem with given navigation controller
     */
    func showNext() {
        let nextIndex = (index+1)%Poems.instance.size
        showPoem(index:nextIndex, original: self.original)
    }
    /*
     * show previous poem with given navigation controller
     */
    func showPrev() {
        let prevIndex = (index == 0)
            ? (Poems.instance.size - 1)
            : (index - 1)
        showPoem(index:prevIndex , original: self.original)
    }
    
    func showReverse() {
        showPoem(index: self.index, original: !original)
    }
    // -----------------------------------
    //   controller lifecycle
    // -----------------------------------
    override func loadView() {
        NSLog("\(type(of:self)).loadView() poem:\(index) original:\(original)")
        super.loadView()
        self.view.addSubview(poemView)
        //poemView.backgroundColor = .red
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        /* must define view frame for scrollable view to display */
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.frame = CGRect(
            x:0,y:safeArea.layoutFrame.height,width: w,height: h)
        self.poemView.frame = self.view.frame
        self.poemView.bounds = self.view.bounds
                NSLog("self.view.frame=\(self.view.frame)")
        NSLog("self.poemview.frame=\(self.poemView.frame)")
    }
    /*
     * must set text for UITextView
    */
    override func viewDidLoad() {
         NSLog("\(type(of:self)).viewDidLoad() ")
         super.viewDidLoad()
         self.showPoem(index: index, original: original)
     }
    
    override func viewWillAppear(_ animated: Bool) {
        NSLog("\(type(of:self)).viewWillAppear() ")
        super.viewWillAppear(animated)
        setupToolbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("\(type(of:self)).viewDidAppear() ")
        if openedAudioPlayer {
            NSLog("\(type(of:self)).viewDidAppear openedAudioPlayer=\(openedAudioPlayer)")
            self.audio.close()
            openedAudioPlayer = false
        }
    }
    
    override func viewWillLayoutSubviews() {
        NSLog("\(type(of:self)).viewWillLayoutSubviews() ")
        let topMargin:CGFloat    = 80
        let leftMargin:CGFloat   = 10
        let rightMargin:CGFloat  = 8
        let bottomMargin:CGFloat = 8
        
        self.poemView.textContainerInset = UIEdgeInsets(
            top: topMargin,
            left: leftMargin,
            bottom: bottomMargin,
            right: rightMargin)
        
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.pin(self.view.superview)
        self.poemView.pin(safeArea)
       
    }
    
     
    var toolbar:UIToolbar {
        let tb = UIToolbar(frame:
               CGRect(
                   x:0,
                   y:UIScreen.main.bounds.height-40,
                   width: UIScreen.main.bounds.width,
                   height: 40))
        
        
        tb.isHidden = false
        tb.barStyle = UIBarStyle.default
        tb.isUserInteractionEnabled = true
        return tb
    }
    func setupToolbar() {
          self.navigationController?.isToolbarHidden = false
          let space    = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          toolbarItems = [
              space,
              UIBarButtonItem(customView: self.prevPoem),space,
              UIBarButtonItem(customView: self.translate),space,
              UIBarButtonItem(customView: self.audio),space,
              UIBarButtonItem(customView: self.share),space,
              UIBarButtonItem(customView: self.nextPoem),
              space
          ]
          toolbar.isUserInteractionEnabled = true
      }
    
    @objc func openAudioPlayer() {
        self.openedAudioPlayer = true
        self.navigationController?.show(
            self.audio.audioPlayerController, sender: self)
        self.audio.play()
    }
}


    


