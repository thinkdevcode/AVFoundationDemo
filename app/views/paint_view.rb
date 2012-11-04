class PaintView < UIView
  def initWithFrame(ect)
    if super
      self.opaque = false;
      @paths = []
    end
    self
  end

  def drawRect(rect)
    UIColor.clearColor.set
    UIBezierPath.bezierPathWithRect(rect).fill
    @paths.each do |path, color|
      color.set
      path.stroke
    end
  end

  def touchesBegan(touches, withEvent:event)
    bp = UIBezierPath.alloc.init
    bp.lineWidth = 3.0
    random_color = UIColor.blackColor
    @paths << [bp, random_color]
  end

  def touchesMoved(touches, withEvent:event)
    touch = event.touchesForView(self).anyObject
    point = touch.locationInView(self)
    if @previousPoint and !@paths.empty?
      bp = @paths.last.first
      bp.moveToPoint(@previousPoint)
      bp.addLineToPoint(point)
    end
    @previousPoint = point
    setNeedsDisplay
  end

  def touchesEnded(touches, withEvent:event)
    @previousPoint = nil
  end

  def eraseContent
    @paths.clear
    setNeedsDisplay
  end
end