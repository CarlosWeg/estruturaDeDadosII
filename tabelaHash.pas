//Alunos: Carlos H. A. Weege e Rafael Zink

//Objetivo da atividade:
//Criar uma aplicação para fazer a
//tabela de espalhamento a partir de placas de automóvel, modelo MERCOSUL.

program tabelaEspelhamentoPlacas;

	const
		tamanhoTabela = 7;
		ajustarAlfabeto = ord('A') + 1;
		ajustarNumerico = ord('0');
	
	type
	
	pntElemento = ^tElemento;
	tElemento = record
		placa: string;
		ocupado: boolean;
		prox: pntElemento;
	end;
	
	tipoPlaca = string;
	
	var
		tabela: array [0..tamanhoTabela -1] of pntElemento;
		op: byte;
		indice: integer;
		placa: tipoPlaca;
		
	function posicaoAlfabeto(caractere: char):integer;
	begin
	
		caractere:=upcase(caractere);	
		posicaoAlfabeto:=ord(caractere) - ajustarAlfabeto;

	end;
	
	function posicaoNumero(caractere: char):integer;
	begin
	
		posicaoNumero:=ord(caractere) - ajustarNumerico;
		
	end;
	
	
	function funcaoHash(placa: tipoPlaca):integer;
	var
	soma,i: integer;
	begin
	
		soma:=0;
		for i:=1 to length(placa) do
		begin
			if placa[i] in ['A'..'Z','a'..'z'] then
				soma:=soma + posicaoAlfabeto(placa[i])
			else if placa[i] in ['0'..'9'] then
				soma:=soma + posicaoNumero(placa[i]);
		end;
		
		funcaoHash:=soma mod tamanhoTabela;
	
	end;
	
	procedure inicializarTabela();
	var
	i: integer;
	begin
		
		for i:=0 to tamanhoTabela-1 do
			tabela[i]:=nil;
		
	end;
	
	procedure adicionarPlaca(placa: tipoPlaca);
	var
	indice: integer;
	novo: pntElemento;
	atual: pntElemento;
	begin
	
		// Criação do novo elemento
		indice:=funcaoHash(placa);
		new(novo);
		novo^.placa:=placa;
		novo^.ocupado:=true;
		novo^.prox:=nil;
		
		// Se o índice está vazio, insere diretamente
		if tabela[indice] = nil then
		begin
			tabela[indice]:= novo;
			writeln('Placa ',placa, ' adicionada no índice ', indice);
		end
		
		else
		begin
			// Percorre a lista até o final para adicionar o novo elemento
			atual:=tabela[indice];
			while atual^.prox<>nil do
				atual:= atual^.prox;
			
			atual^.prox:=novo;
			writeln('Placa ',placa, ' adicionada ao índice ', indice, ' (colisão resolvida por encadeamento).');
		end;
		
	end;
	
	procedure removerPlacaIndice(indice: integer);
	var
	atual, ant: pntElemento;
	begin
	
	  // Verifica se o índice é válido
		if (indice<0) or (indice>=tamanhoTabela) then
			writeln('ERRO: Índice inválido!')
			
		// Verifica se o índice está vazio
		else if tabela[indice] = nil then
			writeln('ERRO: Nenhuma placa encontrada no índice ',indice);
		
		atual:=tabela[indice];
		ant:=nil;
		
		// Percorre a lista até o último elemento
		while atual^.prox <>nil do
		begin
			ant:=atual;
			atual:=atual^.prox;
		end;
		
		// Remove o último elemento
		
		if ant = nil then
			// Caso seja o único elemento na lista
			tabela[indice]:= nil
		
		else
			// Caso haja mais de um elemento na lista	
			ant^.prox:=nil;
		
		writeln('Placa ', atual^.placa, ' removcida do índice ', indice);
		dispose(atual);
		
	end;
	
	procedure exibirTabela();
	var i: integer;
	atual: pntElemento;
	begin
	
		writeln('TABELA HASH:');
		
		for i:=0 to tamanhoTabela-1 do
		begin
		
			write(i,': ');
			atual:=tabela[i];
			
			if atual = nil then
				writeln('[vazio]')
			
			else
			begin
			
				while atual<> nil do
				begin
				
					write(atual^.placa);
					
					if atual^.prox<>nil then
						write('->');
					
					atual:= atual^.prox;
				
				end;
				
				writeln;
				
			end;
		
		end;	
		
	end;
	
begin

	writeln('=================================================');
  writeln('Algoritmo HASH (Tabela de espalhamento)');
  writeln('=================================================');
  writeln('Presione qualquer tecla para iniciar.');
  readkey;
  clrscr;

	repeat
	
			writeln;
	    writeln('=== MENU ===');
	    writeln('Operações válidas:');
	    writeln('1. Adicionar placa');
	    writeln('2. Exibir tabela');
	    writeln('3. Remover placa por índice');
	    writeln('4. Sair');
	
	    readln(op);
	
	    case op of
	        1:
	            begin
	                writeln('Digite a placa (formato MERCOSUL');
	                writeln('Exemplo: ABC1D23');
	                readln(placa);
	
	                if length(placa) = 7 then
	                    adicionarPlaca(placa)
	                else
	                    writeln('ERRO: Placa inválida.');
	            end;
	        2:
	            exibirTabela;
	        3:
	            begin
	                writeln('Digite o índice para remover a última placa: ');
	                readln(indice);
	                removerPlacaIndice(indice);
	            end;
	        4: writeln('Saindo...');
	        
	        else writeln('Opção inválida');
	    end;
	
	until op = 4;
	
end.
			
						
					 
				

	
	
					
					
		 
		
		
		
		
		
	
	
			
		
		
	