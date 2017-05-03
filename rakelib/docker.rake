task :install_deps do
  sh 'gem install bundler'
  sh 'bundle install'
end

task :test do
  sh "docker run -p 80:3030 #{LIBRARY}/#{container_name}:latest sleep 10"
end

desc 'tags latest as next_version'
task :tag do
  sh "docker tag #{LIBRARY}/#{container_name}:latest #{LIBRARY}/#{container_name}:#{next_version}"
  sh "git tag #{next_version}"
  sh "git push --tags"
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