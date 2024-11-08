//Aluno: Carlos Henrique Andrade Weege

program ArvoreBinariaUFMunicipios;

type
PtrNoMunicipio = ^NoMunicipio;
NoMunicipio = record
  esq, dir: PtrNoMunicipio;
  nome: string;
end;

PtrNoUF = ^NoUF;
NoUF = record
  esq, dir: PtrNoUF;
  sigla: string;
  municipios: PtrNoMunicipio;
  quantidade: integer;
end;

var
raizUF: PtrNoUF;

procedure inicializarArvores;
begin
  raizUF := nil;
end;

function criarNoUF(sigla: string): PtrNoUF;
var
novoNo: PtrNoUF;
begin
  new(novoNo);
  novoNo^.sigla := sigla;
  novoNo^.esq := nil;
  novoNo^.dir := nil;
  novoNo^.municipios := nil;
  novoNo^.quantidade := 0;
  criarNoUF := novoNo;
end;

function criarNoMunicipio(nome: string): PtrNoMunicipio;
var
novoNo: PtrNoMunicipio;
begin
  new(novoNo);
  novoNo^.nome := nome;
  novoNo^.esq := nil;
  novoNo^.dir := nil;
  criarNoMunicipio := novoNo;
end;

procedure inserirUF(var raiz: PtrNoUF; sigla: string);
begin

  if raiz = nil then
  raiz := criarNoUF(sigla)
  
  else if sigla < raiz^.sigla then
  inserirUF(raiz^.esq, sigla)
  
  else if sigla > raiz^.sigla then
  inserirUF(raiz^.dir, sigla);
  
end;

procedure inserirMunicipio(var raiz: PtrNoMunicipio; nome: string);
begin

  if raiz = nil then
  raiz := criarNoMunicipio(nome)
  
  else if nome < raiz^.nome then
  inserirMunicipio(raiz^.esq, nome)
  
  else if nome > raiz^.nome then
  inserirMunicipio(raiz^.dir, nome);
  
end;

function buscarUF(raiz: PtrNoUF; sigla: string): PtrNoUF;
begin

  if (raiz = nil) or (raiz^.sigla = sigla) then
  buscarUF := raiz
  
  else if sigla < raiz^.sigla then
  buscarUF := buscarUF(raiz^.esq, sigla)
  
  else
  buscarUF := buscarUF(raiz^.dir, sigla);
  
end;

procedure incluirMunicipio;
var
siglaUF, nomeMunicipio: string;
noUF: PtrNoUF;
begin

  write('Digite a sigla da UF: ');
  readln(siglaUF);
  
  write('Digite o nome do município: ');
  readln(nomeMunicipio);
  
  noUF := buscarUF(raizUF, siglaUF);
  if noUF = nil then
  begin
    inserirUF(raizUF, siglaUF);
    noUF := buscarUF(raizUF, siglaUF);
  end;
  
  inserirMunicipio(noUF^.municipios, nomeMunicipio);
  noUF^.quantidade := noUF^.quantidade + 1;
  
  writeln('Município ', nomeMunicipio, ' inserido na UF ', siglaUF);
end;

function removerMenorValor(var raiz: PtrNoMunicipio): string;
var
nome: string;
aux: PtrNoMunicipio;
begin
  if raiz^.esq = nil then
  begin
    nome := raiz^.nome;
    aux := raiz;
    raiz := raiz^.dir;
    dispose(aux);
    removerMenorValor := nome;
  end
  else
  removerMenorValor := removerMenorValor(raiz^.esq);
end;

function removerMunicipio(var raiz: PtrNoMunicipio; nome: string): boolean;
var
aux: PtrNoMunicipio;
begin

  if raiz = nil then
  removerMunicipio := false
  
  else if nome < raiz^.nome then
  removerMunicipio := removerMunicipio(raiz^.esq, nome)
  
  else if nome > raiz^.nome then
  removerMunicipio := removerMunicipio(raiz^.dir, nome)
  
  else
  begin
    if (raiz^.esq = nil) and (raiz^.dir = nil) then //Nó sem Filhos (Folha)
    begin
      dispose(raiz);
      raiz := nil;
    end
    else if raiz^.esq = nil then // Nó com um Filho
    begin
      aux := raiz;
      raiz := raiz^.dir;
      dispose(aux);
    end
    else if raiz^.dir = nil then  // Nó com um Filho
    begin
      aux := raiz;
      raiz := raiz^.esq;
      dispose(aux);
    end
    else  
    raiz^.nome := removerMenorValor(raiz^.dir);//Nó com Dois Filhos
    
    removerMunicipio := true;
    
  end;
  
end;

