class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    controller = MainController.alloc.initWithNibName(nil, bundle: nil)
    @window.rootViewController = controller
    @window.rootViewController.wantsFullScreenLayout = true
    application.setStatusBarStyle(UIStatusBarStyleBlackTranslucent)
    true
  end
end
