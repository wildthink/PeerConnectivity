Pod::Spec.new do |s|
  s.name         = "PeerConnectivity"
  s.version      = "0.5.0"
  s.summary      = "Functional wrapper for Apple's MultipeerConnectivity framework."
  s.description  = <<-DESC
				A functional wrapper around the MultipeerConnectivity framework that handles edge cases of
				mesh-networks for multiple configurations and allowing access to the delegate callback using
				a '.listenOn { event in }' syntax. All you have to configure is initialize your PeerConnectionManager
				and configure your event handling and you are ready to go.
                   DESC
  s.homepage     = "https://github.com/wildthink/PeerConnectivity"
  s.license      = "MIT"
  s.author       = { "Reid Chatham" => "reid@gethermes.com" }
#  s.platform     = :ios, "9.3"
  s.ios.deployment_target = "9.3"
  s.osx.deployment_target = "10.12"
  s.source       = { :git => "https://github.com/wildthink/PeerConnectivity.git", :tag => "#{s.version}" }
  s.source_files = "Sources/*"
  s.framework    = "MultipeerConnectivity"
end
