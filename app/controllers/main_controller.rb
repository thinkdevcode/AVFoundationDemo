class MainController < UIViewController

  def viewDidLoad
    setupVideoBackground()
    setupPaintForeground()
  end

  def setupVideoBackground
    @vImagePreview = UIView.alloc.initWithFrame(self.view.bounds)
    self.view.addSubview(@vImagePreview)

    @session = AVCaptureSession.alloc.init
    @session.sessionPreset = AVCaptureSessionPresetLow
   
    viewLayer = @vImagePreview.layer;
   
    captureVideoPreviewLayer = AVCaptureVideoPreviewLayer.alloc.initWithSession(@session)

    captureVideoPreviewLayer.frame = @vImagePreview.bounds

    @vImagePreview.layer.addSublayer(captureVideoPreviewLayer)
   
    device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
   
    error_ptr = Pointer.new(:object)

    input = AVCaptureDeviceInput.deviceInputWithDevice(device, error: error_ptr)

    if input == nil
      error = error_ptr[0]
      p "Error => #{error}"
    end

    @session.addInput(input)
   
    @session.startRunning()
  end

  def setupPaintForeground
    @paint = PaintView.alloc.initWithFrame(self.view.bounds)
    self.view.addSubview(@paint)
  end

  def canBecomeFirstResponder
    true
  end

  def motionEnded(motion, withEvent:event)
    @paint.eraseContent if motion == UIEventSubtypeMotionShake
  end

end