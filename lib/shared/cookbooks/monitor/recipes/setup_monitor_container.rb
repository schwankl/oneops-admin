
vol_mon_mount_point = "/Users/mike/vol-mon"
gem_install_dir = "/Users/mike/.rvm/gems/ruby-2.2.4/gems/oneops-admin-1.0.0"
platform_id = node['workorder']['box']['ciId']

cmd = "docker service create --replicas 1 "
cmd += "--mount type=bind,source=#{vol_mon_mount_point}/#{node['workorder']['box']['ciId']},target=/etc/nagios3 "
cmd += "--mount type=bind,source=#{gem_install_dir}/bin/logstash-forwarder,target=/mnt/logstash-forwarder "
cmd += "--mount type=bind,source=/opt/nagios/libexec,target=/opt/nagios/libexec "
cmd += "--mount type=bind,source=#{vol_mon_mount_point}/logstash-config,target=/etc/logstash "
cmd += "-e PLATFORM_ID=#{platform_id} "
cmd += "--host dalstg2.collector.mschwan.oneops.walmart.com:172.29.203.190 "
cmd += "--name #{platform_id} nagios-lsf-supervisord"

execute "#{cmd}"