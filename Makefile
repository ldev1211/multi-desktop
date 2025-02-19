push:
	@if [ -z "$(m)" ]; then echo "Error: Missing commit message. Use 'make push m=\"your commit message\"'"; exit 1; fi
	@git add .
	@git commit -m "$(m)"
	@git push