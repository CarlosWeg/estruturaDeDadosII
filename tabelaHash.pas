//Objetivo da atividade:
//Criar uma aplica��o para fazer a
//tabela de espalhamento a partir de placas de autom�vel.
//Placas modelo MERCOSUL.

program tabelaEspelhamentoPlacas;

	const
	tamanhoTabela = 7;
	ajustarAlfabeto = ord('A');
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
		posicaoAlfabeto:=ord(caractere) - ajustarAlfabeto + 1;

	end;
	
	function posicaoNumero(caractere: char):integer;
	begin
	
		posicaoNumero:=ord(caractere) - ajustarNumerico;
		
	end;
	
	procedure inicializarTabela();
	var
	i: integer;
	begin
		
		for i:=0 to tamanhoTabela-1 do
			tabela[i]:=nil;
		
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
		
		// Calcula o �ndice final usando o operador mod para garantir que o resultado
		//esteja sempre dentro dos limites da tabela (entre 0 e tamanhoTabela-1).
		funcaoHash:=soma mod tamanhoTabela;
	
	end;
	
	function placaExiste(placa: tipoPlaca): boolean;
	var
  indice: integer;
  atual: pntElemento;
  achou: boolean;
	begin
	
	  indice := funcaoHash(placa);
	  atual := tabela[indice];
	  achou := false;
	  
	  while (atual <> nil) and (not achou) do
	  begin
	    if atual^.placa = placa then
	      achou := true;
	    atual := atual^.prox;
	  end;
	  
	  placaExiste:=achou;
	  
	end;
	
	procedure adicionarPlaca(placa: tipoPlaca);
	var
	indice: integer;
	novo: pntElemento;
	atual: pntElemento;
	escolha: char;
	begin
	
		if placaExiste(placa) then
	  begin
	    writeln('Esta placa j� est� cadastrada!');
			writeln('Deseja inserir mesmo assim?');
			writeln('S / N');
			readln(escolha);
			upcase(escolha);
			if escolha = 'N' then
				exit;
	  end;
		
		// Cria��o do novo elemento
		indice:=funcaoHash(placa);
		new(novo);
		novo^.placa:=placa;
		novo^.ocupado:=true;
		novo^.prox:=nil;
		
		// Se o �ndice est� vazio, insere diretamente
		if tabela[indice] = nil then
		begin
			tabela[indice]:= novo;
			writeln('Placa ',placa, ' adicionada no �ndice ', indice);
		end
		
		else
		begin
			// Percorre a lista at� o final para adicionar o novo elemento
			atual:=tabela[indice];
			while atual^.prox<>nil do
				atual:= atual^.prox;
			
			atual^.prox:=novo;
			writeln('Placa ',placa, ' adicionada ao �ndice ', indice, ' (colis�o resolvida por encadeamento).');
		end;
		
	end;
	
	procedure removerPlaca(placa: tipoPlaca);
	var
	indice: integer;
	atual, ant, temp: pntElemento;
	removido: boolean;
	begin
	
	  //Calcula o �ndice onde a placa deveria estar na tabela
	  indice := funcaoHash(placa);
	  
	  //Ponteiros para navega��o
	  atual := tabela[indice];
	  ant := nil;
	  removido := false;
	  
	  while atual <> nil do
	  begin
	    if atual^.placa = placa then
	    begin
	    
	      // Remover o elemento atual
	      
	      if ant = nil then
	      //Se ant � nil, significa que estamos removendo o primeiro elemento
	      tabela[indice] := atual^.prox
	      
	      else
	      // Caso contr�rio, pulamos o elemento atual
	      ant^.prox := atual^.prox;
	      
	      //temp guarda o elemento a ser removido
	      temp := atual;
	      atual := atual^.prox;
	      
	      dispose(temp);
	      
	      removido := true;
	      
	    end
	    
	    else
	    begin
	      //Se n�o encontrou a placa, avan�a os ponteiros
	      ant := atual;
	      atual := atual^.prox;
	    end;
	    
	  end;
	  
	  if removido then
	  	writeln('Placa ', placa, ' removida(s) do �ndice ', indice, '.')
	  	
	  else
	  	writeln('ERRO: Placa ', placa, ' n�o encontrada na tabela.');
	  	
	end;

	
	procedure removerPlacaIndice(indice: integer);
	var
	atual, ant: pntElemento;
	begin

	  // Verifica se o �ndice � v�lido
		if (indice<0) or (indice>tamanhoTabela-1) then
			writeln('ERRO: �ndice inv�lido!')
			
		// Verifica se o �ndice est� vazio
		else if tabela[indice] = nil then
			writeln('ERRO: Nenhuma placa encontrada no �ndice ',indice)
		
		else
		begin
		
			atual:=tabela[indice];
			ant:=nil;
			
			// Percorre a lista at� o �ltimo elemento
			while atual^.prox <>nil do
			begin
				ant:=atual;
				atual:=atual^.prox;
			end;
			
			// Ap�s o while, 'atual' est� no �ltimo elemento e 'ant' no pen�ltimo
			
			// Caso 1: Se ant � nil, significa que s� tinha um elemento na lista
			if ant = nil then
				tabela[indice]:= nil
				
			// Caso 2: Se tinha mais elementos, o pen�ltimo agora aponta para nil
			else
				ant^.prox:=nil;
			
			writeln('Placa ', atual^.placa, ' removida do �ndice ', indice);
			dispose(atual);
			
		end;
		
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
	    writeln('Opera��es v�lidas:');
	    writeln('1. Adicionar placa');
	    writeln('2. Exibir tabela');
	    writeln('3. Remover placa por �ndice');
	    writeln('4. Remover placa por n�mero');
	    writeln('5. Sair');
	
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
	                    writeln('ERRO: Placa inv�lida.');
	            end;
	        2:
	            exibirTabela;
	        3:
	            begin
	                writeln('Digite o �ndice para remover a �ltima placa: ');
	                readln(indice);
	                removerPlacaIndice(indice);
	            end;
	        4:
	            begin
	                writeln('Digite a placa que gostaria de remover: ');
	                readln(placa);
	                removerPlaca(placa);
	            end;
								        	
	        5: writeln('Saindo...');
	        
	        else writeln('Op��o inv�lida');
	    end;
	
	until op = 5;
	
end.