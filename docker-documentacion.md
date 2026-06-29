# Documentacion de contenedores Docker de Sistemas Gestores de Base de Datos

![ImagenDocker](./img/docker.png)

## Contenedor de Tutorial de Docker
docker pull docker/getting-started

docker run -d -p 80:80 docker/getting started

- -d detach (El proceso del contenedor se ejecuta en background) 
- -p (port, publish) (Mapea el puerto)
- docker/getting-started (Nombre de la imagen)

## Contenedor del DBMS MariaDB
docker pull mariadb

## Contenedor de mariaDb sin volumen
docker run --name ServerMariaDBG2 -e MARIADB_ROOT_PASSWORD=123456 \
-d -p 3345:3306 e0236

## Contenedor de mariadb con volumen 
docker run --name ServerMariaDBG2 -e MARIADB_ROOT_PASSWORD=123456 \
-d -v v-mariadbg2:/var/lib/mysql -p 3345:3306 e0236

## Contenedor de Postgress con volumen
docker run --name ServerPostgresG2 -e POSTGRES_PASSWORD=123456 \ -d -p 5457:5432 -v v-postgresg2:/var/lib/postgresql/data \ eba8ddb

## Contenedor de SQLServer 2022 con Volumen
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
-u 0 \
-p 1451:1433 --name SQLServerG2 \
-d -v v-sqlserverg2:/var/opt/mssql/data \
d01cc4

## Comandos Dockerclear
| Comando | Descripcion |
| :--- | :--- |
| dockerpull nombre_imagen | **Descargar una imagen de DockerHub** ![Docker Hub](https://hub.docker.com/) |
| docker images | **Visializar las imagenes que se encuentran en el docker** |
| docker ps | **Visializa todos los contenedores que estan encendidos** |
| docker ps -a | **Visializa todos los contenedores que estan encendidos y apagados** |
| docker stop idcontenedor o nombrecontenedor| **Detiene un contenedor** |
| docker star idcontenedor o nombrecontenedor| **Enciende un contenedor** |
| docker rm id contenedor o nombrecontenedor| **Eliminar un ocntenedor si esta apagado** |
| dock rm -f idcontenedor o nombrecontenedor| **Borrar contenedor este o no encendido** |