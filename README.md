# jdevtools
A java development ecosystem built with vagrant and ansible that provides:
- [GitLab][1] - source control management, issue tracker and wiki
- [Jenkins][2] - continuous integration
- [Sonarqube][3] - code quality inspection tool

For now, it is intended for personal usage, say a personal/school project.  
Includes backup/restore for all applications.

# Quickstart
```
git clone https://github.com/joaocenoura/jdevtools.git jdevtools && cd $_
vagrant up
```
after the installation process is completed, go to:
- [GitLab @ http://localhost:9871/][9871]
- [Jenkins @ http://localhost:9872/][9872]
- [Sonarqube @ http://localhost:9873/][9873]

and you're done!

# Requirements
host machine must have:
- [vagrant][4] (tested with 1.7.2)
- [ansible][5] (tested with 1.9.2)

optionally, you may install:
- [apt-cacher-ng][6] - caches deb packages; useful if developing this project
- [vagrant-timezone][7] - allows to setup a timezone on the vagrant machine

# Backup & Restore
both processes are executed at the host machine:
```
./jdevtools-backup.sh
./jdevtools-restore.sh
```
note:
- backups are stored in `backups/` (this folder is automatically created when performing a backup).
- [fdupes][8] will remove any duplicated backup in order to save space
- the restore process will always fetch the latest backup.

# Configuration

## port forwarding
edit `Vagrantfile` and change the 'host' variable:
```
  config.vm.network "forwarded_port", guest: 80, host: 9871
  config.vm.network "forwarded_port", guest: 8081, host: 9872
  config.vm.network "forwarded_port", guest: 9000, host: 9873
```

## timezone
install [vagrant-timezone][7] plugin: `vagrant plugin install vagrant-timezone`  
edit `Vagrantfile` and change the 'config.timezone.value' variable:
```
  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = "Europe/Lisbon"
  end
```

## apt-cacher-ng
apt-cacher-ng is very useful when one is constantly provisioning the box. It allows to cache deb files (all except gitlab) and reduces drastically the provisioning time.  
to setup the box to use a apt-cacher-ng proxy, simply create the file `provisioning/roles/common/vars/aptcacher.yml` and add:
```
---
aptcacher_host: <apt_cacher_ng_ipaddress>:3142
```

to setup a apt-cacher server, check https://github.com/joaocenoura/apt-cacher-ng  
or use the provided script to spin up a apt-cacher server:
```
# this will checkout https://github.com/joaocenoura/apt-cacher-ng.git
# and create the provisioning/roles/common/vars/aptcacher.yml
./setup_aptcacher.sh
cd tmp/apt-cacher-ng
vagrant up
```

# Guidelines
this is just a simple guideline/workflow to use all the provided tools.
for each project:
- create a new project in [gitlab][9871]
- integrate gitlab with [jenkins][9872] by following this [guide][20]

# References
- https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/raketasks/backup_restore.md
- https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md#backup-and-restore-omnibus-gitlab-configuration
- http://doc.gitlab.com/ee/integration/jenkins.html

[1]: https://about.gitlab.com/
[2]: https://jenkins-ci.org/
[3]: http://www.sonarqube.org/
[4]: https://www.vagrantup.com/
[5]: http://www.ansible.com/
[6]: https://www.unix-ag.uni-kl.de/~bloch/acng/
[7]: https://github.com/tmatilai/vagrant-timezone
[8]: https://github.com/adrianlopezroche/fdupes

[20]: http://doc.gitlab.com/ee/integration/jenkins.html

[9871]: http://localhost:9871
[9872]: http://localhost:9872
[9873]: http://localhost:9873