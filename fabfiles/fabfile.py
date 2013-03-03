#!/usr/bin/env python
from fabric.api import run, env, hosts, roles,local, cd
env.use_ssh_config = True

@hosts(["h2",])
def h2_nginx_clear_cache():
    " Clear cache in nginx "
    run("rm -rf /chroots/http/data/nginx/cache/*")
    run("rm -rf /chroots/http/data/nginx/tmp/*")

def uname():
    "Little test"
    local("uname a")
