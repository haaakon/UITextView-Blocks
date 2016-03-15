Pod::Spec.new do |s|
  s.name         = "UITextView+Blocks"
  s.version      = "1.1.0"
  s.summary      = "Adds blocks to all UITextView delegate methods with a category, no subclassing. Also allows the use of delegate methods if no block is set."
  s.homepage     = "https://github.com/casey.oneill/UITextView-Blocks"
  s.author       = { "Håkon Bogen" => "hakon.bogen@gmail.com" }
  s.license      = "MIT"

  s.source       = { :git => "https://github.com/casey.oneill/UITextView-Blocks.git", :tag => "1.1.0" }

  s.platform     = :ios, '6.0'
  s.source_files = 'UITextView+Blocks.{h,m}'
  s.requires_arc = true
end
