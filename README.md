## SISEDU

O repositório SISEDU foi criado para centralizar todos os repositórios utilizados pelo projeto. A forma de organização é feita através do Submodulos no GIT.

## Como fazer o clone?

```bash
git clone --recurse-submodules --remote-submodules https://<nome-do-usuario>@github.com/oliveirarafael/sisedu.git
```

Após o clone o diretório ficará conforme estrutura abaixo:

```bash
  $tree -a
  .
  ├── api-sisedu
  │   ├── .git
  │   └── .gitignore
  ├── web-sisedu
  │    ├── .git
  │    └── .gitignore
  ├── .gitmodules
  └── README.md
```

Cada repositorio tem seu commits e branches independentes.

## Recomendações

Após realizar o clone do projeto, os Submodulos ficam desanexados. Você pode verificar com o comando `git status` no raiz dos projetos: **web-sisedu** ou **api-sisedu**.

```bash
HEAD detached at 352fe3d
nothing to commit, working tree clean
```

Para solução, é necessário entrar no projeto onde esta o código fonte, exemplo: `$cd api-sisedu` e realizar o comando abaixo: 

`git switch <NOME_BRANCH> ou git checkout <NOME_BRANCH>`

Na maioria dos casos é branch **master**

Realizando esse procedimento e executando o `git status` você terá a seguinte mensagem:

```bash
No ramo master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

## Referências
+ <https://medium.com/@joao_alberto/submodules-no-git-3eef99179151>
+ <https://www.atlassian.com/git/tutorials/git-submodule>

## Ambiente de desenvolvimento

Dentro do diretório **docker** temos o arquivo **docker-compose.yml** que é responsável por subir os containers do projeto.

Para subir os containers execute o comando abaixo:

```bash
cd docker

docker-compose up -d
```
