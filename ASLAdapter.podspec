Pod::Spec.new do |s|
  s.name = 'ASLAdapter'
  s.version = '0.2.9'
  s.summary = 'Convenience adapter over ASL.'

  s.description = 'Convenience ObjC adapter over Apple System Log facility.'

  s.homepage = 'https://github.com/kibosoftware/ios-asladapter'
  s.license = { :type => 'BSD', :file => 'README.md' }

  s.author = { 'Vital Vinahradau' => 'vital.vinahradau@kibocommerce.com' }

  s.platform = :ios, '9.0'
  s.source = { :git => 'git@github.com:kibosoftware/ios-asladapter.git', :tag => s.version.to_s}

  s.public_header_files = 'ASLAdapter/*.h'
  s.source_files = 'ASLAdapter/*.[hm]'

  s.ios.frameworks = 'Foundation'

  s.requires_arc = true
  s.xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC',
  }
end
