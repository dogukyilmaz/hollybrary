pocketbase-up:
	docker-compose up -d --build && docker-compose logs

pocketbase-down:
	docker-compose down

flutter-up:
	flutter run -d chrome

app-run:
	pocketbase-up
	flutter-up

	.PHONY: pocketbase-up pocketbase-down flutter-up app-run