program dijkstra;

const
  max = 15;  // Número de vértices (cidades)
  inf = 9999; // Representa o infinito para as distâncias não acessíveis

type
  grafo = array[1..MAX, 1..max] of integer;
  distancias = array[1..max] of integer;
  visitados = array[1..max] of boolean;

var
  matrizAdjacencia: grafo;
  distancia: distancias;
  visitado: visitados;
  origem, destino, cont: integer;
  cidades: array[1..max] of string;

procedure inicializarGrafo(var g: grafo);
var i, j: integer;
begin

  for i := 1 to max do
    for j := 1 to max do
      if i = j then
        g[i, j] := 0
      else
        g[i, j] := inf;
end;

procedure dijkstra(origem: integer; var g: grafo; var dist: distancias; var visit: visitados);
var i, j, minDist, proxVertice: integer;
begin

  for i := 1 to max do
  begin
    dist[i] := inf;
    visit[i] := false;
  end;

  dist[origem] := 0;

  for i := 1 to max - 1 do
  begin
  
    minDist := inf;
    for j := 1 to MAX do
      if (not visit[j]) and (dist[j] < minDist) then
      begin
        minDist := dist[j];
        proxVertice := j;
      end;

    visit[proxVertice] := true;

    for j := 1 to max do
      if (not visit[j]) and (g[proxVertice, j] <> inf) and
			(dist[proxVertice] + g[proxVertice, j] < dist[j]) then
        dist[j] := dist[proxVertice] + g[proxVertice, j];
        
  end;
end;

procedure exibirCidades;
var i: integer;
begin
  writeln('Cidades disponíveis:');
  for i := 1 to max do
    writeln(i, ' - ', cidades[i]);
end;

begin

	writeln('=================================================');
  writeln('Algoritmo de Dijkstra.');
  writeln('=================================================');
  writeln('Presione qualquer tecla para iniciar.');
  readkey;
  clrscr;
  
  cidades[1] := 'Rio do Sul';
  cidades[2] := 'Ibirama';
  cidades[3] := 'Taió';
  cidades[4] := 'Salete';
  cidades[5] := 'Braço do Trombudo';
  cidades[6] := 'Witmarsum';
  cidades[7] := 'Presidente Getúlio';
  cidades[8] := 'Dona Emma';
  cidades[9] := 'Pouso Redondo';
  cidades[10] := 'Lontras';
  cidades[11] := 'Laurentino';
  cidades[12] := 'Trombudo Central';
  cidades[13] := 'Agrolândia';
  cidades[14] := 'Ituporanga';
  cidades[15] := 'Aurora';

  inicializarGrafo(matrizAdjacencia);

  // Preenchendo os custos

  // Rio do Sul
  matrizAdjacencia[1, 2] := 40;  // Rio do Sul - Ibirama
  matrizAdjacencia[1, 9] := 44;  // Rio do Sul - Pouso Redondo
  matrizAdjacencia[1, 10] := 7; // Rio do Sul - Lontras
  matrizAdjacencia[1, 13] := 40; // Rio do Sul - Agrolândia
  matrizAdjacencia[1, 14] := 15; // Rio do Sul - Ituporanga
  matrizAdjacencia[1, 12] := 45; // Rio do Sul - Trombudo Central
  
  // Ibirama
  matrizAdjacencia[2, 3] := 176; // Ibirama - Taió
  matrizAdjacencia[2, 7] := 22;  // Ibirama - Presidente Getúlio
  matrizAdjacencia[2, 10] := 22; // Ibirama - Lontras
  matrizAdjacencia[2, 1] := 40; // Ibirama - Rio do Sul
  matrizAdjacencia[2, 8] := 75; // Ibirama -Dona Emma

  // Taió
  matrizAdjacencia[3, 4] := 20;  // Taió - Salete
  matrizAdjacencia[3, 5] := 66;  // Taió - Braço do Trombudo
  matrizAdjacencia[3, 6] := 30;  // Taió - Witmarsum
  matrizAdjacencia[3, 2] := 176; // Taió - Ibirama

  // Salete
  matrizAdjacencia[4, 3] := 20;  // Salete - Taió
  matrizAdjacencia[4, 7] := 66;  // Salete - Presidente Getúlio
  matrizAdjacencia[4, 8] := 22;  // Salete - Dona Emma

  // Braço do Trombudo
  matrizAdjacencia[5, 3] := 66;  // Braço do Trombudo - Taió

  // Witmarsum
  matrizAdjacencia[6, 3] := 30;  // Witmarsum - Taió

  // Presidente Getúlio
  matrizAdjacencia[7, 2] := 22;  // Presidente Getúlio - Ibirama
  matrizAdjacencia[7, 4] := 66;  // Presidente Getúlio - Salete

  // Dona Emma
  matrizAdjacencia[8, 4] := 22;  // Dona Emma - Salete
  matrizAdjacencia[8, 2] := 75;  // Dona Emma - Ibirama

  // Pouso Redondo
  matrizAdjacencia[9, 1] := 44;  // Pouso Redondo - Rio do Sul
  matrizAdjacencia[9, 14] := 70;   // Pouso Redondo - Ituporanga
  matrizAdjacencia[9, 12] := 20; // Pouso Redondo - Trombudo Central

  // Lontras
  matrizAdjacencia[10, 1] := 7; // Lontras - Rio do Sul
  matrizAdjacencia[10, 2] := 22; // Lontras - Ibirama
  matrizAdjacencia[10, 11] := 15; // Lontras - Laurentino

  // Laurentino
  matrizAdjacencia[11, 10] := 15; // Laurentino - Lontras
  matrizAdjacencia[11, 12] := 45; // Laurentino - Trombudo Central

  // Trombudo Central
  matrizAdjacencia[12, 9] := 20;  // Trombudo Central - Pouso Redondo
  matrizAdjacencia[12, 14] := 45; // Trombudo Central - Ituporanga
  matrizAdjacencia[12, 11] := 45; // Trombudo Central - Laurentino
  matrizAdjacencia[12, 1] := 45; // Trombudo Central - Rio do Sul

  // Agrolândia
  matrizAdjacencia[13, 1] := 40;  // Agrolândia - Rio do Sul
  matrizAdjacencia[13, 14] := 11; // Agrolândia - Ituporanga

  // Ituporanga
  matrizAdjacencia[14, 1] := 15;  // Ituporanga - Rio do Sul
  matrizAdjacencia[14, 13] := 11; // Ituporanga - Agrolândia
  matrizAdjacencia[14, 15] := 60; // Ituporanga - Aurora
  matrizAdjacencia[14, 9] := 70; // Ituporanga - Pouso Redondo
  matrizAdjacencia[14, 12] := 45; // Ituporanga - Trombudo Central

  // Aurora
  matrizAdjacencia[15, 14] := 60; // Aurora - Ituporanga

  writeln('Digite o número da cidade de origem: ');
  exibirCidades;
  readln(origem);

  // Chama o algoritmo de Dijkstra
  dijkstra(origem, matrizAdjacencia, distancia, visitado);

  // Exibe as distâncias
  writeln;
  writeln('Custo / Distâncias mínimas a partir da cidade ', cidades[origem], ':');
  for cont := 1 to max do
    writeln('Para a cidade ', cidades[cont], ': ', distancia[cont]);
  
  readkey;

end.