all:
	git add .
	git commit -m "update note and emacs config"
	git push

config:
	git add .
	git commit -m "update emacs config"
	git push

note:
	git add .
	git commit -m "update note"
	git push
