task :all => [:main] do
  puts "done." 
end

task :main do
  sh "ansible-playbook -i hosts site.yml"
end

