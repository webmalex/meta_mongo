include .env

main: ver build down rm up ps push 

ver:
	docker run --rm -it -v `pwd`/.env:/src/.env:cached $(REG)/$(GULP) ver

D=docker rm -f $(SRV) ||:; docker-compose run --rm -d -p $(PORT):27017 --name $(SRV)
_=

ci rt:
	time docker-compose build $@
push pull ps logs build:
	docker-compose $@
down:
	docker-compose $@ --remove-orphans
run-rt:
	$D rt $_
run-ci:
	$D ci $_
log:
	docker-compose logs -f rt
up:
	docker-compose up -d rt
rm:
	docker rm -f $(SRV) ||:


ID=`docker-compose ps -q`
sh:
	docker exec -it $(ID) bash
diff:
	docker diff $(ID)
