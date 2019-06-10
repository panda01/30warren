server 'dev.30warren.com', user: 'deploy', roles: %w{web app db}

set :deploy_to, '/home/deploy/30warren/full/staging'
set :branch, :master
