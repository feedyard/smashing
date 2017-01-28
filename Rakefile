require 'httparty'

load 'rake.local' if File.exist?('rake.local')

# defined in rake.local
# REGISTRY is the docker v2 compatible registry to push/pull. e.g., 'https://hub.docker.com/v2/repositories'
# LIBRARY is the repository username or organization name

task default: %w(help)

task :install_deps do
  sh 'gem install bundler'
  sh 'bundle install'
end

desc 'tags latest as next_version'
task :tag do
  sh "docker tag #{LIBRARY}/#{container_name}:latest #{LIBRARY}/#{container_name}:#{next_version}"
end

desc 'pushes the tagged version and latest to docker hub'
task :push => :tag do
  sh "docker push #{LIBRARY}/#{container_name}:#{next_version}"
  sh "docker push #{LIBRARY}/#{container_name}:latest"
end

desc 'builds image as latest'
task :build => :install_deps do
  sh "docker build -t #{LIBRARY}/#{container_name}:latest ."
end

task :help do
  puts <<-EOF
  Rakefile control of docker image ci process

  options: 
  rake build        # builds image as latest
  rake tag          # tags latest as next_version
  rake push         # pushes the tagged version and latest to REGISTRY
  EOF
end