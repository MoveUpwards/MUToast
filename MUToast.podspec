Pod::Spec.new do |s|
  s.name                      = "MUToast"
  s.version                   = "1.0.0"
  s.summary                   = "MUToast"
  s.homepage                  = "https://github.com/MoveUpwards/MUToast"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "Move Upwards" => "contact@moveupwards.dev" }
  s.source                    = { :git => "https://github.com/MoveUpwards/MUToast.git", :tag => s.version.to_s }
  s.swift_version             = "5.0"
  s.ios.deployment_target     = "9.0"
  s.source_files              = "Sources/**/*"
  s.frameworks                = "Foundation"
end
