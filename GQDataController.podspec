Pod::Spec.new do |s|
  s.name         = "GQDataController"
  s.version      = "0.8"
  s.summary      = "A networking framework for MVVM in iOS"

  s.description  = <<-DESC
                   一款符合MVVM模式的网络框架，通过混合AFNetworking和Mantle让你更方便的处理网络交互。
                   DESC

  s.homepage     = "https://github.com/gonefish/GQDataController"
  s.platform     = :ios, "8.0"
  s.license      = "MIT"
  s.author       = { "Qian GuoQiang" => "gonefish@gmail.com" }
  s.source       = { :git => "https://github.com/gonefish/GQDataController.git", :tag => s.version.to_s }

  s.source_files  = "GQDataController*.{h,m}", "GQDynamicDataController.{h,m}"

  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'Mantle', '~> 2.0'
  s.dependency 'OHHTTPStubs', '>= 4.0'

end
