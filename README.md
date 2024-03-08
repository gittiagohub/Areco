Instruções do Projeto em texto:
Clone o repositório : git clone https://github.com/gittiagohub/Areco.git
baixe e instale o gerenciador de denpendêcias boss:  https://github.com/hashload/boss/releases
abra o cmd, vá até a pasta raiz e rode o comando: "boss i"  para baixar todas as dependências
Depois compile o grupo de projetos.

Arquivo Config.ini
O arquivo de configuração fica na pasta do executável.

Contém as seguintes informações:
[API]
Port=9001
Host=127.0.0.1
[DataBaseConnection]
Database=PG
Host=localhost
Port=5432
DatabaseName=areco
User=postgres
Pass=masterkey
DLL=libpq.dll

Caso o arquivo não exista quando rodar o projeto, o mesmo será criado com os valores default acima.
Ao iniciar o app, é verificado se existe o banco de dados, caso não, o mesmo será criado.

Instruções do Projeto em video :
https://share.vidyard.com/watch/2Bb7KLQHskYWz7Vf6ouWsa?
