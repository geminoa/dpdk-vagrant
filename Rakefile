task :all => [:dpdk, :pktgen] do
  puts "done." 
end

task :base do
  sh "ansible-playbook playbooks/base.yml -i hosts"
  sh "ansible-playbook playbooks/rbenv.yml -i hosts"
  sh "ansible-playbook playbooks/neobundle.yml -i hosts"
  sh "ansible-playbook playbooks/netsniff-ng.yml -i hosts"
end

# Only for DPDK server.
task :dpdk => [:base] do
  sh "ansible-playbook playbooks/dpdk.yml -i hosts"
end

# Only for pktgen server.
task :pktgen => [:base] do
  sh "ansible-playbook playbooks/pktgen.yml -i hosts"
end
