require 'httparty'

load 'rake.local' if File.exist?('rake.local')

# defined in rake.local
# REGISTRY is the docker v2 compatible registry to push/pull. e.g., 'https://hub.docker.com/v2/repositories'
# LIBRARY is the repository username or organization name

task default: %w(help)

task :help do
  puts <<-EOF
  Rakefile control of docker image ci process

  options: 
  rake build        # builds image as latest
  rake tag          # tags latest as next_version
  rake push         # pushes the tagged version and latest to REGISTRY
  rake test         # test to perform during build
  EOF
end