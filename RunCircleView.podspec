Pod::Spec.new do |s|

s.name     = 'RunCircleView'

s.version  = '1.0.1'

s.license  = { :type => 'MIT' }

s.summary  = '分段式跑马灯，注册不同类型item 轮播'

s.description = <<-DESC
                   支持xib创建控件。
                   DESC
                   
s.homepage = 'https://github.com/lanligang/EntertainingDiversions'

s.authors  = { 'LenSky' => 'lslanligang@sina.com' }

s.source   = { :git => 'https://github.com/lanligang/EntertainingDiversions.git', :tag => s.version}

s.source_files = 'RunCircleView/RunCircleView/CycleRunCustom/*.{h,m}'

s.requires_arc = true

s.platform     = :ios, '7.0'

s.ios.frameworks = ['UIKit', 'CoreGraphics', 'Foundation']


end