# docker_jira

1. 다음의 환경 변수 선언 필요 (.env 선언)
```
TZ=Asia/Seoul

MYSQL_VERSION=8.0.31
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_ROOT_PASSWORD=changeit
MYSQL_DATABASE=jira
MYSQL_USER=jira
MYSQL_PASSWORD=changeit

JIRA_VERSION=9.5.0
```


2. 실행
```
docker-compose up -d
```
