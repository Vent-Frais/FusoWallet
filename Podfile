platform :ios,'11.0'
inhibit_all_warnings!
use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
end

target 'FusoWallet' do
    pod 'IrohaCrypto'
    pod 'SocketRocket'
    pod 'ZXNavigationBar'
    pod 'AFNetworking'
    pod 'MJExtension'
    pod 'FearlessUtils', :git => 'https://github.com/soramitsu/fearless-utils-iOS.git', :commit => 'f821a9352d1592d60a43b7ced4fe977373d445a4'
    pod 'IQKeyboardManager'
    pod 'ScaleCodec'
    pod 'SGQRCode'
    pod 'ISMessages'
#    pod 'RobinHood'
#    pod 'SoraUI'
#    pod 'SoraFoundation', '~> 0.8.0'
#    pod 'CommonWallet/Core', :git => 'https://github.com/soramitsu/Capital-iOS.git', :commit => '725cefe1d0fa1ea8456580289b326558b13225c2'
#    pod 'ReachabilitySwift'
#    pod 'Starscream', :git => 'https://github.com/ERussel/Starscream.git', :branch => 'feature/without-origin'
#    pod 'R.swift', :inhibit_warnings => true
#    pod 'SwiftyBeaver'
#    pod 'TrustWalletCore'
#    pod 'SoraKeystore'
#    pod 'CommonWallet'
end
