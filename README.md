# LEIA-ME #

Aqui estão algumas informações importantes para a utilização deste repositório e do software em questão.

### Ao que se destina esse repositório? ###

* Resumo Rápido
* Versionamento
* Documentação de mudanças de escopo

### Como faço para configurar o ambiente? ###

* Em termos simples para efetuar qualquer operação de alteração no sistema ADS é preciso ter uma base de dados de teste rodando sobre o Postgresql, arquivo ads.conf apontando para o IP desta base e o projeto aberto dentro da IDE Delhi.
 No diretório fixtures deverá estar instruções SQL detalhadas para a criação ou a importação de uma base completa.
Uma máquina virtual com o sistema operacional Windows XP foi criada e disponibilizada já com a IDE Delphi instalada e um mapeamento para um diretório no computador hospedeiro onde deverá estar o código fonte.
* Configuração

* Dependências 
      * IDE Delphi para compilar o código fonte.  
      * Base de Dados para testes.  
      * Controle de versão Git para publicar alterações.
* Configuração do Banco de Dados
* Como executar testes
* Instruções de Deploy
    * Após o Build do executável substituir o arquivos ADS.exe presente em [\\\\192.168.100.71\\exec\\ADS_ARDIGITAL](\\\\192.168.100.71\\exec\\ADS_ARDIGITAL). Certificar de que o arquivo foi realmente substituído por se tratar de compartilhamento utilizado em diferentes locais e estar rodando sobre SAMBA.
### Orientações para Contribuições no Código ###

* Escrevendo Testes
* Revisão de Código
* Outras orientações

### Com quem devo falar? ###

* Admin ou Proprietário do Repositório
* Operacional de envio de SEDEX (atualmente, setembro de 2015, Iraci Silva, Jeane Aguair, Patricia Firmino)