PUBLIC_KEY = $(shell cat id_ed25519.pub)

clear:
	multipass delete --all --purge

start:
	multipass launch 22.04 --name koungvm --cloud-init user-data.yml
	@multipass ls

gen: check
	sed -e "s/id_ed25519.pub/$(PUBLIC_KEY)/g" template/user-data.yml > user-data.yml

check: id_ed25519 id_ed25519.pub
	@:

id_ed25519 id_ed25519.pub:
	ssh-keygen -t ed25519 -f $(PWD)/id_ed25519 -q -N ""
