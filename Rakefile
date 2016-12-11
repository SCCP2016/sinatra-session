task :default => [:start]

task :init do
  system "bundle install --path vender/bundle --without production"
end

task :test do
  system "bundle exec ruby ./test/test_app.rb"
end

task :start do
  system "bundle exec rackup -o 0.0.0.0"
end
