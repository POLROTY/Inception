
all:
	sudo mkdir -p /home/rpol/data/mariadb
	sudo mkdir -p /home/rpol/data/wordpress
	sudo chmod 777 /home/rpol/data/mariadb
	sudo chmod 777 /home/rpol/data/wordpress
	sudo docker-compose -f ./srcs/docker-compose.yml build
	sudo docker-compose -f ./srcs/docker-compose.yml up -d

stop:
	sudo docker-compose -f ./srcs/docker-compose.yml stop

clean: stop
	sudo docker-compose -f ./srcs/docker-compose.yml down
	sudo docker system prune -af

fclean: clean
	sudo docker volume prune -f
	sudo rm -rf /home/rpol/data/wordpress
	sudo rm -rf /home/rpol/data/mariadb

re : fclean all