function removerMenorValorUF(var raiz: PtrNoUF): string;
var
sigla: string;
aux: PtrNoUF;
begin

  if raiz^.esq = nil then
  begin
    sigla := raiz^.sigla;
    aux := raiz;
    raiz := raiz^.dir;
    dispose(aux);
    removerMenorValorUF := sigla;
  end
  
  else
  removerMenorValorUF := removerMenorValorUF(raiz^.esq);
  
end;

function removerNoUF(var raiz: PtrNoUF; sigla: string): boolean;
var
aux: PtrNoUF;
begin

  if raiz = nil then
  removerNoUF := false
  
  else if sigla < raiz^.sigla then
  removerNoUF := removerNoUF(raiz^.esq, sigla)
  
  else if sigla > raiz^.sigla then
  removerNoUF := removerNoUF(raiz^.dir, sigla)
  
  else
  begin
    if (raiz^.esq = nil) and (raiz^.dir = nil) then  //Nó sem Filhos (Folha)
    begin
      dispose(raiz);
      raiz := nil;
    end
    else if raiz^.esq = nil then // Nó com um Filho
    begin
      aux := raiz;
      raiz := raiz^.dir;
      dispose(aux);
    end
    else if raiz^.dir = nil then  // Nó com um Filho
    begin
      aux := raiz;
      raiz := raiz^.esq;
      dispose(aux);
    end
    else  
    raiz^.sigla := removerMenorValorUF(raiz^.dir); //Nó com Dois Filhos
    
    removerNoUF := true;
  end;
end;

procedure removerMunicipioUF;
var
siglaUF, nomeMunicipio: string;
noUF: PtrNoUF;
begin
  write('Digite a sigla da UF: ');
  readln(siglaUF);
  write('Digite o nome do município a ser removido: ');
  readln(nomeMunicipio);
  
  noUF := buscarUF(raizUF, siglaUF);
  if noUF = nil then
  writeln('UF não encontrada.')
  else
  begin
    if removerMunicipio(noUF^.municipios, nomeMunicipio) then
    begin
      noUF^.quantidade := noUF^.quantidade - 1;
      writeln('Município ', nomeMunicipio, ' removido da UF ', siglaUF);
      
      if noUF^.quantidade = 0 then
      begin
        if removerNoUF(raizUF, siglaUF) then
        writeln('UF ', siglaUF, ' foi removida da árvore principal pois não possui mais municípios.');
      end;
    end
    else
    writeln('Município não encontrado na UF ', siglaUF);
  end;
end;

procedure mostrarArvoreUF(raiz: PtrNoUF);
begin
  if raiz <> nil then
  begin
    mostrarArvoreUF(raiz^.esq);
    writeln(raiz^.sigla, ' (', raiz^.quantidade, ' municípios)');
    mostrarArvoreUF(raiz^.dir);
  end;
end;

procedure mostrarArvoreMunicipios(raiz: PtrNoMunicipio);
begin
  if raiz <> nil then
  begin
    mostrarArvoreMunicipios(raiz^.esq);
    writeln(raiz^.nome);
    mostrarArvoreMunicipios(raiz^.dir);
  end;
end;

procedure mostrarArvores;
var
opcao: char;
siglaUF: string;
noUF: PtrNoUF;
begin
  writeln('Escolha uma opção:');
  writeln('a) Mostrar árvore principal e quantidade de elementos (UFs)');
  writeln('b) Mostrar árvore de municípios de uma UF');
  readln(opcao);
  
  case opcao of
    'a': mostrarArvoreUF(raizUF);
    'b': begin
      write('Digite a sigla da UF: ');
      readln(siglaUF);
      noUF := buscarUF(raizUF, siglaUF);
      if noUF <> nil then
      begin
        writeln('Municípios da UF ', siglaUF, ':');
        mostrarArvoreMunicipios(noUF^.municipios);
      end
      else
      writeln('UF não encontrada.');
    end;
    else writeln('Opção inválida.');
  end;
end;

var
opcao: char;

begin
  
  writeln('=================================================');
  writeln('Algoritmo de Arvore Binária - UF e Municípios.');
  writeln('=================================================');
  writeln('Presione qualquer tecla para iniciar.');
  readkey;
  clrscr;
  
  inicializarArvores;
  
  repeat
    writeln;
    writeln('Escolha uma opção:');
    writeln('a) Incluir município em uma UF');
    writeln('b) Remover município de uma UF');
    writeln('c) Mostrar árvores');
    writeln('d) Sair');
    readln(opcao);
    
    case opcao of
      'a': incluirMunicipio;
      'b': removerMunicipioUF;
      'c': mostrarArvores;
      'd': writeln('Saindo...');
      else writeln('Opção inválida.');
      writeln;
    end;
  until opcao = 'd';
  
end.