#git clone dos repositórios
ssh-agent bash -c 'ssh-add /pasta/sshFile; git clone --recurse-submodules --remote-submodules git@bitbucket.org:oliveirarrafael/sisedu.git'

#criando variaveis de ambiente
export ENV=prod
export DB_URL_JDBC=jdbc:postgresql://localhost:5432/sisedu
export DB_USERNAME=postgres
export DB_PASSWORD=postgres

#subindo o docker-compose
cd sisedu/docker
docker-compose -f docker-compose-prod.yml up -d
