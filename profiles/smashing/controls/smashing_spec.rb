# frozen_string_literal: true
#
control 'packages' do
  impact 1.0
  title 'confirm package installation'
  desc 'confirm all desired packages are installed'
  describe command('apk info') do
    its('stdout') { should include ('tzdata') }
    its('stdout') { should include ('curl') }
    its('stdout') { should include ('wget') }
    its('stdout') { should include ('bash') }
    its('stdout') { should include ('ruby') }
    its('stdout') { should include ('ruby-bundler') }
    its('stdout') { should include ('nodejs') }
    its('stdout') { should include ('ruby-dev') }
    its('stdout') { should include ('g++') }
    its('stdout') { should include ('musl-dev') }
    its('stdout') { should include ('make') }
  end
end

control 'smashing version' do
  impact 1.0
  title 'confirm smashing version installed'
  desc 'confirm version reported by smashing matches the desired version'
  describe command('gem list smashing') do
    its('stdout') { should include ('1.1.0') }
  end
end

control 'dashboard setup completed' do
  impact 1.0
  title 'confirm smashing new command executed'
  desc 'check for existence of dashbaord folder'
  describe command('ls -l dashboard') do
    its('stdout') { should include ('dashboard') }
  end
end
