name             "kannel"
maintainer       "Krishnen Chedambarum"
maintainer_email "krishnen.chedambarum@logossmartcard.com"
license          "MIT"
description      "Installs/Configures Kannel"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends "apache2", "~> 1.4.0"

%w[redhat centos].each do |os|
  supports os
end

