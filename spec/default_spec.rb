require_relative 'spec_helper'

RSpec.configure do |config|
  describe 's3fs-fuse::default' do
    context 'On 12.04' do
      before(:each) do
        config.platform = 'ubuntu'
        config.version = '12.04'
      end
      context 'when the build directory does not exist' do
        before(:each) do
          config.log_level = :error
          expect(File)
            .to receive(:exist?)
            .at_least(1).times
            .and_return(false)
        end
        let(:chef_run) do
          ChefSpec::Runner.new do |node|
            node.set['memory']['total']['to_i'] = 262_144
          end.converge(described_recipe)
        end
        it 'sets up s3fs' do
          expect(chef_run).to include_recipe('build-essential')
          packages = %w(libfuse-dev fuse-utils libxml2-dev mime-support)
          packages += %w(libtool libcurl4-openssl-dev git-core automake)
          packages.each do |package|
            expect(chef_run).to install_package(package)
          end
          expect(chef_run).to create_directory('/mnt/build')
          expect(chef_run).to run_bash('Clone s3fs-fuse')
          expect(chef_run).to_not run_bash('Pull rebase s3fs-fuse')
          expect(chef_run).to run_bash('Build s3fs-fuse')
        end
      end
      context 'when the build directory exists' do
        before(:each) do
          config.log_level = :error
          expect(File)
            .to receive(:exist?)
            .at_least(1).times
            .and_return(true)
        end
        let(:chef_run) do
          ChefSpec::Runner.new do |node|
            node.set['memory']['total']['to_i'] = 262_144
          end.converge(described_recipe)
        end
        it 'sets up s3fs' do
          expect(chef_run).to include_recipe('build-essential')
          packages = %w(libfuse-dev fuse-utils libxml2-dev mime-support)
          packages += %w(libtool libcurl4-openssl-dev git-core automake)
          packages.each do |package|
            expect(chef_run).to install_package(package)
          end
          expect(chef_run).to create_directory('/mnt/build')
          expect(chef_run).to_not run_bash('Clone s3fs-fuse')
          expect(chef_run).to run_bash('Pull rebase s3fs-fuse')
          expect(chef_run).to run_bash('Build s3fs-fuse')
        end
      end
    end
    context 'On 14.04' do
      before(:each) do
        config.platform = 'ubuntu'
        config.version = '14.04'
      end
      context 'when the build directory does not exist' do
        before(:each) do
          config.log_level = :error
          expect(File)
            .to receive(:exist?)
            .at_least(1).times
            .and_return(false)
        end
        let(:chef_run) do
          ChefSpec::Runner.new do |node|
            node.set['memory']['total']['to_i'] = 262_144
          end.converge(described_recipe)
        end
        it 'sets up s3fs' do
          expect(chef_run).to include_recipe('build-essential')
          packages = %w(libfuse-dev libxml2-dev mime-support automake)
          packages += %w(libtool libcurl4-openssl-dev git-core)
          packages += %w(pkg-config libssl-dev)
          packages.each do |package|
            expect(chef_run).to install_package(package)
          end
          expect(chef_run).to create_directory('/mnt/build')
          expect(chef_run).to run_bash('Clone s3fs-fuse')
          expect(chef_run).to_not run_bash('Pull rebase s3fs-fuse')
          expect(chef_run).to run_bash('Build s3fs-fuse')
        end
      end
      context 'when the build directory exists' do
        before(:each) do
          config.log_level = :error
          expect(File)
            .to receive(:exist?)
            .at_least(1).times
            .and_return(true)
        end
        let(:chef_run) do
          ChefSpec::Runner.new do |node|
            node.set['memory']['total']['to_i'] = 262_144
          end.converge(described_recipe)
        end
        it 'sets up s3fs' do
          expect(chef_run).to include_recipe('build-essential')
          packages = %w(libfuse-dev libxml2-dev mime-support automake)
          packages += %w(libtool libcurl4-openssl-dev git-core)
          packages += %w(pkg-config libssl-dev)
          packages.each do |package|
            expect(chef_run).to install_package(package)
          end
          expect(chef_run).to create_directory('/mnt/build')
          expect(chef_run).to_not run_bash('Clone s3fs-fuse')
          expect(chef_run).to run_bash('Pull rebase s3fs-fuse')
          expect(chef_run).to run_bash('Build s3fs-fuse')
        end
      end
    end
  end
end
