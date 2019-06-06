server '45.79.188.198', user: 'deploy', roles: %w{web app db}

set :deploy_to, '/home/deploy/30warren/full/production'
set :branch, :master
