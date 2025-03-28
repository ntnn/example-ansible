# example ansible

A small repo showing what a typical ansible workspace might look like.

This would be a typical repository imported into an AWX instance as
a source of playbooks, where local VMs and containers are used for
testing and development while the real inventory, scheduling, etc.pp. is
managed in AWX.

## Dependencies

- ansible
- ansible-lint
- ansible-collection-community-general

`ansible-collection-community-general` contains many useful roles and
plugins for ansible - e.g. the connection plugin
`community.general.incus` which allows executing roles directly on incus
VMs and containers without further setup.

## Usage

Run `vms-deploy.bash` to deploy some VMs to run the playbooks on. Every
VM will have the prefix `example`.

Run `vms-teardown.bash` to delete all VMs with the prefix `example-`.

After deploying the VMs verify that ansible works by running the `ping`
ansible module on all VMs:

```bash
ansible -m ping all
```

Alternatively run the `ping` playbook:

```bash
ansible-playbook playbooks/ping.yaml
```

After verifying that ansible works, run the `nginx-hello-world`
playbook, which installs and configures nginx on all VMs to serve
a simple html file on port 8080.

```bash
ansible-playbook playbooks/nginx-hello-world.yaml
```

Afterwards each VM will offer the `index.html` returning `Hello, world!` on port 8080:

```bash
incus list --format csv,noheader | awk -F, '{ print $3 }' | awk '{ print $1 }' | xargs -I {} curl http://{}:8080
```

When writing playbooks, always lint them with `ansible-lint`:

```bash
ansible-lint
```

`ansible-lint` can also automatically fix some issues, like quoting, by
passing `--fix`:

```bash
ansible-lint --fix
```
