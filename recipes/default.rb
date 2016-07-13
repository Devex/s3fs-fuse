#
# Cookbook Name:: s3fs-fuse
# Recipe:: default
#
# Copyright 2015, Devex
#
# All rights reserved - Do Not Redistribute
#

include_recipe('build-essential')

release = node[:platform_version].to_f
packages = %w(libfuse-dev libxml2-dev mime-support automake)
packages += %w(libtool libcurl4-openssl-dev git-core)
packages += %w(pkg-config libssl-dev) if release.to_f >= 14.04
packages += %w(fuse-utils) if release.to_f < 14.04
packages.each { |pkg| package pkg }

directory '/mnt/build'
bash 'Clone s3fs-fuse' do
  cwd '/mnt/build'
  code <<-EOH
    git clone https://github.com/s3fs-fuse/s3fs-fuse
  EOH
  not_if { ::File.exist?('/mnt/build/s3fs-fuse') }
end
bash 'Pull rebase s3fs-fuse' do
  cwd '/mnt/build/s3fs-fuse'
  code <<-EOH
    git pull --rebase
  EOH
  only_if { ::File.exist?('/mnt/build/s3fs-fuse') }
end
bash 'Build s3fs-fuse' do
  cwd '/mnt/build/s3fs-fuse'
  code <<-EOH
    ./autogen.sh
    ./configure --prefix=/usr --with-openssl
    make
    make install
  EOH
end
