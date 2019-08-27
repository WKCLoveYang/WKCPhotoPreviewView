Pod::Spec.new do |s|
s.name         = "WKCPhotoPreviewView"
s.version      = "1.0.0"
s.summary      = "图片预览视图"
s.homepage     = "https://github.com/WKCLoveYang/WKCPhotoPreviewView.git"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "WKCLoveYang" => "wkcloveyang@gmail.com" }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://github.com/WKCLoveYang/WKCPhotoPreviewView.git", :tag => "1.0.0" }
s.source_files  = "WKCPhotoPreviewView/**/*.{h,m}"
s.public_header_files = "WKCPhotoPreviewView/**/*.h"
s.frameworks = "Foundation", "UIKit"
s.requires_arc = true

end
