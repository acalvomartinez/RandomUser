platform :ios, '8.0'
use_frameworks!

def running_pods
  pod 'BothamUI', '~> 2.0'
  pod 'SDWebImage'
  pod 'Result'
  pod 'SwiftyUserDefaults'
end

def testing_pods
  pod 'Result'
  pod 'OHHTTPStubs/Swift'
  pod 'Nimble', '~> 5.0'
  pod 'KIF', '~> 3.0', :configurations => ['Debug']
end

target 'RandomUser' do
  running_pods
end

target 'RandomUserTests' do
  running_pods
  testing_pods
end
